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
import '../../packs/dtos/pack_error_code.dart' as _ids0co2z;
import '../../packs/dtos/pack_feature.dart' as _iub8zary;

abstract class PackException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  PackException._({
    required this.message,
    required this.code,
    this.feature,
  });

  factory PackException({
    required String message,
    required _ids0co2z.PackErrorCode code,
    _iub8zary.PackFeature? feature,
  }) = _PackExceptionImpl;

  factory PackException.fromJson(Map<String, dynamic> jsonSerialization) {
    return PackException(
      message: jsonSerialization['message'] as String,
      code: _ids0co2z.PackErrorCode.fromJson(
        (jsonSerialization['code'] as int),
      ),
      feature: jsonSerialization['feature'] == null
          ? null
          : _iub8zary.PackFeature.fromJson(
              (jsonSerialization['feature'] as String),
            ),
    );
  }

  String message;

  _ids0co2z.PackErrorCode code;

  /// Which rule failed, when [code] is limitReached or featureOff.
  _iub8zary.PackFeature? feature;

  /// Returns a shallow copy of this [PackException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PackException copyWith({
    String? message,
    _ids0co2z.PackErrorCode? code,
    _iub8zary.PackFeature? feature,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PackException',
      'message': message,
      'code': code.toJson(),
      if (feature != null) 'feature': feature?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PackException',
      'message': message,
      'code': code.toJson(),
      if (feature != null) 'feature': feature?.toJson(),
    };
  }

  @override
  String toString() {
    return 'PackException(message: $message, code: $code, feature: $feature)';
  }
}

class _Undefined {}

class _PackExceptionImpl extends PackException {
  _PackExceptionImpl({
    required String message,
    required _ids0co2z.PackErrorCode code,
    _iub8zary.PackFeature? feature,
  }) : super._(
         message: message,
         code: code,
         feature: feature,
       );

  /// Returns a shallow copy of this [PackException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PackException copyWith({
    String? message,
    _ids0co2z.PackErrorCode? code,
    Object? feature = _Undefined,
  }) {
    return PackException(
      message: message ?? this.message,
      code: code ?? this.code,
      feature: feature is _iub8zary.PackFeature? ? feature : this.feature,
    );
  }
}
