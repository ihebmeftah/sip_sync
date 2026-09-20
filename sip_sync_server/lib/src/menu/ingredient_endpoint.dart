import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'ingredient_service.dart';

/// Ingredient inventory RPC for a building (create, list, delete).
class IngredientEndpoint extends Endpoint {
  final _ingredients = IngredientService();

  @override
  bool get requireLogin => true;

  /// Lists ingredients for [buildingId] (owner or assigned employee).
  Future<List<IngredientView>> list(
    Session session,
    UuidValue buildingId,
  ) {
    return _ingredients.listForBuilding(session, buildingId);
  }

  /// Owner creates an ingredient.
  Future<IngredientView> create(
    Session session,
    IngredientCreate request,
  ) {
    return _ingredients.create(session, request);
  }

  /// Owner deletes an ingredient by [id].
  Future<void> delete(Session session, UuidValue id) {
    return _ingredients.delete(session, id);
  }

  /// Owner or employee adds incoming quantity to stock.
  Future<IngredientView> restock(
    Session session,
    IngredientRestock request,
  ) {
    return _ingredients.restock(session, request);
  }
}
