import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'profile_view_model.g.dart';

class ProfileUiState {
  const ProfileUiState({
    this.employees = const [],
    this.loadingTeam = false,
    this.saving = false,
    this.adding = false,
    this.errorKey,
    this.saved = false,
  });

  final List<ProfileView> employees;
  final bool loadingTeam;
  final bool saving;
  final bool adding;
  final String? errorKey;
  final bool saved;

  ProfileUiState copyWith({
    List<ProfileView>? employees,
    bool? loadingTeam,
    bool? saving,
    bool? adding,
    String? errorKey,
    bool? saved,
    bool clearError = false,
  }) {
    return ProfileUiState(
      employees: employees ?? this.employees,
      loadingTeam: loadingTeam ?? this.loadingTeam,
      saving: saving ?? this.saving,
      adding: adding ?? this.adding,
      errorKey: clearError ? null : (errorKey ?? this.errorKey),
      saved: saved ?? this.saved,
    );
  }
}

@Riverpod(keepAlive: true)
class ProfileViewModel extends _$ProfileViewModel {
  @override
  ProfileUiState build() {
    ref.listen(authViewModelProvider, (previous, next) {
      if (next.session == null) {
        state = const ProfileUiState();
        return;
      }
      if (previous?.session == null) {
        loadTeam();
      }
    });
    Future<void>.microtask(loadTeam);
    return const ProfileUiState();
  }

  bool get isOwner {
    final roles =
        ref.read(authViewModelProvider).session?.profile.roles ??
        const <String>[];
    return roles.contains('owner');
  }

  Future<void> loadTeam() async {
    if (!isOwner) {
      state = state.copyWith(loadingTeam: false);
      return;
    }
    state = state.copyWith(loadingTeam: true, clearError: true);
    try {
      final list = await ref.read(accountRepositoryProvider).listEmployees();
      state = state.copyWith(employees: list, loadingTeam: false);
    } catch (error) {
      state = state.copyWith(
        loadingTeam: false,
        errorKey: mapError(error).l10nKey,
      );
    }
  }

  Future<bool> save({
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    state = state.copyWith(saving: true, saved: false, clearError: true);
    try {
      final session = await ref
          .read(accountRepositoryProvider)
          .updateMyProfile(
            username: username,
            phoneNumber: phoneNumber,
            firstName: firstName,
            lastName: lastName,
          );
      ref.read(authViewModelProvider.notifier).applySession(session);
      state = state.copyWith(saving: false, saved: true);
      return true;
    } catch (error) {
      state = state.copyWith(saving: false, errorKey: mapError(error).l10nKey);
      return false;
    }
  }

  Future<bool> addEmployee({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    state = state.copyWith(adding: true, clearError: true);
    try {
      await ref
          .read(accountRepositoryProvider)
          .addEmployee(
            email: email,
            password: password,
            username: username,
            phoneNumber: phoneNumber,
            firstName: firstName,
            lastName: lastName,
          );
      state = state.copyWith(adding: false);
      await loadTeam();
      return true;
    } catch (error) {
      state = state.copyWith(adding: false, errorKey: mapError(error).l10nKey);
      return false;
    }
  }
}
