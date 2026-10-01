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

/// A geocoded place label and coordinates.
abstract class PlaceHit
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PlaceHit._({
    required this.label,
    required this.latitude,
    required this.longitude,
  });

  factory PlaceHit({
    required String label,
    required double latitude,
    required double longitude,
  }) = _PlaceHitImpl;

  factory PlaceHit.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlaceHit(
      label: jsonSerialization['label'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
    );
  }

  String label;

  double latitude;

  double longitude;

  /// Returns a shallow copy of this [PlaceHit]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PlaceHit copyWith({
    String? label,
    double? latitude,
    double? longitude,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlaceHit',
      'label': label,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlaceHit',
      'label': label,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _PlaceHitImpl extends PlaceHit {
  _PlaceHitImpl({
    required String label,
    required double latitude,
    required double longitude,
  }) : super._(
         label: label,
         latitude: latitude,
         longitude: longitude,
       );

  /// Returns a shallow copy of this [PlaceHit]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PlaceHit copyWith({
    String? label,
    double? latitude,
    double? longitude,
  }) {
    return PlaceHit(
      label: label ?? this.label,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
