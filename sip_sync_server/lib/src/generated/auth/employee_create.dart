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

abstract class EmployeeCreate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EmployeeCreate._({
    required this.email,
    required this.password,
    required this.username,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  factory EmployeeCreate({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) = _EmployeeCreateImpl;

  factory EmployeeCreate.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmployeeCreate(
      email: jsonSerialization['email'] as String,
      password: jsonSerialization['password'] as String,
      username: jsonSerialization['username'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
    );
  }

  String email;

  String password;

  String username;

  String phoneNumber;

  String firstName;

  String lastName;

  /// Returns a shallow copy of this [EmployeeCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EmployeeCreate copyWith({
    String? email,
    String? password,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmployeeCreate',
      'email': email,
      'password': password,
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmployeeCreate',
      'email': email,
      'password': password,
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _EmployeeCreateImpl extends EmployeeCreate {
  _EmployeeCreateImpl({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) : super._(
         email: email,
         password: password,
         username: username,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
       );

  /// Returns a shallow copy of this [EmployeeCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EmployeeCreate copyWith({
    String? email,
    String? password,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
  }) {
    return EmployeeCreate(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
