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
import '../../orders/dtos/order_actor_view.dart' as _i1wfgxvh;
import '../../orders/dtos/order_cancellation_reason.dart' as _i9x1n0bn;
import '../../orders/dtos/order_item_view.dart' as _i5ik7hbb;
import '../../orders/dtos/order_status.dart' as _iij1ihnv;

abstract class OrderView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OrderView._({
    required this.id,
    required this.buildingId,
    this.venueTableId,
    this.tableNumber,
    required this.ref,
    required this.status,
    required this.launchedBy,
    this.lastPaidBy,
    this.lastPaidAt,
    this.cancelledBy,
    this.cancelledAt,
    this.cancellationReason,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.totalAmount,
  });

  factory OrderView({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    _isc.UuidValue? venueTableId,
    int? tableNumber,
    required int ref,
    required _iij1ihnv.OrderStatus status,
    required _i1wfgxvh.OrderActorView launchedBy,
    _i1wfgxvh.OrderActorView? lastPaidBy,
    DateTime? lastPaidAt,
    _i1wfgxvh.OrderActorView? cancelledBy,
    DateTime? cancelledAt,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<_i5ik7hbb.OrderItemView> items,
    required double totalAmount,
  }) = _OrderViewImpl;

  factory OrderView.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      venueTableId: jsonSerialization['venueTableId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['venueTableId'],
            ),
      tableNumber: jsonSerialization['tableNumber'] as int?,
      ref: jsonSerialization['ref'] as int,
      status: _iij1ihnv.OrderStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      launchedBy: _iozg9o5r.Protocol().deserialize<_i1wfgxvh.OrderActorView>(
        jsonSerialization['launchedBy'],
      ),
      lastPaidBy: jsonSerialization['lastPaidBy'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_i1wfgxvh.OrderActorView>(
              jsonSerialization['lastPaidBy'],
            ),
      lastPaidAt: jsonSerialization['lastPaidAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastPaidAt'],
            ),
      cancelledBy: jsonSerialization['cancelledBy'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_i1wfgxvh.OrderActorView>(
              jsonSerialization['cancelledBy'],
            ),
      cancelledAt: jsonSerialization['cancelledAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['cancelledAt'],
            ),
      cancellationReason: jsonSerialization['cancellationReason'] == null
          ? null
          : _i9x1n0bn.OrderCancellationReason.fromJson(
              (jsonSerialization['cancellationReason'] as String),
            ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      items: _iozg9o5r.Protocol().deserialize<List<_i5ik7hbb.OrderItemView>>(
        jsonSerialization['items'],
      ),
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue buildingId;

  _isc.UuidValue? venueTableId;

  int? tableNumber;

  int ref;

  _iij1ihnv.OrderStatus status;

  _i1wfgxvh.OrderActorView launchedBy;

  _i1wfgxvh.OrderActorView? lastPaidBy;

  DateTime? lastPaidAt;

  _i1wfgxvh.OrderActorView? cancelledBy;

  DateTime? cancelledAt;

  _i9x1n0bn.OrderCancellationReason? cancellationReason;

  DateTime createdAt;

  DateTime updatedAt;

  List<_i5ik7hbb.OrderItemView> items;

  double totalAmount;

  /// Returns a shallow copy of this [OrderView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OrderView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    _isc.UuidValue? venueTableId,
    int? tableNumber,
    int? ref,
    _iij1ihnv.OrderStatus? status,
    _i1wfgxvh.OrderActorView? launchedBy,
    _i1wfgxvh.OrderActorView? lastPaidBy,
    DateTime? lastPaidAt,
    _i1wfgxvh.OrderActorView? cancelledBy,
    DateTime? cancelledAt,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i5ik7hbb.OrderItemView>? items,
    double? totalAmount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      if (venueTableId != null) 'venueTableId': venueTableId?.toJson(),
      if (tableNumber != null) 'tableNumber': tableNumber,
      'ref': ref,
      'status': status.toJson(),
      'launchedBy': launchedBy.toJson(),
      if (lastPaidBy != null) 'lastPaidBy': lastPaidBy?.toJson(),
      if (lastPaidAt != null) 'lastPaidAt': lastPaidAt?.toJson(),
      if (cancelledBy != null) 'cancelledBy': cancelledBy?.toJson(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      if (cancellationReason != null)
        'cancellationReason': cancellationReason?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'totalAmount': totalAmount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      if (venueTableId != null) 'venueTableId': venueTableId?.toJson(),
      if (tableNumber != null) 'tableNumber': tableNumber,
      'ref': ref,
      'status': status.toJson(),
      'launchedBy': launchedBy.toJsonForProtocol(),
      if (lastPaidBy != null) 'lastPaidBy': lastPaidBy?.toJsonForProtocol(),
      if (lastPaidAt != null) 'lastPaidAt': lastPaidAt?.toJson(),
      if (cancelledBy != null) 'cancelledBy': cancelledBy?.toJsonForProtocol(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      if (cancellationReason != null)
        'cancellationReason': cancellationReason?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalAmount': totalAmount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderViewImpl extends OrderView {
  _OrderViewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    _isc.UuidValue? venueTableId,
    int? tableNumber,
    required int ref,
    required _iij1ihnv.OrderStatus status,
    required _i1wfgxvh.OrderActorView launchedBy,
    _i1wfgxvh.OrderActorView? lastPaidBy,
    DateTime? lastPaidAt,
    _i1wfgxvh.OrderActorView? cancelledBy,
    DateTime? cancelledAt,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<_i5ik7hbb.OrderItemView> items,
    required double totalAmount,
  }) : super._(
         id: id,
         buildingId: buildingId,
         venueTableId: venueTableId,
         tableNumber: tableNumber,
         ref: ref,
         status: status,
         launchedBy: launchedBy,
         lastPaidBy: lastPaidBy,
         lastPaidAt: lastPaidAt,
         cancelledBy: cancelledBy,
         cancelledAt: cancelledAt,
         cancellationReason: cancellationReason,
         createdAt: createdAt,
         updatedAt: updatedAt,
         items: items,
         totalAmount: totalAmount,
       );

  /// Returns a shallow copy of this [OrderView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OrderView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    Object? venueTableId = _Undefined,
    Object? tableNumber = _Undefined,
    int? ref,
    _iij1ihnv.OrderStatus? status,
    _i1wfgxvh.OrderActorView? launchedBy,
    Object? lastPaidBy = _Undefined,
    Object? lastPaidAt = _Undefined,
    Object? cancelledBy = _Undefined,
    Object? cancelledAt = _Undefined,
    Object? cancellationReason = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i5ik7hbb.OrderItemView>? items,
    double? totalAmount,
  }) {
    return OrderView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      venueTableId: venueTableId is _isc.UuidValue?
          ? venueTableId
          : this.venueTableId,
      tableNumber: tableNumber is int? ? tableNumber : this.tableNumber,
      ref: ref ?? this.ref,
      status: status ?? this.status,
      launchedBy: launchedBy ?? this.launchedBy.copyWith(),
      lastPaidBy: lastPaidBy is _i1wfgxvh.OrderActorView?
          ? lastPaidBy
          : this.lastPaidBy?.copyWith(),
      lastPaidAt: lastPaidAt is DateTime? ? lastPaidAt : this.lastPaidAt,
      cancelledBy: cancelledBy is _i1wfgxvh.OrderActorView?
          ? cancelledBy
          : this.cancelledBy?.copyWith(),
      cancelledAt: cancelledAt is DateTime? ? cancelledAt : this.cancelledAt,
      cancellationReason:
          cancellationReason is _i9x1n0bn.OrderCancellationReason?
          ? cancellationReason
          : this.cancellationReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
