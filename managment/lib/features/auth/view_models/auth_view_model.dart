import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/di/building_session.dart';
import '../../../core/di/management_session_cache.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../data/repositories/account_repository.dart';
import '../../../data/repositories/building_repository.dart';

part 'auth_view_model.g.dart';

class AuthState {
  const AuthState({this.session, this.isLoading = false, this.errorKey});

  final AccountSessionView? session;
  final bool isLoading;
  final String? errorKey;

  AuthState copyWith({
    AccountSessionView? session,
    bool? isLoading,
    String? errorKey,
    bool clearError = false,
    bool clearSession = false,
  }) {
    return AuthState(
      session: clearSession ? null : (session ?? this.session),
      isLoading: isLoading ?? this.isLoading,
      errorKey: clearError ? null : (errorKey ?? this.errorKey),
    );
  }
}

/// Stable identity for dependents that must not rebuild on loading/error flips.
@Riverpod(keepAlive: true)
UuidValue? signedInAuthUserId(Ref ref) {
  return ref.watch(authViewModelProvider).session?.profile.authUserId;
}

@Riverpod(keepAlive: true)
class AuthViewModel extends _$AuthViewModel {
  AccountRepository get _repository => ref.read(accountRepositoryProvider);

  @override
  AuthState build() {
    _repository.client.auth.authInfoListenable.addListener(_onAuthChanged);
    ref.onDispose(() {
      _repository.client.auth.authInfoListenable.removeListener(_onAuthChanged);
    });
    Future<void>.microtask(restore);
    return const AuthState();
  }

  bool get isSignedIn => _repository.client.auth.isAuthenticated;

  Future<void> restore() async {
    if (!_repository.client.auth.isAuthenticated) {
      return;
    }
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final session = await _repository.me();
      await _applySession(session);
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorKey: mapError(error).l10nKey,
      );
    }
  }

  Future<bool> login(String identifier, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final session = await _repository.login(
        identifier: identifier,
        password: password,
      );
      await _applySession(session);
      return true;
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorKey: mapError(error).l10nKey,
      );
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final session = await _repository.register(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
      );
      await _applySession(session);
      return true;
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorKey: mapError(error).l10nKey,
      );
      return false;
    }
  }

  /// Keeps [AuthState.session] aligned after a profile save.
  Future<void> applySession(AccountSessionView session) =>
      _applySession(session);

  Future<void> signOut() async {
    await _repository.signOut();
    getIt<BuildingSession>().clear();
    getIt<ManagementSessionCache>().clear();
    state = const AuthState();
  }

  Future<void> _applySession(AccountSessionView session) async {
    getIt<ManagementSessionCache>().setSession(session);
    final buildingId = session.buildingId;
    if (buildingId != null) {
      getIt<BuildingSession>().select(buildingId);
      try {
        final building = await getIt<BuildingRepository>().get(buildingId);
        getIt<BuildingSession>().upsert(building);
        getIt<BuildingSession>().select(building.id);
      } catch (_) {
        // Sidebar name may be empty until a later load; routing still works.
      }
    }
    state = state.copyWith(
      session: session,
      isLoading: false,
      clearError: true,
    );
  }

  void _onAuthChanged() {
    if (!_repository.client.auth.isAuthenticated) {
      getIt<BuildingSession>().clear();
      getIt<ManagementSessionCache>().clear();
      state = const AuthState();
    }
  }
}
