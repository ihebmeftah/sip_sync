import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

/// Talks to [EndpointAccount] for the management app.
class AccountRepository {
  AccountRepository(this._client);

  final Client _client;

  Client get client => _client;

  Future<AccountSessionView> login({
    required String identifier,
    required String password,
  }) async {
    final result = await _client.account.login(
      LoginRequest(
        identifier: identifier,
        password: password,
        app: SipApp.management,
      ),
    );
    await _client.auth.updateSignedInUser(result.authSuccess);
    return result.session;
  }

  Future<AccountSessionView> register({
    required String email,
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    final result = await _client.account.register(
      SelfRegisterCreate(
        email: email,
        password: password,
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

  Future<AccountSessionView> updateMyProfile({
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) {
    return _client.account.updateMyProfile(
      ProfileUpdate(
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
      ),
    );
  }

  Future<List<EmployeeView>> listEmployees() => _client.account.listEmployees();

  Future<EmployeeView> getEmployee(UuidValue employeeAuthUserId) {
    return _client.account.getEmployee(employeeAuthUserId);
  }

  Future<EmployeeView> addEmployee({
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    UuidValue? buildingId,
  }) {
    return _client.account.addEmployee(
      EmployeeCreate(
        password: password,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
        buildingId: buildingId,
      ),
    );
  }

  Future<EmployeeView> updateEmployee({
    required UuidValue authUserId,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) {
    return _client.account.updateEmployee(
      EmployeeUpdate(
        authUserId: authUserId,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
      ),
    );
  }

  Future<EmployeeView> setEmployeeEnabled({
    required UuidValue authUserId,
    required bool isEnabled,
  }) {
    return _client.account.setEmployeeEnabled(authUserId, isEnabled);
  }

  Future<void> signOut() => _client.auth.signOutDevice();
}
