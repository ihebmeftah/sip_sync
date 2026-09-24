import 'package:sip_sync_client/sip_sync_client.dart';

/// Building-scoped staff CRUD.
class EmployeeRepository {
  EmployeeRepository(this._client);

  final Client _client;

  Future<EmployeeView> get(UuidValue employeeId) =>
      _client.employee.get(employeeId);

  Future<EmployeeView> add({
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required UuidValue buildingId,
    required UuidValue accessId,
  }) {
    return _client.employee.add(
      EmployeeCreate(
        password: password,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
        buildingId: buildingId,
        accessId: accessId,
      ),
    );
  }

  Future<EmployeeView> update({
    required UuidValue id,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required UuidValue accessId,
  }) {
    return _client.employee.update(
      EmployeeUpdate(
        id: id,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
        accessId: accessId,
      ),
    );
  }

  Future<EmployeeView> setEnabled({
    required UuidValue id,
    required bool isEnabled,
  }) {
    return _client.employee.setEnabled(id, isEnabled);
  }
}
