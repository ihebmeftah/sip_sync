import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';

part 'packs_view_model.g.dart';

/// Pack catalog plus create, update, and delete.
@Riverpod(keepAlive: true)
class PacksViewModel extends _$PacksViewModel {
  @override
  Future<List<PackView>> build() {
    return ref.read(packRepositoryProvider).list();
  }

  /// Returns the created pack, or an l10n error key when the write failed.
  Future<({String? errorKey, PackView? pack})> create(
    PackCreate request,
  ) async {
    try {
      final pack = await ref.read(packRepositoryProvider).create(request);
      state = AsyncData(await ref.read(packRepositoryProvider).list());
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
      state = AsyncData(await ref.read(packRepositoryProvider).list());
      return null;
    } catch (error) {
      return mapError(error).l10nKey;
    }
  }
}
