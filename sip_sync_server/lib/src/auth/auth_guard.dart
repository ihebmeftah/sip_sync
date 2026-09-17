import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'auth_context.dart';

/// Resolves the signed-in custom actor from [Session.authenticated].
class AuthGuard {
  static AuthContext requireAny(Session session) {
    final auth = session.authenticated;
    if (auth == null) {
      throw AccountException(
        message: 'Sign in required.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    final type = _typeFromScopes(auth.scopes);
    if (type == null) {
      throw AccountException(
        message: 'Sign in required.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    late final UuidValue actorId;
    late final UuidValue sessionId;
    try {
      actorId = UuidValue.fromString(auth.userIdentifier);
      sessionId = UuidValue.fromString(auth.authId);
    } catch (_) {
      throw AccountException(
        message: 'Sign in required.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return AuthContext(
      actorType: type,
      actorId: actorId,
      sessionId: sessionId,
    );
  }

  static UuidValue requireOwner(Session session) {
    final ctx = requireAny(session);
    if (ctx.actorType != ActorType.owner) {
      throw AccountException(
        message: 'Only owners can perform this action.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return ctx.actorId;
  }

  static UuidValue requireEmployee(Session session) {
    final ctx = requireAny(session);
    if (ctx.actorType != ActorType.employee) {
      throw AccountException(
        message: 'Only employees can perform this action.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return ctx.actorId;
  }

  static UuidValue requireCustomer(Session session) {
    final ctx = requireAny(session);
    if (ctx.actorType != ActorType.customer) {
      throw AccountException(
        message: 'Only customers can perform this action.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return ctx.actorId;
  }

  static UuidValue requireSuperAdmin(Session session) {
    final ctx = requireAny(session);
    if (ctx.actorType != ActorType.superAdmin) {
      throw AccountException(
        message: 'Only super admins can perform this action.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return ctx.actorId;
  }

  static ActorType? _typeFromScopes(Set<Scope> scopes) {
    if (scopes.contains(SipScopes.owner)) return ActorType.owner;
    if (scopes.contains(SipScopes.employee)) return ActorType.employee;
    if (scopes.contains(SipScopes.customer)) return ActorType.customer;
    if (scopes.contains(SipScopes.superAdmin)) return ActorType.superAdmin;
    return null;
  }
}
