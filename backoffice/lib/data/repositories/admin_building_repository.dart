import 'package:sip_sync_client/sip_sync_client.dart';

/// Read-only platform building list for the backoffice console.
class AdminBuildingRepository {
  AdminBuildingRepository(this._client);

  final Client _client;

  /// One page of venues, with owner and contact fields. Super admin only.
  Future<AdminBuildingPage> listAll({int? limit, int? offset}) =>
      _client.building.listAll(limit: limit, offset: offset);

  /// Pack, counts, and platform gain for one venue. Super admin only.
  Future<AdminBuildingDetail> detail(UuidValue buildingId) {
    return _client.building.adminDetail(buildingId);
  }

  /// Moves the venue onto an enabled pack. Super admin only.
  ///
  /// [billingPeriod] and [expiresAt] are required for every pack except free.
  Future<AdminBuildingDetail> assignPack(
    UuidValue buildingId,
    UuidValue packId, {
    PackBillingPeriod? billingPeriod,
    DateTime? expiresAt,
  }) {
    return _client.building.assignPack(
      buildingId,
      packId,
      billingPeriod: billingPeriod,
      expiresAt: expiresAt,
    );
  }
}
