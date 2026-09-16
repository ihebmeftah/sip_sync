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
import '../auth/sip_app.dart' as _iit1nxnv;

abstract class SelfRegisterCreate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SelfRegisterCreate._({
    required this.email,
    required this.password,
    required this.username,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.app,
  });

  factory SelfRegisterCreate({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required _iit1nxnv.SipApp app,
  }) = _SelfRegisterCreateImpl;

  factory SelfRegisterCreate.fromJson(Map<String, dynamic> jsonSerialization) {
    return SelfRegisterCreate(
      email: jsonSerialization['email'] as String,
      password: jsonSerialization['password'] as String,
      username: jsonSerialization['username'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      app: _iit1nxnv.SipApp.fromJson((jsonSerialization['app'] as int)),
    );
  }

  String email;

  String password;

  String username;

  String phoneNumber;

  String firstName;

  String lastName;

  _iit1nxnv.SipApp app;

  /// Returns a shallow copy of this [SelfRegisterCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SelfRegisterCreate copyWith({
    String? email,
    String? password,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    _iit1nxnv.SipApp? app,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SelfRegisterCreate',
      'email': email,
      'password': password,
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'app': app.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SelfRegisterCreate',
      'email': email,
      'password': password,
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'app': app.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _SelfRegisterCreateImpl extends SelfRegisterCreate {
  _SelfRegisterCreateImpl({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required _iit1nxnv.SipApp app,
  }) : super._(
         email: email,
         password: password,
         username: username,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         app: app,
       );

  /// Returns a shallow copy of this [SelfRegisterCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SelfRegisterCreate copyWith({
    String? email,
    String? password,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    _iit1nxnv.SipApp? app,
  }) {
    return SelfRegisterCreate(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      app: app ?? this.app,
    );
  }
}
