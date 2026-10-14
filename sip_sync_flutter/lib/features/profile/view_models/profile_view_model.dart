import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';

part 'profile_view_model.g.dart';

/// Save and password-change state for the signed-in customer.
class ProfileUiState {
  const ProfileUiState({
    this.saving = false,
    this.errorKey,
    this.saved = false,
    this.changingPassword = false,
    this.passwordErrorKey,
    this.passwordChanged = false,
  });

  final bool saving;
  final String? errorKey;
  final bool saved;
  final bool changingPassword;
  final String? passwordErrorKey;
  final bool passwordChanged;

  ProfileUiState copyWith({
    bool? saving,
    String? errorKey,
    bool? saved,
    bool? changingPassword,
    String? passwordErrorKey,
    bool? passwordChanged,
    bool clearError = false,
    bool clearPasswordError = false,
  }) {
    return ProfileUiState(
      saving: saving ?? this.saving,
      errorKey: clearError ? null : (errorKey ?? this.errorKey),
      saved: saved ?? this.saved,
      changingPassword: changingPassword ?? this.changingPassword,
      passwordErrorKey: clearPasswordError
          ? null
          : (passwordErrorKey ?? this.passwordErrorKey),
      passwordChanged: passwordChanged ?? this.passwordChanged,
    );
  }
}

@Riverpod(keepAlive: true)
class ProfileViewModel extends _$ProfileViewModel {
  @override
  ProfileUiState build() => const ProfileUiState();

  /// Updates name and phone for the signed-in customer.
  Future<bool> save({
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    state = state.copyWith(saving: true, saved: false, clearError: true);
    try {
      await ref
          .read(customerAuthRepositoryProvider)
          .updateProfile(
            phoneNumber: phoneNumber,
            firstName: firstName,
            lastName: lastName,
          );
      state = state.copyWith(saving: false, saved: true);
      return true;
    } catch (error) {
      state = state.copyWith(saving: false, errorKey: mapError(error).l10nKey);
      return false;
    }
  }

  /// Replaces the password after the current one matches.
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    state = state.copyWith(
      changingPassword: true,
      passwordChanged: false,
      clearPasswordError: true,
    );
    try {
      await ref
          .read(customerAuthRepositoryProvider)
          .changePassword(
            currentPassword: currentPassword,
            newPassword: newPassword,
          );
      state = state.copyWith(changingPassword: false, passwordChanged: true);
      return true;
    } catch (error) {
      state = state.copyWith(
        changingPassword: false,
        passwordErrorKey: mapError(error).l10nKey,
      );
      return false;
    }
  }
}
