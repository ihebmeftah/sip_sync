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
import '../../orders/dtos/order_board_event_kind.dart' as _iej3rdh2;
import '../../orders/dtos/order_view.dart' as _icjr839y;

/// One update for the management floor board.
abstract class OrderBoardEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OrderBoardEvent._({
    required this.kind,
    this.order,
    required this.itemIds,
  });

  factory OrderBoardEvent({
    required _iej3rdh2.OrderBoardEventKind kind,
    _icjr839y.OrderView? order,
    required List<_isc.UuidValue> itemIds,
  }) = _OrderBoardEventImpl;

  factory OrderBoardEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderBoardEvent(
      kind: _iej3rdh2.OrderBoardEventKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      order: jsonSerialization['order'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_icjr839y.OrderView>(
              jsonSerialization['order'],
            ),
      itemIds: _iozg9o5r.Protocol().deserialize<List<_isc.UuidValue>>(
        jsonSerialization['itemIds'],
      ),
    );
  }

  _iej3rdh2.OrderBoardEventKind kind;

  _icjr839y.OrderView? order;

  List<_isc.UuidValue> itemIds;

  /// Returns a shallow copy of this [OrderBoardEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OrderBoardEvent copyWith({
    _iej3rdh2.OrderBoardEventKind? kind,
    _icjr839y.OrderView? order,
    List<_isc.UuidValue>? itemIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderBoardEvent',
      'kind': kind.toJson(),
      if (order != null) 'order': order?.toJson(),
      'itemIds': itemIds.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderBoardEvent',
      'kind': kind.toJson(),
      if (order != null) 'order': order?.toJsonForProtocol(),
      'itemIds': itemIds.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderBoardEventImpl extends OrderBoardEvent {
  _OrderBoardEventImpl({
    required _iej3rdh2.OrderBoardEventKind kind,
    _icjr839y.OrderView? order,
    required List<_isc.UuidValue> itemIds,
  }) : super._(
         kind: kind,
         order: order,
         itemIds: itemIds,
       );

  /// Returns a shallow copy of this [OrderBoardEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OrderBoardEvent copyWith({
    _iej3rdh2.OrderBoardEventKind? kind,
    Object? order = _Undefined,
    List<_isc.UuidValue>? itemIds,
  }) {
    return OrderBoardEvent(
      kind: kind ?? this.kind,
      order: order is _icjr839y.OrderView? ? order : this.order?.copyWith(),
      itemIds: itemIds ?? this.itemIds.map((e0) => e0).toList(),
    );
  }
}
