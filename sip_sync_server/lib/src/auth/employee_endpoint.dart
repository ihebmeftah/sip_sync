import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'account_service.dart';

/// Owner-only staff management. Employees always belong to one building.
///
/// Separated from [AccountEndpoint] so venue-scoped staff CRUD is not mixed
/// with customer/owner/backoffice identity flows.
class EmployeeEndpoint extends Endpoint {
  final _accounts = AccountService();

  @override
  bool get requireLogin => true;

  /// Owner reads one employee they added.
  Future<EmployeeView> get(
    Session session,
    UuidValue employeeAuthUserId,
  ) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw AccountException(
        message: 'Sign in required.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return _accounts.getEmployee(
      session,
      ownerAuthUserId: userId,
      employeeAuthUserId: employeeAuthUserId,
    );
  }

  /// Owner adds an employee for an existing building.
  Future<EmployeeView> add(Session session, EmployeeCreate request) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw AccountException(
        message: 'Sign in required.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return _accounts.addEmployee(
      session,
      ownerAuthUserId: userId,
      request: request,
    );
  }

  /// Owner updates an added employee's phone and name.
  Future<EmployeeView> update(Session session, EmployeeUpdate request) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw AccountException(
        message: 'Sign in required.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return _accounts.updateEmployee(
      session,
      ownerAuthUserId: userId,
      request: request,
    );
  }

  /// Owner enables or disables management login for that employee.
  Future<EmployeeView> setEnabled(
    Session session,
    UuidValue employeeAuthUserId,
    bool isEnabled,
  ) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw AccountException(
        message: 'Sign in required.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return _accounts.setEmployeeEnabled(
      session,
      ownerAuthUserId: userId,
      employeeAuthUserId: employeeAuthUserId,
      isEnabled: isEnabled,
    );
  }
}
