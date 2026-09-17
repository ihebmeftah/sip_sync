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
