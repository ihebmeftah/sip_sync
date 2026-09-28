import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';

part 'users_view_model.g.dart';

/// Backoffice user list plus create, update, enable, and delete.
@Riverpod(keepAlive: true)
class UsersViewModel extends _$UsersViewModel {
  @override
  Future<List<SuperAdminView>> build() {
    return ref.read(superAdminAuthRepositoryProvider).list();
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
      state = AsyncData(
        await ref.read(superAdminAuthRepositoryProvider).list(),
      );
      return null;
    } catch (error) {
      return mapError(error).l10nKey;
    }
  }
}
