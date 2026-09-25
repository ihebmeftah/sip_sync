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
import 'package:sip_sync_client/src/protocol/auth/dtos/auth_token_result.dart'
    as _itdxfou6;
import 'package:sip_sync_client/src/protocol/auth/dtos/customer_session_view.dart'
    as _ii1pag0e;
import 'package:sip_sync_client/src/protocol/auth/dtos/email_login_request.dart'
    as _i0krxdyg;
import 'package:sip_sync_client/src/protocol/auth/dtos/email_register_create.dart'
    as _imyts17l;
import 'package:sip_sync_client/src/protocol/auth/dtos/employee_create.dart'
    as _ic5onu3b;
import 'package:sip_sync_client/src/protocol/auth/dtos/employee_session_view.dart'
    as _igulf7jx;
import 'package:sip_sync_client/src/protocol/auth/dtos/employee_update.dart'
    as _ix639qfv;
import 'package:sip_sync_client/src/protocol/auth/dtos/employee_view.dart'
    as _iz70mzqw;
import 'package:sip_sync_client/src/protocol/auth/dtos/owner_session_view.dart'
    as _ibxh18gx;
import 'package:sip_sync_client/src/protocol/auth/dtos/profile_update.dart'
    as _i9d1xwh7;
import 'package:sip_sync_client/src/protocol/auth/dtos/super_admin_create.dart'
    as _itncnxe5;
import 'package:sip_sync_client/src/protocol/auth/dtos/super_admin_session_view.dart'
    as _i6jd5pnx;
import 'package:sip_sync_client/src/protocol/auth/dtos/super_admin_view.dart'
    as _ia930tyq;
import 'package:sip_sync_client/src/protocol/auth/dtos/username_login_request.dart'
    as _ijt6q2rq;
import 'package:sip_sync_client/src/protocol/buildings/dtos/building_create.dart'
    as _iu09iw1h;
import 'package:sip_sync_client/src/protocol/buildings/dtos/building_update.dart'
    as _iimah2gv;
import 'package:sip_sync_client/src/protocol/buildings/dtos/building_view.dart'
    as _ik35q5v8;
import 'package:sip_sync_client/src/protocol/employee_access/dtos/employee_access_create.dart'
    as _iv0z0sh6;
import 'package:sip_sync_client/src/protocol/employee_access/dtos/employee_access_update.dart'
    as _i7zd8pyu;
import 'package:sip_sync_client/src/protocol/employee_access/dtos/employee_access_view.dart'
    as _imdxt5mh;
import 'package:sip_sync_client/src/protocol/menu/dtos/article_composition_create.dart'
    as _itg09r98;
import 'package:sip_sync_client/src/protocol/menu/dtos/article_composition_update.dart'
    as _iwjumayb;
import 'package:sip_sync_client/src/protocol/menu/dtos/article_composition_view.dart'
    as _ier7rmyd;
import 'package:sip_sync_client/src/protocol/menu/dtos/ingredient_create.dart'
    as _iv1xmy57;
import 'package:sip_sync_client/src/protocol/menu/dtos/ingredient_restock.dart'
    as _iif93805;
import 'package:sip_sync_client/src/protocol/menu/dtos/ingredient_view.dart'
    as _i25phy6n;
import 'package:sip_sync_client/src/protocol/menu/dtos/menu_article_create.dart'
    as _ibs3aevp;
import 'package:sip_sync_client/src/protocol/menu/dtos/menu_article_update.dart'
    as _ixix58yq;
import 'package:sip_sync_client/src/protocol/menu/dtos/menu_article_view.dart'
    as _i8rrzffs;
import 'package:sip_sync_client/src/protocol/menu/dtos/menu_category_create.dart'
    as _iqn5nclg;
import 'package:sip_sync_client/src/protocol/menu/dtos/menu_category_update.dart'
    as _ifcginy4;
import 'package:sip_sync_client/src/protocol/menu/dtos/menu_category_view.dart'
    as _i6z5knea;
import 'package:sip_sync_client/src/protocol/orders/dtos/order_add_items.dart'
    as _ie4jvepd;
import 'package:sip_sync_client/src/protocol/orders/dtos/order_create.dart'
    as _i0prt93r;
import 'package:sip_sync_client/src/protocol/orders/dtos/order_item_status_update.dart'
    as _i6knlbz9;
import 'package:sip_sync_client/src/protocol/orders/dtos/order_status.dart'
    as _iqp2kjae;
import 'package:sip_sync_client/src/protocol/orders/dtos/order_view.dart'
    as _i5f9osh7;
import 'package:sip_sync_client/src/protocol/tables/dtos/table_list_filter.dart'
    as _izki6gkh;
import 'package:sip_sync_client/src/protocol/tables/dtos/venue_table_create.dart'
    as _i5q3abjq;
import 'package:sip_sync_client/src/protocol/tables/dtos/venue_table_update.dart'
    as _inqlnrkj;
import 'package:sip_sync_client/src/protocol/tables/dtos/venue_table_view.dart'
    as _ihz72ioq;
import 'protocol.dart' as _il2as5qe;

/// Customer self-register, login, and profile.
/// {@category Endpoint}
class EndpointCustomerAuth extends _isc.EndpointRef {
  EndpointCustomerAuth(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'customerAuth';

  _ida.Future<_itdxfou6.AuthTokenResult> register(
    _imyts17l.EmailRegisterCreate request,
  ) => caller.callServerEndpoint<_itdxfou6.AuthTokenResult>(
    'customerAuth',
    'register',
    {'request': request},
  );

  _ida.Future<_itdxfou6.AuthTokenResult> login(
    _i0krxdyg.EmailLoginRequest request,
  ) => caller.callServerEndpoint<_itdxfou6.AuthTokenResult>(
    'customerAuth',
    'login',
    {'request': request},
  );

  _ida.Future<_ii1pag0e.CustomerSessionView> me() =>
      caller.callServerEndpoint<_ii1pag0e.CustomerSessionView>(
        'customerAuth',
        'me',
        {},
      );

  _ida.Future<_ii1pag0e.CustomerSessionView> updateMyProfile(
    _i9d1xwh7.ProfileUpdate request,
  ) => caller.callServerEndpoint<_ii1pag0e.CustomerSessionView>(
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

  _ida.Future<_itdxfou6.AuthTokenResult> login(
    _ijt6q2rq.UsernameLoginRequest request,
  ) => caller.callServerEndpoint<_itdxfou6.AuthTokenResult>(
    'employeeAuth',
    'login',
    {'request': request},
  );

  _ida.Future<_igulf7jx.EmployeeSessionView> me() =>
      caller.callServerEndpoint<_igulf7jx.EmployeeSessionView>(
        'employeeAuth',
        'me',
        {},
      );

  _ida.Future<_igulf7jx.EmployeeSessionView> updateMyProfile(
    _i9d1xwh7.ProfileUpdate request,
  ) => caller.callServerEndpoint<_igulf7jx.EmployeeSessionView>(
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

  _ida.Future<_iz70mzqw.EmployeeView> get(_isc.UuidValue employeeId) =>
      caller.callServerEndpoint<_iz70mzqw.EmployeeView>(
        'employee',
        'get',
        {'employeeId': employeeId},
      );

  _ida.Future<_iz70mzqw.EmployeeView> add(_ic5onu3b.EmployeeCreate request) =>
      caller.callServerEndpoint<_iz70mzqw.EmployeeView>(
        'employee',
        'add',
        {'request': request},
      );

  _ida.Future<_iz70mzqw.EmployeeView> update(
    _ix639qfv.EmployeeUpdate request,
  ) => caller.callServerEndpoint<_iz70mzqw.EmployeeView>(
    'employee',
    'update',
    {'request': request},
  );

  _ida.Future<_iz70mzqw.EmployeeView> setEnabled(
    _isc.UuidValue employeeId,
    bool isEnabled,
  ) => caller.callServerEndpoint<_iz70mzqw.EmployeeView>(
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

  _ida.Future<_itdxfou6.AuthTokenResult> register(
    _imyts17l.EmailRegisterCreate request,
  ) => caller.callServerEndpoint<_itdxfou6.AuthTokenResult>(
    'ownerAuth',
    'register',
    {'request': request},
  );

  _ida.Future<_itdxfou6.AuthTokenResult> login(
    _i0krxdyg.EmailLoginRequest request,
  ) => caller.callServerEndpoint<_itdxfou6.AuthTokenResult>(
    'ownerAuth',
    'login',
    {'request': request},
  );

  _ida.Future<_ibxh18gx.OwnerSessionView> me() =>
      caller.callServerEndpoint<_ibxh18gx.OwnerSessionView>(
        'ownerAuth',
        'me',
        {},
      );

  _ida.Future<_ibxh18gx.OwnerSessionView> updateMyProfile(
    _i9d1xwh7.ProfileUpdate request,
  ) => caller.callServerEndpoint<_ibxh18gx.OwnerSessionView>(
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

  _ida.Future<_itdxfou6.AuthTokenResult> login(
    _i0krxdyg.EmailLoginRequest request,
  ) => caller.callServerEndpoint<_itdxfou6.AuthTokenResult>(
    'superAdminAuth',
    'login',
    {'request': request},
  );

  _ida.Future<_i6jd5pnx.SuperAdminSessionView> me() =>
      caller.callServerEndpoint<_i6jd5pnx.SuperAdminSessionView>(
        'superAdminAuth',
        'me',
        {},
      );

  _ida.Future<void> logout() => caller.callServerEndpoint<void>(
    'superAdminAuth',
    'logout',
    {},
  );

  _ida.Future<_ia930tyq.SuperAdminView> add(
    _itncnxe5.SuperAdminCreate request,
  ) => caller.callServerEndpoint<_ia930tyq.SuperAdminView>(
    'superAdminAuth',
    'add',
    {'request': request},
  );

  _ida.Future<List<_ia930tyq.SuperAdminView>> list() =>
      caller.callServerEndpoint<List<_ia930tyq.SuperAdminView>>(
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

  _ida.Future<List<_ik35q5v8.BuildingView>> listMine() =>
      caller.callServerEndpoint<List<_ik35q5v8.BuildingView>>(
        'building',
        'listMine',
        {},
      );

  _ida.Future<_ik35q5v8.BuildingView> get(_isc.UuidValue buildingId) =>
      caller.callServerEndpoint<_ik35q5v8.BuildingView>(
        'building',
        'get',
        {'buildingId': buildingId},
      );

  _ida.Future<_ik35q5v8.BuildingView> create(
    _iu09iw1h.BuildingCreate request,
  ) => caller.callServerEndpoint<_ik35q5v8.BuildingView>(
    'building',
    'create',
    {'request': request},
  );

  _ida.Future<_ik35q5v8.BuildingView> update(
    _iimah2gv.BuildingUpdate request,
  ) => caller.callServerEndpoint<_ik35q5v8.BuildingView>(
    'building',
    'update',
    {'request': request},
  );

  _ida.Future<List<_iz70mzqw.EmployeeView>> listEmployees(
    _isc.UuidValue buildingId,
  ) => caller.callServerEndpoint<List<_iz70mzqw.EmployeeView>>(
    'building',
    'listEmployees',
    {'buildingId': buildingId},
  );
}

/// Owner-only RPC for building-scoped employee access profiles.
/// {@category Endpoint}
class EndpointEmployeeAccess extends _isc.EndpointRef {
  EndpointEmployeeAccess(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'employeeAccess';

  /// Lists access profiles for [buildingId].
  _ida.Future<List<_imdxt5mh.EmployeeAccessView>> list(
    _isc.UuidValue buildingId,
  ) => caller.callServerEndpoint<List<_imdxt5mh.EmployeeAccessView>>(
    'employeeAccess',
    'list',
    {'buildingId': buildingId},
  );

  /// Loads one access profile.
  _ida.Future<_imdxt5mh.EmployeeAccessView> get(_isc.UuidValue id) =>
      caller.callServerEndpoint<_imdxt5mh.EmployeeAccessView>(
        'employeeAccess',
        'get',
        {'id': id},
      );

  /// Creates a named profile with permission flags.
  _ida.Future<_imdxt5mh.EmployeeAccessView> create(
    _iv0z0sh6.EmployeeAccessCreate request,
  ) => caller.callServerEndpoint<_imdxt5mh.EmployeeAccessView>(
    'employeeAccess',
    'create',
    {'request': request},
  );

  /// Updates name and flags.
  _ida.Future<_imdxt5mh.EmployeeAccessView> update(
    _i7zd8pyu.EmployeeAccessUpdate request,
  ) => caller.callServerEndpoint<_imdxt5mh.EmployeeAccessView>(
    'employeeAccess',
    'update',
    {'request': request},
  );

  /// Deletes a profile that is not assigned to staff.
  _ida.Future<void> delete(_isc.UuidValue id) =>
      caller.callServerEndpoint<void>(
        'employeeAccess',
        'delete',
        {'id': id},
      );
}

/// Optional article recipe lines (ingredient + quantity).
/// {@category Endpoint}
class EndpointArticleComposition extends _isc.EndpointRef {
  EndpointArticleComposition(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'articleComposition';

  /// Lists composition lines for [articleId] (owner or assigned employee).
  _ida.Future<List<_ier7rmyd.ArticleCompositionView>> list(
    _isc.UuidValue articleId,
  ) => caller.callServerEndpoint<List<_ier7rmyd.ArticleCompositionView>>(
    'articleComposition',
    'list',
    {'articleId': articleId},
  );

  /// Owner adds a composition line.
  _ida.Future<_ier7rmyd.ArticleCompositionView> create(
    _itg09r98.ArticleCompositionCreate request,
  ) => caller.callServerEndpoint<_ier7rmyd.ArticleCompositionView>(
    'articleComposition',
    'create',
    {'request': request},
  );

  /// Owner updates a line quantity.
  _ida.Future<_ier7rmyd.ArticleCompositionView> update(
    _iwjumayb.ArticleCompositionUpdate request,
  ) => caller.callServerEndpoint<_ier7rmyd.ArticleCompositionView>(
    'articleComposition',
    'update',
    {'request': request},
  );

  /// Owner deletes a composition line.
  _ida.Future<void> delete(_isc.UuidValue id) =>
      caller.callServerEndpoint<void>(
        'articleComposition',
        'delete',
        {'id': id},
      );
}

/// Ingredient inventory RPC for a building (create, list, delete).
/// {@category Endpoint}
class EndpointIngredient extends _isc.EndpointRef {
  EndpointIngredient(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ingredient';

  /// Lists ingredients for [buildingId] (owner or assigned employee).
  _ida.Future<List<_i25phy6n.IngredientView>> list(_isc.UuidValue buildingId) =>
      caller.callServerEndpoint<List<_i25phy6n.IngredientView>>(
        'ingredient',
        'list',
        {'buildingId': buildingId},
      );

  /// Owner creates an ingredient.
  _ida.Future<_i25phy6n.IngredientView> create(
    _iv1xmy57.IngredientCreate request,
  ) => caller.callServerEndpoint<_i25phy6n.IngredientView>(
    'ingredient',
    'create',
    {'request': request},
  );

  /// Owner deletes an ingredient by [id].
  _ida.Future<void> delete(_isc.UuidValue id) =>
      caller.callServerEndpoint<void>(
        'ingredient',
        'delete',
        {'id': id},
      );

  /// Owner or employee adds incoming quantity to stock.
  _ida.Future<_i25phy6n.IngredientView> restock(
    _iif93805.IngredientRestock request,
  ) => caller.callServerEndpoint<_i25phy6n.IngredientView>(
    'ingredient',
    'restock',
    {'request': request},
  );
}

/// Menu article RPC for a building.
/// {@category Endpoint}
class EndpointMenuArticle extends _isc.EndpointRef {
  EndpointMenuArticle(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'menuArticle';

  /// Lists articles for [buildingId] (owner or assigned employee).
  _ida.Future<List<_i8rrzffs.MenuArticleView>> list(
    _isc.UuidValue buildingId,
  ) => caller.callServerEndpoint<List<_i8rrzffs.MenuArticleView>>(
    'menuArticle',
    'list',
    {'buildingId': buildingId},
  );

  /// Owner creates an article.
  _ida.Future<_i8rrzffs.MenuArticleView> create(
    _ibs3aevp.MenuArticleCreate request,
  ) => caller.callServerEndpoint<_i8rrzffs.MenuArticleView>(
    'menuArticle',
    'create',
    {'request': request},
  );

  /// Owner updates an article.
  _ida.Future<_i8rrzffs.MenuArticleView> update(
    _ixix58yq.MenuArticleUpdate request,
  ) => caller.callServerEndpoint<_i8rrzffs.MenuArticleView>(
    'menuArticle',
    'update',
    {'request': request},
  );
}

/// Menu category RPC for a building.
/// {@category Endpoint}
class EndpointMenuCategory extends _isc.EndpointRef {
  EndpointMenuCategory(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'menuCategory';

  /// Lists categories for [buildingId] (owner or assigned employee).
  _ida.Future<List<_i6z5knea.MenuCategoryView>> list(
    _isc.UuidValue buildingId,
  ) => caller.callServerEndpoint<List<_i6z5knea.MenuCategoryView>>(
    'menuCategory',
    'list',
    {'buildingId': buildingId},
  );

  /// Owner creates a category.
  _ida.Future<_i6z5knea.MenuCategoryView> create(
    _iqn5nclg.MenuCategoryCreate request,
  ) => caller.callServerEndpoint<_i6z5knea.MenuCategoryView>(
    'menuCategory',
    'create',
    {'request': request},
  );

  /// Owner updates a category.
  _ida.Future<_i6z5knea.MenuCategoryView> update(
    _ifcginy4.MenuCategoryUpdate request,
  ) => caller.callServerEndpoint<_i6z5knea.MenuCategoryView>(
    'menuCategory',
    'update',
    {'request': request},
  );
}

/// Floor / POS order RPC for a building.
/// {@category Endpoint}
class EndpointOrder extends _isc.EndpointRef {
  EndpointOrder(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'order';

  /// Lists orders for [buildingId] (owner or assigned employee).
  ///
  /// When [status] is set, only orders with that status are returned.
  _ida.Future<List<_i5f9osh7.OrderView>> list(
    _isc.UuidValue buildingId,
    _iqp2kjae.OrderStatus? status,
  ) => caller.callServerEndpoint<List<_i5f9osh7.OrderView>>(
    'order',
    'list',
    {
      'buildingId': buildingId,
      'status': status,
    },
  );

  /// Loads one order with items.
  _ida.Future<_i5f9osh7.OrderView> get(_isc.UuidValue orderId) =>
      caller.callServerEndpoint<_i5f9osh7.OrderView>(
        'order',
        'get',
        {'orderId': orderId},
      );

  /// Owner or employee creates an order with lines.
  _ida.Future<_i5f9osh7.OrderView> create(_i0prt93r.OrderCreate request) =>
      caller.callServerEndpoint<_i5f9osh7.OrderView>(
        'order',
        'create',
        {'request': request},
      );

  /// Adds lines to an open order.
  _ida.Future<_i5f9osh7.OrderView> addItems(_ie4jvepd.OrderAddItems request) =>
      caller.callServerEndpoint<_i5f9osh7.OrderView>(
        'order',
        'addItems',
        {'request': request},
      );

  /// Advances or cancels one order line (sets attribution).
  _ida.Future<_i5f9osh7.OrderView> updateItemStatus(
    _i6knlbz9.OrderItemStatusUpdate request,
  ) => caller.callServerEndpoint<_i5f9osh7.OrderView>(
    'order',
    'updateItemStatus',
    {'request': request},
  );

  /// Cancels an open order.
  _ida.Future<_i5f9osh7.OrderView> cancel(_isc.UuidValue orderId) =>
      caller.callServerEndpoint<_i5f9osh7.OrderView>(
        'order',
        'cancel',
        {'orderId': orderId},
      );
}

/// Floor table RPC for a building.
/// {@category Endpoint}
class EndpointVenueTable extends _isc.EndpointRef {
  EndpointVenueTable(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'venueTable';

  /// Lists tables for [buildingId] (owner or assigned employee).
  ///
  /// [filter] narrows by computed floor status or inactive flag (`all` = no filter).
  _ida.Future<List<_ihz72ioq.VenueTableView>> list(
    _isc.UuidValue buildingId,
    _izki6gkh.TableListFilter filter,
  ) => caller.callServerEndpoint<List<_ihz72ioq.VenueTableView>>(
    'venueTable',
    'list',
    {
      'buildingId': buildingId,
      'filter': filter,
    },
  );

  /// Owner creates one or more tables; numbers are assigned in sequence.
  _ida.Future<List<_ihz72ioq.VenueTableView>> create(
    _i5q3abjq.VenueTableCreate request,
  ) => caller.callServerEndpoint<List<_ihz72ioq.VenueTableView>>(
    'venueTable',
    'create',
    {'request': request},
  );

  /// Owner updates seats and active only (number cannot change).
  _ida.Future<_ihz72ioq.VenueTableView> update(
    _inqlnrkj.VenueTableUpdate request,
  ) => caller.callServerEndpoint<_ihz72ioq.VenueTableView>(
    'venueTable',
    'update',
    {'request': request},
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
    employeeAccess = EndpointEmployeeAccess(this);
    articleComposition = EndpointArticleComposition(this);
    ingredient = EndpointIngredient(this);
    menuArticle = EndpointMenuArticle(this);
    menuCategory = EndpointMenuCategory(this);
    order = EndpointOrder(this);
    venueTable = EndpointVenueTable(this);
    modules = Modules(this);
  }

  late final EndpointCustomerAuth customerAuth;

  late final EndpointEmployeeAuth employeeAuth;

  late final EndpointEmployee employee;

  late final EndpointOwnerAuth ownerAuth;

  late final EndpointSuperAdminAuth superAdminAuth;

  late final EndpointBuilding building;

  late final EndpointEmployeeAccess employeeAccess;

  late final EndpointArticleComposition articleComposition;

  late final EndpointIngredient ingredient;

  late final EndpointMenuArticle menuArticle;

  late final EndpointMenuCategory menuCategory;

  late final EndpointOrder order;

  late final EndpointVenueTable venueTable;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'customerAuth': customerAuth,
    'employeeAuth': employeeAuth,
    'employee': employee,
    'ownerAuth': ownerAuth,
    'superAdminAuth': superAdminAuth,
    'building': building,
    'employeeAccess': employeeAccess,
    'articleComposition': articleComposition,
    'ingredient': ingredient,
    'menuArticle': menuArticle,
    'menuCategory': menuCategory,
    'order': order,
    'venueTable': venueTable,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
