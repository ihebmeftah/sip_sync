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

abstract class ProfileView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ProfileView._({
    required this.authUserId,
    this.username,
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.roles,
  });

  factory ProfileView({
    required _isc.UuidValue authUserId,
    String? username,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required List<String> roles,
  }) = _ProfileViewImpl;

  factory ProfileView.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProfileView(
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      username: jsonSerialization['username'] as String?,
      email: jsonSerialization['email'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      roles: _iozg9o5r.Protocol().deserialize<List<String>>(
        jsonSerialization['roles'],
      ),
    );
  }

  _isc.UuidValue authUserId;

  String? username;

  String email;

  String phoneNumber;

  String firstName;

  String lastName;

  List<String> roles;

  /// Returns a shallow copy of this [ProfileView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProfileView copyWith({
    _isc.UuidValue? authUserId,
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
      if (username != null) 'username': username,
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
      if (username != null) 'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'roles': roles.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfileViewImpl extends ProfileView {
  _ProfileViewImpl({
    required _isc.UuidValue authUserId,
    String? username,
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
  @_isc.useResult
  @override
  ProfileView copyWith({
    _isc.UuidValue? authUserId,
    Object? username = _Undefined,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    List<String>? roles,
  }) {
    return ProfileView(
      authUserId: authUserId ?? this.authUserId,
      username: username is String? ? username : this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      roles: roles ?? this.roles.map((e0) => e0).toList(),
    );
  }
}
