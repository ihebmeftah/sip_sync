import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'building_service.dart';

/// Venue CRUD for owners; assigned staff can read their building.
class BuildingEndpoint extends Endpoint {
  final _buildings = BuildingService();

  @override
  bool get requireLogin => true;

  Future<List<BuildingView>> listMine(Session session) {
    return _buildings.listMine(session);
  }

  /// Every venue for the backoffice, including owner contact. Super admin only.
  Future<List<AdminBuildingView>> listAll(Session session) {
    return _buildings.listAll(session);
  }

  /// Venue, pack, counts, and platform gain. Super admin only.
  Future<AdminBuildingDetail> adminDetail(
    Session session,
    UuidValue buildingId,
  ) {
    return _buildings.adminDetail(session, buildingId);
  }

  /// Moves the venue onto an enabled pack. Super admin only.
  Future<AdminBuildingDetail> assignPack(
    Session session,
    UuidValue buildingId,
    UuidValue packId,
  ) {
    return _buildings.assignPack(session, buildingId, packId);
  }

  Future<BuildingView> get(Session session, UuidValue buildingId) {
    return _buildings.get(session, buildingId: buildingId);
  }

  Future<BuildingView> create(Session session, BuildingCreate request) {
    return _buildings.create(session, request);
  }

  Future<BuildingView> update(Session session, BuildingUpdate request) {
    return _buildings.update(session, request);
  }

  Future<List<EmployeeView>> listEmployees(
    Session session,
    UuidValue buildingId,
  ) {
    return _buildings.listEmployees(session, buildingId);
  }
}
