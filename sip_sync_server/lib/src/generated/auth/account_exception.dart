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
import '../auth/account_error_code.dart' as _ijncqacu;

abstract class AccountException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  AccountException._({
    required this.message,
    required this.code,
  });

  factory AccountException({
    required String message,
    required _ijncqacu.AccountErrorCode code,
  }) = _AccountExceptionImpl;

  factory AccountException.fromJson(Map<String, dynamic> jsonSerialization) {
    return AccountException(
      message: jsonSerialization['message'] as String,
      code: _ijncqacu.AccountErrorCode.fromJson(
        (jsonSerialization['code'] as int),
      ),
    );
  }

  String message;

  _ijncqacu.AccountErrorCode code;

  /// Returns a shallow copy of this [AccountException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AccountException copyWith({
    String? message,
    _ijncqacu.AccountErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccountException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AccountException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'AccountException(message: $message, code: $code)';
  }
}

class _AccountExceptionImpl extends AccountException {
  _AccountExceptionImpl({
    required String message,
    required _ijncqacu.AccountErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [AccountException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AccountException copyWith({
    String? message,
    _ijncqacu.AccountErrorCode? code,
  }) {
    return AccountException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
