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
import '../../packs/dtos/pack_error_code.dart' as _ids0co2z;

abstract class PackException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  PackException._({
    required this.message,
    required this.code,
  });

  factory PackException({
    required String message,
    required _ids0co2z.PackErrorCode code,
  }) = _PackExceptionImpl;

  factory PackException.fromJson(Map<String, dynamic> jsonSerialization) {
    return PackException(
      message: jsonSerialization['message'] as String,
      code: _ids0co2z.PackErrorCode.fromJson(
        (jsonSerialization['code'] as int),
      ),
    );
  }

  String message;

  _ids0co2z.PackErrorCode code;

  /// Returns a shallow copy of this [PackException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PackException copyWith({
    String? message,
    _ids0co2z.PackErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PackException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PackException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'PackException(message: $message, code: $code)';
  }
}

class _PackExceptionImpl extends PackException {
  _PackExceptionImpl({
    required String message,
    required _ids0co2z.PackErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [PackException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PackException copyWith({
    String? message,
    _ids0co2z.PackErrorCode? code,
  }) {
    return PackException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
