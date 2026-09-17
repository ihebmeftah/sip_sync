import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/di/app_session_store.dart';
import '../../../core/di/building_session.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../data/repositories/building_repository.dart';
import '../../../data/repositories/owner_auth_repository.dart';

part 'auth_view_model.g.dart';

class AuthState {
  const AuthState({this.isLoading = false, this.errorKey});

  final bool isLoading;
  final String? errorKey;

  AuthState copyWith({
    bool? isLoading,
    String? errorKey,
    bool clearError = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorKey: clearError ? null : (errorKey ?? this.errorKey),
    );
  }
}

@Riverpod(keepAlive: true)
UuidValue? signedInActorId(Ref ref) {
  final store = ref.watch(appSessionStoreProvider);
  return store.actorId;
}

@Riverpod(keepAlive: true)
class AuthViewModel extends _$AuthViewModel {
  OwnerAuthRepository get _repo => ref.read(ownerAuthRepositoryProvider);
  AppSessionStore get _store => getIt<AppSessionStore>();

  @override
  AuthState build() {
    _store.addListener(_onStoreChanged);
    ref.onDispose(() => _store.removeListener(_onStoreChanged));
    Future<void>.microtask(restore);
    return const AuthState();
  }

  void _onStoreChanged() {
    // Force dependents that read the store via GetIt to rebuild when needed.
    ref.invalidate(signedInActorIdProvider);
  }

  Future<void> restore() async {
    if (!_store.isSignedIn) {
      return;
    }
    // Prefer persisted actor profile immediately; refresh from server.
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      if (_store.actorType == ActorType.owner || _store.owner != null) {
        final me = await _repo.ownerMe();
        await _store.setOwner(me);
      } else if (_store.actorType == ActorType.employee ||
          _store.employee != null) {
        final me = await _repo.employeeMe();
        await _store.setEmployee(me);
        getIt<BuildingSession>().select(me.buildingId);
        try {
          final building = await getIt<BuildingRepository>().get(me.buildingId);
          getIt<BuildingSession>().upsert(building);
          getIt<BuildingSession>().select(building.id);
        } catch (_) {}
      } else {
        // Token without actor metadata — force re-login.
        await _store.clear();
        getIt<BuildingSession>().clear();
      }
      state = state.copyWith(isLoading: false);
    } catch (error) {
      await _store.clear();
      getIt<BuildingSession>().clear();
      state = state.copyWith(
        isLoading: false,
        errorKey: mapError(error).l10nKey,
      );
    }
  }

  Future<bool> loginOwner(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repo.loginOwner(email: email, password: password);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorKey: mapError(error).l10nKey,
      );
      return false;
    }
  }

  Future<bool> loginEmployee(String username, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final result = await _repo.loginEmployee(
        username: username,
        password: password,
      );
      final buildingId = result.employee!.buildingId;
      getIt<BuildingSession>().select(buildingId);
      try {
        final building = await getIt<BuildingRepository>().get(buildingId);
        getIt<BuildingSession>().upsert(building);
        getIt<BuildingSession>().select(building.id);
      } catch (_) {}
      state = state.copyWith(isLoading: false);
      return true;
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorKey: mapError(error).l10nKey,
      );
      return false;
    }
  }

  Future<bool> registerOwner({
    required String email,
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repo.registerOwner(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
      );
      state = state.copyWith(isLoading: false);
      return true;
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorKey: mapError(error).l10nKey,
      );
      return false;
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
    getIt<BuildingSession>().clear();
    state = const AuthState();
  }
}
