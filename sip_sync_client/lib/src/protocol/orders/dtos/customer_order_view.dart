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
import '../../orders/dtos/customer_order_line.dart' as _iz4mz5d5;
import '../../orders/dtos/order_cancellation_reason.dart' as _i9x1n0bn;
import '../../orders/dtos/order_status.dart' as _iij1ihnv;

/// Receipt a customer may see for an order they placed.
abstract class CustomerOrderView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CustomerOrderView._({
    required this.id,
    required this.buildingId,
    required this.ref,
    required this.tableNumber,
    required this.currencyCode,
    required this.status,
    this.cancellationReason,
    required this.lines,
    required this.totalAmount,
  });

  factory CustomerOrderView({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required int ref,
    required int tableNumber,
    required String currencyCode,
    required _iij1ihnv.OrderStatus status,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    required List<_iz4mz5d5.CustomerOrderLine> lines,
    required double totalAmount,
  }) = _CustomerOrderViewImpl;

  factory CustomerOrderView.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerOrderView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
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
      lines: _iozg9o5r.Protocol()
          .deserialize<List<_iz4mz5d5.CustomerOrderLine>>(
            jsonSerialization['lines'],
          ),
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue buildingId;

  int ref;

  int tableNumber;

  String currencyCode;

  _iij1ihnv.OrderStatus status;

  /// Set when the venue cancelled the whole order.
  _i9x1n0bn.OrderCancellationReason? cancellationReason;

  List<_iz4mz5d5.CustomerOrderLine> lines;

  double totalAmount;

  /// Returns a shallow copy of this [CustomerOrderView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CustomerOrderView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    int? ref,
    int? tableNumber,
    String? currencyCode,
    _iij1ihnv.OrderStatus? status,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    List<_iz4mz5d5.CustomerOrderLine>? lines,
    double? totalAmount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerOrderView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'ref': ref,
      'tableNumber': tableNumber,
      'currencyCode': currencyCode,
      'status': status.toJson(),
      if (cancellationReason != null)
        'cancellationReason': cancellationReason?.toJson(),
      'lines': lines.toJson(valueToJson: (v) => v.toJson()),
      'totalAmount': totalAmount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerOrderView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'ref': ref,
      'tableNumber': tableNumber,
      'currencyCode': currencyCode,
      'status': status.toJson(),
      if (cancellationReason != null)
        'cancellationReason': cancellationReason?.toJson(),
      'lines': lines.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalAmount': totalAmount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerOrderViewImpl extends CustomerOrderView {
  _CustomerOrderViewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required int ref,
    required int tableNumber,
    required String currencyCode,
    required _iij1ihnv.OrderStatus status,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    required List<_iz4mz5d5.CustomerOrderLine> lines,
    required double totalAmount,
  }) : super._(
         id: id,
         buildingId: buildingId,
         ref: ref,
         tableNumber: tableNumber,
         currencyCode: currencyCode,
         status: status,
         cancellationReason: cancellationReason,
         lines: lines,
         totalAmount: totalAmount,
       );

  /// Returns a shallow copy of this [CustomerOrderView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CustomerOrderView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    int? ref,
    int? tableNumber,
    String? currencyCode,
    _iij1ihnv.OrderStatus? status,
    Object? cancellationReason = _Undefined,
    List<_iz4mz5d5.CustomerOrderLine>? lines,
    double? totalAmount,
  }) {
    return CustomerOrderView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      ref: ref ?? this.ref,
      tableNumber: tableNumber ?? this.tableNumber,
      currencyCode: currencyCode ?? this.currencyCode,
      status: status ?? this.status,
      cancellationReason:
          cancellationReason is _i9x1n0bn.OrderCancellationReason?
          ? cancellationReason
          : this.cancellationReason,
      lines: lines ?? this.lines.map((e0) => e0.copyWith()).toList(),
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
