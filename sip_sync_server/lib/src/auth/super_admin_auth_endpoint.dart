import 'package:serverpod/serverpod.dart';

import '../core/page_window.dart';
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
    if (!admin.isEnabled) {
      throw AccountException(
        message: 'This account is disabled.',
        code: AccountErrorCode.accountDisabled,
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
    return _adminView(admin);
  }

  /// Updates profile fields. A non-empty [SuperAdminUpdate.password] replaces the hash.
  ///
  /// Enabling or disabling follows the same rules as [setEnabled].
  Future<SuperAdminView> update(
    Session session,
    SuperAdminUpdate request,
  ) async {
    final actorId = AuthGuard.requireSuperAdmin(session);
    final email = _auth.normalizeEmail(request.email);
    _auth.validateEmail(email);
    final phone = _auth.normalizePhone(request.phoneNumber);
    _auth.validatePhone(phone);
    _auth.validateName(request.firstName, request.lastName);

    final target = await _requireAdmin(session, request.id);
    await _ensureEmailFree(session, email, exceptId: target.id!);
    await _ensurePhoneFree(session, phone, exceptId: target.id!);

    final password = request.password?.trim();
    var passwordHash = target.passwordHash;
    if (password != null && password.isNotEmpty) {
      _auth.validatePassword(password);
      passwordHash = _auth.passwords.hash(password);
    }

    var updated = await SuperAdmin.db.updateRow(
      session,
      target.copyWith(
        email: email,
        phoneNumber: phone,
        firstName: request.firstName.trim(),
        lastName: request.lastName.trim(),
        passwordHash: passwordHash,
      ),
    );
    if (updated.isEnabled != request.isEnabled) {
      updated = await _applyEnabled(
        session,
        actorId: actorId,
        target: updated,
        isEnabled: request.isEnabled,
      );
    }
    return _adminView(updated);
  }

  /// Enables or disables a backoffice user.
  ///
  /// The default admin and the caller’s own account cannot be disabled.
  /// Disabling revokes that admin’s sessions.
  Future<SuperAdminView> setEnabled(
    Session session,
    UuidValue targetId,
    bool isEnabled,
  ) async {
    final actorId = AuthGuard.requireSuperAdmin(session);
    final target = await _requireAdmin(session, targetId);
    final updated = await _applyEnabled(
      session,
      actorId: actorId,
      target: target,
      isEnabled: isEnabled,
    );
    return _adminView(updated);
  }

  /// Backoffice users, oldest first.
  ///
  /// [limit] defaults to 20 and is capped at 100. [offset] skips that many rows.
  Future<SuperAdminPage> list(
    Session session, {
    int? limit,
    int? offset,
  }) async {
    AuthGuard.requireSuperAdmin(session);
    final window = PageWindow.from(limit: limit, offset: offset);
    final total = await SuperAdmin.db.count(session);
    final rows = await SuperAdmin.db.find(
      session,
      orderBy: (t) => t.createdAt,
      limit: window.limit,
      offset: window.offset,
    );
    return SuperAdminPage(
      items: rows.map(_adminView).toList(),
      total: total,
      limit: window.limit,
      offset: window.offset,
    );
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

  Future<SuperAdmin> _requireAdmin(Session session, UuidValue id) async {
    final target = await SuperAdmin.db.findById(session, id);
    if (target == null) {
      throw AccountException(
        message: 'Admin not found.',
        code: AccountErrorCode.notFound,
      );
    }
    return target;
  }

  Future<void> _ensureEmailFree(
    Session session,
    String email, {
    required UuidValue exceptId,
  }) async {
    final existing = await SuperAdmin.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email) & t.id.notEquals(exceptId),
    );
    if (existing != null) {
      throw AccountException(
        message: 'Email already registered.',
        code: AccountErrorCode.emailTaken,
      );
    }
  }

  Future<void> _ensurePhoneFree(
    Session session,
    String phone, {
    required UuidValue exceptId,
  }) async {
    final existing = await SuperAdmin.db.findFirstRow(
      session,
      where: (t) => t.phoneNumber.equals(phone) & t.id.notEquals(exceptId),
    );
    if (existing != null) {
      throw AccountException(
        message: 'Phone already registered.',
        code: AccountErrorCode.phoneTaken,
      );
    }
  }

  /// Persists [isEnabled]. No-op when unchanged.
  Future<SuperAdmin> _applyEnabled(
    Session session, {
    required UuidValue actorId,
    required SuperAdmin target,
    required bool isEnabled,
  }) async {
    if (target.isEnabled == isEnabled) {
      return target;
    }
    if (!isEnabled && target.isSystemDefault) {
      throw AccountException(
        message: 'Cannot disable the default admin.',
        code: AccountErrorCode.cannotDisableDefaultAdmin,
      );
    }
    if (!isEnabled && target.id == actorId) {
      throw AccountException(
        message: 'Cannot disable your own account.',
        code: AccountErrorCode.cannotDisableSelf,
      );
    }
    final updated = await SuperAdmin.db.updateRow(
      session,
      target.copyWith(isEnabled: isEnabled),
    );
    if (!isEnabled) {
      await SessionService().revokeAllForActor(
        session,
        actorType: ActorType.superAdmin,
        actorId: target.id!,
      );
    }
    return updated;
  }

  SuperAdminView _adminView(SuperAdmin admin) => SuperAdminView(
    id: admin.id!,
    email: admin.email,
    phoneNumber: admin.phoneNumber,
    firstName: admin.firstName,
    lastName: admin.lastName,
    isSystemDefault: admin.isSystemDefault,
    isEnabled: admin.isEnabled,
  );
}
