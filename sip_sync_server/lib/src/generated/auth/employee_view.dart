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

/// Owner-facing staff row. Username is server-generated and read-only.
abstract class EmployeeView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EmployeeView._({
    required this.authUserId,
    required this.username,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.roles,
    required this.isEnabled,
  });

  factory EmployeeView({
    required _is.UuidValue authUserId,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required List<String> roles,
    required bool isEnabled,
  }) = _EmployeeViewImpl;

  factory EmployeeView.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmployeeView(
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      username: jsonSerialization['username'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      roles: _iaib1p48.Protocol().deserialize<List<String>>(
        jsonSerialization['roles'],
      ),
      isEnabled: _is.BoolJsonExtension.fromJson(jsonSerialization['isEnabled']),
    );
  }

  _is.UuidValue authUserId;

  String username;

  String phoneNumber;

  String firstName;

  String lastName;

  List<String> roles;

  bool isEnabled;

  /// Returns a shallow copy of this [EmployeeView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EmployeeView copyWith({
    _is.UuidValue? authUserId,
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
    return _is.SerializationManager.encode(this);
  }
}

class _EmployeeViewImpl extends EmployeeView {
  _EmployeeViewImpl({
    required _is.UuidValue authUserId,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required List<String> roles,
    required bool isEnabled,
  }) : super._(
         authUserId: authUserId,
         username: username,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         roles: roles,
         isEnabled: isEnabled,
       );

  /// Returns a shallow copy of this [EmployeeView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EmployeeView copyWith({
    _is.UuidValue? authUserId,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    List<String>? roles,
    bool? isEnabled,
  }) {
    return EmployeeView(
      authUserId: authUserId ?? this.authUserId,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      roles: roles ?? this.roles.map((e0) => e0).toList(),
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
