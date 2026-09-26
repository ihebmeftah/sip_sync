import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'auth_guard.dart';
import 'auth_support.dart';
import 'session_service.dart';

/// Employee username login and profile (no self-register).
class EmployeeAuthEndpoint extends Endpoint {
  final _auth = AuthSupport();

  Future<AuthTokenResult> login(
    Session session,
    UsernameLoginRequest request,
  ) async {
    final username = request.username.trim().toLowerCase();
    final employee = await Employee.db.findFirstRow(
      session,
      where: (t) => t.username.equals(username),
    );
    if (employee == null ||
        !_auth.passwords.verify(request.password, employee.passwordHash)) {
      throw AccountException(
        message: 'Invalid username or password.',
        code: AccountErrorCode.invalidCredentials,
      );
    }
    if (!employee.isEnabled) {
      throw AccountException(
        message: 'This staff account is disabled.',
        code: AccountErrorCode.accountDisabled,
      );
    }
    return _auth.issueEmployee(session, employee);
  }

  Future<EmployeeSessionView> me(Session session) async {
    final id = AuthGuard.requireEmployee(session);
    return _sessionView(session, id);
  }

  Future<EmployeeSessionView> updateMyProfile(
    Session session,
    ProfileUpdate request,
  ) async {
    final id = AuthGuard.requireEmployee(session);
    final phone = _auth.normalizePhone(request.phoneNumber);
    _auth.validatePhone(phone);
    _auth.validateName(request.firstName, request.lastName);
    final employee = await Employee.db.findById(session, id);
    if (employee == null) {
      throw AccountException(
        message: 'Employee not found.',
        code: AccountErrorCode.notFound,
      );
    }
    final phoneHit = await Employee.db.findFirstRow(
      session,
      where: (t) => t.phoneNumber.equals(phone) & t.id.notEquals(id),
    );
    if (phoneHit != null) {
      throw AccountException(
        message: 'Phone already registered.',
        code: AccountErrorCode.phoneTaken,
      );
    }
    await Employee.db.updateRow(
      session,
      employee.copyWith(
        phoneNumber: phone,
        firstName: request.firstName.trim(),
        lastName: request.lastName.trim(),
      ),
    );
    return _sessionView(session, id);
  }

  /// Updates the signed-in employee's password and drops other sessions.
  Future<void> changePassword(
    Session session,
    ChangePasswordRequest request,
  ) async {
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType != ActorType.employee) {
      throw AccountException(
        message: 'Only employees can perform this action.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    _auth.validatePassword(request.newPassword);
    final employee = await Employee.db.findById(session, ctx.actorId);
    if (employee == null) {
      throw AccountException(
        message: 'Employee not found.',
        code: AccountErrorCode.notFound,
      );
    }
    if (!_auth.passwords.verify(
      request.currentPassword,
      employee.passwordHash,
    )) {
      throw AccountException(
        message: 'Current password is incorrect.',
        code: AccountErrorCode.invalidCredentials,
      );
    }
    await Employee.db.updateRow(
      session,
      employee.copyWith(
        passwordHash: _auth.passwords.hash(request.newPassword),
      ),
    );
    await SessionService().revokeOtherSessionsForActor(
      session,
      actorType: ActorType.employee,
      actorId: ctx.actorId,
      keepSessionId: ctx.sessionId,
    );
  }

  Future<void> logout(Session session) async {
    final ctx = AuthGuard.requireAny(session);
    await SessionService().revoke(session, ctx.sessionId);
  }

  Future<EmployeeSessionView> _sessionView(
    Session session,
    UuidValue id,
  ) async {
    final employee = await Employee.db.findById(
      session,
      id,
      include: Employee.include(access: EmployeeAccess.include()),
    );
    if (employee == null) {
      throw AccountException(
        message: 'Employee not found.',
        code: AccountErrorCode.notFound,
      );
    }
    final access = employee.access;
    return EmployeeSessionView(
      id: employee.id!,
      buildingId: employee.buildingId,
      ownerId: employee.ownerId,
      accessId: employee.accessId,
      access: access == null
          ? null
          : EmployeeAccessView(
              id: access.id!,
              buildingId: access.buildingId,
              name: access.name,
              orderCreation: access.orderCreation,
              orderPayment: access.orderPayment,
              cancelOrder: access.cancelOrder,
              preparation: access.preparation,
              serving: access.serving,
              consultAllOrders: access.consultAllOrders,
              createdAt: access.createdAt,
            ),
      username: employee.username,
      phoneNumber: employee.phoneNumber,
      firstName: employee.firstName,
      lastName: employee.lastName,
      isEnabled: employee.isEnabled,
    );
  }
}
