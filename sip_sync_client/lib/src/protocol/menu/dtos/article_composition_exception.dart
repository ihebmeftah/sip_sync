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
import '../../menu/dtos/article_composition_error_code.dart' as _i7ao2wrk;

abstract class ArticleCompositionException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  ArticleCompositionException._({
    required this.message,
    required this.code,
  });

  factory ArticleCompositionException({
    required String message,
    required _i7ao2wrk.ArticleCompositionErrorCode code,
  }) = _ArticleCompositionExceptionImpl;

  factory ArticleCompositionException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ArticleCompositionException(
      message: jsonSerialization['message'] as String,
      code: _i7ao2wrk.ArticleCompositionErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
    );
  }

  String message;

  _i7ao2wrk.ArticleCompositionErrorCode code;

  /// Returns a shallow copy of this [ArticleCompositionException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ArticleCompositionException copyWith({
    String? message,
    _i7ao2wrk.ArticleCompositionErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArticleCompositionException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ArticleCompositionException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'ArticleCompositionException(message: $message, code: $code)';
  }
}

class _ArticleCompositionExceptionImpl extends ArticleCompositionException {
  _ArticleCompositionExceptionImpl({
    required String message,
    required _i7ao2wrk.ArticleCompositionErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [ArticleCompositionException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ArticleCompositionException copyWith({
    String? message,
    _i7ao2wrk.ArticleCompositionErrorCode? code,
  }) {
    return ArticleCompositionException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
