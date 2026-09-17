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

/// Owner-facing staff row. Username is server-generated and read-only.
abstract class EmployeeView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EmployeeView._({
    required this.authUserId,
    required this.buildingId,
    required this.username,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.roles,
    required this.isEnabled,
  });

  factory EmployeeView({
    required _isc.UuidValue authUserId,
    required _isc.UuidValue buildingId,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required List<String> roles,
    required bool isEnabled,
  }) = _EmployeeViewImpl;

  factory EmployeeView.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmployeeView(
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      username: jsonSerialization['username'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      roles: _iozg9o5r.Protocol().deserialize<List<String>>(
        jsonSerialization['roles'],
      ),
      isEnabled: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isEnabled'],
      ),
    );
  }

  _isc.UuidValue authUserId;

  _isc.UuidValue buildingId;

  String username;

  String phoneNumber;

  String firstName;

  String lastName;

  List<String> roles;

  bool isEnabled;

  /// Returns a shallow copy of this [EmployeeView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EmployeeView copyWith({
    _isc.UuidValue? authUserId,
    _isc.UuidValue? buildingId,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    List<String>? roles,
    bool? isEnabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmployeeView',
      'authUserId': authUserId.toJson(),
      'buildingId': buildingId.toJson(),
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'roles': roles.toJson(),
      'isEnabled': isEnabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmployeeView',
      'authUserId': authUserId.toJson(),
      'buildingId': buildingId.toJson(),
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'roles': roles.toJson(),
      'isEnabled': isEnabled,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _EmployeeViewImpl extends EmployeeView {
  _EmployeeViewImpl({
    required _isc.UuidValue authUserId,
    required _isc.UuidValue buildingId,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required List<String> roles,
    required bool isEnabled,
  }) : super._(
         authUserId: authUserId,
         buildingId: buildingId,
         username: username,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         roles: roles,
         isEnabled: isEnabled,
       );

  /// Returns a shallow copy of this [EmployeeView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EmployeeView copyWith({
    _isc.UuidValue? authUserId,
    _isc.UuidValue? buildingId,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    List<String>? roles,
    bool? isEnabled,
  }) {
    return EmployeeView(
      authUserId: authUserId ?? this.authUserId,
      buildingId: buildingId ?? this.buildingId,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      roles: roles ?? this.roles.map((e0) => e0).toList(),
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
