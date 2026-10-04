import 'package:sip_sync_client/sip_sync_client.dart';

import '../../core/paging/list_paging.dart';

/// Pack catalog for the backoffice console.
class PackRepository {
  PackRepository(this._client);

  final Client _client;

  /// One page of packs, including private and disabled. Super admin only.
  Future<PackPage> list({int? limit, int? offset}) =>
      _client.pack.list(limit: limit, offset: offset);

  /// Every pack, for the assign dialog.
  Future<List<PackView>> listAll() {
    return collectPages(
      load: (offset) async {
        final page = await list(limit: 100, offset: offset);
        return (items: page.items, total: page.total);
      },
    );
  }

  /// Creates a pack. [code] is stored lowercase.
  Future<PackView> create(PackCreate request) => _client.pack.create(request);

  /// Updates prices, flags, and capabilities.
  Future<PackView> update(PackUpdate request) => _client.pack.update(request);

  /// Deletes a non-system pack that no venue is using.
  Future<void> delete(UuidValue id) => _client.pack.delete(id);
}
