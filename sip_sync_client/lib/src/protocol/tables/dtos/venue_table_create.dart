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

abstract class VenueTableCreate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  VenueTableCreate._({
    required this.buildingId,
    required this.count,
    required this.maxSeats,
    required this.isActive,
  });

  factory VenueTableCreate({
    required _isc.UuidValue buildingId,
    required int count,
    required int maxSeats,
    required bool isActive,
  }) = _VenueTableCreateImpl;

  factory VenueTableCreate.fromJson(Map<String, dynamic> jsonSerialization) {
    return VenueTableCreate(
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      count: jsonSerialization['count'] as int,
      maxSeats: jsonSerialization['maxSeats'] as int,
      isActive: _isc.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
    );
  }

  _isc.UuidValue buildingId;

  /// How many tables to create; numbers are assigned sequentially by the server.
  int count;

  int maxSeats;

  bool isActive;

  /// Returns a shallow copy of this [VenueTableCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  VenueTableCreate copyWith({
    _isc.UuidValue? buildingId,
    int? count,
    int? maxSeats,
    bool? isActive,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VenueTableCreate',
      'buildingId': buildingId.toJson(),
      'count': count,
      'maxSeats': maxSeats,
      'isActive': isActive,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VenueTableCreate',
      'buildingId': buildingId.toJson(),
      'count': count,
      'maxSeats': maxSeats,
      'isActive': isActive,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _VenueTableCreateImpl extends VenueTableCreate {
  _VenueTableCreateImpl({
    required _isc.UuidValue buildingId,
    required int count,
    required int maxSeats,
    required bool isActive,
  }) : super._(
         buildingId: buildingId,
         count: count,
         maxSeats: maxSeats,
         isActive: isActive,
       );

  /// Returns a shallow copy of this [VenueTableCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  VenueTableCreate copyWith({
    _isc.UuidValue? buildingId,
    int? count,
    int? maxSeats,
    bool? isActive,
  }) {
    return VenueTableCreate(
      buildingId: buildingId ?? this.buildingId,
      count: count ?? this.count,
      maxSeats: maxSeats ?? this.maxSeats,
      isActive: isActive ?? this.isActive,
    );
  }
}
