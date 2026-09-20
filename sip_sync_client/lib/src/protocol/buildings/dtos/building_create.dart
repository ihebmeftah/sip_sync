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
import '../../buildings/dtos/strict_mode_step.dart' as _ik04yv2w;

abstract class BuildingCreate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BuildingCreate._({
    required this.name,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.openingMinutes,
    required this.closingMinutes,
    required this.currencyCode,
    bool? tableMultiOrder,
    bool? allowAppendingItemsToOrder,
    bool? strictMode,
    required this.strictModeSteps,
  }) : tableMultiOrder = tableMultiOrder ?? false,
       allowAppendingItemsToOrder = allowAppendingItemsToOrder ?? true,
       strictMode = strictMode ?? false;

  factory BuildingCreate({
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    bool? tableMultiOrder,
    bool? allowAppendingItemsToOrder,
    bool? strictMode,
    required List<_ik04yv2w.StrictModeStep> strictModeSteps,
  }) = _BuildingCreateImpl;

  factory BuildingCreate.fromJson(Map<String, dynamic> jsonSerialization) {
    return BuildingCreate(
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      address: jsonSerialization['address'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      openingMinutes: jsonSerialization['openingMinutes'] as int,
      closingMinutes: jsonSerialization['closingMinutes'] as int,
      currencyCode: jsonSerialization['currencyCode'] as String,
      tableMultiOrder: jsonSerialization['tableMultiOrder'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['tableMultiOrder'],
            ),
      allowAppendingItemsToOrder:
          jsonSerialization['allowAppendingItemsToOrder'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['allowAppendingItemsToOrder'],
            ),
      strictMode: jsonSerialization['strictMode'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['strictMode']),
      strictModeSteps: _iozg9o5r.Protocol()
          .deserialize<List<_ik04yv2w.StrictModeStep>>(
            jsonSerialization['strictModeSteps'],
          ),
    );
  }

  String name;

  String type;

  String address;

  double latitude;

  double longitude;

  int openingMinutes;

  int closingMinutes;

  String currencyCode;

  bool tableMultiOrder;

  bool allowAppendingItemsToOrder;

  bool strictMode;

  List<_ik04yv2w.StrictModeStep> strictModeSteps;

  /// Returns a shallow copy of this [BuildingCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BuildingCreate copyWith({
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    int? openingMinutes,
    int? closingMinutes,
    String? currencyCode,
    bool? tableMultiOrder,
    bool? allowAppendingItemsToOrder,
    bool? strictMode,
    List<_ik04yv2w.StrictModeStep>? strictModeSteps,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BuildingCreate',
      'name': name,
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'openingMinutes': openingMinutes,
      'closingMinutes': closingMinutes,
      'currencyCode': currencyCode,
      'tableMultiOrder': tableMultiOrder,
      'allowAppendingItemsToOrder': allowAppendingItemsToOrder,
      'strictMode': strictMode,
      'strictModeSteps': strictModeSteps.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BuildingCreate',
      'name': name,
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'openingMinutes': openingMinutes,
      'closingMinutes': closingMinutes,
      'currencyCode': currencyCode,
      'tableMultiOrder': tableMultiOrder,
      'allowAppendingItemsToOrder': allowAppendingItemsToOrder,
      'strictMode': strictMode,
      'strictModeSteps': strictModeSteps.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _BuildingCreateImpl extends BuildingCreate {
  _BuildingCreateImpl({
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    bool? tableMultiOrder,
    bool? allowAppendingItemsToOrder,
    bool? strictMode,
    required List<_ik04yv2w.StrictModeStep> strictModeSteps,
  }) : super._(
         name: name,
         type: type,
         address: address,
         latitude: latitude,
         longitude: longitude,
         openingMinutes: openingMinutes,
         closingMinutes: closingMinutes,
         currencyCode: currencyCode,
         tableMultiOrder: tableMultiOrder,
         allowAppendingItemsToOrder: allowAppendingItemsToOrder,
         strictMode: strictMode,
         strictModeSteps: strictModeSteps,
       );

  /// Returns a shallow copy of this [BuildingCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BuildingCreate copyWith({
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    int? openingMinutes,
    int? closingMinutes,
    String? currencyCode,
    bool? tableMultiOrder,
    bool? allowAppendingItemsToOrder,
    bool? strictMode,
    List<_ik04yv2w.StrictModeStep>? strictModeSteps,
  }) {
    return BuildingCreate(
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      openingMinutes: openingMinutes ?? this.openingMinutes,
      closingMinutes: closingMinutes ?? this.closingMinutes,
      currencyCode: currencyCode ?? this.currencyCode,
      tableMultiOrder: tableMultiOrder ?? this.tableMultiOrder,
      allowAppendingItemsToOrder:
          allowAppendingItemsToOrder ?? this.allowAppendingItemsToOrder,
      strictMode: strictMode ?? this.strictMode,
      strictModeSteps:
          strictModeSteps ??
          this.strictModeSteps.map((e0) => e0.copyWith()).toList(),
    );
  }
}
