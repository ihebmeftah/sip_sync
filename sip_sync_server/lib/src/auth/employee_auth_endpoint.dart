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
    final employee = await Employee.db.findById(session, id);
    if (employee == null) {
      throw AccountException(
        message: 'Employee not found.',
        code: AccountErrorCode.notFound,
      );
    }
    return EmployeeSessionView(
      id: employee.id!,
      buildingId: employee.buildingId,
      ownerId: employee.ownerId,
      username: employee.username,
      phoneNumber: employee.phoneNumber,
      firstName: employee.firstName,
      lastName: employee.lastName,
      isEnabled: employee.isEnabled,
    );
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
    final updated = await Employee.db.updateRow(
      session,
      employee.copyWith(
        phoneNumber: phone,
        firstName: request.firstName.trim(),
        lastName: request.lastName.trim(),
      ),
    );
    return EmployeeSessionView(
      id: updated.id!,
      buildingId: updated.buildingId,
      ownerId: updated.ownerId,
      username: updated.username,
      phoneNumber: updated.phoneNumber,
      firstName: updated.firstName,
      lastName: updated.lastName,
      isEnabled: updated.isEnabled,
    );
  }

  Future<void> logout(Session session) async {
    final ctx = AuthGuard.requireAny(session);
    await SessionService().revoke(session, ctx.sessionId);
  }
}
