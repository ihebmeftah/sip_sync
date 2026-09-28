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

/// Platform-wide venue row for the backoffice. Includes the owner, not staff.
abstract class AdminBuildingView
    implements _is.SerializableModel, _is.ProtocolSerialization {
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
    this.whatsapp,
    this.instagram,
    this.facebook,
    required this.ownerId,
    required this.ownerFirstName,
    required this.ownerLastName,
    required this.ownerEmail,
    required this.ownerPhoneNumber,
  });

  factory AdminBuildingView({
    required _is.UuidValue id,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required String currencyCode,
    required String phoneNumber,
    required String countryCode,
    String? whatsapp,
    String? instagram,
    String? facebook,
    required _is.UuidValue ownerId,
    required String ownerFirstName,
    required String ownerLastName,
    required String ownerEmail,
    required String ownerPhoneNumber,
  }) = _AdminBuildingViewImpl;

  factory AdminBuildingView.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminBuildingView(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      address: jsonSerialization['address'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      currencyCode: jsonSerialization['currencyCode'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      countryCode: jsonSerialization['countryCode'] as String,
      whatsapp: jsonSerialization['whatsapp'] as String?,
      instagram: jsonSerialization['instagram'] as String?,
      facebook: jsonSerialization['facebook'] as String?,
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      ownerFirstName: jsonSerialization['ownerFirstName'] as String,
      ownerLastName: jsonSerialization['ownerLastName'] as String,
      ownerEmail: jsonSerialization['ownerEmail'] as String,
      ownerPhoneNumber: jsonSerialization['ownerPhoneNumber'] as String,
    );
  }

  _is.UuidValue id;

  String name;

  String type;

  String address;

  double latitude;

  double longitude;

  String currencyCode;

  String phoneNumber;

  String countryCode;

  String? whatsapp;

  String? instagram;

  String? facebook;

  _is.UuidValue ownerId;

  String ownerFirstName;

  String ownerLastName;

  String ownerEmail;

  String ownerPhoneNumber;

  /// Returns a shallow copy of this [AdminBuildingView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminBuildingView copyWith({
    _is.UuidValue? id,
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    String? currencyCode,
    String? phoneNumber,
    String? countryCode,
    String? whatsapp,
    String? instagram,
    String? facebook,
    _is.UuidValue? ownerId,
    String? ownerFirstName,
    String? ownerLastName,
    String? ownerEmail,
    String? ownerPhoneNumber,
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
      if (whatsapp != null) 'whatsapp': whatsapp,
      if (instagram != null) 'instagram': instagram,
      if (facebook != null) 'facebook': facebook,
      'ownerId': ownerId.toJson(),
      'ownerFirstName': ownerFirstName,
      'ownerLastName': ownerLastName,
      'ownerEmail': ownerEmail,
      'ownerPhoneNumber': ownerPhoneNumber,
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
      if (whatsapp != null) 'whatsapp': whatsapp,
      if (instagram != null) 'instagram': instagram,
      if (facebook != null) 'facebook': facebook,
      'ownerId': ownerId.toJson(),
      'ownerFirstName': ownerFirstName,
      'ownerLastName': ownerLastName,
      'ownerEmail': ownerEmail,
      'ownerPhoneNumber': ownerPhoneNumber,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminBuildingViewImpl extends AdminBuildingView {
  _AdminBuildingViewImpl({
    required _is.UuidValue id,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required String currencyCode,
    required String phoneNumber,
    required String countryCode,
    String? whatsapp,
    String? instagram,
    String? facebook,
    required _is.UuidValue ownerId,
    required String ownerFirstName,
    required String ownerLastName,
    required String ownerEmail,
    required String ownerPhoneNumber,
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
         whatsapp: whatsapp,
         instagram: instagram,
         facebook: facebook,
         ownerId: ownerId,
         ownerFirstName: ownerFirstName,
         ownerLastName: ownerLastName,
         ownerEmail: ownerEmail,
         ownerPhoneNumber: ownerPhoneNumber,
       );

  /// Returns a shallow copy of this [AdminBuildingView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminBuildingView copyWith({
    _is.UuidValue? id,
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    String? currencyCode,
    String? phoneNumber,
    String? countryCode,
    Object? whatsapp = _Undefined,
    Object? instagram = _Undefined,
    Object? facebook = _Undefined,
    _is.UuidValue? ownerId,
    String? ownerFirstName,
    String? ownerLastName,
    String? ownerEmail,
    String? ownerPhoneNumber,
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
      whatsapp: whatsapp is String? ? whatsapp : this.whatsapp,
      instagram: instagram is String? ? instagram : this.instagram,
      facebook: facebook is String? ? facebook : this.facebook,
      ownerId: ownerId ?? this.ownerId,
      ownerFirstName: ownerFirstName ?? this.ownerFirstName,
      ownerLastName: ownerLastName ?? this.ownerLastName,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      ownerPhoneNumber: ownerPhoneNumber ?? this.ownerPhoneNumber,
    );
  }
}
