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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../cash_register/dtos/cash_register_error_code.dart' as _i41xtq5q;

abstract class CashRegisterException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  CashRegisterException._({
    required this.message,
    required this.code,
  });

  factory CashRegisterException({
    required String message,
    required _i41xtq5q.CashRegisterErrorCode code,
  }) = _CashRegisterExceptionImpl;

  factory CashRegisterException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CashRegisterException(
      message: jsonSerialization['message'] as String,
      code: _i41xtq5q.CashRegisterErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
    );
  }

  String message;

  _i41xtq5q.CashRegisterErrorCode code;

  /// Returns a shallow copy of this [CashRegisterException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CashRegisterException copyWith({
    String? message,
    _i41xtq5q.CashRegisterErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CashRegisterException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CashRegisterException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'CashRegisterException(message: $message, code: $code)';
  }
}

class _CashRegisterExceptionImpl extends CashRegisterException {
  _CashRegisterExceptionImpl({
    required String message,
    required _i41xtq5q.CashRegisterErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [CashRegisterException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CashRegisterException copyWith({
    String? message,
    _i41xtq5q.CashRegisterErrorCode? code,
  }) {
    return CashRegisterException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
