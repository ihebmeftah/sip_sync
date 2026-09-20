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
import '../../orders/dtos/order_error_code.dart' as _iwle3lpm;

abstract class OrderException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  OrderException._({
    required this.message,
    required this.code,
  });

  factory OrderException({
    required String message,
    required _iwle3lpm.OrderErrorCode code,
  }) = _OrderExceptionImpl;

  factory OrderException.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderException(
      message: jsonSerialization['message'] as String,
      code: _iwle3lpm.OrderErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
    );
  }

  String message;

  _iwle3lpm.OrderErrorCode code;

  /// Returns a shallow copy of this [OrderException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OrderException copyWith({
    String? message,
    _iwle3lpm.OrderErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'OrderException(message: $message, code: $code)';
  }
}

class _OrderExceptionImpl extends OrderException {
  _OrderExceptionImpl({
    required String message,
    required _iwle3lpm.OrderErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [OrderException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OrderException copyWith({
    String? message,
    _iwle3lpm.OrderErrorCode? code,
  }) {
    return OrderException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
