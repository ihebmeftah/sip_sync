import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'auth_guard.dart';
import 'auth_support.dart';
import 'password_reset_service.dart';
import 'session_service.dart';

/// Owner self-register, login, profile, and password reset.
class OwnerAuthEndpoint extends Endpoint {
  final _auth = AuthSupport();
  final _resets = PasswordResetService();

  Future<AuthTokenResult> register(
    Session session,
    EmailRegisterCreate request,
  ) async {
    _auth.validatePassword(request.password);
    final email = _auth.normalizeEmail(request.email);
    _auth.validateEmail(email);
    final phone = _auth.normalizePhone(request.phoneNumber);
    _auth.validatePhone(phone);
    _auth.validateName(request.firstName, request.lastName);

    final existing = await Owner.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (existing != null) {
      throw AccountException(
        message: 'Email already registered.',
        code: AccountErrorCode.emailTaken,
      );
    }
    final phoneHit = await Owner.db.findFirstRow(
      session,
      where: (t) => t.phoneNumber.equals(phone),
    );
    if (phoneHit != null) {
      throw AccountException(
        message: 'Phone already registered.',
        code: AccountErrorCode.phoneTaken,
      );
    }

    final owner = await Owner.db.insertRow(
      session,
      Owner(
        email: email,
        phoneNumber: phone,
        firstName: request.firstName.trim(),
        lastName: request.lastName.trim(),
        passwordHash: _auth.passwords.hash(request.password),
      ),
    );
    return _auth.issueOwner(session, owner);
  }

  Future<AuthTokenResult> login(
    Session session,
    EmailLoginRequest request,
  ) async {
    final email = _auth.normalizeEmail(request.email);
    final owner = await Owner.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (owner == null ||
        !_auth.passwords.verify(request.password, owner.passwordHash)) {
      throw AccountException(
        message: 'Invalid email or password.',
        code: AccountErrorCode.invalidCredentials,
      );
    }
    return _auth.issueOwner(session, owner);
  }

  Future<OwnerSessionView> me(Session session) async {
    final id = AuthGuard.requireOwner(session);
    final owner = await Owner.db.findById(session, id);
    if (owner == null) {
      throw AccountException(
        message: 'Owner not found.',
        code: AccountErrorCode.notFound,
      );
    }
    return OwnerSessionView(
      id: owner.id!,
      email: owner.email,
      phoneNumber: owner.phoneNumber,
      firstName: owner.firstName,
      lastName: owner.lastName,
    );
  }

  Future<OwnerSessionView> updateMyProfile(
    Session session,
    ProfileUpdate request,
  ) async {
    final id = AuthGuard.requireOwner(session);
    final phone = _auth.normalizePhone(request.phoneNumber);
    _auth.validatePhone(phone);
    _auth.validateName(request.firstName, request.lastName);
    final owner = await Owner.db.findById(session, id);
    if (owner == null) {
      throw AccountException(
        message: 'Owner not found.',
        code: AccountErrorCode.notFound,
      );
    }
    final phoneHit = await Owner.db.findFirstRow(
      session,
      where: (t) => t.phoneNumber.equals(phone) & t.id.notEquals(id),
    );
    if (phoneHit != null) {
      throw AccountException(
        message: 'Phone already registered.',
        code: AccountErrorCode.phoneTaken,
      );
    }
    final updated = await Owner.db.updateRow(
      session,
      owner.copyWith(
        phoneNumber: phone,
        firstName: request.firstName.trim(),
        lastName: request.lastName.trim(),
      ),
    );
    return OwnerSessionView(
      id: updated.id!,
      email: updated.email,
      phoneNumber: updated.phoneNumber,
      firstName: updated.firstName,
      lastName: updated.lastName,
    );
  }

  /// Updates the signed-in owner's password and drops other sessions.
  Future<void> changePassword(
    Session session,
    ChangePasswordRequest request,
  ) async {
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType != ActorType.owner) {
      throw AccountException(
        message: 'Only owners can perform this action.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    _auth.validatePassword(request.newPassword);
    final owner = await Owner.db.findById(session, ctx.actorId);
    if (owner == null) {
      throw AccountException(
        message: 'Owner not found.',
        code: AccountErrorCode.notFound,
      );
    }
    if (!_auth.passwords.verify(request.currentPassword, owner.passwordHash)) {
      throw AccountException(
        message: 'Current password is incorrect.',
        code: AccountErrorCode.invalidCredentials,
      );
    }
    await Owner.db.updateRow(
      session,
      owner.copyWith(passwordHash: _auth.passwords.hash(request.newPassword)),
    );
    await SessionService().revokeOtherSessionsForActor(
      session,
      actorType: ActorType.owner,
      actorId: ctx.actorId,
      keepSessionId: ctx.sessionId,
    );
  }

  /// Starts a password reset for an owner email (no enumeration).
  ///
  /// Until email delivery exists, the OTP is logged and returned as
  /// [PasswordResetRequestResult.debugCode] in development/test only.
  Future<PasswordResetRequestResult> requestPasswordReset(
    Session session,
    PasswordResetRequest request,
  ) async {
    final email = _auth.normalizeEmail(request.email);
    _auth.validateEmail(email);
    final code = await _resets.issueForOwnerEmail(session, email);
    if (code != null) {
      session.log(
        'Password reset code for $email: $code',
        level: LogLevel.info,
      );
    }
    final mode = session.serverpod.runMode;
    final exposeDebug = mode == 'development' || mode == 'test';
    return PasswordResetRequestResult(
      debugCode: exposeDebug ? code : null,
    );
  }

  /// Completes owner password reset with OTP + new password.
  Future<void> confirmPasswordReset(
    Session session,
    PasswordResetConfirm request,
  ) async {
    final email = _auth.normalizeEmail(request.email);
    _auth.validateEmail(email);
    _auth.validatePassword(request.newPassword);
    await _resets.consumeValidCode(
      session,
      email: email,
      code: request.code,
    );
    final owner = await Owner.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (owner == null) {
      // Same message as invalid code — do not reveal missing accounts.
      throw AccountException(
        message: 'Invalid or expired reset code.',
        code: AccountErrorCode.invalidResetCode,
      );
    }
    await Owner.db.updateRow(
      session,
      owner.copyWith(passwordHash: _auth.passwords.hash(request.newPassword)),
    );
    await SessionService().revokeAllForActor(
      session,
      actorType: ActorType.owner,
      actorId: owner.id!,
    );
  }

  Future<void> logout(Session session) async {
    final ctx = AuthGuard.requireAny(session);
    await SessionService().revoke(session, ctx.sessionId);
  }
}
