import 'package:sip_sync_client/sip_sync_client.dart';

/// Building-scoped menu article CRUD.
class MenuArticleRepository {
  MenuArticleRepository(this._client);

  final Client _client;

  Future<List<MenuArticleView>> list(UuidValue buildingId) =>
      _client.menuArticle.list(buildingId);

  Future<MenuArticleView> create({
    required UuidValue buildingId,
    required UuidValue categoryId,
    required String name,
    String? description,
    required double price,
  }) {
    return _client.menuArticle.create(
      MenuArticleCreate(
        buildingId: buildingId,
        categoryId: categoryId,
        name: name,
        description: description,
        price: price,
      ),
    );
  }

  Future<MenuArticleView> update({
    required UuidValue id,
    required UuidValue categoryId,
    required String name,
    String? description,
    required double price,
  }) {
    return _client.menuArticle.update(
      MenuArticleUpdate(
        id: id,
        categoryId: categoryId,
        name: name,
        description: description,
        price: price,
      ),
    );
  }
}
