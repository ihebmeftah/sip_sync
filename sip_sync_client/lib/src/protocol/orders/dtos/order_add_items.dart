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
import 'package:sip_sync_client/src/protocol/protocol.dart' as _iozg9o5r;
import '../../orders/dtos/order_item_create_line.dart' as _ik0vi2j5;

abstract class OrderAddItems
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OrderAddItems._({
    required this.orderId,
    required this.items,
  });

  factory OrderAddItems({
    required _isc.UuidValue orderId,
    required List<_ik0vi2j5.OrderItemCreateLine> items,
  }) = _OrderAddItemsImpl;

  factory OrderAddItems.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderAddItems(
      orderId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['orderId'],
      ),
      items: _iozg9o5r.Protocol()
          .deserialize<List<_ik0vi2j5.OrderItemCreateLine>>(
            jsonSerialization['items'],
          ),
    );
  }

  _isc.UuidValue orderId;

  List<_ik0vi2j5.OrderItemCreateLine> items;

  /// Returns a shallow copy of this [OrderAddItems]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OrderAddItems copyWith({
    _isc.UuidValue? orderId,
    List<_ik0vi2j5.OrderItemCreateLine>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderAddItems',
      'orderId': orderId.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderAddItems',
      'orderId': orderId.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _OrderAddItemsImpl extends OrderAddItems {
  _OrderAddItemsImpl({
    required _isc.UuidValue orderId,
    required List<_ik0vi2j5.OrderItemCreateLine> items,
  }) : super._(
         orderId: orderId,
         items: items,
       );

  /// Returns a shallow copy of this [OrderAddItems]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OrderAddItems copyWith({
    _isc.UuidValue? orderId,
    List<_ik0vi2j5.OrderItemCreateLine>? items,
  }) {
    return OrderAddItems(
      orderId: orderId ?? this.orderId,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
