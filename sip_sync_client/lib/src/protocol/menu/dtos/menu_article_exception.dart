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
import '../../menu/dtos/menu_article_error_code.dart' as _ile77l48;

abstract class MenuArticleException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  MenuArticleException._({
    required this.message,
    required this.code,
  });

  factory MenuArticleException({
    required String message,
    required _ile77l48.MenuArticleErrorCode code,
  }) = _MenuArticleExceptionImpl;

  factory MenuArticleException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MenuArticleException(
      message: jsonSerialization['message'] as String,
      code: _ile77l48.MenuArticleErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
    );
  }

  String message;

  _ile77l48.MenuArticleErrorCode code;

  /// Returns a shallow copy of this [MenuArticleException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MenuArticleException copyWith({
    String? message,
    _ile77l48.MenuArticleErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuArticleException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MenuArticleException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'MenuArticleException(message: $message, code: $code)';
  }
}

class _MenuArticleExceptionImpl extends MenuArticleException {
  _MenuArticleExceptionImpl({
    required String message,
    required _ile77l48.MenuArticleErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [MenuArticleException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MenuArticleException copyWith({
    String? message,
    _ile77l48.MenuArticleErrorCode? code,
  }) {
    return MenuArticleException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
