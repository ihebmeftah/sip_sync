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
import '../../reservations/dtos/reservation_error_code.dart' as _iwvv4ura;

abstract class ReservationException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  ReservationException._({
    required this.message,
    required this.code,
  });

  factory ReservationException({
    required String message,
    required _iwvv4ura.ReservationErrorCode code,
  }) = _ReservationExceptionImpl;

  factory ReservationException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ReservationException(
      message: jsonSerialization['message'] as String,
      code: _iwvv4ura.ReservationErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
    );
  }

  String message;

  _iwvv4ura.ReservationErrorCode code;

  /// Returns a shallow copy of this [ReservationException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReservationException copyWith({
    String? message,
    _iwvv4ura.ReservationErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReservationException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReservationException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'ReservationException(message: $message, code: $code)';
  }
}

class _ReservationExceptionImpl extends ReservationException {
  _ReservationExceptionImpl({
    required String message,
    required _iwvv4ura.ReservationErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [ReservationException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReservationException copyWith({
    String? message,
    _iwvv4ura.ReservationErrorCode? code,
  }) {
    return ReservationException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
