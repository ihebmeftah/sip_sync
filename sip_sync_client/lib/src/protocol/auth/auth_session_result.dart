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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:sip_sync_client/src/protocol/protocol.dart' as _iozg9o5r;
import '../auth/account_session_view.dart' as _i1i3voe6;

abstract class AuthSessionResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AuthSessionResult._({
    required this.authSuccess,
    required this.session,
  });

  factory AuthSessionResult({
    required _iacc.AuthSuccess authSuccess,
    required _i1i3voe6.AccountSessionView session,
  }) = _AuthSessionResultImpl;

  factory AuthSessionResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthSessionResult(
      authSuccess: _iozg9o5r.Protocol().deserialize<_iacc.AuthSuccess>(
        jsonSerialization['authSuccess'],
      ),
      session: _iozg9o5r.Protocol().deserialize<_i1i3voe6.AccountSessionView>(
        jsonSerialization['session'],
      ),
    );
  }

  _iacc.AuthSuccess authSuccess;

  _i1i3voe6.AccountSessionView session;

  /// Returns a shallow copy of this [AuthSessionResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AuthSessionResult copyWith({
    _iacc.AuthSuccess? authSuccess,
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
    return _isc.SerializationManager.encode(this);
  }
}

class _AuthSessionResultImpl extends AuthSessionResult {
  _AuthSessionResultImpl({
    required _iacc.AuthSuccess authSuccess,
    required _i1i3voe6.AccountSessionView session,
  }) : super._(
         authSuccess: authSuccess,
         session: session,
       );

  /// Returns a shallow copy of this [AuthSessionResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AuthSessionResult copyWith({
    _iacc.AuthSuccess? authSuccess,
    _i1i3voe6.AccountSessionView? session,
  }) {
    return AuthSessionResult(
      authSuccess: authSuccess ?? this.authSuccess.copyWith(),
      session: session ?? this.session.copyWith(),
    );
  }
}
