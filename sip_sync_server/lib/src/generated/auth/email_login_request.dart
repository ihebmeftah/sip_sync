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

abstract class EmailLoginRequest
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EmailLoginRequest._({
    required this.email,
    required this.password,
  });

  factory EmailLoginRequest({
    required String email,
    required String password,
  }) = _EmailLoginRequestImpl;

  factory EmailLoginRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmailLoginRequest(
      email: jsonSerialization['email'] as String,
      password: jsonSerialization['password'] as String,
    );
  }

  String email;

  String password;

  /// Returns a shallow copy of this [EmailLoginRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EmailLoginRequest copyWith({
    String? email,
    String? password,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmailLoginRequest',
      'email': email,
      'password': password,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmailLoginRequest',
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _EmailLoginRequestImpl extends EmailLoginRequest {
  _EmailLoginRequestImpl({
    required String email,
    required String password,
  }) : super._(
         email: email,
         password: password,
       );

  /// Returns a shallow copy of this [EmailLoginRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EmailLoginRequest copyWith({
    String? email,
    String? password,
  }) {
    return EmailLoginRequest(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
