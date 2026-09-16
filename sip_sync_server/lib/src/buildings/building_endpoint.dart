import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'building_service.dart';

/// Venue CRUD for owners; assigned staff can read their buildings.
class BuildingEndpoint extends Endpoint {
  final _buildings = BuildingService();

  @override
  bool get requireLogin => true;

  /// Buildings the signed-in owner created, or staff assignments.
  Future<List<BuildingView>> listMine(Session session) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw BuildingException(
        message: 'Sign in required.',
        code: BuildingErrorCode.notAuthorized,
      );
    }
    return _buildings.listMine(session, userId);
  }

  /// One venue if the actor owns it or is assigned there.
  Future<BuildingView> get(Session session, UuidValue buildingId) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw BuildingException(
        message: 'Sign in required.',
        code: BuildingErrorCode.notAuthorized,
      );
    }
    return _buildings.get(session, actorId: userId, buildingId: buildingId);
  }

  /// Owner creates a café, restaurant, lounge, bar, or custom venue.
  Future<BuildingView> create(Session session, BuildingCreate request) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw BuildingException(
        message: 'Sign in required.',
        code: BuildingErrorCode.notAuthorized,
      );
    }
    return _buildings.create(
      session,
      ownerAuthUserId: userId,
      request: request,
    );
  }

  /// Owner updates venue details and which staff work there.
  Future<BuildingView> update(Session session, BuildingUpdate request) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw BuildingException(
        message: 'Sign in required.',
        code: BuildingErrorCode.notAuthorized,
      );
    }
    return _buildings.update(
      session,
      ownerAuthUserId: userId,
      request: request,
    );
  }

  /// Staff assigned to [buildingId].
  Future<List<EmployeeView>> listEmployees(
    Session session,
    UuidValue buildingId,
  ) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw BuildingException(
        message: 'Sign in required.',
        code: BuildingErrorCode.notAuthorized,
      );
    }
    return _buildings.listEmployees(
      session,
      actorId: userId,
      buildingId: buildingId,
    );
  }
}
