import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/paging/list_paging.dart';

part 'packs_view_model.g.dart';

/// Pack catalog plus create, update, and delete.
@Riverpod(keepAlive: true)
class PacksViewModel extends _$PacksViewModel {
  var _offset = 0;

  @override
  Future<PackPage> build() => _load();

  Future<void> previousPage() => _show(_offset - listPageSize);

  Future<void> nextPage() => _show(_offset + listPageSize);

  Future<void> _show(int offset) async {
    _offset = offset < 0 ? 0 : offset;
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<PackPage> _load() async {
    final page = await ref
        .read(packRepositoryProvider)
        .list(limit: listPageSize, offset: _offset);
    if (page.items.isEmpty && page.offset > 0 && page.total > 0) {
      _offset = ((page.total - 1) ~/ listPageSize) * listPageSize;
      return _load();
    }
    return page;
  }

  /// Returns the created pack, or an l10n error key when the write failed.
  Future<({String? errorKey, PackView? pack})> create(
    PackCreate request,
  ) async {
    try {
      final pack = await ref.read(packRepositoryProvider).create(request);
      state = AsyncData(await _load());
      return (errorKey: null, pack: pack);
    } catch (error) {
      return (errorKey: mapError(error).l10nKey, pack: null);
    }
  }

  /// Returns an l10n error key, or null when the list was refreshed.
  Future<String?> save(PackUpdate request) {
    return _reload(() => ref.read(packRepositoryProvider).update(request));
  }

  /// Returns an l10n error key, or null when the list was refreshed.
  Future<String?> delete(UuidValue id) {
    return _reload(() => ref.read(packRepositoryProvider).delete(id));
  }

  Future<String?> _reload(Future<void> Function() action) async {
    try {
      await action();
      state = AsyncData(await _load());
      return null;
    } catch (error) {
      return mapError(error).l10nKey;
    }
  }
}
