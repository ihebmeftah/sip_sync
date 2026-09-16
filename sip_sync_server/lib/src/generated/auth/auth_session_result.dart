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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:sip_sync_server/src/generated/protocol.dart' as _iaib1p48;
import '../auth/account_session_view.dart' as _i1i3voe6;

abstract class AuthSessionResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AuthSessionResult._({
    required this.authSuccess,
    required this.session,
  });

  factory AuthSessionResult({
    required _iacs.AuthSuccess authSuccess,
    required _i1i3voe6.AccountSessionView session,
  }) = _AuthSessionResultImpl;

  factory AuthSessionResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthSessionResult(
      authSuccess: _iaib1p48.Protocol().deserialize<_iacs.AuthSuccess>(
        jsonSerialization['authSuccess'],
      ),
      session: _iaib1p48.Protocol().deserialize<_i1i3voe6.AccountSessionView>(
        jsonSerialization['session'],
      ),
    );
  }

  _iacs.AuthSuccess authSuccess;

  _i1i3voe6.AccountSessionView session;

  /// Returns a shallow copy of this [AuthSessionResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AuthSessionResult copyWith({
    _iacs.AuthSuccess? authSuccess,
    _i1i3voe6.AccountSessionView? session,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuthSessionResult',
      'authSuccess': authSuccess.toJson(),
      'session': session.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AuthSessionResult',
      'authSuccess': authSuccess.toJson(),
      'session': session.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AuthSessionResultImpl extends AuthSessionResult {
  _AuthSessionResultImpl({
    required _iacs.AuthSuccess authSuccess,
    required _i1i3voe6.AccountSessionView session,
  }) : super._(
         authSuccess: authSuccess,
         session: session,
       );

  /// Returns a shallow copy of this [AuthSessionResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AuthSessionResult copyWith({
    _iacs.AuthSuccess? authSuccess,
    _i1i3voe6.AccountSessionView? session,
  }) {
    return AuthSessionResult(
      authSuccess: authSuccess ?? this.authSuccess.copyWith(),
      session: session ?? this.session.copyWith(),
    );
  }
}
