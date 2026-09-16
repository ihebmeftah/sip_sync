import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

/// Talks to [EndpointAccount] for the management app.
class AccountRepository {
  AccountRepository(this._client);

  final Client _client;

  Client get client => _client;

  Future<AccountSessionView> login({
    required String email,
    required String password,
  }) async {
    final result = await _client.account.login(
      LoginRequest(email: email, password: password, app: SipApp.management),
    );
    await _client.auth.updateSignedInUser(result.authSuccess);
    return result.session;
  }

  Future<AccountSessionView> register({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    final result = await _client.account.register(
      SelfRegisterCreate(
        email: email,
        password: password,
        username: username,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
        app: SipApp.management,
      ),
    );
    await _client.auth.updateSignedInUser(result.authSuccess);
    return result.session;
  }

  Future<AccountSessionView> me() => _client.account.me();

  Future<List<ProfileView>> listEmployees() => _client.account.listEmployees();

  Future<ProfileView> addEmployee({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) {
    return _client.account.addEmployee(
      EmployeeCreate(
        email: email,
        password: password,
        username: username,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
      ),
    );
  }

  Future<void> signOut() => _client.auth.signOutDevice();
}
