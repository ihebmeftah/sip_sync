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
import '../../orders/dtos/customer_order_line.dart' as _iz4mz5d5;
import '../../orders/dtos/order_status.dart' as _iij1ihnv;

/// Receipt a customer may see for an order they placed.
abstract class CustomerOrderView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CustomerOrderView._({
    required this.id,
    required this.buildingId,
    required this.ref,
    required this.tableNumber,
    required this.currencyCode,
    required this.status,
    required this.lines,
    required this.totalAmount,
  });

  factory CustomerOrderView({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
    required int ref,
    required int tableNumber,
    required String currencyCode,
    required _iij1ihnv.OrderStatus status,
    required List<_iz4mz5d5.CustomerOrderLine> lines,
    required double totalAmount,
  }) = _CustomerOrderViewImpl;

  factory CustomerOrderView.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerOrderView(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      ref: jsonSerialization['ref'] as int,
      tableNumber: jsonSerialization['tableNumber'] as int,
      currencyCode: jsonSerialization['currencyCode'] as String,
      status: _iij1ihnv.OrderStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      lines: _iaib1p48.Protocol()
          .deserialize<List<_iz4mz5d5.CustomerOrderLine>>(
            jsonSerialization['lines'],
          ),
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
    );
  }

  _is.UuidValue id;

  _is.UuidValue buildingId;

  int ref;

  int tableNumber;

  String currencyCode;

  _iij1ihnv.OrderStatus status;

  List<_iz4mz5d5.CustomerOrderLine> lines;

  double totalAmount;

  /// Returns a shallow copy of this [CustomerOrderView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerOrderView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    int? ref,
    int? tableNumber,
    String? currencyCode,
    _iij1ihnv.OrderStatus? status,
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
      'lines': lines.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalAmount': totalAmount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CustomerOrderViewImpl extends CustomerOrderView {
  _CustomerOrderViewImpl({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
    required int ref,
    required int tableNumber,
    required String currencyCode,
    required _iij1ihnv.OrderStatus status,
    required List<_iz4mz5d5.CustomerOrderLine> lines,
    required double totalAmount,
  }) : super._(
         id: id,
         buildingId: buildingId,
         ref: ref,
         tableNumber: tableNumber,
         currencyCode: currencyCode,
         status: status,
         lines: lines,
         totalAmount: totalAmount,
       );

  /// Returns a shallow copy of this [CustomerOrderView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CustomerOrderView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    int? ref,
    int? tableNumber,
    String? currencyCode,
    _iij1ihnv.OrderStatus? status,
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
      lines: lines ?? this.lines.map((e0) => e0.copyWith()).toList(),
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
