import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'menu_article_service.dart';

/// Menu article RPC for a building.
class MenuArticleEndpoint extends Endpoint {
  final _articles = MenuArticleService();

  @override
  bool get requireLogin => true;

  /// Lists articles for [buildingId] (owner or assigned employee).
  Future<List<MenuArticleView>> list(
    Session session,
    UuidValue buildingId,
  ) {
    return _articles.listForBuilding(session, buildingId);
  }

  /// Owner creates an article.
  Future<MenuArticleView> create(
    Session session,
    MenuArticleCreate request,
  ) {
    return _articles.create(session, request);
  }

  /// Owner updates an article.
  Future<MenuArticleView> update(
    Session session,
    MenuArticleUpdate request,
  ) {
    return _articles.update(session, request);
  }
}
