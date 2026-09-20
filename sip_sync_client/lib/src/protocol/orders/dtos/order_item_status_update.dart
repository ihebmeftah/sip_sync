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
import '../../orders/dtos/order_item_status.dart' as _iw3cmuga;

abstract class OrderItemStatusUpdate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OrderItemStatusUpdate._({
    required this.id,
    required this.status,
  });

  factory OrderItemStatusUpdate({
    required _isc.UuidValue id,
    required _iw3cmuga.OrderItemStatus status,
  }) = _OrderItemStatusUpdateImpl;

  factory OrderItemStatusUpdate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OrderItemStatusUpdate(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      status: _iw3cmuga.OrderItemStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
    );
  }

  _isc.UuidValue id;

  _iw3cmuga.OrderItemStatus status;

  /// Returns a shallow copy of this [OrderItemStatusUpdate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OrderItemStatusUpdate copyWith({
    _isc.UuidValue? id,
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
    return _isc.SerializationManager.encode(this);
  }
}

class _OrderItemStatusUpdateImpl extends OrderItemStatusUpdate {
  _OrderItemStatusUpdateImpl({
    required _isc.UuidValue id,
    required _iw3cmuga.OrderItemStatus status,
  }) : super._(
         id: id,
         status: status,
       );

  /// Returns a shallow copy of this [OrderItemStatusUpdate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OrderItemStatusUpdate copyWith({
    _isc.UuidValue? id,
    _iw3cmuga.OrderItemStatus? status,
  }) {
    return OrderItemStatusUpdate(
      id: id ?? this.id,
      status: status ?? this.status,
    );
  }
}
