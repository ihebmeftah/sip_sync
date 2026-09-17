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
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:sip_sync_client/src/protocol/auth/auth_token_result.dart'
    as _iqlrpljp;
import 'package:sip_sync_client/src/protocol/auth/customer_session_view.dart'
    as _i22eeawk;
import 'package:sip_sync_client/src/protocol/auth/email_login_request.dart'
    as _ia66v70m;
import 'package:sip_sync_client/src/protocol/auth/email_register_create.dart'
    as _i7tbe1ul;
import 'package:sip_sync_client/src/protocol/auth/employee_create.dart'
    as _i0ndf5ud;
import 'package:sip_sync_client/src/protocol/auth/employee_session_view.dart'
    as _i39hruwu;
import 'package:sip_sync_client/src/protocol/auth/employee_update.dart'
    as _itl0g0fc;
import 'package:sip_sync_client/src/protocol/auth/employee_view.dart'
    as _ix96cplr;
import 'package:sip_sync_client/src/protocol/auth/owner_session_view.dart'
    as _iu6l1hb5;
import 'package:sip_sync_client/src/protocol/auth/profile_update.dart'
    as _ijw3vapc;
import 'package:sip_sync_client/src/protocol/auth/super_admin_create.dart'
    as _idilg51n;
import 'package:sip_sync_client/src/protocol/auth/super_admin_session_view.dart'
    as _ighxe7ge;
import 'package:sip_sync_client/src/protocol/auth/super_admin_view.dart'
    as _iddpd7et;
import 'package:sip_sync_client/src/protocol/auth/username_login_request.dart'
    as _irmg40wx;
import 'package:sip_sync_client/src/protocol/buildings/building_create.dart'
    as _iekc365h;
import 'package:sip_sync_client/src/protocol/buildings/building_update.dart'
    as _i2rxmt9c;
import 'package:sip_sync_client/src/protocol/buildings/building_view.dart'
    as _ia8vsgay;
import 'package:sip_sync_client/src/protocol/greetings/greeting.dart'
    as _ijvf1i5e;
import 'protocol.dart' as _il2as5qe;

/// Customer self-register, login, and profile.
/// {@category Endpoint}
class EndpointCustomerAuth extends _isc.EndpointRef {
  EndpointCustomerAuth(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'customerAuth';

  _ida.Future<_iqlrpljp.AuthTokenResult> register(
    _i7tbe1ul.EmailRegisterCreate request,
  ) => caller.callServerEndpoint<_iqlrpljp.AuthTokenResult>(
    'customerAuth',
    'register',
    {'request': request},
  );

  _ida.Future<_iqlrpljp.AuthTokenResult> login(
    _ia66v70m.EmailLoginRequest request,
  ) => caller.callServerEndpoint<_iqlrpljp.AuthTokenResult>(
    'customerAuth',
    'login',
    {'request': request},
  );

  _ida.Future<_i22eeawk.CustomerSessionView> me() =>
      caller.callServerEndpoint<_i22eeawk.CustomerSessionView>(
        'customerAuth',
        'me',
        {},
      );

  _ida.Future<_i22eeawk.CustomerSessionView> updateMyProfile(
    _ijw3vapc.ProfileUpdate request,
  ) => caller.callServerEndpoint<_i22eeawk.CustomerSessionView>(
    'customerAuth',
    'updateMyProfile',
    {'request': request},
  );

  _ida.Future<void> logout() => caller.callServerEndpoint<void>(
    'customerAuth',
    'logout',
    {},
  );
}

/// Employee username login and profile (no self-register).
/// {@category Endpoint}
class EndpointEmployeeAuth extends _isc.EndpointRef {
  EndpointEmployeeAuth(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'employeeAuth';

  _ida.Future<_iqlrpljp.AuthTokenResult> login(
    _irmg40wx.UsernameLoginRequest request,
  ) => caller.callServerEndpoint<_iqlrpljp.AuthTokenResult>(
    'employeeAuth',
    'login',
    {'request': request},
  );

  _ida.Future<_i39hruwu.EmployeeSessionView> me() =>
      caller.callServerEndpoint<_i39hruwu.EmployeeSessionView>(
        'employeeAuth',
        'me',
        {},
      );

  _ida.Future<_i39hruwu.EmployeeSessionView> updateMyProfile(
    _ijw3vapc.ProfileUpdate request,
  ) => caller.callServerEndpoint<_i39hruwu.EmployeeSessionView>(
    'employeeAuth',
    'updateMyProfile',
    {'request': request},
  );

  _ida.Future<void> logout() => caller.callServerEndpoint<void>(
    'employeeAuth',
    'logout',
    {},
  );
}

/// Owner-only staff management for a building.
/// {@category Endpoint}
class EndpointEmployee extends _isc.EndpointRef {
  EndpointEmployee(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'employee';

  _ida.Future<_ix96cplr.EmployeeView> get(_isc.UuidValue employeeId) =>
      caller.callServerEndpoint<_ix96cplr.EmployeeView>(
        'employee',
        'get',
        {'employeeId': employeeId},
      );

  _ida.Future<_ix96cplr.EmployeeView> add(_i0ndf5ud.EmployeeCreate request) =>
      caller.callServerEndpoint<_ix96cplr.EmployeeView>(
        'employee',
        'add',
        {'request': request},
      );

  _ida.Future<_ix96cplr.EmployeeView> update(
    _itl0g0fc.EmployeeUpdate request,
  ) => caller.callServerEndpoint<_ix96cplr.EmployeeView>(
    'employee',
    'update',
    {'request': request},
  );

  _ida.Future<_ix96cplr.EmployeeView> setEnabled(
    _isc.UuidValue employeeId,
    bool isEnabled,
  ) => caller.callServerEndpoint<_ix96cplr.EmployeeView>(
    'employee',
    'setEnabled',
    {
      'employeeId': employeeId,
      'isEnabled': isEnabled,
    },
  );
}

/// Owner self-register, login, and profile.
/// {@category Endpoint}
class EndpointOwnerAuth extends _isc.EndpointRef {
  EndpointOwnerAuth(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ownerAuth';

  _ida.Future<_iqlrpljp.AuthTokenResult> register(
    _i7tbe1ul.EmailRegisterCreate request,
  ) => caller.callServerEndpoint<_iqlrpljp.AuthTokenResult>(
    'ownerAuth',
    'register',
    {'request': request},
  );

  _ida.Future<_iqlrpljp.AuthTokenResult> login(
    _ia66v70m.EmailLoginRequest request,
  ) => caller.callServerEndpoint<_iqlrpljp.AuthTokenResult>(
    'ownerAuth',
    'login',
    {'request': request},
  );

  _ida.Future<_iu6l1hb5.OwnerSessionView> me() =>
      caller.callServerEndpoint<_iu6l1hb5.OwnerSessionView>(
        'ownerAuth',
        'me',
        {},
      );

  _ida.Future<_iu6l1hb5.OwnerSessionView> updateMyProfile(
    _ijw3vapc.ProfileUpdate request,
  ) => caller.callServerEndpoint<_iu6l1hb5.OwnerSessionView>(
    'ownerAuth',
    'updateMyProfile',
    {'request': request},
  );

  _ida.Future<void> logout() => caller.callServerEndpoint<void>(
    'ownerAuth',
    'logout',
    {},
  );
}

/// Super admin login, profile, and staff management for backoffice.
/// {@category Endpoint}
class EndpointSuperAdminAuth extends _isc.EndpointRef {
  EndpointSuperAdminAuth(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'superAdminAuth';

  _ida.Future<_iqlrpljp.AuthTokenResult> login(
    _ia66v70m.EmailLoginRequest request,
  ) => caller.callServerEndpoint<_iqlrpljp.AuthTokenResult>(
    'superAdminAuth',
    'login',
    {'request': request},
  );

  _ida.Future<_ighxe7ge.SuperAdminSessionView> me() =>
      caller.callServerEndpoint<_ighxe7ge.SuperAdminSessionView>(
        'superAdminAuth',
        'me',
        {},
      );

  _ida.Future<void> logout() => caller.callServerEndpoint<void>(
    'superAdminAuth',
    'logout',
    {},
  );

  _ida.Future<_iddpd7et.SuperAdminView> add(
    _idilg51n.SuperAdminCreate request,
  ) => caller.callServerEndpoint<_iddpd7et.SuperAdminView>(
    'superAdminAuth',
    'add',
    {'request': request},
  );

  _ida.Future<List<_iddpd7et.SuperAdminView>> list() =>
      caller.callServerEndpoint<List<_iddpd7et.SuperAdminView>>(
        'superAdminAuth',
        'list',
        {},
      );

  _ida.Future<void> delete(_isc.UuidValue targetId) =>
      caller.callServerEndpoint<void>(
        'superAdminAuth',
        'delete',
        {'targetId': targetId},
      );

  /// Seeds the default platform admin if missing.
  _ida.Future<void> ensureDefaultAdmin() => caller.callServerEndpoint<void>(
    'superAdminAuth',
    'ensureDefaultAdmin',
    {},
  );
}

/// Venue CRUD for owners; assigned staff can read their building.
/// {@category Endpoint}
class EndpointBuilding extends _isc.EndpointRef {
  EndpointBuilding(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'building';

  _ida.Future<List<_ia8vsgay.BuildingView>> listMine() =>
      caller.callServerEndpoint<List<_ia8vsgay.BuildingView>>(
        'building',
        'listMine',
        {},
      );

  _ida.Future<_ia8vsgay.BuildingView> get(_isc.UuidValue buildingId) =>
      caller.callServerEndpoint<_ia8vsgay.BuildingView>(
        'building',
        'get',
        {'buildingId': buildingId},
      );

  _ida.Future<_ia8vsgay.BuildingView> create(
    _iekc365h.BuildingCreate request,
  ) => caller.callServerEndpoint<_ia8vsgay.BuildingView>(
    'building',
    'create',
    {'request': request},
  );

  _ida.Future<_ia8vsgay.BuildingView> update(
    _i2rxmt9c.BuildingUpdate request,
  ) => caller.callServerEndpoint<_ia8vsgay.BuildingView>(
    'building',
    'update',
    {'request': request},
  );

  _ida.Future<List<_ix96cplr.EmployeeView>> listEmployees(
    _isc.UuidValue buildingId,
  ) => caller.callServerEndpoint<List<_ix96cplr.EmployeeView>>(
    'building',
    'listEmployees',
    {'buildingId': buildingId},
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_ijvf1i5e.Greeting> hello(String name) =>
      caller.callServerEndpoint<_ijvf1i5e.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    customerAuth = EndpointCustomerAuth(this);
    employeeAuth = EndpointEmployeeAuth(this);
    employee = EndpointEmployee(this);
    ownerAuth = EndpointOwnerAuth(this);
    superAdminAuth = EndpointSuperAdminAuth(this);
    building = EndpointBuilding(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointCustomerAuth customerAuth;

  late final EndpointEmployeeAuth employeeAuth;

  late final EndpointEmployee employee;

  late final EndpointOwnerAuth ownerAuth;

  late final EndpointSuperAdminAuth superAdminAuth;

  late final EndpointBuilding building;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'customerAuth': customerAuth,
    'employeeAuth': employeeAuth,
    'employee': employee,
    'ownerAuth': ownerAuth,
    'superAdminAuth': superAdminAuth,
    'building': building,
    'greeting': greeting,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
