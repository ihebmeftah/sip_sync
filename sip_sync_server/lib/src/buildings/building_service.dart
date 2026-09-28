import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../core/phone_numbers.dart';
import '../employee_access/default_employee_access.dart';
import '../generated/protocol.dart';
import 'strict_mode.dart';

/// Owner venues; employees can read their assigned building.
class BuildingService {
  Future<List<BuildingView>> listMine(Session session) async {
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType == ActorType.owner) {
      final rows = await Building.db.find(
        session,
        where: (t) => t.ownerId.equals(ctx.actorId),
        orderBy: (t) => t.createdAt,
      );
      return Future.wait(rows.map((row) => _view(session, row)));
    }
    if (ctx.actorType == ActorType.employee) {
      final employee = await Employee.db.findById(session, ctx.actorId);
      if (employee == null) {
        return const [];
      }
      final row = await Building.db.findById(session, employee.buildingId);
      if (row == null) {
        return const [];
      }
      return [await _view(session, row)];
    }
    throw BuildingException(
      message: 'Sign in as an owner or employee.',
      code: BuildingErrorCode.notAuthorized,
    );
  }

  /// Platform list for super admins. Owners and staff are rejected.
  Future<List<AdminBuildingView>> listAll(Session session) async {
    AuthGuard.requireSuperAdmin(session);
    final rows = await Building.db.find(
      session,
      include: Building.include(owner: Owner.include()),
      orderBy: (t) => t.name,
    );
    return rows.map(_adminView).toList();
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
    final row = await Building.db.insertRow(
      session,
      Building(
        ownerId: ownerId,
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
    if (row == null || row.ownerId != ownerId) {
      throw BuildingException(
        message: 'Building not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    final updated = await Building.db.updateRow(
      session,
      row.copyWith(
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

  Future<List<EmployeeView>> listEmployees(
    Session session,
    UuidValue buildingId,
  ) async {
    // Staff directory is owner-only (matches EmployeeEndpoint CRUD).
    final ownerId = AuthGuard.requireOwner(session);
    final row = await Building.db.findById(session, buildingId);
    if (row == null || row.ownerId != ownerId) {
      throw BuildingException(
        message: 'Building not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    final records = await Employee.db.find(
      session,
      where: (t) => t.buildingId.equals(buildingId),
      include: Employee.include(access: EmployeeAccess.include()),
    );
    return records
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
        .toList();
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
    final staff = await Employee.db.find(
      session,
      where: (t) => t.buildingId.equals(row.id!),
    );
    return BuildingView(
      id: row.id!,
      ownerId: row.ownerId,
      name: row.name,
      type: row.type,
      address: row.address,
      latitude: row.latitude,
      longitude: row.longitude,
      openingMinutes: row.openingMinutes,
      closingMinutes: row.closingMinutes,
      currencyCode: row.currencyCode,
      phoneNumber: row.phoneNumber,
      countryCode: row.countryCode,
      whatsapp: row.whatsapp,
      instagram: row.instagram,
      facebook: row.facebook,
      otherLinks: row.otherLinks,
      tableMultiOrder: row.tableMultiOrder,
      allowAppendingItemsToOrder: row.allowAppendingItemsToOrder,
      strictMode: row.strictMode,
      strictModeSteps: normalizeStrictModeSteps(row.strictModeSteps),
      employeeIds: staff.map((s) => s.id!).toList(),
    );
  }

  AdminBuildingView _adminView(Building row) {
    final owner = row.owner;
    if (owner == null || row.id == null || owner.id == null) {
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
      whatsapp: row.whatsapp,
      instagram: row.instagram,
      facebook: row.facebook,
      ownerId: owner.id!,
      ownerFirstName: owner.firstName,
      ownerLastName: owner.lastName,
      ownerEmail: owner.email,
      ownerPhoneNumber: owner.phoneNumber,
    );
  }

  ({
    String phoneNumber,
    String countryCode,
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
    final country = PhoneNumbers.countryCodeFromPhone(phone);
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
      countryCode: country,
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
