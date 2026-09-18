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
import '../tables/venue_table_error_code.dart' as _iqffafs0;

abstract class VenueTableException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  VenueTableException._({
    required this.message,
    required this.code,
  });

  factory VenueTableException({
    required String message,
    required _iqffafs0.VenueTableErrorCode code,
  }) = _VenueTableExceptionImpl;

  factory VenueTableException.fromJson(Map<String, dynamic> jsonSerialization) {
    return VenueTableException(
      message: jsonSerialization['message'] as String,
      code: _iqffafs0.VenueTableErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
    );
  }

  String message;

  _iqffafs0.VenueTableErrorCode code;

  /// Returns a shallow copy of this [VenueTableException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  VenueTableException copyWith({
    String? message,
    _iqffafs0.VenueTableErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VenueTableException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VenueTableException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'VenueTableException(message: $message, code: $code)';
  }
}

class _VenueTableExceptionImpl extends VenueTableException {
  _VenueTableExceptionImpl({
    required String message,
    required _iqffafs0.VenueTableErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [VenueTableException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  VenueTableException copyWith({
    String? message,
    _iqffafs0.VenueTableErrorCode? code,
  }) {
    return VenueTableException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
