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

/// Customer request. The signed-in customer is the guest. No table is chosen.
abstract class CustomerReservationCreate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CustomerReservationCreate._({
    required this.buildingId,
    required this.startsAt,
    this.endsAt,
  });

  factory CustomerReservationCreate({
    required _is.UuidValue buildingId,
    required DateTime startsAt,
    DateTime? endsAt,
  }) = _CustomerReservationCreateImpl;

  factory CustomerReservationCreate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CustomerReservationCreate(
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      startsAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: jsonSerialization['endsAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
    );
  }

  _is.UuidValue buildingId;

  DateTime startsAt;

  /// Omitted ends are two hours after [startsAt].
  DateTime? endsAt;

  /// Returns a shallow copy of this [CustomerReservationCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerReservationCreate copyWith({
    _is.UuidValue? buildingId,
    DateTime? startsAt,
    DateTime? endsAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerReservationCreate',
      'buildingId': buildingId.toJson(),
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerReservationCreate',
      'buildingId': buildingId.toJson(),
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerReservationCreateImpl extends CustomerReservationCreate {
  _CustomerReservationCreateImpl({
    required _is.UuidValue buildingId,
    required DateTime startsAt,
    DateTime? endsAt,
  }) : super._(
         buildingId: buildingId,
         startsAt: startsAt,
         endsAt: endsAt,
       );

  /// Returns a shallow copy of this [CustomerReservationCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CustomerReservationCreate copyWith({
    _is.UuidValue? buildingId,
    DateTime? startsAt,
    Object? endsAt = _Undefined,
  }) {
    return CustomerReservationCreate(
      buildingId: buildingId ?? this.buildingId,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt is DateTime? ? endsAt : this.endsAt,
    );
  }
}
