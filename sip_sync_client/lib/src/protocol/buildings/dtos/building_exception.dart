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
import '../../buildings/dtos/building_error_code.dart' as _ixargm7t;

abstract class BuildingException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  BuildingException._({
    required this.message,
    required this.code,
  });

  factory BuildingException({
    required String message,
    required _ixargm7t.BuildingErrorCode code,
  }) = _BuildingExceptionImpl;

  factory BuildingException.fromJson(Map<String, dynamic> jsonSerialization) {
    return BuildingException(
      message: jsonSerialization['message'] as String,
      code: _ixargm7t.BuildingErrorCode.fromJson(
        (jsonSerialization['code'] as int),
      ),
    );
  }

  String message;

  _ixargm7t.BuildingErrorCode code;

  /// Returns a shallow copy of this [BuildingException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BuildingException copyWith({
    String? message,
    _ixargm7t.BuildingErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BuildingException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BuildingException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'BuildingException(message: $message, code: $code)';
  }
}

class _BuildingExceptionImpl extends BuildingException {
  _BuildingExceptionImpl({
    required String message,
    required _ixargm7t.BuildingErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [BuildingException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BuildingException copyWith({
    String? message,
    _ixargm7t.BuildingErrorCode? code,
  }) {
    return BuildingException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
