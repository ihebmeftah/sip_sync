import 'package:sip_sync_client/sip_sync_client.dart';

import '../../core/paging/list_paging.dart';

/// Building-scoped menu category CRUD.
class MenuCategoryRepository {
  MenuCategoryRepository(this._client);

  final Client _client;

  Future<MenuCategoryPage> list(
    UuidValue buildingId, {
    int? limit,
    int? offset,
  }) => _client.menuCategory.list(buildingId, limit: limit, offset: offset);

  /// Every category, for article forms and the order wizard.
  Future<List<MenuCategoryView>> listAll(UuidValue buildingId) {
    return collectPages(
      load: (offset) async {
        final page = await list(buildingId, limit: 100, offset: offset);
        return (items: page.items, total: page.total);
      },
    );
  }

  Future<MenuCategoryView> create({
    required UuidValue buildingId,
    required String name,
    String? description,
  }) {
    return _client.menuCategory.create(
      MenuCategoryCreate(
        buildingId: buildingId,
        name: name,
        description: description,
      ),
    );
  }

  Future<MenuCategoryView> update({
    required UuidValue id,
    required String name,
    String? description,
  }) {
    return _client.menuCategory.update(
      MenuCategoryUpdate(id: id, name: name, description: description),
    );
  }
}
