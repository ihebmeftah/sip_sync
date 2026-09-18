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

abstract class VenueTableUpdate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  VenueTableUpdate._({
    required this.id,
    required this.maxSeats,
    required this.isActive,
  });

  factory VenueTableUpdate({
    required _is.UuidValue id,
    required int maxSeats,
    required bool isActive,
  }) = _VenueTableUpdateImpl;

  factory VenueTableUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return VenueTableUpdate(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      maxSeats: jsonSerialization['maxSeats'] as int,
      isActive: _is.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
    );
  }

  _is.UuidValue id;

  int maxSeats;

  bool isActive;

  /// Returns a shallow copy of this [VenueTableUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VenueTableUpdate copyWith({
    _is.UuidValue? id,
    int? maxSeats,
    bool? isActive,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VenueTableUpdate',
      'id': id.toJson(),
      'maxSeats': maxSeats,
      'isActive': isActive,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VenueTableUpdate',
      'id': id.toJson(),
      'maxSeats': maxSeats,
      'isActive': isActive,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _VenueTableUpdateImpl extends VenueTableUpdate {
  _VenueTableUpdateImpl({
    required _is.UuidValue id,
    required int maxSeats,
    required bool isActive,
  }) : super._(
         id: id,
         maxSeats: maxSeats,
         isActive: isActive,
       );

  /// Returns a shallow copy of this [VenueTableUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VenueTableUpdate copyWith({
    _is.UuidValue? id,
    int? maxSeats,
    bool? isActive,
  }) {
    return VenueTableUpdate(
      id: id ?? this.id,
      maxSeats: maxSeats ?? this.maxSeats,
      isActive: isActive ?? this.isActive,
    );
  }
}
