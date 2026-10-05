import 'package:sip_sync_client/sip_sync_client.dart';

/// Reads the public plan catalog. Plan changes stay with the support team.
class PackRepository {
  PackRepository(this._client);

  final Client _client;

  /// Enabled public packs, cheapest ladder first as stored by sort order.
  Future<List<PackPublicView>> listPublic() => _client.pack.listPublic();
}
