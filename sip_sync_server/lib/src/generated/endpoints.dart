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
import 'package:sip_sync_server/src/generated/auth/dtos/change_password_request.dart'
    as _ig12em2g;
import 'package:sip_sync_server/src/generated/auth/dtos/email_login_request.dart'
    as _ibnmpi7x;
import 'package:sip_sync_server/src/generated/auth/dtos/email_register_create.dart'
    as _i3wgjxde;
import 'package:sip_sync_server/src/generated/auth/dtos/employee_create.dart'
    as _iohyx14n;
import 'package:sip_sync_server/src/generated/auth/dtos/employee_update.dart'
    as _il4f6nhz;
import 'package:sip_sync_server/src/generated/auth/dtos/password_reset_confirm.dart'
    as _ifl92t6h;
import 'package:sip_sync_server/src/generated/auth/dtos/password_reset_request.dart'
    as _i533dha7;
import 'package:sip_sync_server/src/generated/auth/dtos/profile_update.dart'
    as _itbs72nt;
import 'package:sip_sync_server/src/generated/auth/dtos/super_admin_create.dart'
    as _in2dfwpu;
import 'package:sip_sync_server/src/generated/auth/dtos/super_admin_update.dart'
    as _ir293hu7;
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
import 'package:sip_sync_server/src/generated/orders/dtos/customer_order_append.dart'
    as _ixtfjwlp;
import 'package:sip_sync_server/src/generated/orders/dtos/customer_order_place.dart'
    as _iyljqgq2;
import 'package:sip_sync_server/src/generated/orders/dtos/order_add_items.dart'
    as _im5ws0jm;
import 'package:sip_sync_server/src/generated/orders/dtos/order_create.dart'
    as _i5j23umo;
import 'package:sip_sync_server/src/generated/orders/dtos/order_item_status_update.dart'
    as _itxma5c4;
import 'package:sip_sync_server/src/generated/orders/dtos/order_status.dart'
    as _i9w9m1jz;
import 'package:sip_sync_server/src/generated/packs/dtos/pack_billing_period.dart'
    as _is2535ld;
import 'package:sip_sync_server/src/generated/packs/dtos/pack_create.dart'
    as _iijils8v;
import 'package:sip_sync_server/src/generated/packs/dtos/pack_update.dart'
    as _imymid9b;
import 'package:sip_sync_server/src/generated/tables/dtos/table_list_filter.dart'
    as _i2br6vxf;
import 'package:sip_sync_server/src/generated/tables/dtos/venue_table_create.dart'
    as _ituaoqeh;
import 'package:sip_sync_server/src/generated/tables/dtos/venue_table_update.dart'
    as _iishhke5;
import '../auth/customer_auth_endpoint.dart' as _i4yxnu3z;
import '../auth/employee_auth_endpoint.dart' as _i6neyhet;
import '../auth/employee_endpoint.dart' as _i3t5tbp4;
import '../auth/owner_auth_endpoint.dart' as _is2qyeee;
import '../auth/platform_directory_endpoint.dart' as _i2rird0e;
import '../auth/super_admin_auth_endpoint.dart' as _itmp66ay;
import '../buildings/building_endpoint.dart' as _i69ygv7j;
import '../discovery/customer_place_endpoint.dart' as _i6jzpqpk;
import '../discovery/customer_venue_endpoint.dart' as _i4o7mcri;
import '../employee_access/employee_access_endpoint.dart' as _im8yutbr;
import '../menu/article_composition_endpoint.dart' as _iavtsxat;
import '../menu/ingredient_endpoint.dart' as _i7cjtizz;
import '../menu/menu_article_endpoint.dart' as _iefktwfq;
import '../menu/menu_category_endpoint.dart' as _i1h28rjj;
import '../orders/customer_order_endpoint.dart' as _i3ulyznx;
import '../orders/order_endpoint.dart' as _iuf1spo6;
import '../packs/pack_endpoint.dart' as _i9krzab0;
import '../stats/platform_stats_endpoint.dart' as _i586lkkn;
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
      'platformDirectory': _i2rird0e.PlatformDirectoryEndpoint()
        ..initialize(
          server,
          'platformDirectory',
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
      'customerPlace': _i6jzpqpk.CustomerPlaceEndpoint()
        ..initialize(
          server,
          'customerPlace',
          null,
        ),
      'customerVenue': _i4o7mcri.CustomerVenueEndpoint()
        ..initialize(
          server,
          'customerVenue',
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
      'customerOrder': _i3ulyznx.CustomerOrderEndpoint()
        ..initialize(
          server,
          'customerOrder',
          null,
        ),
      'order': _iuf1spo6.OrderEndpoint()
        ..initialize(
          server,
          'order',
          null,
        ),
      'pack': _i9krzab0.PackEndpoint()
        ..initialize(
          server,
          'pack',
          null,
        ),
      'platformStats': _i586lkkn.PlatformStatsEndpoint()
        ..initialize(
          server,
          'platformStats',
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
        'changePassword': _is.MethodConnector(
          name: 'changePassword',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ig12em2g.ChangePasswordRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['employeeAuth'] as _i6neyhet.EmployeeAuthEndpoint)
                      .changePassword(
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
        'changePassword': _is.MethodConnector(
          name: 'changePassword',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ig12em2g.ChangePasswordRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ownerAuth'] as _is2qyeee.OwnerAuthEndpoint)
                  .changePassword(
                    session,
                    params['request'],
                  ),
        ),
        'requestPasswordReset': _is.MethodConnector(
          name: 'requestPasswordReset',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_i533dha7.PasswordResetRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ownerAuth'] as _is2qyeee.OwnerAuthEndpoint)
                  .requestPasswordReset(
                    session,
                    params['request'],
                  ),
        ),
        'confirmPasswordReset': _is.MethodConnector(
          name: 'confirmPasswordReset',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ifl92t6h.PasswordResetConfirm>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ownerAuth'] as _is2qyeee.OwnerAuthEndpoint)
                  .confirmPasswordReset(
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
    connectors['platformDirectory'] = _is.EndpointConnector(
      name: 'platformDirectory',
      endpoint: endpoints['platformDirectory']!,
      methodConnectors: {
        'listOwners': _is.MethodConnector(
          name: 'listOwners',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['platformDirectory']
                          as _i2rird0e.PlatformDirectoryEndpoint)
                      .listOwners(
                        session,
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
        ),
        'listCustomers': _is.MethodConnector(
          name: 'listCustomers',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['platformDirectory']
                          as _i2rird0e.PlatformDirectoryEndpoint)
                      .listCustomers(
                        session,
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
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
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ir293hu7.SuperAdminUpdate>(),
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
                      .update(
                        session,
                        params['request'],
                      ),
        ),
        'setEnabled': _is.MethodConnector(
          name: 'setEnabled',
          params: {
            'targetId': _is.ParameterDescription(
              name: 'targetId',
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
              ) async =>
                  (endpoints['superAdminAuth']
                          as _itmp66ay.SuperAdminAuthEndpoint)
                      .setEnabled(
                        session,
                        params['targetId'],
                        params['isEnabled'],
                      ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['superAdminAuth']
                          as _itmp66ay.SuperAdminAuthEndpoint)
                      .list(
                        session,
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
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
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['building'] as _i69ygv7j.BuildingEndpoint)
                  .listMine(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'listAll': _is.MethodConnector(
          name: 'listAll',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['building'] as _i69ygv7j.BuildingEndpoint).listAll(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'adminDetail': _is.MethodConnector(
          name: 'adminDetail',
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
                  .adminDetail(
                    session,
                    params['buildingId'],
                  ),
        ),
        'assignPack': _is.MethodConnector(
          name: 'assignPack',
          params: {
            'buildingId': _is.ParameterDescription(
              name: 'buildingId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'packId': _is.ParameterDescription(
              name: 'packId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'billingPeriod': _is.ParameterDescription(
              name: 'billingPeriod',
              type: _is.getType<_is2535ld.PackBillingPeriod?>(),
              nullable: true,
            ),
            'expiresAt': _is.ParameterDescription(
              name: 'expiresAt',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['building'] as _i69ygv7j.BuildingEndpoint)
                  .assignPack(
                    session,
                    params['buildingId'],
                    params['packId'],
                    billingPeriod: params['billingPeriod'],
                    expiresAt: params['expiresAt'],
                  ),
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
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
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
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
      },
    );
    connectors['customerPlace'] = _is.EndpointConnector(
      name: 'customerPlace',
      endpoint: endpoints['customerPlace']!,
      methodConnectors: {
        'search': _is.MethodConnector(
          name: 'search',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customerPlace']
                          as _i6jzpqpk.CustomerPlaceEndpoint)
                      .search(
                        session,
                        params['query'],
                      ),
        ),
        'reverse': _is.MethodConnector(
          name: 'reverse',
          params: {
            'latitude': _is.ParameterDescription(
              name: 'latitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'longitude': _is.ParameterDescription(
              name: 'longitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customerPlace']
                          as _i6jzpqpk.CustomerPlaceEndpoint)
                      .reverse(
                        session,
                        params['latitude'],
                        params['longitude'],
                      ),
        ),
      },
    );
    connectors['customerVenue'] = _is.EndpointConnector(
      name: 'customerVenue',
      endpoint: endpoints['customerVenue']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'latitude': _is.ParameterDescription(
              name: 'latitude',
              type: _is.getType<double?>(),
              nullable: true,
            ),
            'longitude': _is.ParameterDescription(
              name: 'longitude',
              type: _is.getType<double?>(),
              nullable: true,
            ),
            'nearbyOnly': _is.ParameterDescription(
              name: 'nearbyOnly',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customerVenue']
                          as _i4o7mcri.CustomerVenueEndpoint)
                      .list(
                        session,
                        limit: params['limit'],
                        offset: params['offset'],
                        latitude: params['latitude'],
                        longitude: params['longitude'],
                        nearbyOnly: params['nearbyOnly'],
                      ),
        ),
        'detail': _is.MethodConnector(
          name: 'detail',
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
                  (endpoints['customerVenue']
                          as _i4o7mcri.CustomerVenueEndpoint)
                      .detail(
                        session,
                        params['buildingId'],
                      ),
        ),
        'menu': _is.MethodConnector(
          name: 'menu',
          params: {
            'buildingId': _is.ParameterDescription(
              name: 'buildingId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customerVenue']
                          as _i4o7mcri.CustomerVenueEndpoint)
                      .menu(
                        session,
                        params['buildingId'],
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
        ),
        'resolveTable': _is.MethodConnector(
          name: 'resolveTable',
          params: {
            'buildingId': _is.ParameterDescription(
              name: 'buildingId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'tableId': _is.ParameterDescription(
              name: 'tableId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'number': _is.ParameterDescription(
              name: 'number',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customerVenue']
                          as _i4o7mcri.CustomerVenueEndpoint)
                      .resolveTable(
                        session,
                        params['buildingId'],
                        params['tableId'],
                        params['number'],
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
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
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
                        limit: params['limit'],
                        offset: params['offset'],
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
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
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
                        limit: params['limit'],
                        offset: params['offset'],
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
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
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
                        limit: params['limit'],
                        offset: params['offset'],
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
    connectors['customerOrder'] = _is.EndpointConnector(
      name: 'customerOrder',
      endpoint: endpoints['customerOrder']!,
      methodConnectors: {
        'place': _is.MethodConnector(
          name: 'place',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_iyljqgq2.CustomerOrderPlace>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customerOrder']
                          as _i3ulyznx.CustomerOrderEndpoint)
                      .place(
                        session,
                        params['request'],
                      ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'from': _is.ParameterDescription(
              name: 'from',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'to': _is.ParameterDescription(
              name: 'to',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customerOrder']
                          as _i3ulyznx.CustomerOrderEndpoint)
                      .list(
                        session,
                        params['from'],
                        params['to'],
                        limit: params['limit'],
                        offset: params['offset'],
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
              ) async =>
                  (endpoints['customerOrder']
                          as _i3ulyznx.CustomerOrderEndpoint)
                      .get(
                        session,
                        params['orderId'],
                      ),
        ),
        'current': _is.MethodConnector(
          name: 'current',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customerOrder']
                          as _i3ulyznx.CustomerOrderEndpoint)
                      .current(session),
        ),
        'append': _is.MethodConnector(
          name: 'append',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ixtfjwlp.CustomerOrderAppend>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customerOrder']
                          as _i3ulyznx.CustomerOrderEndpoint)
                      .append(
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
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_i9w9m1jz.OrderStatus?>(),
              nullable: true,
            ),
            'venueTableId': _is.ParameterDescription(
              name: 'venueTableId',
              type: _is.getType<_is.UuidValue?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _iuf1spo6.OrderEndpoint).list(
                session,
                params['buildingId'],
                params['status'],
                venueTableId: params['venueTableId'],
                limit: params['limit'],
                offset: params['offset'],
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
    connectors['pack'] = _is.EndpointConnector(
      name: 'pack',
      endpoint: endpoints['pack']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['pack'] as _i9krzab0.PackEndpoint).list(
                session,
                limit: params['limit'],
                offset: params['offset'],
              ),
        ),
        'listPublic': _is.MethodConnector(
          name: 'listPublic',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['pack'] as _i9krzab0.PackEndpoint)
                  .listPublic(session),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_iijils8v.PackCreate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['pack'] as _i9krzab0.PackEndpoint).create(
                session,
                params['request'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_imymid9b.PackUpdate>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['pack'] as _i9krzab0.PackEndpoint).update(
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
              ) async => (endpoints['pack'] as _i9krzab0.PackEndpoint).delete(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['platformStats'] = _is.EndpointConnector(
      name: 'platformStats',
      endpoint: endpoints['platformStats']!,
      methodConnectors: {
        'summary': _is.MethodConnector(
          name: 'summary',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['platformStats']
                          as _i586lkkn.PlatformStatsEndpoint)
                      .summary(session),
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
            'filter': _is.ParameterDescription(
              name: 'filter',
              type: _is.getType<_i2br6vxf.TableListFilter>(),
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
                        params['filter'],
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
