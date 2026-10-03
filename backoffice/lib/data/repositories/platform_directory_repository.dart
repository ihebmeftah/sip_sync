import 'package:sip_sync_client/sip_sync_client.dart';

/// Read-only owner and customer directory for the backoffice console.
class PlatformDirectoryRepository {
  PlatformDirectoryRepository(this._client);

  final Client _client;

  /// Every owner, newest first. Super admin only.
  Future<List<PlatformPersonView>> listOwners() =>
      _client.platformDirectory.listOwners();

  /// Every customer, newest first. Super admin only.
  Future<List<PlatformPersonView>> listCustomers() =>
      _client.platformDirectory.listCustomers();
}
