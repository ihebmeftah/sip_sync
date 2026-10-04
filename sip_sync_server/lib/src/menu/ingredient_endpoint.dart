import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'ingredient_service.dart';

/// Ingredient inventory RPC for a building (create, list, delete).
class IngredientEndpoint extends Endpoint {
  final _ingredients = IngredientService();

  @override
  bool get requireLogin => true;

  /// Ingredients for [buildingId], name order.
  ///
  /// Owner or assigned employee. [limit] defaults to 20 and is capped at 100.
  Future<IngredientPage> list(
    Session session,
    UuidValue buildingId, {
    int? limit,
    int? offset,
  }) {
    return _ingredients.listForBuilding(
      session,
      buildingId,
      limit: limit,
      offset: offset,
    );
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
