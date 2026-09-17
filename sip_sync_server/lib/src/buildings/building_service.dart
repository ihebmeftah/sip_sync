import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../generated/protocol.dart';

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
      ),
    );
    return _view(session, row);
  }

  Future<BuildingView> update(
    Session session,
    BuildingUpdate request,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
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
    );
    return records
        .map(
          (e) => EmployeeView(
            id: e.id!,
            buildingId: e.buildingId,
            ownerId: e.ownerId,
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
      employeeIds: staff.map((s) => s.id!).toList(),
    );
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
