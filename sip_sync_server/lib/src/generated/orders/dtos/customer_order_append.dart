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
import 'package:sip_sync_server/src/generated/protocol.dart' as _iaib1p48;
import '../../orders/dtos/customer_order_item.dart' as _i6en5y8z;

/// Extra dishes for an order this customer already has open.
abstract class CustomerOrderAppend
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CustomerOrderAppend._({
    required this.orderId,
    required this.items,
  });

  factory CustomerOrderAppend({
    required _is.UuidValue orderId,
    required List<_i6en5y8z.CustomerOrderItem> items,
  }) = _CustomerOrderAppendImpl;

  factory CustomerOrderAppend.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerOrderAppend(
      orderId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['orderId'],
      ),
      items: _iaib1p48.Protocol()
          .deserialize<List<_i6en5y8z.CustomerOrderItem>>(
            jsonSerialization['items'],
          ),
    );
  }

  _is.UuidValue orderId;

  List<_i6en5y8z.CustomerOrderItem> items;

  /// Returns a shallow copy of this [CustomerOrderAppend]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerOrderAppend copyWith({
    _is.UuidValue? orderId,
    List<_i6en5y8z.CustomerOrderItem>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerOrderAppend',
      'orderId': orderId.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerOrderAppend',
      'orderId': orderId.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CustomerOrderAppendImpl extends CustomerOrderAppend {
  _CustomerOrderAppendImpl({
    required _is.UuidValue orderId,
    required List<_i6en5y8z.CustomerOrderItem> items,
  }) : super._(
         orderId: orderId,
         items: items,
       );

  /// Returns a shallow copy of this [CustomerOrderAppend]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CustomerOrderAppend copyWith({
    _is.UuidValue? orderId,
    List<_i6en5y8z.CustomerOrderItem>? items,
  }) {
    return CustomerOrderAppend(
      orderId: orderId ?? this.orderId,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
