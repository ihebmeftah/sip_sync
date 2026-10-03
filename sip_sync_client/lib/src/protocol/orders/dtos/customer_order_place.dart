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
import '../../orders/dtos/customer_order_item.dart' as _i6en5y8z;

/// A customer order for one scanned table. Prices are taken from the menu.
abstract class CustomerOrderPlace
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CustomerOrderPlace._({
    required this.buildingId,
    required this.tableId,
    required this.items,
  });

  factory CustomerOrderPlace({
    required _isc.UuidValue buildingId,
    required _isc.UuidValue tableId,
    required List<_i6en5y8z.CustomerOrderItem> items,
  }) = _CustomerOrderPlaceImpl;

  factory CustomerOrderPlace.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerOrderPlace(
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      tableId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['tableId'],
      ),
      items: _iozg9o5r.Protocol()
          .deserialize<List<_i6en5y8z.CustomerOrderItem>>(
            jsonSerialization['items'],
          ),
    );
  }

  _isc.UuidValue buildingId;

  _isc.UuidValue tableId;

  List<_i6en5y8z.CustomerOrderItem> items;

  /// Returns a shallow copy of this [CustomerOrderPlace]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CustomerOrderPlace copyWith({
    _isc.UuidValue? buildingId,
    _isc.UuidValue? tableId,
    List<_i6en5y8z.CustomerOrderItem>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerOrderPlace',
      'buildingId': buildingId.toJson(),
      'tableId': tableId.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerOrderPlace',
      'buildingId': buildingId.toJson(),
      'tableId': tableId.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _CustomerOrderPlaceImpl extends CustomerOrderPlace {
  _CustomerOrderPlaceImpl({
    required _isc.UuidValue buildingId,
    required _isc.UuidValue tableId,
    required List<_i6en5y8z.CustomerOrderItem> items,
  }) : super._(
         buildingId: buildingId,
         tableId: tableId,
         items: items,
       );

  /// Returns a shallow copy of this [CustomerOrderPlace]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CustomerOrderPlace copyWith({
    _isc.UuidValue? buildingId,
    _isc.UuidValue? tableId,
    List<_i6en5y8z.CustomerOrderItem>? items,
  }) {
    return CustomerOrderPlace(
      buildingId: buildingId ?? this.buildingId,
      tableId: tableId ?? this.tableId,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
