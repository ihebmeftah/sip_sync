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

/// Staff booking. Either [customerId] or [guestName] identifies the guest.
abstract class ReservationCreate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ReservationCreate._({
    required this.buildingId,
    required this.tableIds,
    required this.startsAt,
    required this.endsAt,
    this.customerId,
    this.guestName,
    this.guestPhone,
    required this.paidAmount,
  });

  factory ReservationCreate({
    required _isc.UuidValue buildingId,
    required List<_isc.UuidValue> tableIds,
    required DateTime startsAt,
    required DateTime endsAt,
    _isc.UuidValue? customerId,
    String? guestName,
    String? guestPhone,
    required double paidAmount,
  }) = _ReservationCreateImpl;

  factory ReservationCreate.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReservationCreate(
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      tableIds: _iozg9o5r.Protocol().deserialize<List<_isc.UuidValue>>(
        jsonSerialization['tableIds'],
      ),
      startsAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      customerId: jsonSerialization['customerId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['customerId'],
            ),
      guestName: jsonSerialization['guestName'] as String?,
      guestPhone: jsonSerialization['guestPhone'] as String?,
      paidAmount: (jsonSerialization['paidAmount'] as num).toDouble(),
    );
  }

  _isc.UuidValue buildingId;

  List<_isc.UuidValue> tableIds;

  DateTime startsAt;

  DateTime endsAt;

  _isc.UuidValue? customerId;

  String? guestName;

  String? guestPhone;

  double paidAmount;

  /// Returns a shallow copy of this [ReservationCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReservationCreate copyWith({
    _isc.UuidValue? buildingId,
    List<_isc.UuidValue>? tableIds,
    DateTime? startsAt,
    DateTime? endsAt,
    _isc.UuidValue? customerId,
    String? guestName,
    String? guestPhone,
    double? paidAmount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReservationCreate',
      'buildingId': buildingId.toJson(),
      'tableIds': tableIds.toJson(valueToJson: (v) => v.toJson()),
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      if (customerId != null) 'customerId': customerId?.toJson(),
      if (guestName != null) 'guestName': guestName,
      if (guestPhone != null) 'guestPhone': guestPhone,
      'paidAmount': paidAmount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReservationCreate',
      'buildingId': buildingId.toJson(),
      'tableIds': tableIds.toJson(valueToJson: (v) => v.toJson()),
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      if (customerId != null) 'customerId': customerId?.toJson(),
      if (guestName != null) 'guestName': guestName,
      if (guestPhone != null) 'guestPhone': guestPhone,
      'paidAmount': paidAmount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReservationCreateImpl extends ReservationCreate {
  _ReservationCreateImpl({
    required _isc.UuidValue buildingId,
    required List<_isc.UuidValue> tableIds,
    required DateTime startsAt,
    required DateTime endsAt,
    _isc.UuidValue? customerId,
    String? guestName,
    String? guestPhone,
    required double paidAmount,
  }) : super._(
         buildingId: buildingId,
         tableIds: tableIds,
         startsAt: startsAt,
         endsAt: endsAt,
         customerId: customerId,
         guestName: guestName,
         guestPhone: guestPhone,
         paidAmount: paidAmount,
       );

  /// Returns a shallow copy of this [ReservationCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReservationCreate copyWith({
    _isc.UuidValue? buildingId,
    List<_isc.UuidValue>? tableIds,
    DateTime? startsAt,
    DateTime? endsAt,
    Object? customerId = _Undefined,
    Object? guestName = _Undefined,
    Object? guestPhone = _Undefined,
    double? paidAmount,
  }) {
    return ReservationCreate(
      buildingId: buildingId ?? this.buildingId,
      tableIds: tableIds ?? this.tableIds.map((e0) => e0).toList(),
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      customerId: customerId is _isc.UuidValue? ? customerId : this.customerId,
      guestName: guestName is String? ? guestName : this.guestName,
      guestPhone: guestPhone is String? ? guestPhone : this.guestPhone,
      paidAmount: paidAmount ?? this.paidAmount,
    );
  }
}
