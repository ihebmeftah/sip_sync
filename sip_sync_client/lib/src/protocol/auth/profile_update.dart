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

/// Writable identity fields for the signed-in user.
///
/// Email stays on the auth identity and is not changed here.
abstract class ProfileUpdate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ProfileUpdate._({
    required this.username,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  factory ProfileUpdate({
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) = _ProfileUpdateImpl;

  factory ProfileUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProfileUpdate(
      username: jsonSerialization['username'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
    );
  }

  String username;

  String phoneNumber;

  String firstName;

  String lastName;

  /// Returns a shallow copy of this [ProfileUpdate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProfileUpdate copyWith({
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProfileUpdate',
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProfileUpdate',
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ProfileUpdateImpl extends ProfileUpdate {
  _ProfileUpdateImpl({
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) : super._(
         username: username,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
       );

  /// Returns a shallow copy of this [ProfileUpdate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ProfileUpdate copyWith({
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
  }) {
    return ProfileUpdate(
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
