import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'ingredients_view_model.g.dart';

@Riverpod(keepAlive: true)
class IngredientsViewModel extends _$IngredientsViewModel {
  late String _buildingId;

  @override
  Future<List<IngredientView>> build(String buildingId) async {
    _buildingId = buildingId;
    ref.watch(signedInActorIdProvider);
    if (buildingId.isEmpty) {
      return const [];
    }
    return ref
        .read(ingredientRepositoryProvider)
        .list(UuidValue.fromString(buildingId));
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      if (_buildingId.isEmpty) {
        return const <IngredientView>[];
      }
      return ref
          .read(ingredientRepositoryProvider)
          .list(UuidValue.fromString(_buildingId));
    });
  }

  Future<IngredientView> createIngredient({
    required String name,
    required UnitsType unit,
    required double currentStock,
    required double thresholdStock,
  }) async {
    final saved = await ref
        .read(ingredientRepositoryProvider)
        .create(
          buildingId: UuidValue.fromString(_buildingId),
          name: name,
          unit: unit,
          currentStock: currentStock,
          thresholdStock: thresholdStock,
        );
    await refresh();
    return saved;
  }

  Future<void> deleteIngredient(UuidValue id) async {
    await ref.read(ingredientRepositoryProvider).delete(id);
    await refresh();
  }
}
