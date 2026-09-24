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

abstract class EmployeeView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EmployeeView._({
    required this.id,
    required this.buildingId,
    required this.ownerId,
    this.accessId,
    this.accessName,
    required this.username,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.isEnabled,
  });

  factory EmployeeView({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required _isc.UuidValue ownerId,
    _isc.UuidValue? accessId,
    String? accessName,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required bool isEnabled,
  }) = _EmployeeViewImpl;

  factory EmployeeView.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmployeeView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      accessId: jsonSerialization['accessId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['accessId']),
      accessName: jsonSerialization['accessName'] as String?,
      username: jsonSerialization['username'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      isEnabled: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isEnabled'],
      ),
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue buildingId;

  _isc.UuidValue ownerId;

  _isc.UuidValue? accessId;

  String? accessName;

  String username;

  String phoneNumber;

  String firstName;

  String lastName;

  bool isEnabled;

  /// Returns a shallow copy of this [EmployeeView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EmployeeView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    _isc.UuidValue? ownerId,
    _isc.UuidValue? accessId,
    String? accessName,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    bool? isEnabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmployeeView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'ownerId': ownerId.toJson(),
      if (accessId != null) 'accessId': accessId?.toJson(),
      if (accessName != null) 'accessName': accessName,
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'isEnabled': isEnabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmployeeView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'ownerId': ownerId.toJson(),
      if (accessId != null) 'accessId': accessId?.toJson(),
      if (accessName != null) 'accessName': accessName,
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'isEnabled': isEnabled,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmployeeViewImpl extends EmployeeView {
  _EmployeeViewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required _isc.UuidValue ownerId,
    _isc.UuidValue? accessId,
    String? accessName,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required bool isEnabled,
  }) : super._(
         id: id,
         buildingId: buildingId,
         ownerId: ownerId,
         accessId: accessId,
         accessName: accessName,
         username: username,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         isEnabled: isEnabled,
       );

  /// Returns a shallow copy of this [EmployeeView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EmployeeView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    _isc.UuidValue? ownerId,
    Object? accessId = _Undefined,
    Object? accessName = _Undefined,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    bool? isEnabled,
  }) {
    return EmployeeView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      ownerId: ownerId ?? this.ownerId,
      accessId: accessId is _isc.UuidValue? ? accessId : this.accessId,
      accessName: accessName is String? ? accessName : this.accessName,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
