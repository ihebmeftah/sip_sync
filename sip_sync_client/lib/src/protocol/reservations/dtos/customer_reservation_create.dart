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

/// Customer booking. The signed-in customer is the guest.
abstract class CustomerReservationCreate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CustomerReservationCreate._({
    required this.buildingId,
    required this.tableIds,
    required this.startsAt,
    required this.endsAt,
  });

  factory CustomerReservationCreate({
    required _isc.UuidValue buildingId,
    required List<_isc.UuidValue> tableIds,
    required DateTime startsAt,
    required DateTime endsAt,
  }) = _CustomerReservationCreateImpl;

  factory CustomerReservationCreate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CustomerReservationCreate(
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
    );
  }

  _isc.UuidValue buildingId;

  List<_isc.UuidValue> tableIds;

  DateTime startsAt;

  DateTime endsAt;

  /// Returns a shallow copy of this [CustomerReservationCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CustomerReservationCreate copyWith({
    _isc.UuidValue? buildingId,
    List<_isc.UuidValue>? tableIds,
    DateTime? startsAt,
    DateTime? endsAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerReservationCreate',
      'buildingId': buildingId.toJson(),
      'tableIds': tableIds.toJson(valueToJson: (v) => v.toJson()),
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerReservationCreate',
      'buildingId': buildingId.toJson(),
      'tableIds': tableIds.toJson(valueToJson: (v) => v.toJson()),
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _CustomerReservationCreateImpl extends CustomerReservationCreate {
  _CustomerReservationCreateImpl({
    required _isc.UuidValue buildingId,
    required List<_isc.UuidValue> tableIds,
    required DateTime startsAt,
    required DateTime endsAt,
  }) : super._(
         buildingId: buildingId,
         tableIds: tableIds,
         startsAt: startsAt,
         endsAt: endsAt,
       );

  /// Returns a shallow copy of this [CustomerReservationCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CustomerReservationCreate copyWith({
    _isc.UuidValue? buildingId,
    List<_isc.UuidValue>? tableIds,
    DateTime? startsAt,
    DateTime? endsAt,
  }) {
    return CustomerReservationCreate(
      buildingId: buildingId ?? this.buildingId,
      tableIds: tableIds ?? this.tableIds.map((e0) => e0).toList(),
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
    );
  }
}
