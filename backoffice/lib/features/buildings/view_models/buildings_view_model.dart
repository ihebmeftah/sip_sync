import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/paging/list_paging.dart';

part 'buildings_view_model.g.dart';

/// Platform building list for the backoffice console.
@Riverpod(keepAlive: true)
class BuildingsViewModel extends _$BuildingsViewModel {
  var _offset = 0;

  @override
  Future<AdminBuildingPage> build() => _load();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<void> previousPage() => _show(_offset - listPageSize);

  Future<void> nextPage() => _show(_offset + listPageSize);

  Future<void> _show(int offset) async {
    _offset = offset < 0 ? 0 : offset;
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<AdminBuildingPage> _load() async {
    final page = await ref
        .read(adminBuildingRepositoryProvider)
        .listAll(limit: listPageSize, offset: _offset);
    if (page.items.isEmpty && page.offset > 0 && page.total > 0) {
      _offset = ((page.total - 1) ~/ listPageSize) * listPageSize;
      return _load();
    }
    return page;
  }
}
