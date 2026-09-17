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
import 'package:sip_sync_server/src/generated/protocol.dart' as _iaib1p48;
import '../auth/actor_type.dart' as _ina5jq9v;
import '../auth/customer_session_view.dart' as _ig1mfpru;
import '../auth/employee_session_view.dart' as _i3xf6uut;
import '../auth/owner_session_view.dart' as _iqtsrga3;
import '../auth/super_admin_session_view.dart' as _igopoe09;

/// Login/register response. [sessionJson] is the actor session view as JSON map fields.
abstract class AuthTokenResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AuthTokenResult._({
    required this.token,
    required this.refreshToken,
    required this.expiresAt,
    required this.actorType,
    this.owner,
    this.employee,
    this.customer,
    this.superAdmin,
  });

  factory AuthTokenResult({
    required String token,
    required String refreshToken,
    required DateTime expiresAt,
    required _ina5jq9v.ActorType actorType,
    _iqtsrga3.OwnerSessionView? owner,
    _i3xf6uut.EmployeeSessionView? employee,
    _ig1mfpru.CustomerSessionView? customer,
    _igopoe09.SuperAdminSessionView? superAdmin,
  }) = _AuthTokenResultImpl;

  factory AuthTokenResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthTokenResult(
      token: jsonSerialization['token'] as String,
      refreshToken: jsonSerialization['refreshToken'] as String,
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      actorType: _ina5jq9v.ActorType.fromJson(
        (jsonSerialization['actorType'] as String),
      ),
      owner: jsonSerialization['owner'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_iqtsrga3.OwnerSessionView>(
              jsonSerialization['owner'],
            ),
      employee: jsonSerialization['employee'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_i3xf6uut.EmployeeSessionView>(
              jsonSerialization['employee'],
            ),
      customer: jsonSerialization['customer'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_ig1mfpru.CustomerSessionView>(
              jsonSerialization['customer'],
            ),
      superAdmin: jsonSerialization['superAdmin'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_igopoe09.SuperAdminSessionView>(
              jsonSerialization['superAdmin'],
            ),
    );
  }

  String token;

  String refreshToken;

  DateTime expiresAt;

  _ina5jq9v.ActorType actorType;

  _iqtsrga3.OwnerSessionView? owner;

  _i3xf6uut.EmployeeSessionView? employee;

  _ig1mfpru.CustomerSessionView? customer;

  _igopoe09.SuperAdminSessionView? superAdmin;

  /// Returns a shallow copy of this [AuthTokenResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AuthTokenResult copyWith({
    String? token,
    String? refreshToken,
    DateTime? expiresAt,
    _ina5jq9v.ActorType? actorType,
    _iqtsrga3.OwnerSessionView? owner,
    _i3xf6uut.EmployeeSessionView? employee,
    _ig1mfpru.CustomerSessionView? customer,
    _igopoe09.SuperAdminSessionView? superAdmin,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuthTokenResult',
      'token': token,
      'refreshToken': refreshToken,
      'expiresAt': expiresAt.toJson(),
      'actorType': actorType.toJson(),
      if (owner != null) 'owner': owner?.toJson(),
      if (employee != null) 'employee': employee?.toJson(),
      if (customer != null) 'customer': customer?.toJson(),
      if (superAdmin != null) 'superAdmin': superAdmin?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AuthTokenResult',
      'token': token,
      'refreshToken': refreshToken,
      'expiresAt': expiresAt.toJson(),
      'actorType': actorType.toJson(),
      if (owner != null) 'owner': owner?.toJsonForProtocol(),
      if (employee != null) 'employee': employee?.toJsonForProtocol(),
      if (customer != null) 'customer': customer?.toJsonForProtocol(),
      if (superAdmin != null) 'superAdmin': superAdmin?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthTokenResultImpl extends AuthTokenResult {
  _AuthTokenResultImpl({
    required String token,
    required String refreshToken,
    required DateTime expiresAt,
    required _ina5jq9v.ActorType actorType,
    _iqtsrga3.OwnerSessionView? owner,
    _i3xf6uut.EmployeeSessionView? employee,
    _ig1mfpru.CustomerSessionView? customer,
    _igopoe09.SuperAdminSessionView? superAdmin,
  }) : super._(
         token: token,
         refreshToken: refreshToken,
         expiresAt: expiresAt,
         actorType: actorType,
         owner: owner,
         employee: employee,
         customer: customer,
         superAdmin: superAdmin,
       );

  /// Returns a shallow copy of this [AuthTokenResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AuthTokenResult copyWith({
    String? token,
    String? refreshToken,
    DateTime? expiresAt,
    _ina5jq9v.ActorType? actorType,
    Object? owner = _Undefined,
    Object? employee = _Undefined,
    Object? customer = _Undefined,
    Object? superAdmin = _Undefined,
  }) {
    return AuthTokenResult(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
      actorType: actorType ?? this.actorType,
      owner: owner is _iqtsrga3.OwnerSessionView?
          ? owner
          : this.owner?.copyWith(),
      employee: employee is _i3xf6uut.EmployeeSessionView?
          ? employee
          : this.employee?.copyWith(),
      customer: customer is _ig1mfpru.CustomerSessionView?
          ? customer
          : this.customer?.copyWith(),
      superAdmin: superAdmin is _igopoe09.SuperAdminSessionView?
          ? superAdmin
          : this.superAdmin?.copyWith(),
    );
  }
}
