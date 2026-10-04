import 'package:sip_sync_client/sip_sync_client.dart';

/// Read-only owner and customer directory for the backoffice console.
class PlatformDirectoryRepository {
  PlatformDirectoryRepository(this._client);

  final Client _client;

  /// One page of owners, newest first. Super admin only.
  Future<PlatformPersonPage> listOwners({int? limit, int? offset}) =>
      _client.platformDirectory.listOwners(limit: limit, offset: offset);

  /// One page of customers, newest first. Super admin only.
  Future<PlatformPersonPage> listCustomers({int? limit, int? offset}) =>
      _client.platformDirectory.listCustomers(limit: limit, offset: offset);
}
