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
import '../../notifications/dtos/notification_error_code.dart' as _id4eagah;

abstract class NotificationException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  NotificationException._({
    required this.message,
    required this.code,
  });

  factory NotificationException({
    required String message,
    required _id4eagah.NotificationErrorCode code,
  }) = _NotificationExceptionImpl;

  factory NotificationException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return NotificationException(
      message: jsonSerialization['message'] as String,
      code: _id4eagah.NotificationErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
    );
  }

  String message;

  _id4eagah.NotificationErrorCode code;

  /// Returns a shallow copy of this [NotificationException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  NotificationException copyWith({
    String? message,
    _id4eagah.NotificationErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NotificationException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NotificationException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'NotificationException(message: $message, code: $code)';
  }
}

class _NotificationExceptionImpl extends NotificationException {
  _NotificationExceptionImpl({
    required String message,
    required _id4eagah.NotificationErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [NotificationException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  NotificationException copyWith({
    String? message,
    _id4eagah.NotificationErrorCode? code,
  }) {
    return NotificationException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
