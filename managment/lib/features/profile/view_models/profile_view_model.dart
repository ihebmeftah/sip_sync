import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';

part 'profile_view_model.g.dart';

class ProfileUiState {
  const ProfileUiState({
    this.saving = false,
    this.errorKey,
    this.saved = false,
  });

  final bool saving;
  final String? errorKey;
  final bool saved;

  ProfileUiState copyWith({
    bool? saving,
    String? errorKey,
    bool? saved,
    bool clearError = false,
  }) {
    return ProfileUiState(
      saving: saving ?? this.saving,
      errorKey: clearError ? null : (errorKey ?? this.errorKey),
      saved: saved ?? this.saved,
    );
  }
}

@Riverpod(keepAlive: true)
class ProfileViewModel extends _$ProfileViewModel {
  @override
  ProfileUiState build() => const ProfileUiState();

  Future<bool> save({
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    state = state.copyWith(saving: true, saved: false, clearError: true);
    try {
      final sessionStore = ref.read(appSessionStoreProvider);
      final auth = ref.read(ownerAuthRepositoryProvider);
      if (sessionStore.isOwner) {
        await auth.updateOwnerProfile(
          phoneNumber: phoneNumber,
          firstName: firstName,
          lastName: lastName,
        );
      } else {
        await auth.updateEmployeeProfile(
          phoneNumber: phoneNumber,
          firstName: firstName,
          lastName: lastName,
        );
      }
      state = state.copyWith(saving: false, saved: true);
      return true;
    } catch (error) {
      state = state.copyWith(saving: false, errorKey: mapError(error).l10nKey);
      return false;
    }
  }
}
