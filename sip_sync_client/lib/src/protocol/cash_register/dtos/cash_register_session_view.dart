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
import '../../cash_register/cash_register_status.dart' as _ib16ienm;
import '../../orders/dtos/order_actor_view.dart' as _i1wfgxvh;

/// One shift, with who opened and closed it and how many tickets it holds.
abstract class CashRegisterSessionView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CashRegisterSessionView._({
    required this.id,
    required this.buildingId,
    required this.status,
    required this.openedBy,
    required this.openedAt,
    this.startCash,
    this.closedBy,
    this.closedAt,
    this.endCash,
    required this.orderCount,
    required this.paidTotal,
  });

  factory CashRegisterSessionView({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required _ib16ienm.CashRegisterStatus status,
    required _i1wfgxvh.OrderActorView openedBy,
    required DateTime openedAt,
    double? startCash,
    _i1wfgxvh.OrderActorView? closedBy,
    DateTime? closedAt,
    double? endCash,
    required int orderCount,
    required double paidTotal,
  }) = _CashRegisterSessionViewImpl;

  factory CashRegisterSessionView.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CashRegisterSessionView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      status: _ib16ienm.CashRegisterStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      openedBy: _iozg9o5r.Protocol().deserialize<_i1wfgxvh.OrderActorView>(
        jsonSerialization['openedBy'],
      ),
      openedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['openedAt'],
      ),
      startCash: (jsonSerialization['startCash'] as num?)?.toDouble(),
      closedBy: jsonSerialization['closedBy'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_i1wfgxvh.OrderActorView>(
              jsonSerialization['closedBy'],
            ),
      closedAt: jsonSerialization['closedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['closedAt']),
      endCash: (jsonSerialization['endCash'] as num?)?.toDouble(),
      orderCount: jsonSerialization['orderCount'] as int,
      paidTotal: (jsonSerialization['paidTotal'] as num).toDouble(),
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue buildingId;

  _ib16ienm.CashRegisterStatus status;

  _i1wfgxvh.OrderActorView openedBy;

  DateTime openedAt;

  /// Counted drawer at open. Null when it was left blank.
  double? startCash;

  _i1wfgxvh.OrderActorView? closedBy;

  DateTime? closedAt;

  /// Counted drawer at close. Null when it was left blank.
  double? endCash;

  /// Tickets stamped with this session. Not stored on the row.
  int orderCount;

  /// Sum of payed lines on those tickets. Not stored on the row.
  double paidTotal;

  /// Returns a shallow copy of this [CashRegisterSessionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CashRegisterSessionView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    _ib16ienm.CashRegisterStatus? status,
    _i1wfgxvh.OrderActorView? openedBy,
    DateTime? openedAt,
    double? startCash,
    _i1wfgxvh.OrderActorView? closedBy,
    DateTime? closedAt,
    double? endCash,
    int? orderCount,
    double? paidTotal,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CashRegisterSessionView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'status': status.toJson(),
      'openedBy': openedBy.toJson(),
      'openedAt': openedAt.toJson(),
      if (startCash != null) 'startCash': startCash,
      if (closedBy != null) 'closedBy': closedBy?.toJson(),
      if (closedAt != null) 'closedAt': closedAt?.toJson(),
      if (endCash != null) 'endCash': endCash,
      'orderCount': orderCount,
      'paidTotal': paidTotal,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CashRegisterSessionView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'status': status.toJson(),
      'openedBy': openedBy.toJsonForProtocol(),
      'openedAt': openedAt.toJson(),
      if (startCash != null) 'startCash': startCash,
      if (closedBy != null) 'closedBy': closedBy?.toJsonForProtocol(),
      if (closedAt != null) 'closedAt': closedAt?.toJson(),
      if (endCash != null) 'endCash': endCash,
      'orderCount': orderCount,
      'paidTotal': paidTotal,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CashRegisterSessionViewImpl extends CashRegisterSessionView {
  _CashRegisterSessionViewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required _ib16ienm.CashRegisterStatus status,
    required _i1wfgxvh.OrderActorView openedBy,
    required DateTime openedAt,
    double? startCash,
    _i1wfgxvh.OrderActorView? closedBy,
    DateTime? closedAt,
    double? endCash,
    required int orderCount,
    required double paidTotal,
  }) : super._(
         id: id,
         buildingId: buildingId,
         status: status,
         openedBy: openedBy,
         openedAt: openedAt,
         startCash: startCash,
         closedBy: closedBy,
         closedAt: closedAt,
         endCash: endCash,
         orderCount: orderCount,
         paidTotal: paidTotal,
       );

  /// Returns a shallow copy of this [CashRegisterSessionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CashRegisterSessionView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    _ib16ienm.CashRegisterStatus? status,
    _i1wfgxvh.OrderActorView? openedBy,
    DateTime? openedAt,
    Object? startCash = _Undefined,
    Object? closedBy = _Undefined,
    Object? closedAt = _Undefined,
    Object? endCash = _Undefined,
    int? orderCount,
    double? paidTotal,
  }) {
    return CashRegisterSessionView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      status: status ?? this.status,
      openedBy: openedBy ?? this.openedBy.copyWith(),
      openedAt: openedAt ?? this.openedAt,
      startCash: startCash is double? ? startCash : this.startCash,
      closedBy: closedBy is _i1wfgxvh.OrderActorView?
          ? closedBy
          : this.closedBy?.copyWith(),
      closedAt: closedAt is DateTime? ? closedAt : this.closedAt,
      endCash: endCash is double? ? endCash : this.endCash,
      orderCount: orderCount ?? this.orderCount,
      paidTotal: paidTotal ?? this.paidTotal,
    );
  }
}
