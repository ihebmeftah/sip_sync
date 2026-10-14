import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'auth_guard.dart';
import 'auth_support.dart';
import 'session_service.dart';

/// Customer self-register, login, and profile.
class CustomerAuthEndpoint extends Endpoint {
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

    final existing = await Customer.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (existing != null) {
      throw AccountException(
        message: 'Email already registered.',
        code: AccountErrorCode.emailTaken,
      );
    }
    final phoneHit = await Customer.db.findFirstRow(
      session,
      where: (t) => t.phoneNumber.equals(phone),
    );
    if (phoneHit != null) {
      throw AccountException(
        message: 'Phone already registered.',
        code: AccountErrorCode.phoneTaken,
      );
    }

    final customer = await Customer.db.insertRow(
      session,
      Customer(
        email: email,
        phoneNumber: phone,
        firstName: request.firstName.trim(),
        lastName: request.lastName.trim(),
        passwordHash: _auth.passwords.hash(request.password),
      ),
    );
    return _auth.issueCustomer(session, customer);
  }

  Future<AuthTokenResult> login(
    Session session,
    EmailLoginRequest request,
  ) async {
    final email = _auth.normalizeEmail(request.email);
    final customer = await Customer.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (customer == null ||
        !_auth.passwords.verify(request.password, customer.passwordHash)) {
      throw AccountException(
        message: 'Invalid email or password.',
        code: AccountErrorCode.invalidCredentials,
      );
    }
    return _auth.issueCustomer(session, customer);
  }

  Future<CustomerSessionView> me(Session session) async {
    final id = AuthGuard.requireCustomer(session);
    final customer = await Customer.db.findById(session, id);
    if (customer == null) {
      throw AccountException(
        message: 'Customer not found.',
        code: AccountErrorCode.notFound,
      );
    }
    return CustomerSessionView(
      id: customer.id!,
      email: customer.email,
      phoneNumber: customer.phoneNumber,
      firstName: customer.firstName,
      lastName: customer.lastName,
    );
  }

  Future<CustomerSessionView> updateMyProfile(
    Session session,
    ProfileUpdate request,
  ) async {
    final id = AuthGuard.requireCustomer(session);
    final phone = _auth.normalizePhone(request.phoneNumber);
    _auth.validatePhone(phone);
    _auth.validateName(request.firstName, request.lastName);
    final customer = await Customer.db.findById(session, id);
    if (customer == null) {
      throw AccountException(
        message: 'Customer not found.',
        code: AccountErrorCode.notFound,
      );
    }
    final phoneHit = await Customer.db.findFirstRow(
      session,
      where: (t) => t.phoneNumber.equals(phone) & t.id.notEquals(id),
    );
    if (phoneHit != null) {
      throw AccountException(
        message: 'Phone already registered.',
        code: AccountErrorCode.phoneTaken,
      );
    }
    final updated = await Customer.db.updateRow(
      session,
      customer.copyWith(
        phoneNumber: phone,
        firstName: request.firstName.trim(),
        lastName: request.lastName.trim(),
      ),
    );
    return CustomerSessionView(
      id: updated.id!,
      email: updated.email,
      phoneNumber: updated.phoneNumber,
      firstName: updated.firstName,
      lastName: updated.lastName,
    );
  }

  /// Updates the signed-in customer's password and drops other sessions.
  Future<void> changePassword(
    Session session,
    ChangePasswordRequest request,
  ) async {
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType != ActorType.customer) {
      throw AccountException(
        message: 'Only customers can perform this action.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    _auth.validatePassword(request.newPassword);
    final customer = await Customer.db.findById(session, ctx.actorId);
    if (customer == null) {
      throw AccountException(
        message: 'Customer not found.',
        code: AccountErrorCode.notFound,
      );
    }
    if (!_auth.passwords.verify(
      request.currentPassword,
      customer.passwordHash,
    )) {
      throw AccountException(
        message: 'Current password is incorrect.',
        code: AccountErrorCode.invalidCredentials,
      );
    }
    await Customer.db.updateRow(
      session,
      customer.copyWith(
        passwordHash: _auth.passwords.hash(request.newPassword),
      ),
    );
    await SessionService().revokeOtherSessionsForActor(
      session,
      actorType: ActorType.customer,
      actorId: ctx.actorId,
      keepSessionId: ctx.sessionId,
    );
  }

  Future<void> logout(Session session) async {
    final ctx = AuthGuard.requireAny(session);
    await SessionService().revoke(session, ctx.sessionId);
  }
}
