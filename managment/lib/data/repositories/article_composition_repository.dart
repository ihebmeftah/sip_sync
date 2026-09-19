import 'package:sip_sync_client/sip_sync_client.dart';

/// Optional article recipe lines (ingredient + quantity).
class ArticleCompositionRepository {
  ArticleCompositionRepository(this._client);

  final Client _client;

  Future<List<ArticleCompositionView>> list(UuidValue articleId) =>
      _client.articleComposition.list(articleId);

  Future<ArticleCompositionView> create({
    required UuidValue articleId,
    required UuidValue ingredientId,
    required double quantity,
  }) {
    return _client.articleComposition.create(
      ArticleCompositionCreate(
        articleId: articleId,
        ingredientId: ingredientId,
        quantity: quantity,
      ),
    );
  }

  Future<ArticleCompositionView> update({
    required UuidValue id,
    required double quantity,
  }) {
    return _client.articleComposition.update(
      ArticleCompositionUpdate(id: id, quantity: quantity),
    );
  }

  Future<void> delete(UuidValue id) => _client.articleComposition.delete(id);
}
