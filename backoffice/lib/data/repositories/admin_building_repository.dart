import 'package:sip_sync_client/sip_sync_client.dart';

/// Read-only platform building list for the backoffice console.
class AdminBuildingRepository {
  AdminBuildingRepository(this._client);

  final Client _client;

  /// Every venue, with owner and contact fields. Super admin only.
  Future<List<AdminBuildingView>> listAll() => _client.building.listAll();

  /// Pack, counts, and platform gain for one venue. Super admin only.
  Future<AdminBuildingDetail> detail(UuidValue buildingId) {
    return _client.building.adminDetail(buildingId);
  }

  /// Moves the venue onto an enabled pack. Super admin only.
  Future<AdminBuildingDetail> assignPack(
    UuidValue buildingId,
    UuidValue packId,
  ) {
    return _client.building.assignPack(buildingId, packId);
  }
}
