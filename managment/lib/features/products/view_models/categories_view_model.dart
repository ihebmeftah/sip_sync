import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/paging/list_paging.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'categories_view_model.g.dart';

/// Full category catalog for forms and the order wizard.
@riverpod
Future<List<MenuCategoryView>> categoryCatalog(Ref ref, String buildingId) {
  ref.watch(signedInActorIdProvider);
  if (buildingId.isEmpty) {
    return Future.value(const []);
  }
  return ref
      .read(menuCategoryRepositoryProvider)
      .listAll(UuidValue.fromString(buildingId));
}

@Riverpod(keepAlive: true)
class CategoriesViewModel extends _$CategoriesViewModel {
  late String _buildingId;
  var _offset = 0;

  @override
  Future<MenuCategoryPage> build(String buildingId) async {
    _buildingId = buildingId;
    _offset = 0;
    ref.watch(signedInActorIdProvider);
    return _load();
  }

  Future<void> refresh() async {
    ref.invalidate(categoryCatalogProvider(_buildingId));
    state = await AsyncValue.guard(_load);
  }

  Future<void> previousPage() => _show(_offset - listPageSize);

  Future<void> nextPage() => _show(_offset + listPageSize);

  Future<void> _show(int offset) async {
    _offset = offset < 0 ? 0 : offset;
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<MenuCategoryPage> _load() async {
    if (_buildingId.isEmpty) {
      return _empty(0);
    }
    final page = await ref
        .read(menuCategoryRepositoryProvider)
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

  MenuCategoryPage _empty(int offset) {
    return MenuCategoryPage(
      items: const [],
      total: 0,
      limit: listPageSize,
      offset: offset,
    );
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
