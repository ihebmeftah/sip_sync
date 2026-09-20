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
import 'package:sip_sync_server/src/generated/protocol.dart' as _iaib1p48;
import '../../buildings/dtos/strict_mode_step.dart' as _ik04yv2w;

abstract class BuildingUpdate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  BuildingUpdate._({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.openingMinutes,
    required this.closingMinutes,
    required this.currencyCode,
    required this.tableMultiOrder,
    required this.allowAppendingItemsToOrder,
    required this.strictMode,
    required this.strictModeSteps,
  });

  factory BuildingUpdate({
    required _is.UuidValue id,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    required bool tableMultiOrder,
    required bool allowAppendingItemsToOrder,
    required bool strictMode,
    required List<_ik04yv2w.StrictModeStep> strictModeSteps,
  }) = _BuildingUpdateImpl;

  factory BuildingUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return BuildingUpdate(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      address: jsonSerialization['address'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      openingMinutes: jsonSerialization['openingMinutes'] as int,
      closingMinutes: jsonSerialization['closingMinutes'] as int,
      currencyCode: jsonSerialization['currencyCode'] as String,
      tableMultiOrder: _is.BoolJsonExtension.fromJson(
        jsonSerialization['tableMultiOrder'],
      ),
      allowAppendingItemsToOrder: _is.BoolJsonExtension.fromJson(
        jsonSerialization['allowAppendingItemsToOrder'],
      ),
      strictMode: _is.BoolJsonExtension.fromJson(
        jsonSerialization['strictMode'],
      ),
      strictModeSteps: _iaib1p48.Protocol()
          .deserialize<List<_ik04yv2w.StrictModeStep>>(
            jsonSerialization['strictModeSteps'],
          ),
    );
  }

  _is.UuidValue id;

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

  /// Returns a shallow copy of this [BuildingUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BuildingUpdate copyWith({
    _is.UuidValue? id,
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
      '__className__': 'BuildingUpdate',
      'id': id.toJson(),
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
      '__className__': 'BuildingUpdate',
      'id': id.toJson(),
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
    return _is.SerializationManager.encode(this);
  }
}

class _BuildingUpdateImpl extends BuildingUpdate {
  _BuildingUpdateImpl({
    required _is.UuidValue id,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    required bool tableMultiOrder,
    required bool allowAppendingItemsToOrder,
    required bool strictMode,
    required List<_ik04yv2w.StrictModeStep> strictModeSteps,
  }) : super._(
         id: id,
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

  /// Returns a shallow copy of this [BuildingUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BuildingUpdate copyWith({
    _is.UuidValue? id,
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
    return BuildingUpdate(
      id: id ?? this.id,
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
