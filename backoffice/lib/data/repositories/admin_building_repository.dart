import 'package:sip_sync_client/sip_sync_client.dart';

/// Read-only platform building list for the backoffice console.
class AdminBuildingRepository {
  AdminBuildingRepository(this._client);

  final Client _client;

  /// Every venue, with owner and contact fields. Super admin only.
  Future<List<AdminBuildingView>> listAll() => _client.building.listAll();
}
