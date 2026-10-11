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
import '../../orders/dtos/order_cancellation_reason.dart' as _i9x1n0bn;
import '../../orders/dtos/order_status.dart' as _iij1ihnv;

/// One of the signed-in customer's orders, without the dish lines.
abstract class CustomerOrderSummary
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CustomerOrderSummary._({
    required this.id,
    required this.buildingId,
    required this.venueName,
    required this.ref,
    required this.tableNumber,
    required this.currencyCode,
    required this.status,
    this.cancellationReason,
    required this.itemCount,
    required this.totalAmount,
    required this.createdAt,
  });

  factory CustomerOrderSummary({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required String venueName,
    required int ref,
    required int tableNumber,
    required String currencyCode,
    required _iij1ihnv.OrderStatus status,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    required int itemCount,
    required double totalAmount,
    required DateTime createdAt,
  }) = _CustomerOrderSummaryImpl;

  factory CustomerOrderSummary.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CustomerOrderSummary(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      venueName: jsonSerialization['venueName'] as String,
      ref: jsonSerialization['ref'] as int,
      tableNumber: jsonSerialization['tableNumber'] as int,
      currencyCode: jsonSerialization['currencyCode'] as String,
      status: _iij1ihnv.OrderStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      cancellationReason: jsonSerialization['cancellationReason'] == null
          ? null
          : _i9x1n0bn.OrderCancellationReason.fromJson(
              (jsonSerialization['cancellationReason'] as String),
            ),
      itemCount: jsonSerialization['itemCount'] as int,
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue buildingId;

  String venueName;

  int ref;

  int tableNumber;

  String currencyCode;

  _iij1ihnv.OrderStatus status;

  /// Set when the venue cancelled the whole order.
  _i9x1n0bn.OrderCancellationReason? cancellationReason;

  int itemCount;

  double totalAmount;

  DateTime createdAt;

  /// Returns a shallow copy of this [CustomerOrderSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CustomerOrderSummary copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    String? venueName,
    int? ref,
    int? tableNumber,
    String? currencyCode,
    _iij1ihnv.OrderStatus? status,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    int? itemCount,
    double? totalAmount,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerOrderSummary',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'venueName': venueName,
      'ref': ref,
      'tableNumber': tableNumber,
      'currencyCode': currencyCode,
      'status': status.toJson(),
      if (cancellationReason != null)
        'cancellationReason': cancellationReason?.toJson(),
      'itemCount': itemCount,
      'totalAmount': totalAmount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerOrderSummary',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'venueName': venueName,
      'ref': ref,
      'tableNumber': tableNumber,
      'currencyCode': currencyCode,
      'status': status.toJson(),
      if (cancellationReason != null)
        'cancellationReason': cancellationReason?.toJson(),
      'itemCount': itemCount,
      'totalAmount': totalAmount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerOrderSummaryImpl extends CustomerOrderSummary {
  _CustomerOrderSummaryImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required String venueName,
    required int ref,
    required int tableNumber,
    required String currencyCode,
    required _iij1ihnv.OrderStatus status,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    required int itemCount,
    required double totalAmount,
    required DateTime createdAt,
  }) : super._(
         id: id,
         buildingId: buildingId,
         venueName: venueName,
         ref: ref,
         tableNumber: tableNumber,
         currencyCode: currencyCode,
         status: status,
         cancellationReason: cancellationReason,
         itemCount: itemCount,
         totalAmount: totalAmount,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CustomerOrderSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CustomerOrderSummary copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    String? venueName,
    int? ref,
    int? tableNumber,
    String? currencyCode,
    _iij1ihnv.OrderStatus? status,
    Object? cancellationReason = _Undefined,
    int? itemCount,
    double? totalAmount,
    DateTime? createdAt,
  }) {
    return CustomerOrderSummary(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      venueName: venueName ?? this.venueName,
      ref: ref ?? this.ref,
      tableNumber: tableNumber ?? this.tableNumber,
      currencyCode: currencyCode ?? this.currencyCode,
      status: status ?? this.status,
      cancellationReason:
          cancellationReason is _i9x1n0bn.OrderCancellationReason?
          ? cancellationReason
          : this.cancellationReason,
      itemCount: itemCount ?? this.itemCount,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
