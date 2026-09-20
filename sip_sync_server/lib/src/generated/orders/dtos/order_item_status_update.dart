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
import '../../orders/dtos/order_item_status.dart' as _iw3cmuga;

abstract class OrderItemStatusUpdate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  OrderItemStatusUpdate._({
    required this.id,
    required this.status,
  });

  factory OrderItemStatusUpdate({
    required _is.UuidValue id,
    required _iw3cmuga.OrderItemStatus status,
  }) = _OrderItemStatusUpdateImpl;

  factory OrderItemStatusUpdate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OrderItemStatusUpdate(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      status: _iw3cmuga.OrderItemStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
    );
  }

  _is.UuidValue id;

  _iw3cmuga.OrderItemStatus status;

  /// Returns a shallow copy of this [OrderItemStatusUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OrderItemStatusUpdate copyWith({
    _is.UuidValue? id,
    _iw3cmuga.OrderItemStatus? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderItemStatusUpdate',
      'id': id.toJson(),
      'status': status.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderItemStatusUpdate',
      'id': id.toJson(),
      'status': status.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _OrderItemStatusUpdateImpl extends OrderItemStatusUpdate {
  _OrderItemStatusUpdateImpl({
    required _is.UuidValue id,
    required _iw3cmuga.OrderItemStatus status,
  }) : super._(
         id: id,
         status: status,
       );

  /// Returns a shallow copy of this [OrderItemStatusUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OrderItemStatusUpdate copyWith({
    _is.UuidValue? id,
    _iw3cmuga.OrderItemStatus? status,
  }) {
    return OrderItemStatusUpdate(
      id: id ?? this.id,
      status: status ?? this.status,
    );
  }
}
