import 'package:sip_sync_client/sip_sync_client.dart';

/// Building-scoped menu category CRUD.
class MenuCategoryRepository {
  MenuCategoryRepository(this._client);

  final Client _client;

  Future<List<MenuCategoryView>> list(UuidValue buildingId) =>
      _client.menuCategory.list(buildingId);

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
