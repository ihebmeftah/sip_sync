/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

/// Complete owner password reset with emailed/dev OTP.
abstract class PasswordResetConfirm
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PasswordResetConfirm._({
    required this.email,
    required this.code,
    required this.newPassword,
  });

  factory PasswordResetConfirm({
    required String email,
    required String code,
    required String newPassword,
  }) = _PasswordResetConfirmImpl;

  factory PasswordResetConfirm.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return PasswordResetConfirm(
      email: jsonSerialization['email'] as String,
      code: jsonSerialization['code'] as String,
      newPassword: jsonSerialization['newPassword'] as String,
    );
  }

  String email;

  String code;

  String newPassword;

  /// Returns a shallow copy of this [PasswordResetConfirm]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PasswordResetConfirm copyWith({
    String? email,
    String? code,
    String? newPassword,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PasswordResetConfirm',
      'email': email,
      'code': code,
      'newPassword': newPassword,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PasswordResetConfirm',
      'email': email,
      'code': code,
      'newPassword': newPassword,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _PasswordResetConfirmImpl extends PasswordResetConfirm {
  _PasswordResetConfirmImpl({
    required String email,
    required String code,
    required String newPassword,
  }) : super._(
         email: email,
         code: code,
         newPassword: newPassword,
       );

  /// Returns a shallow copy of this [PasswordResetConfirm]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PasswordResetConfirm copyWith({
    String? email,
    String? code,
    String? newPassword,
  }) {
    return PasswordResetConfirm(
      email: email ?? this.email,
      code: code ?? this.code,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}
