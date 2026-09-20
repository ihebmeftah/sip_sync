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
import '../../auth/dtos/actor_type.dart' as _i6ch5qy5;
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
    this.passedByType,
    this.passedById,
    this.preparedByType,
    this.preparedById,
    this.servedByType,
    this.servedById,
    this.paidToType,
    this.paidToId,
    this.cancelledByType,
    this.cancelledById,
    required this.createdAt,
    required this.updatedAt,
    this.preparedAt,
    this.servedAt,
    this.paidAt,
    this.cancelledAt,
  });

  factory OrderItemView({
    required _isc.UuidValue id,
    required _isc.UuidValue orderId,
    required _isc.UuidValue articleId,
    required String articleName,
    required double unitPrice,
    required _iw3cmuga.OrderItemStatus status,
    _i6ch5qy5.ActorType? passedByType,
    _isc.UuidValue? passedById,
    _i6ch5qy5.ActorType? preparedByType,
    _isc.UuidValue? preparedById,
    _i6ch5qy5.ActorType? servedByType,
    _isc.UuidValue? servedById,
    _i6ch5qy5.ActorType? paidToType,
    _isc.UuidValue? paidToId,
    _i6ch5qy5.ActorType? cancelledByType,
    _isc.UuidValue? cancelledById,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? preparedAt,
    DateTime? servedAt,
    DateTime? paidAt,
    DateTime? cancelledAt,
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
      passedByType: jsonSerialization['passedByType'] == null
          ? null
          : _i6ch5qy5.ActorType.fromJson(
              (jsonSerialization['passedByType'] as String),
            ),
      passedById: jsonSerialization['passedById'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['passedById'],
            ),
      preparedByType: jsonSerialization['preparedByType'] == null
          ? null
          : _i6ch5qy5.ActorType.fromJson(
              (jsonSerialization['preparedByType'] as String),
            ),
      preparedById: jsonSerialization['preparedById'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['preparedById'],
            ),
      servedByType: jsonSerialization['servedByType'] == null
          ? null
          : _i6ch5qy5.ActorType.fromJson(
              (jsonSerialization['servedByType'] as String),
            ),
      servedById: jsonSerialization['servedById'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['servedById'],
            ),
      paidToType: jsonSerialization['paidToType'] == null
          ? null
          : _i6ch5qy5.ActorType.fromJson(
              (jsonSerialization['paidToType'] as String),
            ),
      paidToId: jsonSerialization['paidToId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['paidToId']),
      cancelledByType: jsonSerialization['cancelledByType'] == null
          ? null
          : _i6ch5qy5.ActorType.fromJson(
              (jsonSerialization['cancelledByType'] as String),
            ),
      cancelledById: jsonSerialization['cancelledById'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['cancelledById'],
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
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue orderId;

  _isc.UuidValue articleId;

  String articleName;

  double unitPrice;

  _iw3cmuga.OrderItemStatus status;

  _i6ch5qy5.ActorType? passedByType;

  _isc.UuidValue? passedById;

  _i6ch5qy5.ActorType? preparedByType;

  _isc.UuidValue? preparedById;

  _i6ch5qy5.ActorType? servedByType;

  _isc.UuidValue? servedById;

  _i6ch5qy5.ActorType? paidToType;

  _isc.UuidValue? paidToId;

  _i6ch5qy5.ActorType? cancelledByType;

  _isc.UuidValue? cancelledById;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? preparedAt;

  DateTime? servedAt;

  DateTime? paidAt;

  DateTime? cancelledAt;

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
    _i6ch5qy5.ActorType? passedByType,
    _isc.UuidValue? passedById,
    _i6ch5qy5.ActorType? preparedByType,
    _isc.UuidValue? preparedById,
    _i6ch5qy5.ActorType? servedByType,
    _isc.UuidValue? servedById,
    _i6ch5qy5.ActorType? paidToType,
    _isc.UuidValue? paidToId,
    _i6ch5qy5.ActorType? cancelledByType,
    _isc.UuidValue? cancelledById,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? preparedAt,
    DateTime? servedAt,
    DateTime? paidAt,
    DateTime? cancelledAt,
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
      if (passedByType != null) 'passedByType': passedByType?.toJson(),
      if (passedById != null) 'passedById': passedById?.toJson(),
      if (preparedByType != null) 'preparedByType': preparedByType?.toJson(),
      if (preparedById != null) 'preparedById': preparedById?.toJson(),
      if (servedByType != null) 'servedByType': servedByType?.toJson(),
      if (servedById != null) 'servedById': servedById?.toJson(),
      if (paidToType != null) 'paidToType': paidToType?.toJson(),
      if (paidToId != null) 'paidToId': paidToId?.toJson(),
      if (cancelledByType != null) 'cancelledByType': cancelledByType?.toJson(),
      if (cancelledById != null) 'cancelledById': cancelledById?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (preparedAt != null) 'preparedAt': preparedAt?.toJson(),
      if (servedAt != null) 'servedAt': servedAt?.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
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
      if (passedByType != null) 'passedByType': passedByType?.toJson(),
      if (passedById != null) 'passedById': passedById?.toJson(),
      if (preparedByType != null) 'preparedByType': preparedByType?.toJson(),
      if (preparedById != null) 'preparedById': preparedById?.toJson(),
      if (servedByType != null) 'servedByType': servedByType?.toJson(),
      if (servedById != null) 'servedById': servedById?.toJson(),
      if (paidToType != null) 'paidToType': paidToType?.toJson(),
      if (paidToId != null) 'paidToId': paidToId?.toJson(),
      if (cancelledByType != null) 'cancelledByType': cancelledByType?.toJson(),
      if (cancelledById != null) 'cancelledById': cancelledById?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (preparedAt != null) 'preparedAt': preparedAt?.toJson(),
      if (servedAt != null) 'servedAt': servedAt?.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
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
    _i6ch5qy5.ActorType? passedByType,
    _isc.UuidValue? passedById,
    _i6ch5qy5.ActorType? preparedByType,
    _isc.UuidValue? preparedById,
    _i6ch5qy5.ActorType? servedByType,
    _isc.UuidValue? servedById,
    _i6ch5qy5.ActorType? paidToType,
    _isc.UuidValue? paidToId,
    _i6ch5qy5.ActorType? cancelledByType,
    _isc.UuidValue? cancelledById,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? preparedAt,
    DateTime? servedAt,
    DateTime? paidAt,
    DateTime? cancelledAt,
  }) : super._(
         id: id,
         orderId: orderId,
         articleId: articleId,
         articleName: articleName,
         unitPrice: unitPrice,
         status: status,
         passedByType: passedByType,
         passedById: passedById,
         preparedByType: preparedByType,
         preparedById: preparedById,
         servedByType: servedByType,
         servedById: servedById,
         paidToType: paidToType,
         paidToId: paidToId,
         cancelledByType: cancelledByType,
         cancelledById: cancelledById,
         createdAt: createdAt,
         updatedAt: updatedAt,
         preparedAt: preparedAt,
         servedAt: servedAt,
         paidAt: paidAt,
         cancelledAt: cancelledAt,
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
    Object? passedByType = _Undefined,
    Object? passedById = _Undefined,
    Object? preparedByType = _Undefined,
    Object? preparedById = _Undefined,
    Object? servedByType = _Undefined,
    Object? servedById = _Undefined,
    Object? paidToType = _Undefined,
    Object? paidToId = _Undefined,
    Object? cancelledByType = _Undefined,
    Object? cancelledById = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? preparedAt = _Undefined,
    Object? servedAt = _Undefined,
    Object? paidAt = _Undefined,
    Object? cancelledAt = _Undefined,
  }) {
    return OrderItemView(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      articleId: articleId ?? this.articleId,
      articleName: articleName ?? this.articleName,
      unitPrice: unitPrice ?? this.unitPrice,
      status: status ?? this.status,
      passedByType: passedByType is _i6ch5qy5.ActorType?
          ? passedByType
          : this.passedByType,
      passedById: passedById is _isc.UuidValue? ? passedById : this.passedById,
      preparedByType: preparedByType is _i6ch5qy5.ActorType?
          ? preparedByType
          : this.preparedByType,
      preparedById: preparedById is _isc.UuidValue?
          ? preparedById
          : this.preparedById,
      servedByType: servedByType is _i6ch5qy5.ActorType?
          ? servedByType
          : this.servedByType,
      servedById: servedById is _isc.UuidValue? ? servedById : this.servedById,
      paidToType: paidToType is _i6ch5qy5.ActorType?
          ? paidToType
          : this.paidToType,
      paidToId: paidToId is _isc.UuidValue? ? paidToId : this.paidToId,
      cancelledByType: cancelledByType is _i6ch5qy5.ActorType?
          ? cancelledByType
          : this.cancelledByType,
      cancelledById: cancelledById is _isc.UuidValue?
          ? cancelledById
          : this.cancelledById,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      preparedAt: preparedAt is DateTime? ? preparedAt : this.preparedAt,
      servedAt: servedAt is DateTime? ? servedAt : this.servedAt,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
      cancelledAt: cancelledAt is DateTime? ? cancelledAt : this.cancelledAt,
    );
  }
}
