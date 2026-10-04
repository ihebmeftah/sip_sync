import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'menu_category_service.dart';

/// Menu category RPC for a building.
class MenuCategoryEndpoint extends Endpoint {
  final _categories = MenuCategoryService();

  @override
  bool get requireLogin => true;

  /// Categories for [buildingId], name order.
  ///
  /// Owner or assigned employee. [limit] defaults to 20 and is capped at 100.
  Future<MenuCategoryPage> list(
    Session session,
    UuidValue buildingId, {
    int? limit,
    int? offset,
  }) {
    return _categories.listForBuilding(
      session,
      buildingId,
      limit: limit,
      offset: offset,
    );
  }

  /// Owner creates a category.
  Future<MenuCategoryView> create(
    Session session,
    MenuCategoryCreate request,
  ) {
    return _categories.create(session, request);
  }

  /// Owner updates a category.
  Future<MenuCategoryView> update(
    Session session,
    MenuCategoryUpdate request,
  ) {
    return _categories.update(session, request);
  }
}
