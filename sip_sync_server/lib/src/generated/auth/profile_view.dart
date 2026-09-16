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

abstract class ProfileView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ProfileView._({
    required this.authUserId,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.roles,
  });

  factory ProfileView({
    required _is.UuidValue authUserId,
    required String username,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required List<String> roles,
  }) = _ProfileViewImpl;

  factory ProfileView.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProfileView(
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      username: jsonSerialization['username'] as String,
      email: jsonSerialization['email'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      roles: _iaib1p48.Protocol().deserialize<List<String>>(
        jsonSerialization['roles'],
      ),
    );
  }

  _is.UuidValue authUserId;

  String username;

  String email;

  String phoneNumber;

  String firstName;

  String lastName;

  List<String> roles;

  /// Returns a shallow copy of this [ProfileView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProfileView copyWith({
    _is.UuidValue? authUserId,
    String? username,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    List<String>? roles,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProfileView',
      'authUserId': authUserId.toJson(),
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'roles': roles.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProfileView',
      'authUserId': authUserId.toJson(),
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'roles': roles.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ProfileViewImpl extends ProfileView {
  _ProfileViewImpl({
    required _is.UuidValue authUserId,
    required String username,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required List<String> roles,
  }) : super._(
         authUserId: authUserId,
         username: username,
         email: email,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         roles: roles,
       );

  /// Returns a shallow copy of this [ProfileView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProfileView copyWith({
    _is.UuidValue? authUserId,
    String? username,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    List<String>? roles,
  }) {
    return ProfileView(
      authUserId: authUserId ?? this.authUserId,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      roles: roles ?? this.roles.map((e0) => e0).toList(),
    );
  }
}
