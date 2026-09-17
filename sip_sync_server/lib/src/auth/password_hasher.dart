import 'dart:convert';
import 'dart:math';

import 'package:bcrypt/bcrypt.dart';
import 'package:crypto/crypto.dart';

/// Hashes and verifies actor passwords with bcrypt.
class PasswordHasher {
  String hash(String password) => BCrypt.hashpw(password, BCrypt.gensalt());

  bool verify(String password, String passwordHash) {
    try {
      return BCrypt.checkpw(password, passwordHash);
    } catch (_) {
      return false;
    }
  }
}

/// Opaque session token helpers.
class TokenCrypto {
  static final _random = Random.secure();

  /// Returns a URL-safe random token (~43 chars).
  String generateToken() {
    final bytes = List<int>.generate(32, (_) => _random.nextInt(256));
    return base64UrlEncode(bytes).replaceAll('=', '');
  }

  String hashToken(String token) =>
      sha256.convert(utf8.encode(token)).toString();
}
