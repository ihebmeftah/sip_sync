import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'article_composition_service.dart';

/// Optional article recipe lines (ingredient + quantity).
class ArticleCompositionEndpoint extends Endpoint {
  final _compositions = ArticleCompositionService();

  @override
  bool get requireLogin => true;

  /// Lists composition lines for [articleId] (owner or assigned employee).
  Future<List<ArticleCompositionView>> list(
    Session session,
    UuidValue articleId,
  ) {
    return _compositions.listForArticle(session, articleId);
  }

  /// Owner adds a composition line.
  Future<ArticleCompositionView> create(
    Session session,
    ArticleCompositionCreate request,
  ) {
    return _compositions.create(session, request);
  }

  /// Owner updates a line quantity.
  Future<ArticleCompositionView> update(
    Session session,
    ArticleCompositionUpdate request,
  ) {
    return _compositions.update(session, request);
  }

  /// Owner deletes a composition line.
  Future<void> delete(Session session, UuidValue id) {
    return _compositions.delete(session, id);
  }
}
