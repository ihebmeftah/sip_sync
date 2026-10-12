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
import '../../notifications/dtos/app_notification_kind.dart' as _icpt1wso;
import '../../orders/dtos/order_cancellation_reason.dart' as _i9x1n0bn;
import '../../orders/dtos/order_item_status.dart' as _iw3cmuga;
import '../../orders/dtos/order_status.dart' as _iij1ihnv;
import '../../reservations/reservation_status.dart' as _isnodepe;

/// One alert the signed-in actor may see. No other recipient's rows are returned.
abstract class AppNotificationView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AppNotificationView._({
    required this.id,
    required this.buildingId,
    required this.venueName,
    required this.subjectId,
    required this.kind,
    this.orderItemId,
    this.orderRef,
    this.articleName,
    this.itemStatus,
    this.orderStatus,
    this.reservationStatus,
    this.cancellationReason,
    required this.read,
    required this.createdAt,
  });

  factory AppNotificationView({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
    required String venueName,
    required _is.UuidValue subjectId,
    required _icpt1wso.AppNotificationKind kind,
    _is.UuidValue? orderItemId,
    int? orderRef,
    String? articleName,
    _iw3cmuga.OrderItemStatus? itemStatus,
    _iij1ihnv.OrderStatus? orderStatus,
    _isnodepe.ReservationStatus? reservationStatus,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    required bool read,
    required DateTime createdAt,
  }) = _AppNotificationViewImpl;

  factory AppNotificationView.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppNotificationView(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      venueName: jsonSerialization['venueName'] as String,
      subjectId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['subjectId'],
      ),
      kind: _icpt1wso.AppNotificationKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      orderItemId: jsonSerialization['orderItemId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['orderItemId'],
            ),
      orderRef: jsonSerialization['orderRef'] as int?,
      articleName: jsonSerialization['articleName'] as String?,
      itemStatus: jsonSerialization['itemStatus'] == null
          ? null
          : _iw3cmuga.OrderItemStatus.fromJson(
              (jsonSerialization['itemStatus'] as String),
            ),
      orderStatus: jsonSerialization['orderStatus'] == null
          ? null
          : _iij1ihnv.OrderStatus.fromJson(
              (jsonSerialization['orderStatus'] as String),
            ),
      reservationStatus: jsonSerialization['reservationStatus'] == null
          ? null
          : _isnodepe.ReservationStatus.fromJson(
              (jsonSerialization['reservationStatus'] as String),
            ),
      cancellationReason: jsonSerialization['cancellationReason'] == null
          ? null
          : _i9x1n0bn.OrderCancellationReason.fromJson(
              (jsonSerialization['cancellationReason'] as String),
            ),
      read: _is.BoolJsonExtension.fromJson(jsonSerialization['read']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  _is.UuidValue id;

  _is.UuidValue buildingId;

  String venueName;

  /// Order id, reservation id, or a later management record. The app opens it from [kind].
  _is.UuidValue subjectId;

  _icpt1wso.AppNotificationKind kind;

  _is.UuidValue? orderItemId;

  int? orderRef;

  String? articleName;

  _iw3cmuga.OrderItemStatus? itemStatus;

  _iij1ihnv.OrderStatus? orderStatus;

  _isnodepe.ReservationStatus? reservationStatus;

  _i9x1n0bn.OrderCancellationReason? cancellationReason;

  /// False until [NotificationEndpoint.markRead].
  bool read;

  DateTime createdAt;

  /// Returns a shallow copy of this [AppNotificationView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AppNotificationView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    String? venueName,
    _is.UuidValue? subjectId,
    _icpt1wso.AppNotificationKind? kind,
    _is.UuidValue? orderItemId,
    int? orderRef,
    String? articleName,
    _iw3cmuga.OrderItemStatus? itemStatus,
    _iij1ihnv.OrderStatus? orderStatus,
    _isnodepe.ReservationStatus? reservationStatus,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    bool? read,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppNotificationView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'venueName': venueName,
      'subjectId': subjectId.toJson(),
      'kind': kind.toJson(),
      if (orderItemId != null) 'orderItemId': orderItemId?.toJson(),
      if (orderRef != null) 'orderRef': orderRef,
      if (articleName != null) 'articleName': articleName,
      if (itemStatus != null) 'itemStatus': itemStatus?.toJson(),
      if (orderStatus != null) 'orderStatus': orderStatus?.toJson(),
      if (reservationStatus != null)
        'reservationStatus': reservationStatus?.toJson(),
      if (cancellationReason != null)
        'cancellationReason': cancellationReason?.toJson(),
      'read': read,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppNotificationView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'venueName': venueName,
      'subjectId': subjectId.toJson(),
      'kind': kind.toJson(),
      if (orderItemId != null) 'orderItemId': orderItemId?.toJson(),
      if (orderRef != null) 'orderRef': orderRef,
      if (articleName != null) 'articleName': articleName,
      if (itemStatus != null) 'itemStatus': itemStatus?.toJson(),
      if (orderStatus != null) 'orderStatus': orderStatus?.toJson(),
      if (reservationStatus != null)
        'reservationStatus': reservationStatus?.toJson(),
      if (cancellationReason != null)
        'cancellationReason': cancellationReason?.toJson(),
      'read': read,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppNotificationViewImpl extends AppNotificationView {
  _AppNotificationViewImpl({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
    required String venueName,
    required _is.UuidValue subjectId,
    required _icpt1wso.AppNotificationKind kind,
    _is.UuidValue? orderItemId,
    int? orderRef,
    String? articleName,
    _iw3cmuga.OrderItemStatus? itemStatus,
    _iij1ihnv.OrderStatus? orderStatus,
    _isnodepe.ReservationStatus? reservationStatus,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    required bool read,
    required DateTime createdAt,
  }) : super._(
         id: id,
         buildingId: buildingId,
         venueName: venueName,
         subjectId: subjectId,
         kind: kind,
         orderItemId: orderItemId,
         orderRef: orderRef,
         articleName: articleName,
         itemStatus: itemStatus,
         orderStatus: orderStatus,
         reservationStatus: reservationStatus,
         cancellationReason: cancellationReason,
         read: read,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AppNotificationView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AppNotificationView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    String? venueName,
    _is.UuidValue? subjectId,
    _icpt1wso.AppNotificationKind? kind,
    Object? orderItemId = _Undefined,
    Object? orderRef = _Undefined,
    Object? articleName = _Undefined,
    Object? itemStatus = _Undefined,
    Object? orderStatus = _Undefined,
    Object? reservationStatus = _Undefined,
    Object? cancellationReason = _Undefined,
    bool? read,
    DateTime? createdAt,
  }) {
    return AppNotificationView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      venueName: venueName ?? this.venueName,
      subjectId: subjectId ?? this.subjectId,
      kind: kind ?? this.kind,
      orderItemId: orderItemId is _is.UuidValue?
          ? orderItemId
          : this.orderItemId,
      orderRef: orderRef is int? ? orderRef : this.orderRef,
      articleName: articleName is String? ? articleName : this.articleName,
      itemStatus: itemStatus is _iw3cmuga.OrderItemStatus?
          ? itemStatus
          : this.itemStatus,
      orderStatus: orderStatus is _iij1ihnv.OrderStatus?
          ? orderStatus
          : this.orderStatus,
      reservationStatus: reservationStatus is _isnodepe.ReservationStatus?
          ? reservationStatus
          : this.reservationStatus,
      cancellationReason:
          cancellationReason is _i9x1n0bn.OrderCancellationReason?
          ? cancellationReason
          : this.cancellationReason,
      read: read ?? this.read,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
