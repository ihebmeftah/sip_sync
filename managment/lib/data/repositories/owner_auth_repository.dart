import 'package:sip_sync_client/sip_sync_client.dart';

import '../../core/di/app_session_store.dart';

/// Owner and employee authentication for the management app.
class OwnerAuthRepository {
  OwnerAuthRepository(this._client, this._store);

  final Client _client;
  final AppSessionStore _store;

  Future<AuthTokenResult> registerOwner({
    required String email,
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    final result = await _client.ownerAuth.register(
      EmailRegisterCreate(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
      ),
    );
    await _store.applyAuth(result);
    return result;
  }

  Future<AuthTokenResult> loginOwner({
    required String email,
    required String password,
  }) async {
    final result = await _client.ownerAuth.login(
      EmailLoginRequest(email: email, password: password),
    );
    await _store.applyAuth(result);
    return result;
  }

  Future<AuthTokenResult> loginEmployee({
    required String username,
    required String password,
  }) async {
    final result = await _client.employeeAuth.login(
      UsernameLoginRequest(username: username, password: password),
    );
    await _store.applyAuth(result);
    return result;
  }

  Future<OwnerSessionView> ownerMe() => _client.ownerAuth.me();

  Future<EmployeeSessionView> employeeMe() => _client.employeeAuth.me();

  Future<OwnerSessionView> updateOwnerProfile({
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    final view = await _client.ownerAuth.updateMyProfile(
      ProfileUpdate(
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
      ),
    );
    await _store.setOwner(view);
    return view;
  }

  Future<EmployeeSessionView> updateEmployeeProfile({
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    final view = await _client.employeeAuth.updateMyProfile(
      ProfileUpdate(
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
      ),
    );
    await _store.setEmployee(view);
    return view;
  }

  Future<void> signOut() async {
    try {
      if (_store.isOwner) {
        await _client.ownerAuth.logout();
      } else if (_store.isEmployee) {
        await _client.employeeAuth.logout();
      }
    } catch (_) {
      // Clear local session anyway.
    }
    await _store.clear();
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final request = ChangePasswordRequest(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    if (_store.isOwner) {
      await _client.ownerAuth.changePassword(request);
    } else if (_store.isEmployee) {
      await _client.employeeAuth.changePassword(request);
    } else {
      throw AccountException(
        message: 'Sign in required.',
        code: AccountErrorCode.notAuthorized,
      );
    }
  }

  /// Owner-only. Returns [PasswordResetRequestResult.debugCode] in dev/test.
  Future<PasswordResetRequestResult> requestPasswordReset(String email) {
    return _client.ownerAuth.requestPasswordReset(
      PasswordResetRequest(email: email),
    );
  }

  Future<void> confirmPasswordReset({
    required String email,
    required String code,
    required String newPassword,
  }) {
    return _client.ownerAuth.confirmPasswordReset(
      PasswordResetConfirm(email: email, code: code, newPassword: newPassword),
    );
  }
}
