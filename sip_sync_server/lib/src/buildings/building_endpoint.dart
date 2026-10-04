import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'building_service.dart';

/// Venue CRUD for owners; assigned staff can read their building.
class BuildingEndpoint extends Endpoint {
  final _buildings = BuildingService();

  @override
  bool get requireLogin => true;

  /// Venues the caller can open. Owners see their own; staff see one.
  ///
  /// [limit] defaults to 20 and is capped at 100.
  Future<BuildingPage> listMine(
    Session session, {
    int? limit,
    int? offset,
  }) {
    return _buildings.listMine(session, limit: limit, offset: offset);
  }

  /// Venues for the backoffice, including owner contact. Super admin only.
  ///
  /// [query] matches the venue name, address, or the owner's first or last
  /// name. [packId] keeps venues on that pack. Both can be combined.
  Future<AdminBuildingPage> listAll(
    Session session, {
    int? limit,
    int? offset,
    String? query,
    UuidValue? packId,
  }) {
    return _buildings.listAll(
      session,
      limit: limit,
      offset: offset,
      query: query,
      packId: packId,
    );
  }

  /// Venue, pack, counts, and platform gain. Super admin only.
  Future<AdminBuildingDetail> adminDetail(
    Session session,
    UuidValue buildingId,
  ) {
    return _buildings.adminDetail(session, buildingId);
  }

  /// Moves a free-plan venue onto an enabled pack. Super admin only.
  ///
  /// A venue already on a paid plan is rejected. The free pack takes no term.
  /// Any other pack needs [billingPeriod] and [expiresAt]. Monthly and yearly
  /// dates must be at least that period out and may be later. A daily date
  /// past 20 days is stored as monthly. The venue returns to the free pack
  /// when that date arrives. Each step is kept as history.
  Future<AdminBuildingDetail> assignPack(
    Session session,
    UuidValue buildingId,
    UuidValue packId, {
    PackBillingPeriod? billingPeriod,
    DateTime? expiresAt,
  }) {
    return _buildings.assignPack(
      session,
      buildingId,
      packId,
      billingPeriod: billingPeriod,
      expiresAt: expiresAt,
    );
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

  /// Staff of [buildingId], owner only. Name order.
  Future<EmployeePage> listEmployees(
    Session session,
    UuidValue buildingId, {
    int? limit,
    int? offset,
  }) {
    return _buildings.listEmployees(
      session,
      buildingId,
      limit: limit,
      offset: offset,
    );
  }
}
