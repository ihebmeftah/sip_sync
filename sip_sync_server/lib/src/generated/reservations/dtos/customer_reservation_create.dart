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

/// Customer booking. The signed-in customer is the guest.
abstract class CustomerReservationCreate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CustomerReservationCreate._({
    required this.buildingId,
    required this.tableIds,
    required this.startsAt,
    required this.endsAt,
  });

  factory CustomerReservationCreate({
    required _is.UuidValue buildingId,
    required List<_is.UuidValue> tableIds,
    required DateTime startsAt,
    required DateTime endsAt,
  }) = _CustomerReservationCreateImpl;

  factory CustomerReservationCreate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CustomerReservationCreate(
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      tableIds: _iaib1p48.Protocol().deserialize<List<_is.UuidValue>>(
        jsonSerialization['tableIds'],
      ),
      startsAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
    );
  }

  _is.UuidValue buildingId;

  List<_is.UuidValue> tableIds;

  DateTime startsAt;

  DateTime endsAt;

  /// Returns a shallow copy of this [CustomerReservationCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerReservationCreate copyWith({
    _is.UuidValue? buildingId,
    List<_is.UuidValue>? tableIds,
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
    return _is.SerializationManager.encode(this);
  }
}

class _CustomerReservationCreateImpl extends CustomerReservationCreate {
  _CustomerReservationCreateImpl({
    required _is.UuidValue buildingId,
    required List<_is.UuidValue> tableIds,
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
  @_is.useResult
  @override
  CustomerReservationCreate copyWith({
    _is.UuidValue? buildingId,
    List<_is.UuidValue>? tableIds,
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
