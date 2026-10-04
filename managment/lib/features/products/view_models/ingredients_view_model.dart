import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/paging/list_paging.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'ingredients_view_model.g.dart';

/// Full ingredient catalog for recipe editors.
@riverpod
Future<List<IngredientView>> ingredientCatalog(Ref ref, String buildingId) {
  ref.watch(signedInActorIdProvider);
  if (buildingId.isEmpty) {
    return Future.value(const []);
  }
  return ref
      .read(ingredientRepositoryProvider)
      .listAll(UuidValue.fromString(buildingId));
}

@Riverpod(keepAlive: true)
class IngredientsViewModel extends _$IngredientsViewModel {
  late String _buildingId;
  var _offset = 0;

  @override
  Future<IngredientPage> build(String buildingId) async {
    _buildingId = buildingId;
    _offset = 0;
    ref.watch(signedInActorIdProvider);
    return _load();
  }

  Future<void> refresh() async {
    ref.invalidate(ingredientCatalogProvider(_buildingId));
    state = await AsyncValue.guard(_load);
  }

  Future<void> previousPage() => _show(_offset - listPageSize);

  Future<void> nextPage() => _show(_offset + listPageSize);

  Future<void> _show(int offset) async {
    _offset = offset < 0 ? 0 : offset;
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<IngredientPage> _load() async {
    if (_buildingId.isEmpty) {
      return IngredientPage(
        items: const [],
        total: 0,
        limit: listPageSize,
        offset: 0,
      );
    }
    final page = await ref
        .read(ingredientRepositoryProvider)
        .list(
          UuidValue.fromString(_buildingId),
          limit: listPageSize,
          offset: _offset,
        );
    if (page.items.isEmpty && page.offset > 0 && page.total > 0) {
      _offset = ((page.total - 1) ~/ listPageSize) * listPageSize;
      return _load();
    }
    return page;
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

  Future<IngredientView> restock({
    required UuidValue id,
    required double quantity,
  }) async {
    final saved = await ref
        .read(ingredientRepositoryProvider)
        .restock(id: id, quantity: quantity);
    final current = state.asData?.value;
    if (current == null) {
      await refresh();
    } else {
      state = AsyncData(
        current.copyWith(
          items: [
            for (final row in current.items)
              if (row.id == saved.id) saved else row,
          ],
        ),
      );
      ref.invalidate(ingredientCatalogProvider(_buildingId));
    }
    return saved;
  }
}
