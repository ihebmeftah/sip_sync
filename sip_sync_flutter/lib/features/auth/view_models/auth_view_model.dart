import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../data/repositories/account_repository.dart';

part 'auth_view_model.g.dart';

class AuthState {
  const AuthState({
    this.session,
    this.isLoading = false,
    this.errorKey,
  });

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
      state = state.copyWith(session: session, isLoading: false);
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorKey: mapError(error).l10nKey,
      );
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final session = await _repository.login(email: email, password: password);
      state = state.copyWith(session: session, isLoading: false);
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
      state = state.copyWith(session: session, isLoading: false);
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
    await _repository.signOut();
    state = const AuthState();
  }

  void _onAuthChanged() {
    if (!_repository.client.auth.isAuthenticated) {
      state = const AuthState();
    }
  }
}
