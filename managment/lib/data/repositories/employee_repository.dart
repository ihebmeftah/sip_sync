import 'package:sip_sync_client/sip_sync_client.dart';

/// Talks to [EndpointEmployee] for building-scoped staff management.
class EmployeeRepository {
  EmployeeRepository(this._client);

  final Client _client;

  Future<EmployeeView> get(UuidValue employeeAuthUserId) {
    return _client.employee.get(employeeAuthUserId);
  }

  Future<EmployeeView> add({
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required UuidValue buildingId,
  }) {
    return _client.employee.add(
      EmployeeCreate(
        password: password,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
        buildingId: buildingId,
      ),
    );
  }

  Future<EmployeeView> update({
    required UuidValue authUserId,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) {
    return _client.employee.update(
      EmployeeUpdate(
        authUserId: authUserId,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
      ),
    );
  }

  Future<EmployeeView> setEnabled({
    required UuidValue authUserId,
    required bool isEnabled,
  }) {
    return _client.employee.setEnabled(authUserId, isEnabled);
  }
}
