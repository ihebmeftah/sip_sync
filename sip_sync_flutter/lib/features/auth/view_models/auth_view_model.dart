import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/di/app_session_store.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../data/repositories/customer_auth_repository.dart';

part 'auth_view_model.g.dart';

class AuthState {
  const AuthState({
    this.session,
    this.isLoading = false,
    this.errorKey,
  });

  final CustomerSessionView? session;
  final bool isLoading;
  final String? errorKey;

  AuthState copyWith({
    CustomerSessionView? session,
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
  CustomerAuthRepository get _repository =>
      ref.read(customerAuthRepositoryProvider);
  AppSessionStore get _store => getIt<AppSessionStore>();

  @override
  AuthState build() {
    _store.addListener(_onStoreChanged);
    ref.onDispose(() => _store.removeListener(_onStoreChanged));
    Future<void>.microtask(restore);
    return AuthState(session: _store.customer);
  }

  bool get isSignedIn => _store.isSignedIn;

  Future<void> restore() async {
    if (!_store.isSignedIn) {
      return;
    }
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final session = await _repository.me();
      await _store.setCustomer(session);
      state = state.copyWith(session: session, isLoading: false);
    } catch (error) {
      await _store.clear();
      state = state.copyWith(
        isLoading: false,
        clearSession: true,
        errorKey: mapError(error).l10nKey,
      );
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final result = await _repository.login(email: email, password: password);
      state = state.copyWith(
        session: result.customer,
        isLoading: false,
      );
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
      final result = await _repository.register(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
      );
      state = state.copyWith(
        session: result.customer,
        isLoading: false,
      );
      return true;
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorKey: mapError(error).l10nKey,
      );
      return false;
    }
  }

  /// Drops a server message once the customer edits the form.
  void clearError() {
    if (state.errorKey == null) {
      return;
    }
    state = state.copyWith(clearError: true);
  }

  Future<void> signOut() async {
    await _repository.signOut();
    state = const AuthState();
  }

  void _onStoreChanged() {
    if (!_store.isSignedIn) {
      state = const AuthState();
    } else if (_store.customer != null) {
      state = state.copyWith(session: _store.customer);
    }
  }
}
