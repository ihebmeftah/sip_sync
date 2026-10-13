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
import '../../orders/dtos/order_item_status.dart' as _iw3cmuga;

abstract class OrderItemView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OrderItemView._({
    required this.id,
    required this.orderId,
    required this.articleId,
    required this.articleName,
    required this.unitPrice,
    required this.status,
    this.addedBy,
    this.preparedBy,
    this.servedBy,
    this.paidTo,
    this.cancelledBy,
    required this.createdAt,
    required this.updatedAt,
    this.preparedAt,
    this.servedAt,
    this.paidAt,
    this.cancelledAt,
    this.cancellationReason,
  });

  factory OrderItemView({
    required _isc.UuidValue id,
    required _isc.UuidValue orderId,
    required _isc.UuidValue articleId,
    required String articleName,
    required double unitPrice,
    required _iw3cmuga.OrderItemStatus status,
    _i1wfgxvh.OrderActorView? addedBy,
    _i1wfgxvh.OrderActorView? preparedBy,
    _i1wfgxvh.OrderActorView? servedBy,
    _i1wfgxvh.OrderActorView? paidTo,
    _i1wfgxvh.OrderActorView? cancelledBy,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? preparedAt,
    DateTime? servedAt,
    DateTime? paidAt,
    DateTime? cancelledAt,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
  }) = _OrderItemViewImpl;

  factory OrderItemView.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderItemView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      orderId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['orderId'],
      ),
      articleId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['articleId'],
      ),
      articleName: jsonSerialization['articleName'] as String,
      unitPrice: (jsonSerialization['unitPrice'] as num).toDouble(),
      status: _iw3cmuga.OrderItemStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      addedBy: jsonSerialization['addedBy'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_i1wfgxvh.OrderActorView>(
              jsonSerialization['addedBy'],
            ),
      preparedBy: jsonSerialization['preparedBy'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_i1wfgxvh.OrderActorView>(
              jsonSerialization['preparedBy'],
            ),
      servedBy: jsonSerialization['servedBy'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_i1wfgxvh.OrderActorView>(
              jsonSerialization['servedBy'],
            ),
      paidTo: jsonSerialization['paidTo'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_i1wfgxvh.OrderActorView>(
              jsonSerialization['paidTo'],
            ),
      cancelledBy: jsonSerialization['cancelledBy'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_i1wfgxvh.OrderActorView>(
              jsonSerialization['cancelledBy'],
            ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      preparedAt: jsonSerialization['preparedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['preparedAt'],
            ),
      servedAt: jsonSerialization['servedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['servedAt']),
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
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
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue orderId;

  _isc.UuidValue articleId;

  String articleName;

  double unitPrice;

  _iw3cmuga.OrderItemStatus status;

  /// Who created the line.
  _i1wfgxvh.OrderActorView? addedBy;

  /// Kitchen staff who picked the line or marked it ready.
  _i1wfgxvh.OrderActorView? preparedBy;

  _i1wfgxvh.OrderActorView? servedBy;

  _i1wfgxvh.OrderActorView? paidTo;

  _i1wfgxvh.OrderActorView? cancelledBy;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? preparedAt;

  DateTime? servedAt;

  DateTime? paidAt;

  DateTime? cancelledAt;

  _i9x1n0bn.OrderCancellationReason? cancellationReason;

  /// Returns a shallow copy of this [OrderItemView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OrderItemView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? orderId,
    _isc.UuidValue? articleId,
    String? articleName,
    double? unitPrice,
    _iw3cmuga.OrderItemStatus? status,
    _i1wfgxvh.OrderActorView? addedBy,
    _i1wfgxvh.OrderActorView? preparedBy,
    _i1wfgxvh.OrderActorView? servedBy,
    _i1wfgxvh.OrderActorView? paidTo,
    _i1wfgxvh.OrderActorView? cancelledBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? preparedAt,
    DateTime? servedAt,
    DateTime? paidAt,
    DateTime? cancelledAt,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderItemView',
      'id': id.toJson(),
      'orderId': orderId.toJson(),
      'articleId': articleId.toJson(),
      'articleName': articleName,
      'unitPrice': unitPrice,
      'status': status.toJson(),
      if (addedBy != null) 'addedBy': addedBy?.toJson(),
      if (preparedBy != null) 'preparedBy': preparedBy?.toJson(),
      if (servedBy != null) 'servedBy': servedBy?.toJson(),
      if (paidTo != null) 'paidTo': paidTo?.toJson(),
      if (cancelledBy != null) 'cancelledBy': cancelledBy?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (preparedAt != null) 'preparedAt': preparedAt?.toJson(),
      if (servedAt != null) 'servedAt': servedAt?.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      if (cancellationReason != null)
        'cancellationReason': cancellationReason?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderItemView',
      'id': id.toJson(),
      'orderId': orderId.toJson(),
      'articleId': articleId.toJson(),
      'articleName': articleName,
      'unitPrice': unitPrice,
      'status': status.toJson(),
      if (addedBy != null) 'addedBy': addedBy?.toJsonForProtocol(),
      if (preparedBy != null) 'preparedBy': preparedBy?.toJsonForProtocol(),
      if (servedBy != null) 'servedBy': servedBy?.toJsonForProtocol(),
      if (paidTo != null) 'paidTo': paidTo?.toJsonForProtocol(),
      if (cancelledBy != null) 'cancelledBy': cancelledBy?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (preparedAt != null) 'preparedAt': preparedAt?.toJson(),
      if (servedAt != null) 'servedAt': servedAt?.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      if (cancellationReason != null)
        'cancellationReason': cancellationReason?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderItemViewImpl extends OrderItemView {
  _OrderItemViewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue orderId,
    required _isc.UuidValue articleId,
    required String articleName,
    required double unitPrice,
    required _iw3cmuga.OrderItemStatus status,
    _i1wfgxvh.OrderActorView? addedBy,
    _i1wfgxvh.OrderActorView? preparedBy,
    _i1wfgxvh.OrderActorView? servedBy,
    _i1wfgxvh.OrderActorView? paidTo,
    _i1wfgxvh.OrderActorView? cancelledBy,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? preparedAt,
    DateTime? servedAt,
    DateTime? paidAt,
    DateTime? cancelledAt,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
  }) : super._(
         id: id,
         orderId: orderId,
         articleId: articleId,
         articleName: articleName,
         unitPrice: unitPrice,
         status: status,
         addedBy: addedBy,
         preparedBy: preparedBy,
         servedBy: servedBy,
         paidTo: paidTo,
         cancelledBy: cancelledBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
         preparedAt: preparedAt,
         servedAt: servedAt,
         paidAt: paidAt,
         cancelledAt: cancelledAt,
         cancellationReason: cancellationReason,
       );

  /// Returns a shallow copy of this [OrderItemView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OrderItemView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? orderId,
    _isc.UuidValue? articleId,
    String? articleName,
    double? unitPrice,
    _iw3cmuga.OrderItemStatus? status,
    Object? addedBy = _Undefined,
    Object? preparedBy = _Undefined,
    Object? servedBy = _Undefined,
    Object? paidTo = _Undefined,
    Object? cancelledBy = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? preparedAt = _Undefined,
    Object? servedAt = _Undefined,
    Object? paidAt = _Undefined,
    Object? cancelledAt = _Undefined,
    Object? cancellationReason = _Undefined,
  }) {
    return OrderItemView(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      articleId: articleId ?? this.articleId,
      articleName: articleName ?? this.articleName,
      unitPrice: unitPrice ?? this.unitPrice,
      status: status ?? this.status,
      addedBy: addedBy is _i1wfgxvh.OrderActorView?
          ? addedBy
          : this.addedBy?.copyWith(),
      preparedBy: preparedBy is _i1wfgxvh.OrderActorView?
          ? preparedBy
          : this.preparedBy?.copyWith(),
      servedBy: servedBy is _i1wfgxvh.OrderActorView?
          ? servedBy
          : this.servedBy?.copyWith(),
      paidTo: paidTo is _i1wfgxvh.OrderActorView?
          ? paidTo
          : this.paidTo?.copyWith(),
      cancelledBy: cancelledBy is _i1wfgxvh.OrderActorView?
          ? cancelledBy
          : this.cancelledBy?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      preparedAt: preparedAt is DateTime? ? preparedAt : this.preparedAt,
      servedAt: servedAt is DateTime? ? servedAt : this.servedAt,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
      cancelledAt: cancelledAt is DateTime? ? cancelledAt : this.cancelledAt,
      cancellationReason:
          cancellationReason is _i9x1n0bn.OrderCancellationReason?
          ? cancellationReason
          : this.cancellationReason,
    );
  }
}
