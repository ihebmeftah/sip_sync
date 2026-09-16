import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'account_service.dart';

/// Public registration/login plus owner and backoffice user management.
///
/// App access is enforced here; Flutter route guards are UX only.
class AccountEndpoint extends Endpoint {
  final _accounts = AccountService();

  /// Customer or owner self-registration. Reuses an existing email identity
  /// when the password matches.
  Future<AuthSessionResult> register(
    Session session,
    SelfRegisterCreate request,
  ) {
    return _accounts.register(session, request);
  }

  /// Email or username login for one [LoginRequest.app].
  Future<AuthSessionResult> login(
    Session session,
    LoginRequest request,
  ) {
    return _accounts.login(session, request);
  }

  /// Current profile and roles.
  Future<AccountSessionView> me(Session session) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw AccountException(
        message: 'Sign in required.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return _accounts.me(session, userId);
  }

  /// Updates the signed-in user's phone and name.
  Future<AccountSessionView> updateMyProfile(
    Session session,
    ProfileUpdate request,
  ) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw AccountException(
        message: 'Sign in required.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return _accounts.updateMyProfile(
      session,
      authUserId: userId,
      request: request,
    );
  }

  /// Owner reads one employee they added.
  Future<EmployeeView> getEmployee(
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

  /// Owner adds an employee (new account with generated username).
  Future<EmployeeView> addEmployee(
    Session session,
    EmployeeCreate request,
  ) async {
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

  /// Employees added by the signed-in owner.
  Future<List<EmployeeView>> listEmployees(Session session) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw AccountException(
        message: 'Sign in required.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return _accounts.listEmployees(session, userId);
  }

  /// Owner updates an added employee's username, phone, and name.
  Future<EmployeeView> updateEmployee(
    Session session,
    EmployeeUpdate request,
  ) async {
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
  Future<EmployeeView> setEmployeeEnabled(
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

  /// Backoffice admin creates another backoffice user (`isAdmin` stays false).
  Future<BackofficeUserView> addBackofficeUser(
    Session session,
    BackofficeUserCreate request,
  ) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw AccountException(
        message: 'Sign in required.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return _accounts.addBackofficeUser(
      session,
      actorId: userId,
      request: request,
    );
  }

  /// Lists platform backoffice users.
  Future<List<BackofficeUserView>> listBackofficeUsers(Session session) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw AccountException(
        message: 'Sign in required.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return _accounts.listBackofficeUsers(session, userId);
  }

  /// Deletes a non-default backoffice membership.
  Future<void> deleteBackofficeUser(
    Session session,
    UuidValue targetAuthUserId,
  ) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw AccountException(
        message: 'Sign in required.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    await _accounts.deleteBackofficeUser(
      session,
      actorId: userId,
      targetId: targetAuthUserId,
    );
  }
}
