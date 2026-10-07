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
import '../../auth/dtos/actor_type.dart' as _i6ch5qy5;
import '../../reservations/reservation_status.dart' as _isnodepe;

abstract class ReservationView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ReservationView._({
    required this.id,
    required this.buildingId,
    required this.startsAt,
    required this.endsAt,
    required this.status,
    required this.tableIds,
    required this.tableNumbers,
    this.customerId,
    required this.guestName,
    this.guestPhone,
    required this.paidAmount,
    required this.createdByType,
  });

  factory ReservationView({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required DateTime startsAt,
    required DateTime endsAt,
    required _isnodepe.ReservationStatus status,
    required List<_isc.UuidValue> tableIds,
    required List<int> tableNumbers,
    _isc.UuidValue? customerId,
    required String guestName,
    String? guestPhone,
    required double paidAmount,
    required _i6ch5qy5.ActorType createdByType,
  }) = _ReservationViewImpl;

  factory ReservationView.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReservationView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      startsAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      status: _isnodepe.ReservationStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      tableIds: _iozg9o5r.Protocol().deserialize<List<_isc.UuidValue>>(
        jsonSerialization['tableIds'],
      ),
      tableNumbers: _iozg9o5r.Protocol().deserialize<List<int>>(
        jsonSerialization['tableNumbers'],
      ),
      customerId: jsonSerialization['customerId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['customerId'],
            ),
      guestName: jsonSerialization['guestName'] as String,
      guestPhone: jsonSerialization['guestPhone'] as String?,
      paidAmount: (jsonSerialization['paidAmount'] as num).toDouble(),
      createdByType: _i6ch5qy5.ActorType.fromJson(
        (jsonSerialization['createdByType'] as String),
      ),
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue buildingId;

  DateTime startsAt;

  DateTime endsAt;

  _isnodepe.ReservationStatus status;

  List<_isc.UuidValue> tableIds;

  List<int> tableNumbers;

  _isc.UuidValue? customerId;

  String guestName;

  String? guestPhone;

  double paidAmount;

  _i6ch5qy5.ActorType createdByType;

  /// Returns a shallow copy of this [ReservationView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReservationView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    DateTime? startsAt,
    DateTime? endsAt,
    _isnodepe.ReservationStatus? status,
    List<_isc.UuidValue>? tableIds,
    List<int>? tableNumbers,
    _isc.UuidValue? customerId,
    String? guestName,
    String? guestPhone,
    double? paidAmount,
    _i6ch5qy5.ActorType? createdByType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReservationView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'status': status.toJson(),
      'tableIds': tableIds.toJson(valueToJson: (v) => v.toJson()),
      'tableNumbers': tableNumbers.toJson(),
      if (customerId != null) 'customerId': customerId?.toJson(),
      'guestName': guestName,
      if (guestPhone != null) 'guestPhone': guestPhone,
      'paidAmount': paidAmount,
      'createdByType': createdByType.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReservationView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'status': status.toJson(),
      'tableIds': tableIds.toJson(valueToJson: (v) => v.toJson()),
      'tableNumbers': tableNumbers.toJson(),
      if (customerId != null) 'customerId': customerId?.toJson(),
      'guestName': guestName,
      if (guestPhone != null) 'guestPhone': guestPhone,
      'paidAmount': paidAmount,
      'createdByType': createdByType.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReservationViewImpl extends ReservationView {
  _ReservationViewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required DateTime startsAt,
    required DateTime endsAt,
    required _isnodepe.ReservationStatus status,
    required List<_isc.UuidValue> tableIds,
    required List<int> tableNumbers,
    _isc.UuidValue? customerId,
    required String guestName,
    String? guestPhone,
    required double paidAmount,
    required _i6ch5qy5.ActorType createdByType,
  }) : super._(
         id: id,
         buildingId: buildingId,
         startsAt: startsAt,
         endsAt: endsAt,
         status: status,
         tableIds: tableIds,
         tableNumbers: tableNumbers,
         customerId: customerId,
         guestName: guestName,
         guestPhone: guestPhone,
         paidAmount: paidAmount,
         createdByType: createdByType,
       );

  /// Returns a shallow copy of this [ReservationView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReservationView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    DateTime? startsAt,
    DateTime? endsAt,
    _isnodepe.ReservationStatus? status,
    List<_isc.UuidValue>? tableIds,
    List<int>? tableNumbers,
    Object? customerId = _Undefined,
    String? guestName,
    Object? guestPhone = _Undefined,
    double? paidAmount,
    _i6ch5qy5.ActorType? createdByType,
  }) {
    return ReservationView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      status: status ?? this.status,
      tableIds: tableIds ?? this.tableIds.map((e0) => e0).toList(),
      tableNumbers: tableNumbers ?? this.tableNumbers.map((e0) => e0).toList(),
      customerId: customerId is _isc.UuidValue? ? customerId : this.customerId,
      guestName: guestName ?? this.guestName,
      guestPhone: guestPhone is String? ? guestPhone : this.guestPhone,
      paidAmount: paidAmount ?? this.paidAmount,
      createdByType: createdByType ?? this.createdByType,
    );
  }
}
