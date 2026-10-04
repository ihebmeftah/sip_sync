import 'package:sip_sync_client/sip_sync_client.dart';

/// Pack catalog for the backoffice console.
class PackRepository {
  PackRepository(this._client);

  final Client _client;

  /// Every pack, including private and disabled. Super admin only.
  Future<List<PackView>> list() => _client.pack.list();

  /// Creates a pack. [code] is stored lowercase.
  Future<PackView> create(PackCreate request) => _client.pack.create(request);

  /// Updates prices, flags, and capabilities.
  Future<PackView> update(PackUpdate request) => _client.pack.update(request);

  /// Deletes a non-system pack that no venue is using.
  Future<void> delete(UuidValue id) => _client.pack.delete(id);
}
