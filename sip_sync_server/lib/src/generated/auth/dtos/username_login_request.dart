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

abstract class UsernameLoginRequest
    implements _is.SerializableModel, _is.ProtocolSerialization {
  UsernameLoginRequest._({
    required this.username,
    required this.password,
  });

  factory UsernameLoginRequest({
    required String username,
    required String password,
  }) = _UsernameLoginRequestImpl;

  factory UsernameLoginRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UsernameLoginRequest(
      username: jsonSerialization['username'] as String,
      password: jsonSerialization['password'] as String,
    );
  }

  String username;

  String password;

  /// Returns a shallow copy of this [UsernameLoginRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UsernameLoginRequest copyWith({
    String? username,
    String? password,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UsernameLoginRequest',
      'username': username,
      'password': password,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UsernameLoginRequest',
      'username': username,
      'password': password,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _UsernameLoginRequestImpl extends UsernameLoginRequest {
  _UsernameLoginRequestImpl({
    required String username,
    required String password,
  }) : super._(
         username: username,
         password: password,
       );

  /// Returns a shallow copy of this [UsernameLoginRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UsernameLoginRequest copyWith({
    String? username,
    String? password,
  }) {
    return UsernameLoginRequest(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
