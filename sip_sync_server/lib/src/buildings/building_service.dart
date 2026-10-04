import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../core/page_window.dart';
import '../core/phone_numbers.dart';
import '../employee_access/default_employee_access.dart';
import '../generated/protocol.dart';
import '../packs/pack_catalog.dart';
import '../packs/pack_expiry.dart';
import '../packs/pack_gate.dart';
import '../packs/pack_history.dart';
import '../packs/pack_service.dart';
import '../packs/pack_term.dart';
import 'country_names.dart';
import 'strict_mode.dart';

/// Owner venues; employees can read their assigned building.
class BuildingService {
  /// Venues this owner created, oldest first, or the one building a staff
  /// member is assigned to.
  Future<BuildingPage> listMine(
    Session session, {
    int? limit,
    int? offset,
  }) async {
    final window = PageWindow.from(limit: limit, offset: offset);
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType == ActorType.owner) {
      Expression where(BuildingTable t) => t.ownerId.equals(ctx.actorId);
      final total = await Building.db.count(session, where: where);
      final rows = await Building.db.find(
        session,
        where: where,
        orderBy: (t) => t.createdAt,
        limit: window.limit,
        offset: window.offset,
      );
      return BuildingPage(
        items: await Future.wait(rows.map((row) => _view(session, row))),
        total: total,
        limit: window.limit,
        offset: window.offset,
      );
    }
    if (ctx.actorType == ActorType.employee) {
      final employee = await Employee.db.findById(session, ctx.actorId);
      if (employee == null) {
        return _emptyBuildings(window);
      }
      final row = await Building.db.findById(session, employee.buildingId);
      if (row == null || window.offset > 0) {
        return BuildingPage(
          items: const [],
          total: row == null ? 0 : 1,
          limit: window.limit,
          offset: window.offset,
        );
      }
      return BuildingPage(
        items: [await _view(session, row)],
        total: 1,
        limit: window.limit,
        offset: window.offset,
      );
    }
    throw BuildingException(
      message: 'Sign in as an owner or employee.',
      code: BuildingErrorCode.notAuthorized,
    );
  }

  /// Platform list for super admins, name order. Owners and staff are rejected.
  ///
  /// [query] matches the venue name, address, or owner first or last name,
  /// including a "first last" pair. [packId] limits the page to one pack.
  /// A blank query and a null pack return every venue. The count uses the
  /// same filter, so paging stays inside the match.
  Future<AdminBuildingPage> listAll(
    Session session, {
    int? limit,
    int? offset,
    String? query,
    UuidValue? packId,
  }) async {
    AuthGuard.requireSuperAdmin(session);
    final window = PageWindow.from(limit: limit, offset: offset);
    final where = _listWhere(query: query, packId: packId);
    final total = await Building.db.count(session, where: where);
    final rows = await Building.db.find(
      session,
      where: where,
      include: Building.include(
        owner: Owner.include(),
        pack: Pack.include(),
      ),
      orderBy: (t) => t.name,
      limit: window.limit,
      offset: window.offset,
    );
    return AdminBuildingPage(
      items: rows.map(_adminView).toList(),
      total: total,
      limit: window.limit,
      offset: window.offset,
    );
  }

  /// Venue counts grouped by country. Super admin only.
  ///
  /// Each row is one country, with the venue count and the average coordinates
  /// so a map can place a marker. Blank names are filled from the ISO code first.
  Future<List<CountryBuildingStat>> countryStats(Session session) async {
    AuthGuard.requireSuperAdmin(session);
    await CountryNames.fillMissing(session);
    final rows = await session.db.unsafeQuery('''
SELECT "countryCode", "countryName", COUNT(*)::int, AVG(latitude), AVG(longitude)
FROM building
GROUP BY "countryCode", "countryName"
ORDER BY COUNT(*) DESC, "countryName" ASC
''');
    return [
      for (final row in rows)
        CountryBuildingStat(
          countryCode: row[0]! as String,
          countryName: row[1]! as String,
          buildingCount: sqlInt(row[2]),
          latitude: (row[3] as num).toDouble(),
          longitude: (row[4] as num).toDouble(),
        ),
    ];
  }

  /// Stores the English country name when an older row only has the code.
  Future<Building> _withCountryName(Session session, Building row) async {
    if (row.countryName.isNotEmpty) {
      return row;
    }
    final name = PhoneNumbers.countryNameFromCode(row.countryCode);
    if (name == null) {
      return row;
    }
    return Building.db.updateRow(session, row.copyWith(countryName: name));
  }

  /// Blank search and no pack leave the list unfiltered.
  WhereExpressionBuilder<BuildingTable>? _listWhere({
    required String? query,
    required UuidValue? packId,
  }) {
    final text = _clipQuery(query);
    if (text == null && packId == null) {
      return null;
    }
    return (table) {
      Expression? clause;
      if (packId != null) {
        clause = table.packId.equals(packId);
      }
      if (text != null) {
        final match = _textMatch(table, text);
        clause = clause == null ? match : (clause & match);
      }
      return clause!;
    };
  }

  BuildingPage _emptyBuildings(PageWindow window) {
    return BuildingPage(
      items: const [],
      total: 0,
      limit: window.limit,
      offset: window.offset,
    );
  }

  Future<BuildingView> get(
    Session session, {
    required UuidValue buildingId,
  }) async {
    final row = await _readableBuilding(session, buildingId);
    return _view(session, row);
  }

  Future<BuildingView> create(
    Session session,
    BuildingCreate request,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
    final contact = _validateContact(request);
    _validate(request);
    final free = await PackCatalog.requireFree(session);
    PackGate.requireIfRequested(
      request.tableMultiOrder,
      free.tableMultiOrder,
      PackFeature.tableMultiOrder,
    );
    PackGate.requireIfRequested(
      request.strictMode,
      free.strictMode,
      PackFeature.strictMode,
    );
    PackGate.requireIfRequested(
      request.allowAppendingItemsToOrder,
      free.allowAppendingItems,
      PackFeature.appendingItems,
    );
    final row = await session.db.transaction((transaction) async {
      final inserted = await Building.db.insertRow(
        session,
        Building(
          ownerId: ownerId,
          packId: free.id!,
          name: request.name.trim(),
          type: _normalizeType(request.type),
          address: request.address.trim(),
          latitude: request.latitude,
          longitude: request.longitude,
          openingMinutes: request.openingMinutes,
          closingMinutes: request.closingMinutes,
          currencyCode: request.currencyCode.trim().toUpperCase(),
          phoneNumber: contact.phoneNumber,
          countryCode: contact.countryCode,
          countryName: contact.countryName,
          whatsapp: contact.whatsapp,
          instagram: contact.instagram,
          facebook: contact.facebook,
          otherLinks: contact.otherLinks,
          tableMultiOrder: request.tableMultiOrder,
          allowAppendingItemsToOrder: request.allowAppendingItemsToOrder,
          strictMode: request.strictMode,
          strictModeSteps: normalizeStrictModeSteps(request.strictModeSteps),
        ),
        transaction: transaction,
      );
      await BuildingPackHistory.openInitial(
        session,
        buildingId: inserted.id!,
        packId: free.id!,
        transaction: transaction,
      );
      return inserted;
    });
    await DefaultEmployeeAccess.seedForBuilding(session, row.id!);
    return _view(session, row);
  }

  Future<BuildingView> update(
    Session session,
    BuildingUpdate request,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
    final contact = _validateContact(request);
    _validate(request);
    final row = await Building.db.findById(session, request.id);
    if (row == null || row.ownerId != ownerId || row.id == null) {
      throw BuildingException(
        message: 'Building not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    final pack = await PackGate.ofBuilding(session, row.id!);
    final current = await Building.db.findById(session, row.id!);
    if (current == null) {
      throw BuildingException(
        message: 'Building not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    PackGate.requireIfRequested(
      request.tableMultiOrder && !row.tableMultiOrder,
      pack.tableMultiOrder,
      PackFeature.tableMultiOrder,
    );
    PackGate.requireIfRequested(
      request.strictMode && !row.strictMode,
      pack.strictMode,
      PackFeature.strictMode,
    );
    PackGate.requireIfRequested(
      request.allowAppendingItemsToOrder && !row.allowAppendingItemsToOrder,
      pack.allowAppendingItems,
      PackFeature.appendingItems,
    );
    final updated = await Building.db.updateRow(
      session,
      current.copyWith(
        name: request.name.trim(),
        type: _normalizeType(request.type),
        address: request.address.trim(),
        latitude: request.latitude,
        longitude: request.longitude,
        openingMinutes: request.openingMinutes,
        closingMinutes: request.closingMinutes,
        currencyCode: request.currencyCode.trim().toUpperCase(),
        phoneNumber: contact.phoneNumber,
        countryCode: contact.countryCode,
        countryName: contact.countryName,
        whatsapp: contact.whatsapp,
        instagram: contact.instagram,
        facebook: contact.facebook,
        otherLinks: contact.otherLinks,
        tableMultiOrder: request.tableMultiOrder,
        allowAppendingItemsToOrder: request.allowAppendingItemsToOrder,
        strictMode: request.strictMode,
        strictModeSteps: normalizeStrictModeSteps(request.strictModeSteps),
      ),
    );
    return _view(session, updated);
  }

  /// Staff of [buildingId], last name then first name. Owner only.
  Future<EmployeePage> listEmployees(
    Session session,
    UuidValue buildingId, {
    int? limit,
    int? offset,
  }) async {
    // Staff directory is owner-only (matches EmployeeEndpoint CRUD).
    final ownerId = AuthGuard.requireOwner(session);
    final row = await Building.db.findById(session, buildingId);
    if (row == null || row.ownerId != ownerId) {
      throw BuildingException(
        message: 'Building not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    final window = PageWindow.from(limit: limit, offset: offset);
    Expression where(EmployeeTable t) => t.buildingId.equals(buildingId);
    final total = await Employee.db.count(session, where: where);
    final records = await Employee.db.find(
      session,
      where: where,
      orderByList: (t) => [t.lastName, t.firstName],
      include: Employee.include(access: EmployeeAccess.include()),
      limit: window.limit,
      offset: window.offset,
    );
    return EmployeePage(
      items: records
          .map(
            (e) => EmployeeView(
              id: e.id!,
              buildingId: e.buildingId,
              ownerId: e.ownerId,
              accessId: e.accessId,
              accessName: e.access?.name,
              username: e.username,
              phoneNumber: e.phoneNumber,
              firstName: e.firstName,
              lastName: e.lastName,
              isEnabled: e.isEnabled,
            ),
          )
          .toList(),
      total: total,
      limit: window.limit,
      offset: window.offset,
    );
  }

  Future<Building> _readableBuilding(
    Session session,
    UuidValue buildingId,
  ) async {
    final row = await Building.db.findById(session, buildingId);
    if (row == null) {
      throw BuildingException(
        message: 'Building not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType == ActorType.owner && row.ownerId == ctx.actorId) {
      return row;
    }
    if (ctx.actorType == ActorType.employee) {
      final employee = await Employee.db.findById(session, ctx.actorId);
      if (employee != null && employee.buildingId == buildingId) {
        return row;
      }
    }
    throw BuildingException(
      message: 'Building not found.',
      code: BuildingErrorCode.notFound,
    );
  }

  Future<BuildingView> _view(Session session, Building row) async {
    final current = await _withCountryName(
      session,
      await PackExpiry.apply(session, row),
    );
    final staff = await Employee.db.find(
      session,
      where: (t) => t.buildingId.equals(current.id!),
    );
    final pack =
        current.pack ?? await Pack.db.findById(session, current.packId);
    if (pack == null) {
      throw PackException(
        message: 'This venue has no pack.',
        code: PackErrorCode.notFound,
      );
    }
    return BuildingView(
      id: current.id!,
      ownerId: current.ownerId,
      name: current.name,
      type: current.type,
      address: current.address,
      latitude: current.latitude,
      longitude: current.longitude,
      openingMinutes: current.openingMinutes,
      closingMinutes: current.closingMinutes,
      currencyCode: current.currencyCode,
      phoneNumber: current.phoneNumber,
      countryCode: current.countryCode,
      countryName: current.countryName,
      whatsapp: current.whatsapp,
      instagram: current.instagram,
      facebook: current.facebook,
      otherLinks: current.otherLinks,
      tableMultiOrder: current.tableMultiOrder,
      allowAppendingItemsToOrder: current.allowAppendingItemsToOrder,
      strictMode: current.strictMode,
      strictModeSteps: normalizeStrictModeSteps(current.strictModeSteps),
      employeeIds: staff.map((s) => s.id!).toList(),
      pack: PackGate.summary(pack),
    );
  }

  /// Venue, pack, counts, and platform gain. Super admin only.
  Future<AdminBuildingDetail> adminDetail(
    Session session,
    UuidValue buildingId,
  ) async {
    AuthGuard.requireSuperAdmin(session);
    final row = await _adminRow(session, buildingId);
    return _detail(session, row);
  }

  /// Puts a venue that is on the free pack onto [packId].
  ///
  /// A venue already on a paid plan is rejected until cancellation exists.
  /// The free pack clears any term. Every other enabled pack needs
  /// [billingPeriod] and an [expiresAt] in the future. A monthly date is at
  /// least one month out, a yearly date at least one year, and either may be
  /// later. A daily date past 20 days is stored as a monthly term. When the
  /// end passes, the venue returns to the free pack and both steps are kept
  /// in the assignment history.
  Future<AdminBuildingDetail> assignPack(
    Session session,
    UuidValue buildingId,
    UuidValue packId, {
    PackBillingPeriod? billingPeriod,
    DateTime? expiresAt,
  }) async {
    AuthGuard.requireSuperAdmin(session);
    final pack = await Pack.db.findById(session, packId);
    if (pack == null || pack.id == null || !pack.isEnabled) {
      throw PackException(
        message: 'Pack not found.',
        code: PackErrorCode.notFound,
      );
    }
    final stored = await Building.db.findById(
      session,
      buildingId,
      include: Building.include(pack: Pack.include()),
    );
    if (stored == null || stored.pack == null) {
      throw BuildingException(
        message: 'Building not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    final row = await PackExpiry.apply(session, stored);
    final current = row.pack;
    if (current == null) {
      throw PackException(
        message: 'This venue has no pack.',
        code: PackErrorCode.notFound,
      );
    }
    if (current.code != PackCatalog.freeCode) {
      throw PackException(
        message: 'This venue already has a paid plan.',
        code: PackErrorCode.paidPlanActive,
      );
    }
    if (current.id == pack.id) {
      return adminDetail(session, buildingId);
    }
    final isFree = pack.code == PackCatalog.freeCode;
    final term = _paidTerm(
      isFree: isFree,
      billingPeriod: billingPeriod,
      expiresAt: expiresAt,
    );
    await BuildingPackHistory.change(
      session,
      building: row,
      pack: pack,
      billingPeriod: term?.period,
      expiresAt: term?.expiresAt,
      reason: BuildingPackEndReason.replaced,
    );
    return adminDetail(session, buildingId);
  }

  /// A paid assignment, or null when the venue is moving to the free pack.
  ({PackBillingPeriod period, DateTime expiresAt})? _paidTerm({
    required bool isFree,
    required PackBillingPeriod? billingPeriod,
    required DateTime? expiresAt,
  }) {
    if (isFree) {
      return null;
    }
    if (billingPeriod == null || expiresAt == null) {
      throw PackException(
        message: 'Choose daily, monthly, or yearly, and an end date.',
        code: PackErrorCode.invalidInput,
      );
    }
    return resolvePackTerm(period: billingPeriod, expiresAt: expiresAt);
  }

  Future<Building> _adminRow(Session session, UuidValue buildingId) async {
    final row = await Building.db.findById(
      session,
      buildingId,
      include: Building.include(
        owner: Owner.include(),
        pack: Pack.include(),
      ),
    );
    if (row == null || row.pack == null || row.owner == null) {
      throw BuildingException(
        message: 'Building not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    return row;
  }

  Future<AdminBuildingDetail> _detail(Session session, Building row) async {
    final current = await _withCountryName(
      session,
      await PackExpiry.apply(session, row),
    );
    final id = current.id!;
    final pack = current.pack!;
    final categoryCount = await MenuCategory.db.count(
      session,
      where: (t) => t.buildingId.equals(id),
    );
    final articleCount = await MenuArticle.db.count(
      session,
      where: (t) => t.buildingId.equals(id),
    );
    final tableCount = await VenueTable.db.count(
      session,
      where: (t) => t.buildingId.equals(id),
    );
    final orderCount = await VenueOrder.db.count(
      session,
      where: (t) => t.buildingId.equals(id),
    );
    final customerOrders = await VenueOrder.db.find(
      session,
      where: (t) =>
          t.buildingId.equals(id) &
          t.launchedByType.equals(ActorType.customer) &
          t.status.notEquals(OrderStatus.cancelled),
      include: VenueOrder.include(
        items: VenueOrderItem.includeList(),
      ),
    );
    var customerSales = 0.0;
    for (final order in customerOrders) {
      for (final item in order.items ?? const <VenueOrderItem>[]) {
        if (item.status == OrderItemStatus.cancelled) {
          continue;
        }
        customerSales += item.unitPrice;
      }
    }
    final feeEarned = customerSales * pack.customerOrderFeeBps / 10000;
    return AdminBuildingDetail(
      building: _adminView(current),
      pack: PackService().present(pack),
      categoryCount: categoryCount,
      articleCount: articleCount,
      tableCount: tableCount,
      orderCount: orderCount,
      customerOrderCount: customerOrders.length,
      customerSales: customerSales,
      feeEarned: feeEarned,
      packBillingPeriod: current.packBillingPeriod,
      packExpiresAt: current.packExpiresAt,
      packHistory: await BuildingPackHistory.list(session, id),
    );
  }

  AdminBuildingView _adminView(Building row) {
    final owner = row.owner;
    final pack = row.pack;
    if (owner == null ||
        pack == null ||
        row.id == null ||
        owner.id == null ||
        pack.id == null) {
      throw BuildingException(
        message: 'Building owner is missing.',
        code: BuildingErrorCode.notFound,
      );
    }
    return AdminBuildingView(
      id: row.id!,
      name: row.name,
      type: row.type,
      address: row.address,
      latitude: row.latitude,
      longitude: row.longitude,
      currencyCode: row.currencyCode,
      phoneNumber: row.phoneNumber,
      countryCode: row.countryCode,
      countryName: row.countryName,
      whatsapp: row.whatsapp,
      instagram: row.instagram,
      facebook: row.facebook,
      ownerId: owner.id!,
      ownerFirstName: owner.firstName,
      ownerLastName: owner.lastName,
      ownerEmail: owner.email,
      ownerPhoneNumber: owner.phoneNumber,
      packId: pack.id!,
      packName: pack.name,
    );
  }

  /// Trims and caps a list search. Empty becomes null.
  String? _clipQuery(String? query) {
    final text = query?.trim() ?? '';
    if (text.isEmpty) {
      return null;
    }
    return text.length > 80 ? text.substring(0, 80) : text;
  }

  /// Case-insensitive match on name, address, and owner name.
  ///
  /// `%` and `_` in the typed text stay literal. Two or more words also
  /// match owner first and last name in either order.
  Expression _textMatch(BuildingTable table, String raw) {
    final pattern = '%${_escapeLike(raw)}%';
    var match =
        table.name.ilike(pattern) |
        table.address.ilike(pattern) |
        table.owner.firstName.ilike(pattern) |
        table.owner.lastName.ilike(pattern);
    final parts = raw
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.length >= 2) {
      final first = '%${_escapeLike(parts.first)}%';
      final rest = '%${_escapeLike(parts.sublist(1).join(' '))}%';
      match =
          match |
          (table.owner.firstName.ilike(first) &
              table.owner.lastName.ilike(rest)) |
          (table.owner.lastName.ilike(first) &
              table.owner.firstName.ilike(rest));
    }
    return match;
  }

  String _escapeLike(String value) {
    return value
        .replaceAll(r'\', r'\\')
        .replaceAll('%', r'\%')
        .replaceAll('_', r'\_');
  }

  ({
    String phoneNumber,
    String countryCode,
    String countryName,
    String? whatsapp,
    String? instagram,
    String? facebook,
    List<String> otherLinks,
  })
  _validateContact(dynamic request) {
    final phone = PhoneNumbers.normalize(request.phoneNumber as String);
    if (!PhoneNumbers.isValid(phone)) {
      throw BuildingException(
        message: 'Enter a phone with country code, e.g. +216…',
        code: BuildingErrorCode.invalidInput,
      );
    }
    final country = PhoneNumbers.countryFromPhone(phone);
    if (country == null) {
      throw BuildingException(
        message: 'Unsupported phone country code.',
        code: BuildingErrorCode.invalidInput,
      );
    }

    String? whatsapp;
    final rawWhatsapp = (request.whatsapp as String?)?.trim();
    if (rawWhatsapp != null && rawWhatsapp.isNotEmpty) {
      whatsapp = PhoneNumbers.normalize(rawWhatsapp);
      if (!PhoneNumbers.isValid(whatsapp)) {
        throw BuildingException(
          message: 'WhatsApp must be a phone with country code.',
          code: BuildingErrorCode.invalidInput,
        );
      }
    }

    final instagram = _optionalHandleOrUrl(
      request.instagram as String?,
      max: 120,
    );
    final facebook = _optionalHandleOrUrl(
      request.facebook as String?,
      max: 200,
    );
    final otherLinks = _normalizeLinks(
      (request.otherLinks as List<String>?) ?? const [],
    );

    return (
      phoneNumber: phone,
      countryCode: country.codeShort,
      countryName: PhoneNumbers.countryNameFromCode(country.codeShort)!,
      whatsapp: whatsapp,
      instagram: instagram,
      facebook: facebook,
      otherLinks: otherLinks,
    );
  }

  String? _optionalHandleOrUrl(String? raw, {required int max}) {
    final value = raw?.trim() ?? '';
    if (value.isEmpty) {
      return null;
    }
    if (value.length > max) {
      throw BuildingException(
        message: 'Social link is too long.',
        code: BuildingErrorCode.invalidInput,
      );
    }
    return value;
  }

  List<String> _normalizeLinks(List<String> raw) {
    final out = <String>[];
    for (final item in raw) {
      final value = item.trim();
      if (value.isEmpty) {
        continue;
      }
      if (value.length > 300 ||
          !RegExp(r'^https?://', caseSensitive: false).hasMatch(value)) {
        throw BuildingException(
          message: 'Other links must be http(s) URLs.',
          code: BuildingErrorCode.invalidInput,
        );
      }
      out.add(value);
      if (out.length > 10) {
        throw BuildingException(
          message: 'Too many other links.',
          code: BuildingErrorCode.invalidInput,
        );
      }
    }
    return out;
  }

  void _validate(dynamic request) {
    final name = request.name as String;
    final type = request.type as String;
    final address = request.address as String;
    final latitude = request.latitude as double;
    final longitude = request.longitude as double;
    final openingMinutes = request.openingMinutes as int;
    final closingMinutes = request.closingMinutes as int;
    final currencyCode = request.currencyCode as String;

    if (name.trim().isEmpty || name.trim().length > 80) {
      throw BuildingException(
        message: 'Enter a venue name.',
        code: BuildingErrorCode.invalidInput,
      );
    }
    _normalizeType(type);
    if (address.trim().length < 3 || address.trim().length > 200) {
      throw BuildingException(
        message: 'Enter a street address.',
        code: BuildingErrorCode.invalidInput,
      );
    }
    if (latitude < -90 ||
        latitude > 90 ||
        longitude < -180 ||
        longitude > 180) {
      throw BuildingException(
        message: 'Latitude and longitude are out of range.',
        code: BuildingErrorCode.invalidInput,
      );
    }
    if (openingMinutes < 0 ||
        openingMinutes > 1439 ||
        closingMinutes < 0 ||
        closingMinutes > 1439) {
      throw BuildingException(
        message: 'Opening and closing times must be within a day.',
        code: BuildingErrorCode.invalidInput,
      );
    }
    final currency = currencyCode.trim().toUpperCase();
    if (!Currencies.isValidCode(currency)) {
      throw BuildingException(
        message: 'Use a valid three-letter currency code.',
        code: BuildingErrorCode.invalidInput,
      );
    }
  }

  String _normalizeType(String type) {
    final value = type.trim().toLowerCase();
    if (value.length < 2 ||
        value.length > 40 ||
        !RegExp(r'^[a-z0-9][a-z0-9 \-]*$').hasMatch(value)) {
      throw BuildingException(
        message: 'Enter a venue type.',
        code: BuildingErrorCode.invalidInput,
      );
    }
    return value;
  }
}
