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
import '../../employee_access/dtos/employee_access_view.dart' as _ihjvf6nj;

abstract class EmployeeSessionView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EmployeeSessionView._({
    required this.id,
    required this.buildingId,
    required this.ownerId,
    this.accessId,
    this.access,
    required this.username,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.isEnabled,
  });

  factory EmployeeSessionView({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required _isc.UuidValue ownerId,
    _isc.UuidValue? accessId,
    _ihjvf6nj.EmployeeAccessView? access,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required bool isEnabled,
  }) = _EmployeeSessionViewImpl;

  factory EmployeeSessionView.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmployeeSessionView(
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
      access: jsonSerialization['access'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_ihjvf6nj.EmployeeAccessView>(
              jsonSerialization['access'],
            ),
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

  _ihjvf6nj.EmployeeAccessView? access;

  String username;

  String phoneNumber;

  String firstName;

  String lastName;

  bool isEnabled;

  /// Returns a shallow copy of this [EmployeeSessionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EmployeeSessionView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    _isc.UuidValue? ownerId,
    _isc.UuidValue? accessId,
    _ihjvf6nj.EmployeeAccessView? access,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    bool? isEnabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmployeeSessionView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'ownerId': ownerId.toJson(),
      if (accessId != null) 'accessId': accessId?.toJson(),
      if (access != null) 'access': access?.toJson(),
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
      '__className__': 'EmployeeSessionView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'ownerId': ownerId.toJson(),
      if (accessId != null) 'accessId': accessId?.toJson(),
      if (access != null) 'access': access?.toJsonForProtocol(),
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

class _EmployeeSessionViewImpl extends EmployeeSessionView {
  _EmployeeSessionViewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required _isc.UuidValue ownerId,
    _isc.UuidValue? accessId,
    _ihjvf6nj.EmployeeAccessView? access,
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
         access: access,
         username: username,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         isEnabled: isEnabled,
       );

  /// Returns a shallow copy of this [EmployeeSessionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EmployeeSessionView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    _isc.UuidValue? ownerId,
    Object? accessId = _Undefined,
    Object? access = _Undefined,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    bool? isEnabled,
  }) {
    return EmployeeSessionView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      ownerId: ownerId ?? this.ownerId,
      accessId: accessId is _isc.UuidValue? ? accessId : this.accessId,
      access: access is _ihjvf6nj.EmployeeAccessView?
          ? access
          : this.access?.copyWith(),
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
