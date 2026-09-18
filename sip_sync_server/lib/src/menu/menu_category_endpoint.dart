import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'menu_category_service.dart';

/// Menu category RPC for a building.
class MenuCategoryEndpoint extends Endpoint {
  final _categories = MenuCategoryService();

  @override
  bool get requireLogin => true;

  /// Lists categories for [buildingId] (owner or assigned employee).
  Future<List<MenuCategoryView>> list(
    Session session,
    UuidValue buildingId,
  ) {
    return _categories.listForBuilding(session, buildingId);
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
