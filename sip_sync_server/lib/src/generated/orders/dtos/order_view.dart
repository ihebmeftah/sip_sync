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
import '../../auth/dtos/actor_type.dart' as _i6ch5qy5;
import '../../orders/dtos/order_item_view.dart' as _i5ik7hbb;
import '../../orders/dtos/order_status.dart' as _iij1ihnv;

abstract class OrderView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  OrderView._({
    required this.id,
    required this.buildingId,
    this.venueTableId,
    this.tableNumber,
    required this.status,
    required this.launchedByType,
    required this.launchedById,
    this.lastPaidByType,
    this.lastPaidById,
    this.lastPaidAt,
    this.cancelledByType,
    this.cancelledById,
    this.cancelledAt,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.totalAmount,
  });

  factory OrderView({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
    _is.UuidValue? venueTableId,
    int? tableNumber,
    required _iij1ihnv.OrderStatus status,
    required _i6ch5qy5.ActorType launchedByType,
    required _is.UuidValue launchedById,
    _i6ch5qy5.ActorType? lastPaidByType,
    _is.UuidValue? lastPaidById,
    DateTime? lastPaidAt,
    _i6ch5qy5.ActorType? cancelledByType,
    _is.UuidValue? cancelledById,
    DateTime? cancelledAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<_i5ik7hbb.OrderItemView> items,
    required double totalAmount,
  }) = _OrderViewImpl;

  factory OrderView.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderView(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      venueTableId: jsonSerialization['venueTableId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['venueTableId'],
            ),
      tableNumber: jsonSerialization['tableNumber'] as int?,
      status: _iij1ihnv.OrderStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      launchedByType: _i6ch5qy5.ActorType.fromJson(
        (jsonSerialization['launchedByType'] as String),
      ),
      launchedById: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['launchedById'],
      ),
      lastPaidByType: jsonSerialization['lastPaidByType'] == null
          ? null
          : _i6ch5qy5.ActorType.fromJson(
              (jsonSerialization['lastPaidByType'] as String),
            ),
      lastPaidById: jsonSerialization['lastPaidById'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['lastPaidById'],
            ),
      lastPaidAt: jsonSerialization['lastPaidAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['lastPaidAt']),
      cancelledByType: jsonSerialization['cancelledByType'] == null
          ? null
          : _i6ch5qy5.ActorType.fromJson(
              (jsonSerialization['cancelledByType'] as String),
            ),
      cancelledById: jsonSerialization['cancelledById'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['cancelledById'],
            ),
      cancelledAt: jsonSerialization['cancelledAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['cancelledAt'],
            ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      items: _iaib1p48.Protocol().deserialize<List<_i5ik7hbb.OrderItemView>>(
        jsonSerialization['items'],
      ),
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
    );
  }

  _is.UuidValue id;

  _is.UuidValue buildingId;

  _is.UuidValue? venueTableId;

  int? tableNumber;

  _iij1ihnv.OrderStatus status;

  _i6ch5qy5.ActorType launchedByType;

  _is.UuidValue launchedById;

  _i6ch5qy5.ActorType? lastPaidByType;

  _is.UuidValue? lastPaidById;

  DateTime? lastPaidAt;

  _i6ch5qy5.ActorType? cancelledByType;

  _is.UuidValue? cancelledById;

  DateTime? cancelledAt;

  DateTime createdAt;

  DateTime updatedAt;

  List<_i5ik7hbb.OrderItemView> items;

  double totalAmount;

  /// Returns a shallow copy of this [OrderView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OrderView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    _is.UuidValue? venueTableId,
    int? tableNumber,
    _iij1ihnv.OrderStatus? status,
    _i6ch5qy5.ActorType? launchedByType,
    _is.UuidValue? launchedById,
    _i6ch5qy5.ActorType? lastPaidByType,
    _is.UuidValue? lastPaidById,
    DateTime? lastPaidAt,
    _i6ch5qy5.ActorType? cancelledByType,
    _is.UuidValue? cancelledById,
    DateTime? cancelledAt,
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
      'status': status.toJson(),
      'launchedByType': launchedByType.toJson(),
      'launchedById': launchedById.toJson(),
      if (lastPaidByType != null) 'lastPaidByType': lastPaidByType?.toJson(),
      if (lastPaidById != null) 'lastPaidById': lastPaidById?.toJson(),
      if (lastPaidAt != null) 'lastPaidAt': lastPaidAt?.toJson(),
      if (cancelledByType != null) 'cancelledByType': cancelledByType?.toJson(),
      if (cancelledById != null) 'cancelledById': cancelledById?.toJson(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
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
      'status': status.toJson(),
      'launchedByType': launchedByType.toJson(),
      'launchedById': launchedById.toJson(),
      if (lastPaidByType != null) 'lastPaidByType': lastPaidByType?.toJson(),
      if (lastPaidById != null) 'lastPaidById': lastPaidById?.toJson(),
      if (lastPaidAt != null) 'lastPaidAt': lastPaidAt?.toJson(),
      if (cancelledByType != null) 'cancelledByType': cancelledByType?.toJson(),
      if (cancelledById != null) 'cancelledById': cancelledById?.toJson(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalAmount': totalAmount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderViewImpl extends OrderView {
  _OrderViewImpl({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
    _is.UuidValue? venueTableId,
    int? tableNumber,
    required _iij1ihnv.OrderStatus status,
    required _i6ch5qy5.ActorType launchedByType,
    required _is.UuidValue launchedById,
    _i6ch5qy5.ActorType? lastPaidByType,
    _is.UuidValue? lastPaidById,
    DateTime? lastPaidAt,
    _i6ch5qy5.ActorType? cancelledByType,
    _is.UuidValue? cancelledById,
    DateTime? cancelledAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<_i5ik7hbb.OrderItemView> items,
    required double totalAmount,
  }) : super._(
         id: id,
         buildingId: buildingId,
         venueTableId: venueTableId,
         tableNumber: tableNumber,
         status: status,
         launchedByType: launchedByType,
         launchedById: launchedById,
         lastPaidByType: lastPaidByType,
         lastPaidById: lastPaidById,
         lastPaidAt: lastPaidAt,
         cancelledByType: cancelledByType,
         cancelledById: cancelledById,
         cancelledAt: cancelledAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
         items: items,
         totalAmount: totalAmount,
       );

  /// Returns a shallow copy of this [OrderView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OrderView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    Object? venueTableId = _Undefined,
    Object? tableNumber = _Undefined,
    _iij1ihnv.OrderStatus? status,
    _i6ch5qy5.ActorType? launchedByType,
    _is.UuidValue? launchedById,
    Object? lastPaidByType = _Undefined,
    Object? lastPaidById = _Undefined,
    Object? lastPaidAt = _Undefined,
    Object? cancelledByType = _Undefined,
    Object? cancelledById = _Undefined,
    Object? cancelledAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i5ik7hbb.OrderItemView>? items,
    double? totalAmount,
  }) {
    return OrderView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      venueTableId: venueTableId is _is.UuidValue?
          ? venueTableId
          : this.venueTableId,
      tableNumber: tableNumber is int? ? tableNumber : this.tableNumber,
      status: status ?? this.status,
      launchedByType: launchedByType ?? this.launchedByType,
      launchedById: launchedById ?? this.launchedById,
      lastPaidByType: lastPaidByType is _i6ch5qy5.ActorType?
          ? lastPaidByType
          : this.lastPaidByType,
      lastPaidById: lastPaidById is _is.UuidValue?
          ? lastPaidById
          : this.lastPaidById,
      lastPaidAt: lastPaidAt is DateTime? ? lastPaidAt : this.lastPaidAt,
      cancelledByType: cancelledByType is _i6ch5qy5.ActorType?
          ? cancelledByType
          : this.cancelledByType,
      cancelledById: cancelledById is _is.UuidValue?
          ? cancelledById
          : this.cancelledById,
      cancelledAt: cancelledAt is DateTime? ? cancelledAt : this.cancelledAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
