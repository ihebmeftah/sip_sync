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
import '../../packs/dtos/building_pack_view.dart' as _i1961zho;

abstract class BuildingView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BuildingView._({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.openingMinutes,
    required this.closingMinutes,
    required this.currencyCode,
    required this.phoneNumber,
    required this.countryCode,
    required this.countryName,
    this.whatsapp,
    this.instagram,
    this.facebook,
    required this.otherLinks,
    required this.tableMultiOrder,
    required this.allowAppendingItemsToOrder,
    required this.strictMode,
    required this.strictModeSteps,
    required this.employeeIds,
    required this.pack,
  });

  factory BuildingView({
    required _isc.UuidValue id,
    required _isc.UuidValue ownerId,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    required String phoneNumber,
    required String countryCode,
    required String countryName,
    String? whatsapp,
    String? instagram,
    String? facebook,
    required List<String> otherLinks,
    required bool tableMultiOrder,
    required bool allowAppendingItemsToOrder,
    required bool strictMode,
    required List<_ik04yv2w.StrictModeStep> strictModeSteps,
    required List<_isc.UuidValue> employeeIds,
    required _i1961zho.BuildingPackView pack,
  }) = _BuildingViewImpl;

  factory BuildingView.fromJson(Map<String, dynamic> jsonSerialization) {
    return BuildingView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      address: jsonSerialization['address'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      openingMinutes: jsonSerialization['openingMinutes'] as int,
      closingMinutes: jsonSerialization['closingMinutes'] as int,
      currencyCode: jsonSerialization['currencyCode'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      countryCode: jsonSerialization['countryCode'] as String,
      countryName: jsonSerialization['countryName'] as String,
      whatsapp: jsonSerialization['whatsapp'] as String?,
      instagram: jsonSerialization['instagram'] as String?,
      facebook: jsonSerialization['facebook'] as String?,
      otherLinks: _iozg9o5r.Protocol().deserialize<List<String>>(
        jsonSerialization['otherLinks'],
      ),
      tableMultiOrder: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['tableMultiOrder'],
      ),
      allowAppendingItemsToOrder: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['allowAppendingItemsToOrder'],
      ),
      strictMode: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['strictMode'],
      ),
      strictModeSteps: _iozg9o5r.Protocol()
          .deserialize<List<_ik04yv2w.StrictModeStep>>(
            jsonSerialization['strictModeSteps'],
          ),
      employeeIds: _iozg9o5r.Protocol().deserialize<List<_isc.UuidValue>>(
        jsonSerialization['employeeIds'],
      ),
      pack: _iozg9o5r.Protocol().deserialize<_i1961zho.BuildingPackView>(
        jsonSerialization['pack'],
      ),
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue ownerId;

  String name;

  String type;

  String address;

  double latitude;

  double longitude;

  int openingMinutes;

  int closingMinutes;

  String currencyCode;

  String phoneNumber;

  String countryCode;

  String countryName;

  String? whatsapp;

  String? instagram;

  String? facebook;

  List<String> otherLinks;

  bool tableMultiOrder;

  bool allowAppendingItemsToOrder;

  bool strictMode;

  List<_ik04yv2w.StrictModeStep> strictModeSteps;

  List<_isc.UuidValue> employeeIds;

  _i1961zho.BuildingPackView pack;

  /// Returns a shallow copy of this [BuildingView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BuildingView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    int? openingMinutes,
    int? closingMinutes,
    String? currencyCode,
    String? phoneNumber,
    String? countryCode,
    String? countryName,
    String? whatsapp,
    String? instagram,
    String? facebook,
    List<String>? otherLinks,
    bool? tableMultiOrder,
    bool? allowAppendingItemsToOrder,
    bool? strictMode,
    List<_ik04yv2w.StrictModeStep>? strictModeSteps,
    List<_isc.UuidValue>? employeeIds,
    _i1961zho.BuildingPackView? pack,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BuildingView',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'name': name,
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'openingMinutes': openingMinutes,
      'closingMinutes': closingMinutes,
      'currencyCode': currencyCode,
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
      'countryName': countryName,
      if (whatsapp != null) 'whatsapp': whatsapp,
      if (instagram != null) 'instagram': instagram,
      if (facebook != null) 'facebook': facebook,
      'otherLinks': otherLinks.toJson(),
      'tableMultiOrder': tableMultiOrder,
      'allowAppendingItemsToOrder': allowAppendingItemsToOrder,
      'strictMode': strictMode,
      'strictModeSteps': strictModeSteps.toJson(valueToJson: (v) => v.toJson()),
      'employeeIds': employeeIds.toJson(valueToJson: (v) => v.toJson()),
      'pack': pack.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BuildingView',
      'id': id.toJson(),
      'ownerId': ownerId.toJson(),
      'name': name,
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'openingMinutes': openingMinutes,
      'closingMinutes': closingMinutes,
      'currencyCode': currencyCode,
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
      'countryName': countryName,
      if (whatsapp != null) 'whatsapp': whatsapp,
      if (instagram != null) 'instagram': instagram,
      if (facebook != null) 'facebook': facebook,
      'otherLinks': otherLinks.toJson(),
      'tableMultiOrder': tableMultiOrder,
      'allowAppendingItemsToOrder': allowAppendingItemsToOrder,
      'strictMode': strictMode,
      'strictModeSteps': strictModeSteps.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'employeeIds': employeeIds.toJson(valueToJson: (v) => v.toJson()),
      'pack': pack.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BuildingViewImpl extends BuildingView {
  _BuildingViewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue ownerId,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    required String phoneNumber,
    required String countryCode,
    required String countryName,
    String? whatsapp,
    String? instagram,
    String? facebook,
    required List<String> otherLinks,
    required bool tableMultiOrder,
    required bool allowAppendingItemsToOrder,
    required bool strictMode,
    required List<_ik04yv2w.StrictModeStep> strictModeSteps,
    required List<_isc.UuidValue> employeeIds,
    required _i1961zho.BuildingPackView pack,
  }) : super._(
         id: id,
         ownerId: ownerId,
         name: name,
         type: type,
         address: address,
         latitude: latitude,
         longitude: longitude,
         openingMinutes: openingMinutes,
         closingMinutes: closingMinutes,
         currencyCode: currencyCode,
         phoneNumber: phoneNumber,
         countryCode: countryCode,
         countryName: countryName,
         whatsapp: whatsapp,
         instagram: instagram,
         facebook: facebook,
         otherLinks: otherLinks,
         tableMultiOrder: tableMultiOrder,
         allowAppendingItemsToOrder: allowAppendingItemsToOrder,
         strictMode: strictMode,
         strictModeSteps: strictModeSteps,
         employeeIds: employeeIds,
         pack: pack,
       );

  /// Returns a shallow copy of this [BuildingView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BuildingView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? ownerId,
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    int? openingMinutes,
    int? closingMinutes,
    String? currencyCode,
    String? phoneNumber,
    String? countryCode,
    String? countryName,
    Object? whatsapp = _Undefined,
    Object? instagram = _Undefined,
    Object? facebook = _Undefined,
    List<String>? otherLinks,
    bool? tableMultiOrder,
    bool? allowAppendingItemsToOrder,
    bool? strictMode,
    List<_ik04yv2w.StrictModeStep>? strictModeSteps,
    List<_isc.UuidValue>? employeeIds,
    _i1961zho.BuildingPackView? pack,
  }) {
    return BuildingView(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      openingMinutes: openingMinutes ?? this.openingMinutes,
      closingMinutes: closingMinutes ?? this.closingMinutes,
      currencyCode: currencyCode ?? this.currencyCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      whatsapp: whatsapp is String? ? whatsapp : this.whatsapp,
      instagram: instagram is String? ? instagram : this.instagram,
      facebook: facebook is String? ? facebook : this.facebook,
      otherLinks: otherLinks ?? this.otherLinks.map((e0) => e0).toList(),
      tableMultiOrder: tableMultiOrder ?? this.tableMultiOrder,
      allowAppendingItemsToOrder:
          allowAppendingItemsToOrder ?? this.allowAppendingItemsToOrder,
      strictMode: strictMode ?? this.strictMode,
      strictModeSteps:
          strictModeSteps ??
          this.strictModeSteps.map((e0) => e0.copyWith()).toList(),
      employeeIds: employeeIds ?? this.employeeIds.map((e0) => e0).toList(),
      pack: pack ?? this.pack.copyWith(),
    );
  }
}
