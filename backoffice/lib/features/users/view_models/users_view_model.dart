import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/paging/list_paging.dart';

part 'users_view_model.g.dart';

/// Backoffice user list plus create, update, enable, and delete.
@Riverpod(keepAlive: true)
class UsersViewModel extends _$UsersViewModel {
  var _offset = 0;

  @override
  Future<SuperAdminPage> build() => _load();

  Future<void> previousPage() => _show(_offset - listPageSize);

  Future<void> nextPage() => _show(_offset + listPageSize);

  Future<void> _show(int offset) async {
    _offset = offset < 0 ? 0 : offset;
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<SuperAdminPage> _load() async {
    final page = await ref
        .read(superAdminAuthRepositoryProvider)
        .list(limit: listPageSize, offset: _offset);
    if (page.items.isEmpty && page.offset > 0 && page.total > 0) {
      _offset = ((page.total - 1) ~/ listPageSize) * listPageSize;
      return _load();
    }
    return page;
  }

  /// Returns an l10n error key, or null when the list was refreshed.
  Future<String?> create({
    required String email,
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) {
    return _reload(() {
      return ref
          .read(superAdminAuthRepositoryProvider)
          .add(
            email: email,
            password: password,
            phoneNumber: phoneNumber,
            firstName: firstName,
            lastName: lastName,
          );
    });
  }

  /// Returns an l10n error key, or null when the list was refreshed.
  Future<String?> save({
    required UuidValue id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required bool isEnabled,
    String? password,
  }) {
    return _reload(() {
      return ref
          .read(superAdminAuthRepositoryProvider)
          .update(
            id: id,
            email: email,
            phoneNumber: phoneNumber,
            firstName: firstName,
            lastName: lastName,
            isEnabled: isEnabled,
            password: password,
          );
    });
  }

  /// Returns an l10n error key, or null when the list was refreshed.
  Future<String?> setEnabled(UuidValue id, bool isEnabled) {
    return _reload(
      () =>
          ref.read(superAdminAuthRepositoryProvider).setEnabled(id, isEnabled),
    );
  }

  /// Returns an l10n error key, or null when the list was refreshed.
  Future<String?> delete(UuidValue id) {
    return _reload(() => ref.read(superAdminAuthRepositoryProvider).delete(id));
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
