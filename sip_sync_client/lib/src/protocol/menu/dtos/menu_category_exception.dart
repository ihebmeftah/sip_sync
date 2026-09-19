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
import '../../menu/dtos/menu_category_error_code.dart' as _iaa8rqt3;

abstract class MenuCategoryException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  MenuCategoryException._({
    required this.message,
    required this.code,
  });

  factory MenuCategoryException({
    required String message,
    required _iaa8rqt3.MenuCategoryErrorCode code,
  }) = _MenuCategoryExceptionImpl;

  factory MenuCategoryException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MenuCategoryException(
      message: jsonSerialization['message'] as String,
      code: _iaa8rqt3.MenuCategoryErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
    );
  }

  String message;

  _iaa8rqt3.MenuCategoryErrorCode code;

  /// Returns a shallow copy of this [MenuCategoryException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MenuCategoryException copyWith({
    String? message,
    _iaa8rqt3.MenuCategoryErrorCode? code,
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
    required _iaa8rqt3.MenuCategoryErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [MenuCategoryException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MenuCategoryException copyWith({
    String? message,
    _iaa8rqt3.MenuCategoryErrorCode? code,
  }) {
    return MenuCategoryException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
