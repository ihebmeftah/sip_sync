import 'package:serverpod/serverpod.dart';

import '../auth/account_service.dart';
import '../generated/protocol.dart';

/// Owner venues and the staff assigned to each one.
///
/// See `Docs/features/buildings.md`.
class BuildingService {
  final _accounts = AccountService();

  /// Buildings the actor owns, or is assigned to as staff.
  Future<List<BuildingView>> listMine(
    Session session,
    UuidValue actorId,
  ) async {
    if (await _accounts.hasRole(session, actorId, AppRole.owner)) {
      final rows = await Building.db.find(
        session,
        where: (t) => t.ownerAuthUserId.equals(actorId),
        orderBy: (t) => t.createdAt,
      );
      final views = <BuildingView>[];
      for (final row in rows) {
        views.add(await _view(session, row));
      }
      return views;
    }

    if (!await _accounts.hasRole(session, actorId, AppRole.employee)) {
      throw BuildingException(
        message: 'Sign in as an owner or employee.',
        code: BuildingErrorCode.notAuthorized,
      );
    }

    final assignments = await BuildingStaff.db.find(
      session,
      where: (t) => t.employeeAuthUserId.equals(actorId),
    );
    final views = <BuildingView>[];
    for (final assignment in assignments) {
      final row = await Building.db.findById(session, assignment.buildingId);
      if (row != null) {
        views.add(await _view(session, row));
      }
    }
    return views;
  }

  /// Owner CRUD read, or staff assigned to that building.
  Future<BuildingView> get(
    Session session, {
    required UuidValue actorId,
    required UuidValue buildingId,
  }) async {
    final row = await _readableBuilding(
      session,
      actorId: actorId,
      buildingId: buildingId,
    );
    return _view(session, row);
  }

  /// Owner creates a venue and optionally assigns existing staff.
  Future<BuildingView> create(
    Session session, {
    required UuidValue ownerAuthUserId,
    required BuildingCreate request,
  }) async {
    await _requireOwner(session, ownerAuthUserId);
    _validate(
      request.name,
      request.type,
      request.address,
      request.latitude,
      request.longitude,
      request.openingMinutes,
      request.closingMinutes,
      request.currencyCode,
    );

    final row = await Building.db.insertRow(
      session,
      Building(
        ownerAuthUserId: ownerAuthUserId,
        name: request.name.trim(),
        type: _normalizeType(request.type),
        address: request.address.trim(),
        latitude: request.latitude,
        longitude: request.longitude,
        openingMinutes: request.openingMinutes,
        closingMinutes: request.closingMinutes,
        currencyCode: request.currencyCode.trim().toUpperCase(),
      ),
    );
    await _replaceStaff(
      session,
      ownerAuthUserId: ownerAuthUserId,
      buildingId: row.id!,
      employeeAuthUserIds: request.employeeAuthUserIds,
    );
    return _view(session, row);
  }

  /// Owner updates venue fields and staff assignment.
  Future<BuildingView> update(
    Session session, {
    required UuidValue ownerAuthUserId,
    required BuildingUpdate request,
  }) async {
    final row = await _ownedBuilding(
      session,
      ownerAuthUserId: ownerAuthUserId,
      buildingId: request.id,
    );
    _validate(
      request.name,
      request.type,
      request.address,
      request.latitude,
      request.longitude,
      request.openingMinutes,
      request.closingMinutes,
      request.currencyCode,
    );

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
      ),
    );
    await _replaceStaff(
      session,
      ownerAuthUserId: ownerAuthUserId,
      buildingId: updated.id!,
      employeeAuthUserIds: request.employeeAuthUserIds,
    );
    return _view(session, updated);
  }

  /// Staff assigned to [buildingId]. Owner or assigned employee may read.
  Future<List<EmployeeView>> listEmployees(
    Session session, {
    required UuidValue actorId,
    required UuidValue buildingId,
  }) async {
    await _readableBuilding(
      session,
      actorId: actorId,
      buildingId: buildingId,
    );
    final staff = await BuildingStaff.db.find(
      session,
      where: (t) => t.buildingId.equals(buildingId),
    );
    final building = await Building.db.findById(session, buildingId);
    final views = <EmployeeView>[];
    for (final row in staff) {
      views.add(
        await _accounts.getEmployee(
          session,
          ownerAuthUserId: building!.ownerAuthUserId,
          employeeAuthUserId: row.employeeAuthUserId,
        ),
      );
    }
    return views;
  }

  Future<Building> _ownedBuilding(
    Session session, {
    required UuidValue ownerAuthUserId,
    required UuidValue buildingId,
  }) async {
    await _requireOwner(session, ownerAuthUserId);
    final row = await Building.db.findById(session, buildingId);
    if (row == null || row.ownerAuthUserId != ownerAuthUserId) {
      throw BuildingException(
        message: 'Building not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    return row;
  }

  Future<Building> _readableBuilding(
    Session session, {
    required UuidValue actorId,
    required UuidValue buildingId,
  }) async {
    final row = await Building.db.findById(session, buildingId);
    if (row == null) {
      throw BuildingException(
        message: 'Building not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    if (row.ownerAuthUserId == actorId) {
      return row;
    }
    final assigned = await BuildingStaff.db.findFirstRow(
      session,
      where: (t) =>
          t.buildingId.equals(buildingId) &
          t.employeeAuthUserId.equals(actorId),
    );
    if (assigned == null) {
      throw BuildingException(
        message: 'Building not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    return row;
  }

  Future<void> _requireOwner(Session session, UuidValue authUserId) async {
    if (!await _accounts.hasRole(session, authUserId, AppRole.owner)) {
      throw BuildingException(
        message: 'Only owners can manage buildings.',
        code: BuildingErrorCode.notAuthorized,
      );
    }
  }

  Future<void> _replaceStaff(
    Session session, {
    required UuidValue ownerAuthUserId,
    required UuidValue buildingId,
    required List<UuidValue> employeeAuthUserIds,
  }) async {
    final unique = <String, UuidValue>{};
    for (final id in employeeAuthUserIds) {
      unique[id.uuid] = id;
    }
    for (final id in unique.values) {
      await _accounts.getEmployee(
        session,
        ownerAuthUserId: ownerAuthUserId,
        employeeAuthUserId: id,
      );
    }
    await BuildingStaff.db.deleteWhere(
      session,
      where: (t) => t.buildingId.equals(buildingId),
    );
    for (final id in unique.values) {
      await BuildingStaff.db.insertRow(
        session,
        BuildingStaff(buildingId: buildingId, employeeAuthUserId: id),
      );
    }
  }

  Future<BuildingView> _view(Session session, Building row) async {
    final staff = await BuildingStaff.db.find(
      session,
      where: (t) => t.buildingId.equals(row.id!),
    );
    return BuildingView(
      id: row.id!,
      ownerAuthUserId: row.ownerAuthUserId,
      name: row.name,
      type: row.type,
      address: row.address,
      latitude: row.latitude,
      longitude: row.longitude,
      openingMinutes: row.openingMinutes,
      closingMinutes: row.closingMinutes,
      currencyCode: row.currencyCode,
      employeeAuthUserIds: staff.map((s) => s.employeeAuthUserId).toList(),
    );
  }

  void _validate(
    String name,
    String type,
    String address,
    double latitude,
    double longitude,
    int openingMinutes,
    int closingMinutes,
    String currencyCode,
  ) {
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
    if (!RegExp(r'^[A-Z]{3}$').hasMatch(currency)) {
      throw BuildingException(
        message: 'Use a three-letter currency code.',
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
