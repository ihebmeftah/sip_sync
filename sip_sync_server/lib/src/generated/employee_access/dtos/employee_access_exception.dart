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
import '../../employee_access/dtos/employee_access_error_code.dart'
    as _ij9t2iwp;

abstract class EmployeeAccessException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  EmployeeAccessException._({
    required this.message,
    required this.code,
  });

  factory EmployeeAccessException({
    required String message,
    required _ij9t2iwp.EmployeeAccessErrorCode code,
  }) = _EmployeeAccessExceptionImpl;

  factory EmployeeAccessException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EmployeeAccessException(
      message: jsonSerialization['message'] as String,
      code: _ij9t2iwp.EmployeeAccessErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
    );
  }

  String message;

  _ij9t2iwp.EmployeeAccessErrorCode code;

  /// Returns a shallow copy of this [EmployeeAccessException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EmployeeAccessException copyWith({
    String? message,
    _ij9t2iwp.EmployeeAccessErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmployeeAccessException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmployeeAccessException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'EmployeeAccessException(message: $message, code: $code)';
  }
}

class _EmployeeAccessExceptionImpl extends EmployeeAccessException {
  _EmployeeAccessExceptionImpl({
    required String message,
    required _ij9t2iwp.EmployeeAccessErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [EmployeeAccessException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EmployeeAccessException copyWith({
    String? message,
    _ij9t2iwp.EmployeeAccessErrorCode? code,
  }) {
    return EmployeeAccessException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
