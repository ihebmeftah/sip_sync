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

abstract class BuildingView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BuildingView._({
    required this.id,
    required this.ownerAuthUserId,
    required this.name,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.openingMinutes,
    required this.closingMinutes,
    required this.currencyCode,
    required this.employeeAuthUserIds,
  });

  factory BuildingView({
    required _isc.UuidValue id,
    required _isc.UuidValue ownerAuthUserId,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    required List<_isc.UuidValue> employeeAuthUserIds,
  }) = _BuildingViewImpl;

  factory BuildingView.fromJson(Map<String, dynamic> jsonSerialization) {
    return BuildingView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerAuthUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerAuthUserId'],
      ),
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      address: jsonSerialization['address'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      openingMinutes: jsonSerialization['openingMinutes'] as int,
      closingMinutes: jsonSerialization['closingMinutes'] as int,
      currencyCode: jsonSerialization['currencyCode'] as String,
      employeeAuthUserIds: _iozg9o5r.Protocol()
          .deserialize<List<_isc.UuidValue>>(
            jsonSerialization['employeeAuthUserIds'],
          ),
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue ownerAuthUserId;

  String name;

  String type;

  String address;

  double latitude;

  double longitude;

  int openingMinutes;

  int closingMinutes;

  String currencyCode;

  List<_isc.UuidValue> employeeAuthUserIds;

  /// Returns a shallow copy of this [BuildingView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BuildingView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerAuthUserId,
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    int? openingMinutes,
    int? closingMinutes,
    String? currencyCode,
    List<_isc.UuidValue>? employeeAuthUserIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BuildingView',
      'id': id.toJson(),
      'ownerAuthUserId': ownerAuthUserId.toJson(),
      'name': name,
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'openingMinutes': openingMinutes,
      'closingMinutes': closingMinutes,
      'currencyCode': currencyCode,
      'employeeAuthUserIds': employeeAuthUserIds.toJson(
        valueToJson: (v) => v.toJson(),
      ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BuildingView',
      'id': id.toJson(),
      'ownerAuthUserId': ownerAuthUserId.toJson(),
      'name': name,
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'openingMinutes': openingMinutes,
      'closingMinutes': closingMinutes,
      'currencyCode': currencyCode,
      'employeeAuthUserIds': employeeAuthUserIds.toJson(
        valueToJson: (v) => v.toJson(),
      ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _BuildingViewImpl extends BuildingView {
  _BuildingViewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue ownerAuthUserId,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    required List<_isc.UuidValue> employeeAuthUserIds,
  }) : super._(
         id: id,
         ownerAuthUserId: ownerAuthUserId,
         name: name,
         type: type,
         address: address,
         latitude: latitude,
         longitude: longitude,
         openingMinutes: openingMinutes,
         closingMinutes: closingMinutes,
         currencyCode: currencyCode,
         employeeAuthUserIds: employeeAuthUserIds,
       );

  /// Returns a shallow copy of this [BuildingView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BuildingView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerAuthUserId,
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    int? openingMinutes,
    int? closingMinutes,
    String? currencyCode,
    List<_isc.UuidValue>? employeeAuthUserIds,
  }) {
    return BuildingView(
      id: id ?? this.id,
      ownerAuthUserId: ownerAuthUserId ?? this.ownerAuthUserId,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      openingMinutes: openingMinutes ?? this.openingMinutes,
      closingMinutes: closingMinutes ?? this.closingMinutes,
      currencyCode: currencyCode ?? this.currencyCode,
      employeeAuthUserIds:
          employeeAuthUserIds ??
          this.employeeAuthUserIds.map((e0) => e0).toList(),
    );
  }
}
