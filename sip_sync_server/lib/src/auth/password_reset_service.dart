import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'password_hasher.dart';

/// Issues and verifies short-lived owner password-reset OTPs.
class PasswordResetService {
  PasswordResetService({TokenCrypto? tokens})
    : _tokens = tokens ?? TokenCrypto();

  final TokenCrypto _tokens;
  static const _ttl = Duration(minutes: 15);
  static final _random = Random.secure();

  /// Creates a reset row for [email] when an owner exists. Always safe to call.
  ///
  /// Returns the plaintext code when a row was created (caller logs / debug).
  Future<String?> issueForOwnerEmail(Session session, String email) async {
    final owner = await Owner.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (owner == null) {
      return null;
    }

    // Invalidate prior unused codes for this email.
    final pending = await PasswordReset.db.find(
      session,
      where: (t) => t.email.equals(email) & t.consumedAt.equals(null),
    );
    for (final row in pending) {
      await PasswordReset.db.updateRow(
        session,
        row.copyWith(consumedAt: DateTime.now().toUtc()),
      );
    }

    final code = (_random.nextInt(900000) + 100000).toString();
    await PasswordReset.db.insertRow(
      session,
      PasswordReset(
        email: email,
        codeHash: _tokens.hashToken(code),
        expiresAt: DateTime.now().toUtc().add(_ttl),
      ),
    );
    return code;
  }

  /// Verifies [code] for [email] and marks the matching row consumed.
  Future<void> consumeValidCode(
    Session session, {
    required String email,
    required String code,
  }) async {
    final trimmed = code.trim();
    if (trimmed.length < 4) {
      throw AccountException(
        message: 'Invalid or expired reset code.',
        code: AccountErrorCode.invalidResetCode,
      );
    }

    final rows = await PasswordReset.db.find(
      session,
      where: (t) => t.email.equals(email) & t.consumedAt.equals(null),
      orderBy: (t) => t.createdAt.desc(),
      limit: 5,
    );
    if (rows.isEmpty) {
      throw AccountException(
        message: 'Invalid or expired reset code.',
        code: AccountErrorCode.invalidResetCode,
      );
    }

    final now = DateTime.now().toUtc();
    PasswordReset? match;
    for (final row in rows) {
      if (_tokens.hashToken(trimmed) == row.codeHash) {
        match = row;
        break;
      }
    }
    if (match == null) {
      throw AccountException(
        message: 'Invalid or expired reset code.',
        code: AccountErrorCode.invalidResetCode,
      );
    }
    if (match.expiresAt.isBefore(now)) {
      await PasswordReset.db.updateRow(
        session,
        match.copyWith(consumedAt: now),
      );
      throw AccountException(
        message: 'This reset code has expired.',
        code: AccountErrorCode.resetCodeExpired,
      );
    }

    await PasswordReset.db.updateRow(
      session,
      match.copyWith(consumedAt: now),
    );
  }
}
