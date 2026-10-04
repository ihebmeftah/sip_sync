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

/// Platform-wide venue row for the backoffice. Includes the owner, not staff.
abstract class AdminBuildingView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AdminBuildingView._({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.currencyCode,
    required this.phoneNumber,
    required this.countryCode,
    required this.countryName,
    this.whatsapp,
    this.instagram,
    this.facebook,
    required this.ownerId,
    required this.ownerFirstName,
    required this.ownerLastName,
    required this.ownerEmail,
    required this.ownerPhoneNumber,
    required this.packId,
    required this.packName,
  });

  factory AdminBuildingView({
    required _isc.UuidValue id,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required String currencyCode,
    required String phoneNumber,
    required String countryCode,
    required String countryName,
    String? whatsapp,
    String? instagram,
    String? facebook,
    required _isc.UuidValue ownerId,
    required String ownerFirstName,
    required String ownerLastName,
    required String ownerEmail,
    required String ownerPhoneNumber,
    required _isc.UuidValue packId,
    required String packName,
  }) = _AdminBuildingViewImpl;

  factory AdminBuildingView.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminBuildingView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      address: jsonSerialization['address'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      currencyCode: jsonSerialization['currencyCode'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      countryCode: jsonSerialization['countryCode'] as String,
      countryName: jsonSerialization['countryName'] as String,
      whatsapp: jsonSerialization['whatsapp'] as String?,
      instagram: jsonSerialization['instagram'] as String?,
      facebook: jsonSerialization['facebook'] as String?,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      ownerFirstName: jsonSerialization['ownerFirstName'] as String,
      ownerLastName: jsonSerialization['ownerLastName'] as String,
      ownerEmail: jsonSerialization['ownerEmail'] as String,
      ownerPhoneNumber: jsonSerialization['ownerPhoneNumber'] as String,
      packId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['packId']),
      packName: jsonSerialization['packName'] as String,
    );
  }

  _isc.UuidValue id;

  String name;

  String type;

  String address;

  double latitude;

  double longitude;

  String currencyCode;

  String phoneNumber;

  String countryCode;

  String countryName;

  String? whatsapp;

  String? instagram;

  String? facebook;

  _isc.UuidValue ownerId;

  String ownerFirstName;

  String ownerLastName;

  String ownerEmail;

  String ownerPhoneNumber;

  _isc.UuidValue packId;

  String packName;

  /// Returns a shallow copy of this [AdminBuildingView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminBuildingView copyWith({
    _isc.UuidValue? id,
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    String? currencyCode,
    String? phoneNumber,
    String? countryCode,
    String? countryName,
    String? whatsapp,
    String? instagram,
    String? facebook,
    _isc.UuidValue? ownerId,
    String? ownerFirstName,
    String? ownerLastName,
    String? ownerEmail,
    String? ownerPhoneNumber,
    _isc.UuidValue? packId,
    String? packName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminBuildingView',
      'id': id.toJson(),
      'name': name,
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'currencyCode': currencyCode,
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
      'countryName': countryName,
      if (whatsapp != null) 'whatsapp': whatsapp,
      if (instagram != null) 'instagram': instagram,
      if (facebook != null) 'facebook': facebook,
      'ownerId': ownerId.toJson(),
      'ownerFirstName': ownerFirstName,
      'ownerLastName': ownerLastName,
      'ownerEmail': ownerEmail,
      'ownerPhoneNumber': ownerPhoneNumber,
      'packId': packId.toJson(),
      'packName': packName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminBuildingView',
      'id': id.toJson(),
      'name': name,
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'currencyCode': currencyCode,
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
      'countryName': countryName,
      if (whatsapp != null) 'whatsapp': whatsapp,
      if (instagram != null) 'instagram': instagram,
      if (facebook != null) 'facebook': facebook,
      'ownerId': ownerId.toJson(),
      'ownerFirstName': ownerFirstName,
      'ownerLastName': ownerLastName,
      'ownerEmail': ownerEmail,
      'ownerPhoneNumber': ownerPhoneNumber,
      'packId': packId.toJson(),
      'packName': packName,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminBuildingViewImpl extends AdminBuildingView {
  _AdminBuildingViewImpl({
    required _isc.UuidValue id,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required String currencyCode,
    required String phoneNumber,
    required String countryCode,
    required String countryName,
    String? whatsapp,
    String? instagram,
    String? facebook,
    required _isc.UuidValue ownerId,
    required String ownerFirstName,
    required String ownerLastName,
    required String ownerEmail,
    required String ownerPhoneNumber,
    required _isc.UuidValue packId,
    required String packName,
  }) : super._(
         id: id,
         name: name,
         type: type,
         address: address,
         latitude: latitude,
         longitude: longitude,
         currencyCode: currencyCode,
         phoneNumber: phoneNumber,
         countryCode: countryCode,
         countryName: countryName,
         whatsapp: whatsapp,
         instagram: instagram,
         facebook: facebook,
         ownerId: ownerId,
         ownerFirstName: ownerFirstName,
         ownerLastName: ownerLastName,
         ownerEmail: ownerEmail,
         ownerPhoneNumber: ownerPhoneNumber,
         packId: packId,
         packName: packName,
       );

  /// Returns a shallow copy of this [AdminBuildingView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminBuildingView copyWith({
    _isc.UuidValue? id,
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    String? currencyCode,
    String? phoneNumber,
    String? countryCode,
    String? countryName,
    Object? whatsapp = _Undefined,
    Object? instagram = _Undefined,
    Object? facebook = _Undefined,
    _isc.UuidValue? ownerId,
    String? ownerFirstName,
    String? ownerLastName,
    String? ownerEmail,
    String? ownerPhoneNumber,
    _isc.UuidValue? packId,
    String? packName,
  }) {
    return AdminBuildingView(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      currencyCode: currencyCode ?? this.currencyCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      whatsapp: whatsapp is String? ? whatsapp : this.whatsapp,
      instagram: instagram is String? ? instagram : this.instagram,
      facebook: facebook is String? ? facebook : this.facebook,
      ownerId: ownerId ?? this.ownerId,
      ownerFirstName: ownerFirstName ?? this.ownerFirstName,
      ownerLastName: ownerLastName ?? this.ownerLastName,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      ownerPhoneNumber: ownerPhoneNumber ?? this.ownerPhoneNumber,
      packId: packId ?? this.packId,
      packName: packName ?? this.packName,
    );
  }
}
