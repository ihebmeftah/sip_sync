import 'package:sip_sync_client/sip_sync_client.dart';

import '../../core/di/app_session_store.dart';

/// Super-admin authentication and staff CRUD for the backoffice app.
class SuperAdminAuthRepository {
  SuperAdminAuthRepository(this._client, this._store);

  final Client _client;
  final AppSessionStore _store;

  Future<AuthTokenResult> login({
    required String email,
    required String password,
  }) async {
    final result = await _client.superAdminAuth.login(
      EmailLoginRequest(email: email, password: password),
    );
    await _store.applyAuth(result);
    return result;
  }

  Future<SuperAdminSessionView> me() => _client.superAdminAuth.me();

  Future<List<SuperAdminView>> list() => _client.superAdminAuth.list();

  Future<SuperAdminView> add({
    required String email,
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) {
    return _client.superAdminAuth.add(
      SuperAdminCreate(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
      ),
    );
  }

  /// Replaces profile fields. Pass [password] only when it should change.
  Future<SuperAdminView> update({
    required UuidValue id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required bool isEnabled,
    String? password,
  }) {
    return _client.superAdminAuth.update(
      SuperAdminUpdate(
        id: id,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
        isEnabled: isEnabled,
      ),
    );
  }

  /// Enables or disables a backoffice user. The server rejects self and default.
  Future<SuperAdminView> setEnabled(UuidValue targetId, bool isEnabled) =>
      _client.superAdminAuth.setEnabled(targetId, isEnabled);

  Future<void> delete(UuidValue targetId) =>
      _client.superAdminAuth.delete(targetId);

  Future<void> signOut() async {
    try {
      await _client.superAdminAuth.logout();
    } catch (_) {}
    await _store.clear();
  }
}
