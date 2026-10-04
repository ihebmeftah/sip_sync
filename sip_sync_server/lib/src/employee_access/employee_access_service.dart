import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../core/page_window.dart';
import '../generated/protocol.dart';
import '../packs/pack_gate.dart';

/// Owner CRUD for named employee access profiles in a building.
class EmployeeAccessService {
  /// Access profiles for a building the owner owns, name order.
  Future<EmployeeAccessPage> listForBuilding(
    Session session,
    UuidValue buildingId, {
    int? limit,
    int? offset,
  }) async {
    final ownerId = AuthGuard.requireOwner(session);
    await _requireOwnedBuilding(session, ownerId, buildingId);
    final window = PageWindow.from(limit: limit, offset: offset);
    Expression where(EmployeeAccessTable t) => t.buildingId.equals(buildingId);
    final total = await EmployeeAccess.db.count(session, where: where);
    final rows = await EmployeeAccess.db.find(
      session,
      where: where,
      orderBy: (t) => t.name,
      limit: window.limit,
      offset: window.offset,
    );
    return EmployeeAccessPage(
      items: rows.map(_view).toList(),
      total: total,
      limit: window.limit,
      offset: window.offset,
    );
  }

  /// Loads one profile; owner must own the building.
  Future<EmployeeAccessView> get(Session session, UuidValue id) async {
    final ownerId = AuthGuard.requireOwner(session);
    final row = await EmployeeAccess.db.findById(session, id);
    if (row == null) {
      throw EmployeeAccessException(
        message: 'Access profile not found.',
        code: EmployeeAccessErrorCode.notFound,
      );
    }
    await _requireOwnedBuilding(session, ownerId, row.buildingId);
    return _view(row);
  }

  /// Creates a named profile with permission flags.
  Future<EmployeeAccessView> create(
    Session session,
    EmployeeAccessCreate request,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
    await _requireOwnedBuilding(session, ownerId, request.buildingId);
    final name = _validateName(request.name);
    await _assertNameAvailable(session, request.buildingId, name);
    final pack = await PackGate.ofBuilding(session, request.buildingId);
    PackGate.requireFeature(
      pack.customAccessProfiles,
      PackFeature.customAccessProfiles,
    );

    final row = await EmployeeAccess.db.insertRow(
      session,
      EmployeeAccess(
        buildingId: request.buildingId,
        name: name,
        orderCreation: request.orderCreation,
        orderPayment: request.orderPayment,
        cancelOrder: request.cancelOrder,
        preparation: request.preparation,
        serving: request.serving,
        consultAllOrders: request.consultAllOrders,
      ),
    );
    return _view(row);
  }

  /// Updates name and flags for an existing profile.
  Future<EmployeeAccessView> update(
    Session session,
    EmployeeAccessUpdate request,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
    final existing = await EmployeeAccess.db.findById(session, request.id);
    if (existing == null) {
      throw EmployeeAccessException(
        message: 'Access profile not found.',
        code: EmployeeAccessErrorCode.notFound,
      );
    }
    await _requireOwnedBuilding(session, ownerId, existing.buildingId);
    final name = _validateName(request.name);
    await _assertNameAvailable(
      session,
      existing.buildingId,
      name,
      excludingId: existing.id,
    );

    final updated = await EmployeeAccess.db.updateRow(
      session,
      existing.copyWith(
        name: name,
        orderCreation: request.orderCreation,
        orderPayment: request.orderPayment,
        cancelOrder: request.cancelOrder,
        preparation: request.preparation,
        serving: request.serving,
        consultAllOrders: request.consultAllOrders,
      ),
    );
    return _view(updated);
  }

  /// Deletes a profile that is not assigned to any employee.
  Future<void> delete(Session session, UuidValue id) async {
    final ownerId = AuthGuard.requireOwner(session);
    final existing = await EmployeeAccess.db.findById(session, id);
    if (existing == null) {
      throw EmployeeAccessException(
        message: 'Access profile not found.',
        code: EmployeeAccessErrorCode.notFound,
      );
    }
    await _requireOwnedBuilding(session, ownerId, existing.buildingId);
    final assigned = await Employee.db.count(
      session,
      where: (t) => t.accessId.equals(id),
    );
    if (assigned > 0) {
      throw EmployeeAccessException(
        message: 'Access profile is assigned to staff.',
        code: EmployeeAccessErrorCode.inUse,
      );
    }
    await EmployeeAccess.db.deleteRow(session, existing);
  }

  EmployeeAccessView _view(EmployeeAccess row) => EmployeeAccessView(
    id: row.id!,
    buildingId: row.buildingId,
    name: row.name,
    orderCreation: row.orderCreation,
    orderPayment: row.orderPayment,
    cancelOrder: row.cancelOrder,
    preparation: row.preparation,
    serving: row.serving,
    consultAllOrders: row.consultAllOrders,
    createdAt: row.createdAt,
  );

  String _validateName(String raw) {
    final name = raw.trim();
    if (name.isEmpty || name.length > 80) {
      throw EmployeeAccessException(
        message: 'Access name must be 1–80 characters.',
        code: EmployeeAccessErrorCode.invalidInput,
      );
    }
    return name;
  }

  Future<void> _assertNameAvailable(
    Session session,
    UuidValue buildingId,
    String name, {
    UuidValue? excludingId,
  }) async {
    final clash = await EmployeeAccess.db.findFirstRow(
      session,
      where: (t) {
        var filter = t.buildingId.equals(buildingId) & t.name.ilike(name);
        if (excludingId != null) {
          filter = filter & t.id.notEquals(excludingId);
        }
        return filter;
      },
    );
    if (clash != null) {
      throw EmployeeAccessException(
        message: 'An access profile with that name already exists here.',
        code: EmployeeAccessErrorCode.nameTaken,
      );
    }
  }

  Future<void> _requireOwnedBuilding(
    Session session,
    UuidValue ownerId,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null || building.ownerId != ownerId) {
      throw EmployeeAccessException(
        message: 'Building not found.',
        code: EmployeeAccessErrorCode.notFound,
      );
    }
  }
}
