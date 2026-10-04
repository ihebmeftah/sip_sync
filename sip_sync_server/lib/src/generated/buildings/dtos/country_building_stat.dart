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

/// How many venues sit in one country, with a map point at their center.
abstract class CountryBuildingStat
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CountryBuildingStat._({
    required this.countryCode,
    required this.countryName,
    required this.buildingCount,
    required this.latitude,
    required this.longitude,
  });

  factory CountryBuildingStat({
    required String countryCode,
    required String countryName,
    required int buildingCount,
    required double latitude,
    required double longitude,
  }) = _CountryBuildingStatImpl;

  factory CountryBuildingStat.fromJson(Map<String, dynamic> jsonSerialization) {
    return CountryBuildingStat(
      countryCode: jsonSerialization['countryCode'] as String,
      countryName: jsonSerialization['countryName'] as String,
      buildingCount: jsonSerialization['buildingCount'] as int,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
    );
  }

  String countryCode;

  String countryName;

  int buildingCount;

  double latitude;

  double longitude;

  /// Returns a shallow copy of this [CountryBuildingStat]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CountryBuildingStat copyWith({
    String? countryCode,
    String? countryName,
    int? buildingCount,
    double? latitude,
    double? longitude,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CountryBuildingStat',
      'countryCode': countryCode,
      'countryName': countryName,
      'buildingCount': buildingCount,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CountryBuildingStat',
      'countryCode': countryCode,
      'countryName': countryName,
      'buildingCount': buildingCount,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CountryBuildingStatImpl extends CountryBuildingStat {
  _CountryBuildingStatImpl({
    required String countryCode,
    required String countryName,
    required int buildingCount,
    required double latitude,
    required double longitude,
  }) : super._(
         countryCode: countryCode,
         countryName: countryName,
         buildingCount: buildingCount,
         latitude: latitude,
         longitude: longitude,
       );

  /// Returns a shallow copy of this [CountryBuildingStat]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CountryBuildingStat copyWith({
    String? countryCode,
    String? countryName,
    int? buildingCount,
    double? latitude,
    double? longitude,
  }) {
    return CountryBuildingStat(
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      buildingCount: buildingCount ?? this.buildingCount,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
