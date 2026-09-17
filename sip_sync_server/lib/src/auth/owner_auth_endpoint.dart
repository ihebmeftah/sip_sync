import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'auth_guard.dart';
import 'auth_support.dart';
import 'session_service.dart';

/// Owner self-register, login, and profile.
class OwnerAuthEndpoint extends Endpoint {
  final _auth = AuthSupport();

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

  Future<void> logout(Session session) async {
    final ctx = AuthGuard.requireAny(session);
    await SessionService().revoke(session, ctx.sessionId);
  }
}
