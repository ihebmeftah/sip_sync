import 'package:sip_sync_client/sip_sync_client.dart';

/// Building-scoped ingredient create / list / delete.
class IngredientRepository {
  IngredientRepository(this._client);

  final Client _client;

  Future<List<IngredientView>> list(UuidValue buildingId) =>
      _client.ingredient.list(buildingId);

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
}
