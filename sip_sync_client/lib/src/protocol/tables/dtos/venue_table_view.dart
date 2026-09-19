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
import '../../tables/dtos/table_floor_status.dart' as _iv1evzd3;

abstract class VenueTableView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  VenueTableView._({
    required this.id,
    required this.buildingId,
    required this.number,
    required this.maxSeats,
    required this.isActive,
    required this.status,
  });

  factory VenueTableView({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required int number,
    required int maxSeats,
    required bool isActive,
    required _iv1evzd3.TableFloorStatus status,
  }) = _VenueTableViewImpl;

  factory VenueTableView.fromJson(Map<String, dynamic> jsonSerialization) {
    return VenueTableView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      number: jsonSerialization['number'] as int,
      maxSeats: jsonSerialization['maxSeats'] as int,
      isActive: _isc.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      status: _iv1evzd3.TableFloorStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue buildingId;

  int number;

  int maxSeats;

  bool isActive;

  /// Computed floor status (not a DB column).
  _iv1evzd3.TableFloorStatus status;

  /// Returns a shallow copy of this [VenueTableView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  VenueTableView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    int? number,
    int? maxSeats,
    bool? isActive,
    _iv1evzd3.TableFloorStatus? status,
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
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _VenueTableViewImpl extends VenueTableView {
  _VenueTableViewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required int number,
    required int maxSeats,
    required bool isActive,
    required _iv1evzd3.TableFloorStatus status,
  }) : super._(
         id: id,
         buildingId: buildingId,
         number: number,
         maxSeats: maxSeats,
         isActive: isActive,
         status: status,
       );

  /// Returns a shallow copy of this [VenueTableView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  VenueTableView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    int? number,
    int? maxSeats,
    bool? isActive,
    _iv1evzd3.TableFloorStatus? status,
  }) {
    return VenueTableView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      number: number ?? this.number,
      maxSeats: maxSeats ?? this.maxSeats,
      isActive: isActive ?? this.isActive,
      status: status ?? this.status,
    );
  }
}
