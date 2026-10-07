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
import '../../reservations/reservation_phase.dart' as _imjzfucu;
import '../../tables/dtos/table_floor_status.dart' as _iv1evzd3;

abstract class VenueTableView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  VenueTableView._({
    required this.id,
    required this.buildingId,
    required this.number,
    required this.maxSeats,
    required this.isActive,
    required this.status,
    _imjzfucu.ReservationPhase? reservationPhase,
    this.reservationGuest,
    this.reservationStartsAt,
  }) : reservationPhase = reservationPhase ?? _imjzfucu.ReservationPhase.none;

  factory VenueTableView({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
    required int number,
    required int maxSeats,
    required bool isActive,
    required _iv1evzd3.TableFloorStatus status,
    _imjzfucu.ReservationPhase? reservationPhase,
    String? reservationGuest,
    DateTime? reservationStartsAt,
  }) = _VenueTableViewImpl;

  factory VenueTableView.fromJson(Map<String, dynamic> jsonSerialization) {
    return VenueTableView(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      number: jsonSerialization['number'] as int,
      maxSeats: jsonSerialization['maxSeats'] as int,
      isActive: _is.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      status: _iv1evzd3.TableFloorStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      reservationPhase: jsonSerialization['reservationPhase'] == null
          ? null
          : _imjzfucu.ReservationPhase.fromJson(
              (jsonSerialization['reservationPhase'] as String),
            ),
      reservationGuest: jsonSerialization['reservationGuest'] as String?,
      reservationStartsAt: jsonSerialization['reservationStartsAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['reservationStartsAt'],
            ),
    );
  }

  _is.UuidValue id;

  _is.UuidValue buildingId;

  int number;

  int maxSeats;

  bool isActive;

  /// Computed floor status (not a DB column).
  _iv1evzd3.TableFloorStatus status;

  /// Upcoming or in-progress booking on this table. Not stored.
  _imjzfucu.ReservationPhase reservationPhase;

  String? reservationGuest;

  DateTime? reservationStartsAt;

  /// Returns a shallow copy of this [VenueTableView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VenueTableView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    int? number,
    int? maxSeats,
    bool? isActive,
    _iv1evzd3.TableFloorStatus? status,
    _imjzfucu.ReservationPhase? reservationPhase,
    String? reservationGuest,
    DateTime? reservationStartsAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VenueTableView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'number': number,
      'maxSeats': maxSeats,
      'isActive': isActive,
      'status': status.toJson(),
      'reservationPhase': reservationPhase.toJson(),
      if (reservationGuest != null) 'reservationGuest': reservationGuest,
      if (reservationStartsAt != null)
        'reservationStartsAt': reservationStartsAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VenueTableView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'number': number,
      'maxSeats': maxSeats,
      'isActive': isActive,
      'status': status.toJson(),
      'reservationPhase': reservationPhase.toJson(),
      if (reservationGuest != null) 'reservationGuest': reservationGuest,
      if (reservationStartsAt != null)
        'reservationStartsAt': reservationStartsAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VenueTableViewImpl extends VenueTableView {
  _VenueTableViewImpl({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
    required int number,
    required int maxSeats,
    required bool isActive,
    required _iv1evzd3.TableFloorStatus status,
    _imjzfucu.ReservationPhase? reservationPhase,
    String? reservationGuest,
    DateTime? reservationStartsAt,
  }) : super._(
         id: id,
         buildingId: buildingId,
         number: number,
         maxSeats: maxSeats,
         isActive: isActive,
         status: status,
         reservationPhase: reservationPhase,
         reservationGuest: reservationGuest,
         reservationStartsAt: reservationStartsAt,
       );

  /// Returns a shallow copy of this [VenueTableView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VenueTableView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    int? number,
    int? maxSeats,
    bool? isActive,
    _iv1evzd3.TableFloorStatus? status,
    _imjzfucu.ReservationPhase? reservationPhase,
    Object? reservationGuest = _Undefined,
    Object? reservationStartsAt = _Undefined,
  }) {
    return VenueTableView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      number: number ?? this.number,
      maxSeats: maxSeats ?? this.maxSeats,
      isActive: isActive ?? this.isActive,
      status: status ?? this.status,
      reservationPhase: reservationPhase ?? this.reservationPhase,
      reservationGuest: reservationGuest is String?
          ? reservationGuest
          : this.reservationGuest,
      reservationStartsAt: reservationStartsAt is DateTime?
          ? reservationStartsAt
          : this.reservationStartsAt,
    );
  }
}
