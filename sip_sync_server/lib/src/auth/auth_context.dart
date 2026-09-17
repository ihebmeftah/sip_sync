import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Product auth scopes carried in [AuthenticationInfo] (not Serverpod AuthUser).
abstract final class SipScopes {
  static const owner = Scope('sip.owner');
  static const employee = Scope('sip.employee');
  static const customer = Scope('sip.customer');
  static const superAdmin = Scope('sip.superAdmin');

  static Scope forActor(ActorType type) => switch (type) {
    ActorType.owner => owner,
    ActorType.employee => employee,
    ActorType.customer => customer,
    ActorType.superAdmin => superAdmin,
  };
}

/// Resolved custom session for a request.
class AuthContext {
  const AuthContext({
    required this.actorType,
    required this.actorId,
    required this.sessionId,
  });

  final ActorType actorType;
  final UuidValue actorId;
  final UuidValue sessionId;
}
