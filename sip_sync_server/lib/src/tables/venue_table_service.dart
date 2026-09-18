import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../generated/protocol.dart';

/// CRUD for venue floor tables. [TableFloorStatus] is computed, never stored.
class VenueTableService {
  /// Lists tables for a building the caller can access.
  Future<List<VenueTableView>> listForBuilding(
    Session session,
    UuidValue buildingId,
  ) async {
    await _requireBuildingAccess(session, buildingId);
    final rows = await VenueTable.db.find(
      session,
      where: (t) => t.buildingId.equals(buildingId),
      orderBy: (t) => t.number,
    );
    return rows.map(_view).toList();
  }

  /// Owner-only: create [request.count] tables with sequential numbers.
  Future<List<VenueTableView>> create(
    Session session,
    VenueTableCreate request,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
    await _requireOwnedBuilding(session, ownerId, request.buildingId);
    _validateCount(request.count);
    _validateSeats(request.maxSeats);

    final existing = await VenueTable.db.find(
      session,
      where: (t) => t.buildingId.equals(request.buildingId),
      orderBy: (t) => t.number.desc(),
      limit: 1,
    );
    var nextNumber = existing.isEmpty ? 1 : existing.first.number + 1;
    if (nextNumber + request.count - 1 > 9999) {
      throw VenueTableException(
        message: 'Not enough table numbers left in this venue.',
        code: VenueTableErrorCode.invalidInput,
      );
    }

    final created = <VenueTable>[];
    for (var i = 0; i < request.count; i++) {
      final number = nextNumber + i;
      final row = await VenueTable.db.insertRow(
        session,
        VenueTable(
          buildingId: request.buildingId,
          number: number,
          maxSeats: request.maxSeats,
          isActive: request.isActive,
        ),
      );
      created.add(row);
    }
    return created.map(_view).toList();
  }

  /// Owner-only: update seats and active flag (table number is immutable).
  Future<VenueTableView> update(
    Session session,
    VenueTableUpdate request,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
    final existing = await VenueTable.db.findById(session, request.id);
    if (existing == null) {
      throw VenueTableException(
        message: 'Table not found.',
        code: VenueTableErrorCode.notFound,
      );
    }
    await _requireOwnedBuilding(session, ownerId, existing.buildingId);
    _validateSeats(request.maxSeats);

    final updated = await VenueTable.db.updateRow(
      session,
      existing.copyWith(
        maxSeats: request.maxSeats,
        isActive: request.isActive,
      ),
    );
    return _view(updated);
  }

  VenueTableView _view(VenueTable row) => VenueTableView(
    id: row.id!,
    buildingId: row.buildingId,
    number: row.number,
    maxSeats: row.maxSeats,
    isActive: row.isActive,
    // Until orders/reservations exist, every active table is available.
    status: TableFloorStatus.available,
  );

  void _validateCount(int count) {
    if (count < 1 || count > 100) {
      throw VenueTableException(
        message: 'Add between 1 and 100 tables at a time.',
        code: VenueTableErrorCode.invalidInput,
      );
    }
  }

  void _validateSeats(int maxSeats) {
    if (maxSeats < 1 || maxSeats > 50) {
      throw VenueTableException(
        message: 'Max seats must be between 1 and 50.',
        code: VenueTableErrorCode.invalidInput,
      );
    }
  }

  Future<void> _requireBuildingAccess(
    Session session,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null) {
      throw VenueTableException(
        message: 'Building not found.',
        code: VenueTableErrorCode.notFound,
      );
    }
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType == ActorType.owner && building.ownerId == ctx.actorId) {
      return;
    }
    if (ctx.actorType == ActorType.employee) {
      final employee = await Employee.db.findById(session, ctx.actorId);
      if (employee != null && employee.buildingId == buildingId) {
        return;
      }
    }
    throw VenueTableException(
      message: 'Not allowed for this building.',
      code: VenueTableErrorCode.notAuthorized,
    );
  }

  Future<void> _requireOwnedBuilding(
    Session session,
    UuidValue ownerId,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null || building.ownerId != ownerId) {
      throw VenueTableException(
        message: 'Building not found.',
        code: VenueTableErrorCode.notFound,
      );
    }
  }
}
