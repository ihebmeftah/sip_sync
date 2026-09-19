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
import 'package:sip_sync_client/src/protocol/protocol.dart' as _iozg9o5r;
import '../../auth/dtos/actor_type.dart' as _i6ch5qy5;
import '../../auth/dtos/customer_session_view.dart' as _i3k4drn5;
import '../../auth/dtos/employee_session_view.dart' as _i93vc624;
import '../../auth/dtos/owner_session_view.dart' as _ivo6wr7r;
import '../../auth/dtos/super_admin_session_view.dart' as _igso29pm;

/// Login/register response. [sessionJson] is the actor session view as JSON map fields.
abstract class AuthTokenResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required _i6ch5qy5.ActorType actorType,
    _ivo6wr7r.OwnerSessionView? owner,
    _i93vc624.EmployeeSessionView? employee,
    _i3k4drn5.CustomerSessionView? customer,
    _igso29pm.SuperAdminSessionView? superAdmin,
  }) = _AuthTokenResultImpl;

  factory AuthTokenResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthTokenResult(
      token: jsonSerialization['token'] as String,
      refreshToken: jsonSerialization['refreshToken'] as String,
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      actorType: _i6ch5qy5.ActorType.fromJson(
        (jsonSerialization['actorType'] as String),
      ),
      owner: jsonSerialization['owner'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_ivo6wr7r.OwnerSessionView>(
              jsonSerialization['owner'],
            ),
      employee: jsonSerialization['employee'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_i93vc624.EmployeeSessionView>(
              jsonSerialization['employee'],
            ),
      customer: jsonSerialization['customer'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_i3k4drn5.CustomerSessionView>(
              jsonSerialization['customer'],
            ),
      superAdmin: jsonSerialization['superAdmin'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_igso29pm.SuperAdminSessionView>(
              jsonSerialization['superAdmin'],
            ),
    );
  }

  String token;

  String refreshToken;

  DateTime expiresAt;

  _i6ch5qy5.ActorType actorType;

  _ivo6wr7r.OwnerSessionView? owner;

  _i93vc624.EmployeeSessionView? employee;

  _i3k4drn5.CustomerSessionView? customer;

  _igso29pm.SuperAdminSessionView? superAdmin;

  /// Returns a shallow copy of this [AuthTokenResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AuthTokenResult copyWith({
    String? token,
    String? refreshToken,
    DateTime? expiresAt,
    _i6ch5qy5.ActorType? actorType,
    _ivo6wr7r.OwnerSessionView? owner,
    _i93vc624.EmployeeSessionView? employee,
    _i3k4drn5.CustomerSessionView? customer,
    _igso29pm.SuperAdminSessionView? superAdmin,
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
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthTokenResultImpl extends AuthTokenResult {
  _AuthTokenResultImpl({
    required String token,
    required String refreshToken,
    required DateTime expiresAt,
    required _i6ch5qy5.ActorType actorType,
    _ivo6wr7r.OwnerSessionView? owner,
    _i93vc624.EmployeeSessionView? employee,
    _i3k4drn5.CustomerSessionView? customer,
    _igso29pm.SuperAdminSessionView? superAdmin,
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
  @_isc.useResult
  @override
  AuthTokenResult copyWith({
    String? token,
    String? refreshToken,
    DateTime? expiresAt,
    _i6ch5qy5.ActorType? actorType,
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
      owner: owner is _ivo6wr7r.OwnerSessionView?
          ? owner
          : this.owner?.copyWith(),
      employee: employee is _i93vc624.EmployeeSessionView?
          ? employee
          : this.employee?.copyWith(),
      customer: customer is _i3k4drn5.CustomerSessionView?
          ? customer
          : this.customer?.copyWith(),
      superAdmin: superAdmin is _igso29pm.SuperAdminSessionView?
          ? superAdmin
          : this.superAdmin?.copyWith(),
    );
  }
}
