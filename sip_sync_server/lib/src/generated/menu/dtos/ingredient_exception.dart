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
import '../../menu/dtos/ingredient_error_code.dart' as _i5xd0ftf;

abstract class IngredientException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  IngredientException._({
    required this.message,
    required this.code,
  });

  factory IngredientException({
    required String message,
    required _i5xd0ftf.IngredientErrorCode code,
  }) = _IngredientExceptionImpl;

  factory IngredientException.fromJson(Map<String, dynamic> jsonSerialization) {
    return IngredientException(
      message: jsonSerialization['message'] as String,
      code: _i5xd0ftf.IngredientErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
    );
  }

  String message;

  _i5xd0ftf.IngredientErrorCode code;

  /// Returns a shallow copy of this [IngredientException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IngredientException copyWith({
    String? message,
    _i5xd0ftf.IngredientErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IngredientException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IngredientException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'IngredientException(message: $message, code: $code)';
  }
}

class _IngredientExceptionImpl extends IngredientException {
  _IngredientExceptionImpl({
    required String message,
    required _i5xd0ftf.IngredientErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [IngredientException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IngredientException copyWith({
    String? message,
    _i5xd0ftf.IngredientErrorCode? code,
  }) {
    return IngredientException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
