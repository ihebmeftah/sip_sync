import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'auth_guard.dart';
import 'auth_support.dart';
import 'session_service.dart';

/// Super admin login, profile, and staff management for backoffice.
class SuperAdminAuthEndpoint extends Endpoint {
  final _auth = AuthSupport();

  Future<AuthTokenResult> login(
    Session session,
    EmailLoginRequest request,
  ) async {
    final email = _auth.normalizeEmail(request.email);
    final admin = await SuperAdmin.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (admin == null ||
        !_auth.passwords.verify(request.password, admin.passwordHash)) {
      throw AccountException(
        message: 'Invalid email or password.',
        code: AccountErrorCode.invalidCredentials,
      );
    }
    return _auth.issueSuperAdmin(session, admin);
  }

  Future<SuperAdminSessionView> me(Session session) async {
    final id = AuthGuard.requireSuperAdmin(session);
    final admin = await SuperAdmin.db.findById(session, id);
    if (admin == null) {
      throw AccountException(
        message: 'Admin not found.',
        code: AccountErrorCode.notFound,
      );
    }
    return _view(admin);
  }

  Future<void> logout(Session session) async {
    final ctx = AuthGuard.requireAny(session);
    await SessionService().revoke(session, ctx.sessionId);
  }

  Future<SuperAdminView> add(
    Session session,
    SuperAdminCreate request,
  ) async {
    AuthGuard.requireSuperAdmin(session);
    _auth.validatePassword(request.password);
    final email = _auth.normalizeEmail(request.email);
    _auth.validateEmail(email);
    final phone = _auth.normalizePhone(request.phoneNumber);
    _auth.validatePhone(phone);
    _auth.validateName(request.firstName, request.lastName);

    final existing = await SuperAdmin.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (existing != null) {
      throw AccountException(
        message: 'Email already registered.',
        code: AccountErrorCode.emailTaken,
      );
    }

    final admin = await SuperAdmin.db.insertRow(
      session,
      SuperAdmin(
        email: email,
        phoneNumber: phone,
        firstName: request.firstName.trim(),
        lastName: request.lastName.trim(),
        passwordHash: _auth.passwords.hash(request.password),
        isSystemDefault: false,
      ),
    );
    return SuperAdminView(
      id: admin.id!,
      email: admin.email,
      phoneNumber: admin.phoneNumber,
      firstName: admin.firstName,
      lastName: admin.lastName,
      isSystemDefault: admin.isSystemDefault,
    );
  }

  Future<List<SuperAdminView>> list(Session session) async {
    AuthGuard.requireSuperAdmin(session);
    final rows = await SuperAdmin.db.find(session, orderBy: (t) => t.createdAt);
    return rows.map(_adminView).toList();
  }

  Future<void> delete(Session session, UuidValue targetId) async {
    AuthGuard.requireSuperAdmin(session);
    final target = await SuperAdmin.db.findById(session, targetId);
    if (target == null) {
      throw AccountException(
        message: 'Admin not found.',
        code: AccountErrorCode.notFound,
      );
    }
    if (target.isSystemDefault) {
      throw AccountException(
        message: 'Cannot delete the default admin.',
        code: AccountErrorCode.cannotDeleteDefaultAdmin,
      );
    }
    await SuperAdmin.db.deleteRow(session, target);
  }

  /// Seeds the default platform admin if missing.
  Future<void> ensureDefaultAdmin(Session session) async {
    final existing = await SuperAdmin.db.findFirstRow(
      session,
      where: (t) => t.isSystemDefault.equals(true),
    );
    if (existing != null) {
      return;
    }
    final email =
        session.passwords['sipSyncDefaultAdminEmail'] ?? 'admin@sipsync.local';
    final password =
        session.passwords['sipSyncDefaultAdminPassword'] ?? 'SipSyncAdmin8!';
    await SuperAdmin.db.insertRow(
      session,
      SuperAdmin(
        email: email.toLowerCase(),
        phoneNumber: '+21600000000',
        firstName: 'Sip',
        lastName: 'Admin',
        passwordHash: _auth.passwords.hash(password),
        isSystemDefault: true,
      ),
    );
  }

  SuperAdminSessionView _view(SuperAdmin admin) => SuperAdminSessionView(
    id: admin.id!,
    email: admin.email,
    phoneNumber: admin.phoneNumber,
    firstName: admin.firstName,
    lastName: admin.lastName,
    isSystemDefault: admin.isSystemDefault,
  );

  SuperAdminView _adminView(SuperAdmin admin) => SuperAdminView(
    id: admin.id!,
    email: admin.email,
    phoneNumber: admin.phoneNumber,
    firstName: admin.firstName,
    lastName: admin.lastName,
    isSystemDefault: admin.isSystemDefault,
  );
}
