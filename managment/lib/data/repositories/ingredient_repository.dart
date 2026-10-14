import 'package:sip_sync_client/sip_sync_client.dart';

import '../../core/paging/list_paging.dart';

/// Building-scoped ingredient create / list / delete.
class IngredientRepository {
  IngredientRepository(this._client);

  final Client _client;

  /// Ingredients whose current stock is zero.
  Future<int> outOfStockCount(UuidValue buildingId) =>
      _client.ingredient.outOfStockCount(buildingId);

  Future<IngredientPage> list(
    UuidValue buildingId, {
    int? limit,
    int? offset,
    bool? outOfStock,
  }) => _client.ingredient.list(
    buildingId,
    limit: limit,
    offset: offset,
    outOfStock: outOfStock,
  );

  /// Every ingredient, for recipe pickers.
  Future<List<IngredientView>> listAll(UuidValue buildingId) {
    return collectPages(
      load: (offset) async {
        final page = await list(buildingId, limit: 100, offset: offset);
        return (items: page.items, total: page.total);
      },
    );
  }

  Future<IngredientView> create({
    required UuidValue buildingId,
    required String name,
    required UnitsType unit,
    required double currentStock,
    required double thresholdStock,
  }) {
    return _client.ingredient.create(
      IngredientCreate(
        buildingId: buildingId,
        name: name,
        unit: unit,
        currentStock: currentStock,
        thresholdStock: thresholdStock,
      ),
    );
  }

  Future<void> delete(UuidValue id) => _client.ingredient.delete(id);

  Future<IngredientView> restock({
    required UuidValue id,
    required double quantity,
  }) {
    return _client.ingredient.restock(
      IngredientRestock(id: id, quantity: quantity),
    );
  }
}
