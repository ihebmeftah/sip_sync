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
import '../../discovery/dtos/place_error_code.dart' as _if6937ed;

abstract class PlaceException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  PlaceException._({
    required this.message,
    required this.code,
  });

  factory PlaceException({
    required String message,
    required _if6937ed.PlaceErrorCode code,
  }) = _PlaceExceptionImpl;

  factory PlaceException.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlaceException(
      message: jsonSerialization['message'] as String,
      code: _if6937ed.PlaceErrorCode.fromJson(
        (jsonSerialization['code'] as int),
      ),
    );
  }

  String message;

  _if6937ed.PlaceErrorCode code;

  /// Returns a shallow copy of this [PlaceException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PlaceException copyWith({
    String? message,
    _if6937ed.PlaceErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlaceException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlaceException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'PlaceException(message: $message, code: $code)';
  }
}

class _PlaceExceptionImpl extends PlaceException {
  _PlaceExceptionImpl({
    required String message,
    required _if6937ed.PlaceErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [PlaceException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PlaceException copyWith({
    String? message,
    _if6937ed.PlaceErrorCode? code,
  }) {
    return PlaceException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
