import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'categories_view_model.g.dart';

@Riverpod(keepAlive: true)
class CategoriesViewModel extends _$CategoriesViewModel {
  late String _buildingId;

  @override
  Future<List<MenuCategoryView>> build(String buildingId) async {
    _buildingId = buildingId;
    ref.watch(signedInActorIdProvider);
    if (buildingId.isEmpty) {
      return const [];
    }
    return ref
        .read(menuCategoryRepositoryProvider)
        .list(UuidValue.fromString(buildingId));
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      if (_buildingId.isEmpty) {
        return const <MenuCategoryView>[];
      }
      return ref
          .read(menuCategoryRepositoryProvider)
          .list(UuidValue.fromString(_buildingId));
    });
  }

  Future<MenuCategoryView> createCategory({
    required String name,
    String? description,
  }) async {
    final saved = await ref
        .read(menuCategoryRepositoryProvider)
        .create(
          buildingId: UuidValue.fromString(_buildingId),
          name: name,
          description: description,
        );
    await refresh();
    return saved;
  }

  Future<MenuCategoryView> updateCategory({
    required UuidValue id,
    required String name,
    String? description,
  }) async {
    final saved = await ref
        .read(menuCategoryRepositoryProvider)
        .update(id: id, name: name, description: description);
    await refresh();
    return saved;
  }
}
