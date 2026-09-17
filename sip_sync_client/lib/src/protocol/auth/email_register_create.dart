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

abstract class EmailRegisterCreate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EmailRegisterCreate._({
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  factory EmailRegisterCreate({
    required String email,
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) = _EmailRegisterCreateImpl;

  factory EmailRegisterCreate.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmailRegisterCreate(
      email: jsonSerialization['email'] as String,
      password: jsonSerialization['password'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
    );
  }

  String email;

  String password;

  String phoneNumber;

  String firstName;

  String lastName;

  /// Returns a shallow copy of this [EmailRegisterCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EmailRegisterCreate copyWith({
    String? email,
    String? password,
    String? phoneNumber,
    String? firstName,
    String? lastName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmailRegisterCreate',
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmailRegisterCreate',
      'email': email,
      'password': password,
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

class _EmailRegisterCreateImpl extends EmailRegisterCreate {
  _EmailRegisterCreateImpl({
    required String email,
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) : super._(
         email: email,
         password: password,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
       );

  /// Returns a shallow copy of this [EmailRegisterCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EmailRegisterCreate copyWith({
    String? email,
    String? password,
    String? phoneNumber,
    String? firstName,
    String? lastName,
  }) {
    return EmailRegisterCreate(
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
