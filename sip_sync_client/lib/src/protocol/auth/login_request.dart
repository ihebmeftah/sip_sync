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
import '../auth/sip_app.dart' as _iit1nxnv;

abstract class LoginRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LoginRequest._({
    required this.identifier,
    required this.password,
    required this.app,
  });

  factory LoginRequest({
    required String identifier,
    required String password,
    required _iit1nxnv.SipApp app,
  }) = _LoginRequestImpl;

  factory LoginRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoginRequest(
      identifier: jsonSerialization['identifier'] as String,
      password: jsonSerialization['password'] as String,
      app: _iit1nxnv.SipApp.fromJson((jsonSerialization['app'] as int)),
    );
  }

  /// Email for customer/owner/backoffice, or employee username.
  String identifier;

  String password;

  _iit1nxnv.SipApp app;

  /// Returns a shallow copy of this [LoginRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LoginRequest copyWith({
    String? identifier,
    String? password,
    _iit1nxnv.SipApp? app,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LoginRequest',
      'identifier': identifier,
      'password': password,
      'app': app.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LoginRequest',
      'identifier': identifier,
      'password': password,
      'app': app.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _LoginRequestImpl extends LoginRequest {
  _LoginRequestImpl({
    required String identifier,
    required String password,
    required _iit1nxnv.SipApp app,
  }) : super._(
         identifier: identifier,
         password: password,
         app: app,
       );

  /// Returns a shallow copy of this [LoginRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LoginRequest copyWith({
    String? identifier,
    String? password,
    _iit1nxnv.SipApp? app,
  }) {
    return LoginRequest(
      identifier: identifier ?? this.identifier,
      password: password ?? this.password,
      app: app ?? this.app,
    );
  }
}
