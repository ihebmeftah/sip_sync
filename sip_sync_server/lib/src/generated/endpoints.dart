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
import 'package:sip_sync_server/src/generated/auth/dtos/email_login_request.dart'
    as _ibnmpi7x;
import 'package:sip_sync_server/src/generated/auth/dtos/email_register_create.dart'
    as _i3wgjxde;
import 'package:sip_sync_server/src/generated/auth/dtos/employee_create.dart'
    as _iohyx14n;
import 'package:sip_sync_server/src/generated/auth/dtos/employee_update.dart'
    as _il4f6nhz;
import 'package:sip_sync_server/src/generated/auth/dtos/profile_update.dart'
    as _itbs72nt;
import 'package:sip_sync_server/src/generated/auth/dtos/super_admin_create.dart'
    as _in2dfwpu;
import 'package:sip_sync_server/src/generated/auth/dtos/username_login_request.dart'
    as _imoptt9g;
import 'package:sip_sync_server/src/generated/buildings/dtos/building_create.dart'
    as _iwyazuzj;
import 'package:sip_sync_server/src/generated/buildings/dtos/building_update.dart'
    as _ikeccdvf;
import 'package:sip_sync_server/src/generated/employee_access/dtos/employee_access_create.dart'
    as _iidenruw;
import 'package:sip_sync_server/src/generated/employee_access/dtos/employee_access_update.dart'
    as _if6umj7e;
import 'package:sip_sync_server/src/generated/menu/dtos/article_composition_create.dart'
    as _i1npuv27;
import 'package:sip_sync_server/src/generated/menu/dtos/article_composition_update.dart'
    as _ismlqq4o;
import 'package:sip_sync_server/src/generated/menu/dtos/ingredient_create.dart'
    as _iplysw6f;
import 'package:sip_sync_server/src/generated/menu/dtos/ingredient_restock.dart'
    as _ibya07f7;
import 'package:sip_sync_server/src/generated/menu/dtos/menu_article_create.dart'
    as _ijrbnog1;
import 'package:sip_sync_server/src/generated/menu/dtos/menu_article_update.dart'
    as _i7h46pya;
import 'package:sip_sync_server/src/generated/menu/dtos/menu_category_create.dart'
    as _i2o0r9sg;
import 'package:sip_sync_server/src/generated/menu/dtos/menu_category_update.dart'
    as _i8wyftia;
import 'package:sip_sync_server/src/generated/orders/dtos/order_add_items.dart'
    as _im5ws0jm;
import 'package:sip_sync_server/src/generated/orders/dtos/order_create.dart'
    as _i5j23umo;
import 'package:sip_sync_server/src/generated/orders/dtos/order_item_status_update.dart'
    as _itxma5c4;
import 'package:sip_sync_server/src/generated/tables/dtos/venue_table_create.dart'
    as _ituaoqeh;
import 'package:sip_sync_server/src/generated/tables/dtos/venue_table_update.dart'
    as _iishhke5;
import '../auth/customer_auth_endpoint.dart' as _i4yxnu3z;
import '../auth/employee_auth_endpoint.dart' as _i6neyhet;
import '../auth/employee_endpoint.dart' as _i3t5tbp4;
import '../auth/owner_auth_endpoint.dart' as _is2qyeee;
import '../auth/super_admin_auth_endpoint.dart' as _itmp66ay;
import '../buildings/building_endpoint.dart' as _i69ygv7j;
import '../employee_access/employee_access_endpoint.dart' as _im8yutbr;
import '../menu/article_composition_endpoint.dart' as _iavtsxat;
import '../menu/ingredient_endpoint.dart' as _i7cjtizz;
import '../menu/menu_article_endpoint.dart' as _iefktwfq;
import '../menu/menu_category_endpoint.dart' as _i1h28rjj;
import '../orders/order_endpoint.dart' as _iuf1spo6;
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
      'employeeAccess': _im8yutbr.EmployeeAccessEndpoint()
        ..initialize(
          server,
          'employeeAccess',
          null,
        ),
      'articleComposition': _iavtsxat.ArticleCompositionEndpoint()
        ..initialize(
          server,
          'articleComposition',
          null,
        ),
      'ingredient': _i7cjtizz.IngredientEndpoint()
        ..initialize(
          server,
          'ingredient',
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
      'order': _iuf1spo6.OrderEndpoint()
        ..initialize(
          server,
          'order',
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
              type: _is.getType<_i3wgjxde.EmailRegisterCreate>(),
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
              type: _is.getType<_ibnmpi7x.EmailLoginRequest>(),
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
              type: _is.getType<_itbs72nt.ProfileUpdate>(),
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
              type: _is.getType<_imoptt9g.UsernameLoginRequest>(),
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
              type: _is.getType<_itbs72nt.ProfileUpdate>(),
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
              type: _is.getType<_iohyx14n.EmployeeCreate>(),
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
              type: _is.getType<_il4f6nhz.EmployeeUpdate>(),
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
              type: _is.getType<_i3wgjxde.EmailRegisterCreate>(),
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
              type: _is.getType<_ibnmpi7x.EmailLoginRequest>(),
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
              type: _is.getType<_itbs72nt.ProfileUpdate>(),
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
              type: _is.getType<_ibnmpi7x.EmailLoginRequest>(),
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
              type: _is.getType<_in2dfwpu.SuperAdminCreate>(),
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
              type: _is.getType<_iwyazuzj.BuildingCreate>(),
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
              type: _is.getType<_ikeccdvf.BuildingUpdate>(),
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
    connectors['employeeAccess'] = _is.EndpointConnector(
      name: 'employeeAccess',
      endpoint: endpoints['employeeAccess']!,
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
                  (endpoints['employeeAccess']
                          as _im8yutbr.EmployeeAccessEndpoint)
                      .list(
                        session,
                        params['buildingId'],
                      ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['employeeAccess']
                          as _im8yutbr.EmployeeAccessEndpoint)
                      .get(
                        session,
                        params['id'],
                      ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_iidenruw.EmployeeAccessCreate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['employeeAccess']
                          as _im8yutbr.EmployeeAccessEndpoint)
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
              type: _is.getType<_if6umj7e.EmployeeAccessUpdate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['employeeAccess']
                          as _im8yutbr.EmployeeAccessEndpoint)
                      .update(
                        session,
                        params['request'],
                      ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['employeeAccess']
                          as _im8yutbr.EmployeeAccessEndpoint)
                      .delete(
                        session,
                        params['id'],
                      ),
        ),
      },
    );
    connectors['articleComposition'] = _is.EndpointConnector(
      name: 'articleComposition',
      endpoint: endpoints['articleComposition']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'articleId': _is.ParameterDescription(
              name: 'articleId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['articleComposition']
                          as _iavtsxat.ArticleCompositionEndpoint)
                      .list(
                        session,
                        params['articleId'],
                      ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_i1npuv27.ArticleCompositionCreate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['articleComposition']
                          as _iavtsxat.ArticleCompositionEndpoint)
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
              type: _is.getType<_ismlqq4o.ArticleCompositionUpdate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['articleComposition']
                          as _iavtsxat.ArticleCompositionEndpoint)
                      .update(
                        session,
                        params['request'],
                      ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['articleComposition']
                          as _iavtsxat.ArticleCompositionEndpoint)
                      .delete(
                        session,
                        params['id'],
                      ),
        ),
      },
    );
    connectors['ingredient'] = _is.EndpointConnector(
      name: 'ingredient',
      endpoint: endpoints['ingredient']!,
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
                  (endpoints['ingredient'] as _i7cjtizz.IngredientEndpoint)
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
              type: _is.getType<_iplysw6f.IngredientCreate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ingredient'] as _i7cjtizz.IngredientEndpoint)
                      .create(
                        session,
                        params['request'],
                      ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ingredient'] as _i7cjtizz.IngredientEndpoint)
                      .delete(
                        session,
                        params['id'],
                      ),
        ),
        'restock': _is.MethodConnector(
          name: 'restock',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ibya07f7.IngredientRestock>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ingredient'] as _i7cjtizz.IngredientEndpoint)
                      .restock(
                        session,
                        params['request'],
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
              type: _is.getType<_ijrbnog1.MenuArticleCreate>(),
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
              type: _is.getType<_i7h46pya.MenuArticleUpdate>(),
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
              type: _is.getType<_i2o0r9sg.MenuCategoryCreate>(),
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
              type: _is.getType<_i8wyftia.MenuCategoryUpdate>(),
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
    connectors['order'] = _is.EndpointConnector(
      name: 'order',
      endpoint: endpoints['order']!,
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
              ) async => (endpoints['order'] as _iuf1spo6.OrderEndpoint).list(
                session,
                params['buildingId'],
              ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'orderId': _is.ParameterDescription(
              name: 'orderId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _iuf1spo6.OrderEndpoint).get(
                session,
                params['orderId'],
              ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_i5j23umo.OrderCreate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _iuf1spo6.OrderEndpoint).create(
                session,
                params['request'],
              ),
        ),
        'addItems': _is.MethodConnector(
          name: 'addItems',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_im5ws0jm.OrderAddItems>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _iuf1spo6.OrderEndpoint).addItems(
                    session,
                    params['request'],
                  ),
        ),
        'updateItemStatus': _is.MethodConnector(
          name: 'updateItemStatus',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_itxma5c4.OrderItemStatusUpdate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _iuf1spo6.OrderEndpoint)
                  .updateItemStatus(
                    session,
                    params['request'],
                  ),
        ),
        'cancel': _is.MethodConnector(
          name: 'cancel',
          params: {
            'orderId': _is.ParameterDescription(
              name: 'orderId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _iuf1spo6.OrderEndpoint).cancel(
                session,
                params['orderId'],
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
              type: _is.getType<_ituaoqeh.VenueTableCreate>(),
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
              type: _is.getType<_iishhke5.VenueTableUpdate>(),
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
