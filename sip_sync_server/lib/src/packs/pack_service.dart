import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../core/page_window.dart';
import '../generated/protocol.dart';

/// Pack catalog for super admins, plus the public list the apps will read.
class PackService {
  static final _codePattern = RegExp(r'^[a-z][a-z0-9_]{0,31}$');
  static const _nameMax = 80;
  static const _moneyMax = 1000000000;
  static const _feeMax = 10000;
  static const _limitMax = 100000;

  /// Packs, sort order then name. Super admin only.
  Future<PackPage> list(
    Session session, {
    int? limit,
    int? offset,
  }) async {
    AuthGuard.requireSuperAdmin(session);
    final window = PageWindow.from(limit: limit, offset: offset);
    final total = await Pack.db.count(session);
    final rows = await Pack.db.find(
      session,
      orderByList: (t) => [t.sortOrder, t.name],
      limit: window.limit,
      offset: window.offset,
    );
    return PackPage(
      items: rows.map(_view).toList(),
      total: total,
      limit: window.limit,
      offset: window.offset,
    );
  }

  /// Enabled public packs. Any signed-in actor.
  Future<List<PackPublicView>> listPublic(Session session) async {
    AuthGuard.requireAny(session);
    final rows = await Pack.db.find(
      session,
      where: (t) => t.isPublic.equals(true) & t.isEnabled.equals(true),
    );
    rows.sort(_bySortThenName);
    return rows.map(_public).toList();
  }

  /// Creates a non-system pack.
  Future<PackView> create(Session session, PackCreate request) async {
    AuthGuard.requireSuperAdmin(session);
    final code = request.code.trim().toLowerCase();
    final name = _name(request.name);
    _money(request.monthlyMillimes, request.annualMillimes);
    _fee(request.customerOrderFeeBps);
    _capabilities(request.capabilities);
    if (!_codePattern.hasMatch(code)) {
      throw PackException(
        message: 'Use a lowercase code that starts with a letter.',
        code: PackErrorCode.invalidInput,
      );
    }
    final taken = await Pack.db.findFirstRow(
      session,
      where: (t) => t.code.equals(code),
    );
    if (taken != null) {
      throw PackException(
        message: 'That code is already used.',
        code: PackErrorCode.codeTaken,
      );
    }

    final row = await Pack.db.insertRow(
      session,
      Pack(
        code: code,
        name: name,
        monthlyMillimes: request.monthlyMillimes,
        annualMillimes: request.annualMillimes,
        customerOrderFeeBps: request.customerOrderFeeBps,
        isPublic: request.isPublic,
        isEnabled: request.isEnabled,
        isSystem: false,
        sortOrder: request.sortOrder,
        maxEmployees: request.capabilities.maxEmployees,
        maxTables: request.capabilities.maxTables,
        maxCategories: request.capabilities.maxCategories,
        maxArticles: request.capabilities.maxArticles,
        maxIngredients: request.capabilities.maxIngredients,
        customerDiscovery: request.capabilities.customerDiscovery,
        tableQr: request.capabilities.tableQr,
        customerOrdering: request.capabilities.customerOrdering,
        inventory: request.capabilities.inventory,
        allowAppendingItems: request.capabilities.allowAppendingItems,
        tableMultiOrder: request.capabilities.tableMultiOrder,
        strictMode: request.capabilities.strictMode,
        customAccessProfiles: request.capabilities.customAccessProfiles,
        reservations: request.capabilities.reservations,
        cashRegister: request.capabilities.cashRegister,
        maxReservationsPerDay: request.capabilities.maxReservationsPerDay,
      ),
    );
    return _view(row);
  }

  /// Updates prices, flags, and capabilities. Code stays.
  Future<PackView> update(Session session, PackUpdate request) async {
    AuthGuard.requireSuperAdmin(session);
    final name = _name(request.name);
    _money(request.monthlyMillimes, request.annualMillimes);
    _fee(request.customerOrderFeeBps);
    _capabilities(request.capabilities);
    final existing = await Pack.db.findById(session, request.id);
    if (existing == null) {
      throw PackException(
        message: 'Pack not found.',
        code: PackErrorCode.notFound,
      );
    }

    final updated = await Pack.db.updateRow(
      session,
      existing.copyWith(
        name: name,
        monthlyMillimes: request.monthlyMillimes,
        annualMillimes: request.annualMillimes,
        customerOrderFeeBps: request.customerOrderFeeBps,
        isPublic: request.isPublic,
        isEnabled: request.isEnabled,
        sortOrder: request.sortOrder,
        maxEmployees: request.capabilities.maxEmployees,
        maxTables: request.capabilities.maxTables,
        maxCategories: request.capabilities.maxCategories,
        maxArticles: request.capabilities.maxArticles,
        maxIngredients: request.capabilities.maxIngredients,
        customerDiscovery: request.capabilities.customerDiscovery,
        tableQr: request.capabilities.tableQr,
        customerOrdering: request.capabilities.customerOrdering,
        inventory: request.capabilities.inventory,
        allowAppendingItems: request.capabilities.allowAppendingItems,
        tableMultiOrder: request.capabilities.tableMultiOrder,
        strictMode: request.capabilities.strictMode,
        customAccessProfiles: request.capabilities.customAccessProfiles,
        reservations: request.capabilities.reservations,
        cashRegister: request.capabilities.cashRegister,
        maxReservationsPerDay: request.capabilities.maxReservationsPerDay,
      ),
    );
    return _view(updated);
  }

  /// Deletes a non-system pack that no venue is using.
  Future<void> delete(Session session, UuidValue id) async {
    AuthGuard.requireSuperAdmin(session);
    final existing = await Pack.db.findById(session, id);
    if (existing == null) {
      throw PackException(
        message: 'Pack not found.',
        code: PackErrorCode.notFound,
      );
    }
    if (existing.isSystem) {
      throw PackException(
        message: 'The free pack cannot be deleted.',
        code: PackErrorCode.cannotDeleteSystemPack,
      );
    }
    final venues = await Building.db.count(
      session,
      where: (t) => t.packId.equals(id),
    );
    if (venues > 0) {
      throw PackException(
        message: 'A venue is still on this pack.',
        code: PackErrorCode.packInUse,
      );
    }
    await Pack.db.deleteRow(session, existing);
  }

  /// Admin row for a stored pack.
  PackView present(Pack row) => _view(row);

  PackView _view(Pack row) {
    return PackView(
      id: row.id!,
      code: row.code,
      name: row.name,
      monthlyMillimes: row.monthlyMillimes,
      annualMillimes: row.annualMillimes,
      customerOrderFeeBps: row.customerOrderFeeBps,
      isPublic: row.isPublic,
      isEnabled: row.isEnabled,
      isSystem: row.isSystem,
      sortOrder: row.sortOrder,
      capabilities: _capabilitiesOf(row),
      createdAt: row.createdAt,
    );
  }

  PackPublicView _public(Pack row) {
    return PackPublicView(
      id: row.id!,
      code: row.code,
      name: row.name,
      monthlyMillimes: row.monthlyMillimes,
      annualMillimes: row.annualMillimes,
      customerOrderFeeBps: row.customerOrderFeeBps,
      sortOrder: row.sortOrder,
      capabilities: _capabilitiesOf(row),
    );
  }

  PackCapabilities _capabilitiesOf(Pack row) {
    return PackCapabilities(
      maxEmployees: row.maxEmployees,
      maxTables: row.maxTables,
      maxCategories: row.maxCategories,
      maxArticles: row.maxArticles,
      maxIngredients: row.maxIngredients,
      customerDiscovery: row.customerDiscovery,
      tableQr: row.tableQr,
      customerOrdering: row.customerOrdering,
      inventory: row.inventory,
      allowAppendingItems: row.allowAppendingItems,
      tableMultiOrder: row.tableMultiOrder,
      strictMode: row.strictMode,
      customAccessProfiles: row.customAccessProfiles,
      reservations: row.reservations,
      cashRegister: row.cashRegister,
      maxReservationsPerDay: row.maxReservationsPerDay,
    );
  }

  int _bySortThenName(Pack a, Pack b) {
    final byOrder = a.sortOrder.compareTo(b.sortOrder);
    if (byOrder != 0) {
      return byOrder;
    }
    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  }

  String _name(String raw) {
    final name = raw.trim();
    if (name.isEmpty || name.length > _nameMax) {
      throw PackException(
        message: 'Enter a name.',
        code: PackErrorCode.invalidInput,
      );
    }
    return name;
  }

  void _money(int monthly, int? annual) {
    if (monthly < 0 || monthly > _moneyMax) {
      throw PackException(
        message: 'Check the monthly price.',
        code: PackErrorCode.invalidInput,
      );
    }
    if (annual != null && (annual < 0 || annual > _moneyMax)) {
      throw PackException(
        message: 'Check the annual price.',
        code: PackErrorCode.invalidInput,
      );
    }
  }

  void _fee(int bps) {
    if (bps < 0 || bps > _feeMax) {
      throw PackException(
        message: 'The customer-app fee must be between 0% and 100%.',
        code: PackErrorCode.invalidInput,
      );
    }
  }

  void _capabilities(PackCapabilities capabilities) {
    _limit(capabilities.maxEmployees);
    _limit(capabilities.maxTables);
    _limit(capabilities.maxCategories);
    _limit(capabilities.maxArticles);
    _limit(capabilities.maxIngredients);
    _limit(capabilities.maxReservationsPerDay);
  }

  void _limit(int? value) {
    if (value != null && (value < 0 || value > _limitMax)) {
      throw PackException(
        message: 'Limits must be zero or a positive number.',
        code: PackErrorCode.invalidInput,
      );
    }
  }
}
