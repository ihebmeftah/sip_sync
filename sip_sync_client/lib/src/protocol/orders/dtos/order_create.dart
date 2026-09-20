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

abstract class OrderCreate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OrderCreate._({
    required this.buildingId,
    this.venueTableId,
    required this.items,
  });

  factory OrderCreate({
    required _isc.UuidValue buildingId,
    _isc.UuidValue? venueTableId,
    required List<_ik0vi2j5.OrderItemCreateLine> items,
  }) = _OrderCreateImpl;

  factory OrderCreate.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderCreate(
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      venueTableId: jsonSerialization['venueTableId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['venueTableId'],
            ),
      items: _iozg9o5r.Protocol()
          .deserialize<List<_ik0vi2j5.OrderItemCreateLine>>(
            jsonSerialization['items'],
          ),
    );
  }

  _isc.UuidValue buildingId;

  _isc.UuidValue? venueTableId;

  List<_ik0vi2j5.OrderItemCreateLine> items;

  /// Returns a shallow copy of this [OrderCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OrderCreate copyWith({
    _isc.UuidValue? buildingId,
    _isc.UuidValue? venueTableId,
    List<_ik0vi2j5.OrderItemCreateLine>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderCreate',
      'buildingId': buildingId.toJson(),
      if (venueTableId != null) 'venueTableId': venueTableId?.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderCreate',
      'buildingId': buildingId.toJson(),
      if (venueTableId != null) 'venueTableId': venueTableId?.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderCreateImpl extends OrderCreate {
  _OrderCreateImpl({
    required _isc.UuidValue buildingId,
    _isc.UuidValue? venueTableId,
    required List<_ik0vi2j5.OrderItemCreateLine> items,
  }) : super._(
         buildingId: buildingId,
         venueTableId: venueTableId,
         items: items,
       );

  /// Returns a shallow copy of this [OrderCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OrderCreate copyWith({
    _isc.UuidValue? buildingId,
    Object? venueTableId = _Undefined,
    List<_ik0vi2j5.OrderItemCreateLine>? items,
  }) {
    return OrderCreate(
      buildingId: buildingId ?? this.buildingId,
      venueTableId: venueTableId is _isc.UuidValue?
          ? venueTableId
          : this.venueTableId,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
