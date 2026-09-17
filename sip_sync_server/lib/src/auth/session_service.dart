import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'auth_context.dart';
import 'password_hasher.dart';

/// Creates and validates opaque bearer sessions stored in [AuthSession].
class SessionService {
  SessionService({TokenCrypto? tokens}) : _tokens = tokens ?? TokenCrypto();

  final TokenCrypto _tokens;
  static const _ttl = Duration(days: 30);

  Future<({String token, String refreshToken, DateTime expiresAt, UuidValue sessionId})>
  create(
    Session session, {
    required ActorType actorType,
    required UuidValue actorId,
  }) async {
    final token = _tokens.generateToken();
    final refresh = _tokens.generateToken();
    final expiresAt = DateTime.now().toUtc().add(_ttl);
    final row = await AuthSession.db.insertRow(
      session,
      AuthSession(
        actorType: actorType,
        actorId: actorId,
        tokenHash: _tokens.hashToken(token),
        refreshTokenHash: _tokens.hashToken(refresh),
        expiresAt: expiresAt,
      ),
    );
    return (
      token: token,
      refreshToken: refresh,
      expiresAt: expiresAt,
      sessionId: row.id!,
    );
  }

  Future<AuthContext?> resolve(Session session, String rawToken) async {
    final hash = _tokens.hashToken(rawToken);
    final row = await AuthSession.db.findFirstRow(
      session,
      where: (t) => t.tokenHash.equals(hash),
    );
    if (row == null) {
      return null;
    }
    if (row.expiresAt.isBefore(DateTime.now().toUtc())) {
      await AuthSession.db.deleteRow(session, row);
      return null;
    }
    return AuthContext(
      actorType: row.actorType,
      actorId: row.actorId,
      sessionId: row.id!,
    );
  }

  Future<void> revoke(Session session, UuidValue sessionId) async {
    await AuthSession.db.deleteWhere(
      session,
      where: (t) => t.id.equals(sessionId),
    );
  }

  Future<void> revokeAllForActor(
    Session session, {
    required ActorType actorType,
    required UuidValue actorId,
  }) async {
    await AuthSession.db.deleteWhere(
      session,
      where: (t) => t.actorType.equals(actorType) & t.actorId.equals(actorId),
    );
  }
}

/// Wired into [Serverpod] as `authenticationHandler`.
Future<AuthenticationInfo?> sipSyncAuthenticationHandler(
  Session session,
  String token,
) async {
  // Client sends full "Bearer xxx" via authHeaderValue; strip if present.
  var raw = token.trim();
  if (raw.toLowerCase().startsWith('bearer ')) {
    raw = raw.substring(7).trim();
  }
  if (raw.isEmpty) {
    return null;
  }
  final ctx = await SessionService().resolve(session, raw);
  if (ctx == null) {
    return null;
  }
  return AuthenticationInfo(
    ctx.actorId.uuid,
    {SipScopes.forActor(ctx.actorType)},
    authId: ctx.sessionId.uuid,
  );
}
