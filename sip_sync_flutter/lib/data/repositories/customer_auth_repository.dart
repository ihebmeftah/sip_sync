import 'package:sip_sync_client/sip_sync_client.dart';

import '../../core/di/app_session_store.dart';

/// Customer authentication for the customer app.
class CustomerAuthRepository {
  CustomerAuthRepository(this._client, this._store);

  final Client _client;
  final AppSessionStore _store;

  Future<AuthTokenResult> register({
    required String email,
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    final result = await _client.customerAuth.register(
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

  Future<AuthTokenResult> login({
    required String email,
    required String password,
  }) async {
    final result = await _client.customerAuth.login(
      EmailLoginRequest(email: email, password: password),
    );
    await _store.applyAuth(result);
    return result;
  }

  Future<CustomerSessionView> me() => _client.customerAuth.me();

  /// Saves the signed-in customer's name and phone, then refreshes the session.
  Future<CustomerSessionView> updateProfile({
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    final view = await _client.customerAuth.updateMyProfile(
      ProfileUpdate(
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
      ),
    );
    await _store.setCustomer(view);
    return view;
  }

  /// Verifies the current password, sets a new one, and signs out other devices.
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return _client.customerAuth.changePassword(
      ChangePasswordRequest(
        currentPassword: currentPassword,
        newPassword: newPassword,
      ),
    );
  }

  Future<void> signOut() async {
    try {
      await _client.customerAuth.logout();
    } catch (_) {}
    await _store.clear();
  }
}
