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
import '../menu/menu_category_error_code.dart' as _i8kmon4e;

abstract class MenuCategoryException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  MenuCategoryException._({
    required this.message,
    required this.code,
  });

  factory MenuCategoryException({
    required String message,
    required _i8kmon4e.MenuCategoryErrorCode code,
  }) = _MenuCategoryExceptionImpl;

  factory MenuCategoryException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MenuCategoryException(
      message: jsonSerialization['message'] as String,
      code: _i8kmon4e.MenuCategoryErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
    );
  }

  String message;

  _i8kmon4e.MenuCategoryErrorCode code;

  /// Returns a shallow copy of this [MenuCategoryException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MenuCategoryException copyWith({
    String? message,
    _i8kmon4e.MenuCategoryErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuCategoryException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MenuCategoryException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'MenuCategoryException(message: $message, code: $code)';
  }
}

class _MenuCategoryExceptionImpl extends MenuCategoryException {
  _MenuCategoryExceptionImpl({
    required String message,
    required _i8kmon4e.MenuCategoryErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [MenuCategoryException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MenuCategoryException copyWith({
    String? message,
    _i8kmon4e.MenuCategoryErrorCode? code,
  }) {
    return MenuCategoryException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
