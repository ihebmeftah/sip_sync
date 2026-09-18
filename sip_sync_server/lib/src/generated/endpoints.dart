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
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:sip_sync_server/src/generated/auth/email_login_request.dart'
    as _i61r4gix;
import 'package:sip_sync_server/src/generated/auth/email_register_create.dart'
    as _ihm3fhv0;
import 'package:sip_sync_server/src/generated/auth/employee_create.dart'
    as _itsh5tmy;
import 'package:sip_sync_server/src/generated/auth/employee_update.dart'
    as _isn5wmy3;
import 'package:sip_sync_server/src/generated/auth/profile_update.dart'
    as _id6sv1bw;
import 'package:sip_sync_server/src/generated/auth/super_admin_create.dart'
    as _id6ub811;
import 'package:sip_sync_server/src/generated/auth/username_login_request.dart'
    as _i4u41mzh;
import 'package:sip_sync_server/src/generated/buildings/building_create.dart'
    as _iikuia2o;
import 'package:sip_sync_server/src/generated/buildings/building_update.dart'
    as _ipidi05l;
import 'package:sip_sync_server/src/generated/menu/menu_article_create.dart'
    as _io67qn2p;
import 'package:sip_sync_server/src/generated/menu/menu_article_update.dart'
    as _igs394lv;
import 'package:sip_sync_server/src/generated/menu/menu_category_create.dart'
    as _ickdwlcc;
import 'package:sip_sync_server/src/generated/menu/menu_category_update.dart'
    as _i4izftei;
import 'package:sip_sync_server/src/generated/tables/venue_table_create.dart'
    as _ij730ie3;
import 'package:sip_sync_server/src/generated/tables/venue_table_update.dart'
    as _ixxdkctx;
import '../auth/customer_auth_endpoint.dart' as _i4yxnu3z;
import '../auth/employee_auth_endpoint.dart' as _i6neyhet;
import '../auth/employee_endpoint.dart' as _i3t5tbp4;
import '../auth/owner_auth_endpoint.dart' as _is2qyeee;
import '../auth/super_admin_auth_endpoint.dart' as _itmp66ay;
import '../buildings/building_endpoint.dart' as _i69ygv7j;
import '../greetings/greeting_endpoint.dart' as _il624ik7;
import '../menu/menu_article_endpoint.dart' as _iefktwfq;
import '../menu/menu_category_endpoint.dart' as _i1h28rjj;
import '../tables/venue_table_endpoint.dart' as _ira8yrq4;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'customerAuth': _i4yxnu3z.CustomerAuthEndpoint()
        ..initialize(
          server,
          'customerAuth',
          null,
        ),
      'employeeAuth': _i6neyhet.EmployeeAuthEndpoint()
        ..initialize(
          server,
          'employeeAuth',
          null,
        ),
      'employee': _i3t5tbp4.EmployeeEndpoint()
        ..initialize(
          server,
          'employee',
          null,
        ),
      'ownerAuth': _is2qyeee.OwnerAuthEndpoint()
        ..initialize(
          server,
          'ownerAuth',
          null,
        ),
      'superAdminAuth': _itmp66ay.SuperAdminAuthEndpoint()
        ..initialize(
          server,
          'superAdminAuth',
          null,
        ),
      'building': _i69ygv7j.BuildingEndpoint()
        ..initialize(
          server,
          'building',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'menuArticle': _iefktwfq.MenuArticleEndpoint()
        ..initialize(
          server,
          'menuArticle',
          null,
        ),
      'menuCategory': _i1h28rjj.MenuCategoryEndpoint()
        ..initialize(
          server,
          'menuCategory',
          null,
        ),
      'venueTable': _ira8yrq4.VenueTableEndpoint()
        ..initialize(
          server,
          'venueTable',
          null,
        ),
    };
    connectors['customerAuth'] = _is.EndpointConnector(
      name: 'customerAuth',
      endpoint: endpoints['customerAuth']!,
      methodConnectors: {
        'register': _is.MethodConnector(
          name: 'register',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ihm3fhv0.EmailRegisterCreate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customerAuth'] as _i4yxnu3z.CustomerAuthEndpoint)
                      .register(
                        session,
                        params['request'],
                      ),
        ),
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_i61r4gix.EmailLoginRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customerAuth'] as _i4yxnu3z.CustomerAuthEndpoint)
                      .login(
                        session,
                        params['request'],
                      ),
        ),
        'me': _is.MethodConnector(
          name: 'me',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customerAuth'] as _i4yxnu3z.CustomerAuthEndpoint)
                      .me(session),
        ),
        'updateMyProfile': _is.MethodConnector(
          name: 'updateMyProfile',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_id6sv1bw.ProfileUpdate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customerAuth'] as _i4yxnu3z.CustomerAuthEndpoint)
                      .updateMyProfile(
                        session,
                        params['request'],
                      ),
        ),
        'logout': _is.MethodConnector(
          name: 'logout',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customerAuth'] as _i4yxnu3z.CustomerAuthEndpoint)
                      .logout(session),
        ),
      },
    );
    connectors['employeeAuth'] = _is.EndpointConnector(
      name: 'employeeAuth',
      endpoint: endpoints['employeeAuth']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_i4u41mzh.UsernameLoginRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['employeeAuth'] as _i6neyhet.EmployeeAuthEndpoint)
                      .login(
                        session,
                        params['request'],
                      ),
        ),
        'me': _is.MethodConnector(
          name: 'me',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['employeeAuth'] as _i6neyhet.EmployeeAuthEndpoint)
                      .me(session),
        ),
        'updateMyProfile': _is.MethodConnector(
          name: 'updateMyProfile',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_id6sv1bw.ProfileUpdate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['employeeAuth'] as _i6neyhet.EmployeeAuthEndpoint)
                      .updateMyProfile(
                        session,
                        params['request'],
                      ),
        ),
        'logout': _is.MethodConnector(
          name: 'logout',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['employeeAuth'] as _i6neyhet.EmployeeAuthEndpoint)
                      .logout(session),
        ),
      },
    );
    connectors['employee'] = _is.EndpointConnector(
      name: 'employee',
      endpoint: endpoints['employee']!,
      methodConnectors: {
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'employeeId': _is.ParameterDescription(
              name: 'employeeId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['employee'] as _i3t5tbp4.EmployeeEndpoint).get(
                    session,
                    params['employeeId'],
                  ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_itsh5tmy.EmployeeCreate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['employee'] as _i3t5tbp4.EmployeeEndpoint).add(
                    session,
                    params['request'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_isn5wmy3.EmployeeUpdate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['employee'] as _i3t5tbp4.EmployeeEndpoint).update(
                    session,
                    params['request'],
                  ),
        ),
        'setEnabled': _is.MethodConnector(
          name: 'setEnabled',
          params: {
            'employeeId': _is.ParameterDescription(
              name: 'employeeId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'isEnabled': _is.ParameterDescription(
              name: 'isEnabled',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['employee'] as _i3t5tbp4.EmployeeEndpoint)
                  .setEnabled(
                    session,
                    params['employeeId'],
                    params['isEnabled'],
                  ),
        ),
      },
    );
    connectors['ownerAuth'] = _is.EndpointConnector(
      name: 'ownerAuth',
      endpoint: endpoints['ownerAuth']!,
      methodConnectors: {
        'register': _is.MethodConnector(
          name: 'register',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ihm3fhv0.EmailRegisterCreate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ownerAuth'] as _is2qyeee.OwnerAuthEndpoint)
                  .register(
                    session,
                    params['request'],
                  ),
        ),
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_i61r4gix.EmailLoginRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ownerAuth'] as _is2qyeee.OwnerAuthEndpoint).login(
                    session,
                    params['request'],
                  ),
        ),
        'me': _is.MethodConnector(
          name: 'me',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ownerAuth'] as _is2qyeee.OwnerAuthEndpoint)
                  .me(session),
        ),
        'updateMyProfile': _is.MethodConnector(
          name: 'updateMyProfile',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_id6sv1bw.ProfileUpdate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ownerAuth'] as _is2qyeee.OwnerAuthEndpoint)
                  .updateMyProfile(
                    session,
                    params['request'],
                  ),
        ),
        'logout': _is.MethodConnector(
          name: 'logout',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ownerAuth'] as _is2qyeee.OwnerAuthEndpoint)
                  .logout(session),
        ),
      },
    );
    connectors['superAdminAuth'] = _is.EndpointConnector(
      name: 'superAdminAuth',
      endpoint: endpoints['superAdminAuth']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_i61r4gix.EmailLoginRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['superAdminAuth']
                          as _itmp66ay.SuperAdminAuthEndpoint)
                      .login(
                        session,
                        params['request'],
                      ),
        ),
        'me': _is.MethodConnector(
          name: 'me',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['superAdminAuth']
                          as _itmp66ay.SuperAdminAuthEndpoint)
                      .me(session),
        ),
        'logout': _is.MethodConnector(
          name: 'logout',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['superAdminAuth']
                          as _itmp66ay.SuperAdminAuthEndpoint)
                      .logout(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_id6ub811.SuperAdminCreate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['superAdminAuth']
                          as _itmp66ay.SuperAdminAuthEndpoint)
                      .add(
                        session,
                        params['request'],
                      ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['superAdminAuth']
                          as _itmp66ay.SuperAdminAuthEndpoint)
                      .list(session),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'targetId': _is.ParameterDescription(
              name: 'targetId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['superAdminAuth']
                          as _itmp66ay.SuperAdminAuthEndpoint)
                      .delete(
                        session,
                        params['targetId'],
                      ),
        ),
        'ensureDefaultAdmin': _is.MethodConnector(
          name: 'ensureDefaultAdmin',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['superAdminAuth']
                          as _itmp66ay.SuperAdminAuthEndpoint)
                      .ensureDefaultAdmin(session),
        ),
      },
    );
    connectors['building'] = _is.EndpointConnector(
      name: 'building',
      endpoint: endpoints['building']!,
      methodConnectors: {
        'listMine': _is.MethodConnector(
          name: 'listMine',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['building'] as _i69ygv7j.BuildingEndpoint)
                  .listMine(session),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'buildingId': _is.ParameterDescription(
              name: 'buildingId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['building'] as _i69ygv7j.BuildingEndpoint).get(
                    session,
                    params['buildingId'],
                  ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_iikuia2o.BuildingCreate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['building'] as _i69ygv7j.BuildingEndpoint).create(
                    session,
                    params['request'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ipidi05l.BuildingUpdate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['building'] as _i69ygv7j.BuildingEndpoint).update(
                    session,
                    params['request'],
                  ),
        ),
        'listEmployees': _is.MethodConnector(
          name: 'listEmployees',
          params: {
            'buildingId': _is.ParameterDescription(
              name: 'buildingId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['building'] as _i69ygv7j.BuildingEndpoint)
                  .listEmployees(
                    session,
                    params['buildingId'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    connectors['menuArticle'] = _is.EndpointConnector(
      name: 'menuArticle',
      endpoint: endpoints['menuArticle']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'buildingId': _is.ParameterDescription(
              name: 'buildingId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['menuArticle'] as _iefktwfq.MenuArticleEndpoint)
                      .list(
                        session,
                        params['buildingId'],
                      ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_io67qn2p.MenuArticleCreate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['menuArticle'] as _iefktwfq.MenuArticleEndpoint)
                      .create(
                        session,
                        params['request'],
                      ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_igs394lv.MenuArticleUpdate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['menuArticle'] as _iefktwfq.MenuArticleEndpoint)
                      .update(
                        session,
                        params['request'],
                      ),
        ),
      },
    );
    connectors['menuCategory'] = _is.EndpointConnector(
      name: 'menuCategory',
      endpoint: endpoints['menuCategory']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'buildingId': _is.ParameterDescription(
              name: 'buildingId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['menuCategory'] as _i1h28rjj.MenuCategoryEndpoint)
                      .list(
                        session,
                        params['buildingId'],
                      ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ickdwlcc.MenuCategoryCreate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['menuCategory'] as _i1h28rjj.MenuCategoryEndpoint)
                      .create(
                        session,
                        params['request'],
                      ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_i4izftei.MenuCategoryUpdate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['menuCategory'] as _i1h28rjj.MenuCategoryEndpoint)
                      .update(
                        session,
                        params['request'],
                      ),
        ),
      },
    );
    connectors['venueTable'] = _is.EndpointConnector(
      name: 'venueTable',
      endpoint: endpoints['venueTable']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'buildingId': _is.ParameterDescription(
              name: 'buildingId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['venueTable'] as _ira8yrq4.VenueTableEndpoint)
                      .list(
                        session,
                        params['buildingId'],
                      ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ij730ie3.VenueTableCreate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['venueTable'] as _ira8yrq4.VenueTableEndpoint)
                      .create(
                        session,
                        params['request'],
                      ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ixxdkctx.VenueTableUpdate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['venueTable'] as _ira8yrq4.VenueTableEndpoint)
                      .update(
                        session,
                        params['request'],
                      ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
