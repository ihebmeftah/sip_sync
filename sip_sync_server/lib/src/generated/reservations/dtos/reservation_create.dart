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

/// Staff booking. Created already confirmed, with no table until one is assigned.
/// Either [customerId] or [guestName] identifies the guest.
abstract class ReservationCreate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ReservationCreate._({
    required this.buildingId,
    required this.startsAt,
    this.endsAt,
    this.customerId,
    this.guestName,
    this.guestPhone,
    required this.paidAmount,
  });

  factory ReservationCreate({
    required _is.UuidValue buildingId,
    required DateTime startsAt,
    DateTime? endsAt,
    _is.UuidValue? customerId,
    String? guestName,
    String? guestPhone,
    required double paidAmount,
  }) = _ReservationCreateImpl;

  factory ReservationCreate.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReservationCreate(
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      startsAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: jsonSerialization['endsAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      customerId: jsonSerialization['customerId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['customerId'],
            ),
      guestName: jsonSerialization['guestName'] as String?,
      guestPhone: jsonSerialization['guestPhone'] as String?,
      paidAmount: (jsonSerialization['paidAmount'] as num).toDouble(),
    );
  }

  _is.UuidValue buildingId;

  DateTime startsAt;

  /// Omitted ends are two hours after [startsAt].
  DateTime? endsAt;

  _is.UuidValue? customerId;

  String? guestName;

  String? guestPhone;

  double paidAmount;

  /// Returns a shallow copy of this [ReservationCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ReservationCreate copyWith({
    _is.UuidValue? buildingId,
    DateTime? startsAt,
    DateTime? endsAt,
    _is.UuidValue? customerId,
    String? guestName,
    String? guestPhone,
    double? paidAmount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReservationCreate',
      'buildingId': buildingId.toJson(),
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
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
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      if (customerId != null) 'customerId': customerId?.toJson(),
      if (guestName != null) 'guestName': guestName,
      if (guestPhone != null) 'guestPhone': guestPhone,
      'paidAmount': paidAmount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReservationCreateImpl extends ReservationCreate {
  _ReservationCreateImpl({
    required _is.UuidValue buildingId,
    required DateTime startsAt,
    DateTime? endsAt,
    _is.UuidValue? customerId,
    String? guestName,
    String? guestPhone,
    required double paidAmount,
  }) : super._(
         buildingId: buildingId,
         startsAt: startsAt,
         endsAt: endsAt,
         customerId: customerId,
         guestName: guestName,
         guestPhone: guestPhone,
         paidAmount: paidAmount,
       );

  /// Returns a shallow copy of this [ReservationCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ReservationCreate copyWith({
    _is.UuidValue? buildingId,
    DateTime? startsAt,
    Object? endsAt = _Undefined,
    Object? customerId = _Undefined,
    Object? guestName = _Undefined,
    Object? guestPhone = _Undefined,
    double? paidAmount,
  }) {
    return ReservationCreate(
      buildingId: buildingId ?? this.buildingId,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt is DateTime? ? endsAt : this.endsAt,
      customerId: customerId is _is.UuidValue? ? customerId : this.customerId,
      guestName: guestName is String? ? guestName : this.guestName,
      guestPhone: guestPhone is String? ? guestPhone : this.guestPhone,
      paidAmount: paidAmount ?? this.paidAmount,
    );
  }
}
