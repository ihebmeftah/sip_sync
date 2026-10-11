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
import 'package:sip_sync_client/src/protocol/auth/dtos/change_password_request.dart'
    as _ilzajllb;
import 'package:sip_sync_client/src/protocol/auth/dtos/customer_session_view.dart'
    as _ii1pag0e;
import 'package:sip_sync_client/src/protocol/auth/dtos/email_login_request.dart'
    as _i0krxdyg;
import 'package:sip_sync_client/src/protocol/auth/dtos/email_register_create.dart'
    as _imyts17l;
import 'package:sip_sync_client/src/protocol/auth/dtos/employee_create.dart'
    as _ic5onu3b;
import 'package:sip_sync_client/src/protocol/auth/dtos/employee_page.dart'
    as _it4lhkdu;
import 'package:sip_sync_client/src/protocol/auth/dtos/employee_session_view.dart'
    as _igulf7jx;
import 'package:sip_sync_client/src/protocol/auth/dtos/employee_update.dart'
    as _ix639qfv;
import 'package:sip_sync_client/src/protocol/auth/dtos/employee_view.dart'
    as _iz70mzqw;
import 'package:sip_sync_client/src/protocol/auth/dtos/owner_session_view.dart'
    as _ibxh18gx;
import 'package:sip_sync_client/src/protocol/auth/dtos/password_reset_confirm.dart'
    as _ihx8fgpk;
import 'package:sip_sync_client/src/protocol/auth/dtos/password_reset_request.dart'
    as _ifcla4ri;
import 'package:sip_sync_client/src/protocol/auth/dtos/password_reset_request_result.dart'
    as _iv84wffs;
import 'package:sip_sync_client/src/protocol/auth/dtos/platform_person_page.dart'
    as _i2elmu13;
import 'package:sip_sync_client/src/protocol/auth/dtos/profile_update.dart'
    as _i9d1xwh7;
import 'package:sip_sync_client/src/protocol/auth/dtos/super_admin_create.dart'
    as _itncnxe5;
import 'package:sip_sync_client/src/protocol/auth/dtos/super_admin_page.dart'
    as _iy2qxild;
import 'package:sip_sync_client/src/protocol/auth/dtos/super_admin_session_view.dart'
    as _i6jd5pnx;
import 'package:sip_sync_client/src/protocol/auth/dtos/super_admin_update.dart'
    as _i1ju3f9f;
import 'package:sip_sync_client/src/protocol/auth/dtos/super_admin_view.dart'
    as _ia930tyq;
import 'package:sip_sync_client/src/protocol/auth/dtos/username_login_request.dart'
    as _ijt6q2rq;
import 'package:sip_sync_client/src/protocol/buildings/dtos/admin_building_detail.dart'
    as _ig0c1d2c;
import 'package:sip_sync_client/src/protocol/buildings/dtos/admin_building_page.dart'
    as _ihfql4vm;
import 'package:sip_sync_client/src/protocol/buildings/dtos/building_create.dart'
    as _iu09iw1h;
import 'package:sip_sync_client/src/protocol/buildings/dtos/building_page.dart'
    as _idr0ofas;
import 'package:sip_sync_client/src/protocol/buildings/dtos/building_update.dart'
    as _iimah2gv;
import 'package:sip_sync_client/src/protocol/buildings/dtos/building_view.dart'
    as _ik35q5v8;
import 'package:sip_sync_client/src/protocol/buildings/dtos/country_building_stat.dart'
    as _iebf7xye;
import 'package:sip_sync_client/src/protocol/discovery/dtos/customer_menu.dart'
    as _i1mbazw4;
import 'package:sip_sync_client/src/protocol/discovery/dtos/customer_seated_table.dart'
    as _iggqoelg;
import 'package:sip_sync_client/src/protocol/discovery/dtos/customer_venue_detail.dart'
    as _i3ttx85w;
import 'package:sip_sync_client/src/protocol/discovery/dtos/customer_venue_page.dart'
    as _ihk3nm0c;
import 'package:sip_sync_client/src/protocol/discovery/dtos/place_hit.dart'
    as _ijgfn5qw;
import 'package:sip_sync_client/src/protocol/employee_access/dtos/employee_access_create.dart'
    as _iv0z0sh6;
import 'package:sip_sync_client/src/protocol/employee_access/dtos/employee_access_page.dart'
    as _idopbith;
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
import 'package:sip_sync_client/src/protocol/menu/dtos/ingredient_page.dart'
    as _i5p5mc8n;
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
import 'package:sip_sync_client/src/protocol/menu/dtos/menu_category_page.dart'
    as _i48lt3pj;
import 'package:sip_sync_client/src/protocol/menu/dtos/menu_category_update.dart'
    as _ifcginy4;
import 'package:sip_sync_client/src/protocol/menu/dtos/menu_category_view.dart'
    as _i6z5knea;
import 'package:sip_sync_client/src/protocol/orders/dtos/customer_order_append.dart'
    as _izdy5w2j;
import 'package:sip_sync_client/src/protocol/orders/dtos/customer_order_page.dart'
    as _iwuqnthl;
import 'package:sip_sync_client/src/protocol/orders/dtos/customer_order_place.dart'
    as _i5gpmr9n;
import 'package:sip_sync_client/src/protocol/orders/dtos/customer_order_view.dart'
    as _iiy8950w;
import 'package:sip_sync_client/src/protocol/orders/dtos/order_add_items.dart'
    as _ie4jvepd;
import 'package:sip_sync_client/src/protocol/orders/dtos/order_create.dart'
    as _i0prt93r;
import 'package:sip_sync_client/src/protocol/orders/dtos/order_item_status_update.dart'
    as _i6knlbz9;
import 'package:sip_sync_client/src/protocol/orders/dtos/order_page.dart'
    as _ith3f88l;
import 'package:sip_sync_client/src/protocol/orders/dtos/order_status.dart'
    as _iqp2kjae;
import 'package:sip_sync_client/src/protocol/orders/dtos/order_view.dart'
    as _i5f9osh7;
import 'package:sip_sync_client/src/protocol/packs/dtos/pack_billing_period.dart'
    as _ikrrfqlm;
import 'package:sip_sync_client/src/protocol/packs/dtos/pack_create.dart'
    as _iuhtf04l;
import 'package:sip_sync_client/src/protocol/packs/dtos/pack_page.dart'
    as _iv7y27qe;
import 'package:sip_sync_client/src/protocol/packs/dtos/pack_public_view.dart'
    as _ir1kads3;
import 'package:sip_sync_client/src/protocol/packs/dtos/pack_update.dart'
    as _i8gbceh6;
import 'package:sip_sync_client/src/protocol/packs/dtos/pack_view.dart'
    as _ihy1alcs;
import 'package:sip_sync_client/src/protocol/reservations/dtos/customer_reservation_create.dart'
    as _iwv7rt7o;
import 'package:sip_sync_client/src/protocol/reservations/dtos/reservation_create.dart'
    as _iq3meyhi;
import 'package:sip_sync_client/src/protocol/reservations/dtos/reservation_customer_match.dart'
    as _io69v53p;
import 'package:sip_sync_client/src/protocol/reservations/dtos/reservation_view.dart'
    as _ixub33vy;
import 'package:sip_sync_client/src/protocol/stats/dtos/platform_stats.dart'
    as _i6db8rp3;
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

  /// Updates the signed-in employee's password and drops other sessions.
  _ida.Future<void> changePassword(_ilzajllb.ChangePasswordRequest request) =>
      caller.callServerEndpoint<void>(
        'employeeAuth',
        'changePassword',
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

/// Owner self-register, login, profile, and password reset.
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

  /// Updates the signed-in owner's password and drops other sessions.
  _ida.Future<void> changePassword(_ilzajllb.ChangePasswordRequest request) =>
      caller.callServerEndpoint<void>(
        'ownerAuth',
        'changePassword',
        {'request': request},
      );

  /// Starts a password reset for an owner email (no enumeration).
  ///
  /// Until email delivery exists, the OTP is logged and returned as
  /// [PasswordResetRequestResult.debugCode] in development/test only.
  _ida.Future<_iv84wffs.PasswordResetRequestResult> requestPasswordReset(
    _ifcla4ri.PasswordResetRequest request,
  ) => caller.callServerEndpoint<_iv84wffs.PasswordResetRequestResult>(
    'ownerAuth',
    'requestPasswordReset',
    {'request': request},
  );

  /// Completes owner password reset with OTP + new password.
  _ida.Future<void> confirmPasswordReset(
    _ihx8fgpk.PasswordResetConfirm request,
  ) => caller.callServerEndpoint<void>(
    'ownerAuth',
    'confirmPasswordReset',
    {'request': request},
  );

  _ida.Future<void> logout() => caller.callServerEndpoint<void>(
    'ownerAuth',
    'logout',
    {},
  );
}

/// Super-admin directory of owners and customers. No writes.
/// {@category Endpoint}
class EndpointPlatformDirectory extends _isc.EndpointRef {
  EndpointPlatformDirectory(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'platformDirectory';

  /// Owners on the platform, newest first. Super admin only.
  ///
  /// [limit] defaults to 20 and is capped at 100. [offset] skips that many rows.
  _ida.Future<_i2elmu13.PlatformPersonPage> listOwners({
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<_i2elmu13.PlatformPersonPage>(
    'platformDirectory',
    'listOwners',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  /// Customers on the platform, newest first. Super admin only.
  _ida.Future<_i2elmu13.PlatformPersonPage> listCustomers({
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<_i2elmu13.PlatformPersonPage>(
    'platformDirectory',
    'listCustomers',
    {
      'limit': limit,
      'offset': offset,
    },
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

  /// Updates profile fields. A non-empty [SuperAdminUpdate.password] replaces the hash.
  ///
  /// Enabling or disabling follows the same rules as [setEnabled].
  _ida.Future<_ia930tyq.SuperAdminView> update(
    _i1ju3f9f.SuperAdminUpdate request,
  ) => caller.callServerEndpoint<_ia930tyq.SuperAdminView>(
    'superAdminAuth',
    'update',
    {'request': request},
  );

  /// Enables or disables a backoffice user.
  ///
  /// The default admin and the caller’s own account cannot be disabled.
  /// Disabling revokes that admin’s sessions.
  _ida.Future<_ia930tyq.SuperAdminView> setEnabled(
    _isc.UuidValue targetId,
    bool isEnabled,
  ) => caller.callServerEndpoint<_ia930tyq.SuperAdminView>(
    'superAdminAuth',
    'setEnabled',
    {
      'targetId': targetId,
      'isEnabled': isEnabled,
    },
  );

  /// Backoffice users, oldest first.
  ///
  /// [limit] defaults to 20 and is capped at 100. [offset] skips that many rows.
  _ida.Future<_iy2qxild.SuperAdminPage> list({
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<_iy2qxild.SuperAdminPage>(
    'superAdminAuth',
    'list',
    {
      'limit': limit,
      'offset': offset,
    },
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

  /// Venues the caller can open. Owners see their own; staff see one.
  ///
  /// [limit] defaults to 20 and is capped at 100.
  _ida.Future<_idr0ofas.BuildingPage> listMine({
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<_idr0ofas.BuildingPage>(
    'building',
    'listMine',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  /// Venues for the backoffice, including owner contact. Super admin only.
  ///
  /// [query] matches the venue name, address, or the owner's first or last
  /// name. [packId] keeps venues on that pack. Both can be combined.
  _ida.Future<_ihfql4vm.AdminBuildingPage> listAll({
    int? limit,
    int? offset,
    String? query,
    _isc.UuidValue? packId,
  }) => caller.callServerEndpoint<_ihfql4vm.AdminBuildingPage>(
    'building',
    'listAll',
    {
      'limit': limit,
      'offset': offset,
      'query': query,
      'packId': packId,
    },
  );

  /// Venue counts by country, with a map point. Super admin only.
  _ida.Future<List<_iebf7xye.CountryBuildingStat>> countryStats() =>
      caller.callServerEndpoint<List<_iebf7xye.CountryBuildingStat>>(
        'building',
        'countryStats',
        {},
      );

  /// Venue, pack, counts, and platform gain. Super admin only.
  _ida.Future<_ig0c1d2c.AdminBuildingDetail> adminDetail(
    _isc.UuidValue buildingId,
  ) => caller.callServerEndpoint<_ig0c1d2c.AdminBuildingDetail>(
    'building',
    'adminDetail',
    {'buildingId': buildingId},
  );

  /// Moves a free-plan venue onto an enabled pack. Super admin only.
  ///
  /// A venue already on a paid plan is rejected. The free pack takes no term.
  /// Any other pack needs [billingPeriod] and [expiresAt]. Monthly and yearly
  /// dates must be at least that period out and may be later. A daily date
  /// past 20 days is stored as monthly. The venue returns to the free pack
  /// when that date arrives. Each step is kept as history.
  _ida.Future<_ig0c1d2c.AdminBuildingDetail> assignPack(
    _isc.UuidValue buildingId,
    _isc.UuidValue packId, {
    _ikrrfqlm.PackBillingPeriod? billingPeriod,
    DateTime? expiresAt,
  }) => caller.callServerEndpoint<_ig0c1d2c.AdminBuildingDetail>(
    'building',
    'assignPack',
    {
      'buildingId': buildingId,
      'packId': packId,
      'billingPeriod': billingPeriod,
      'expiresAt': expiresAt,
    },
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

  /// Staff of [buildingId], owner only. Name order.
  _ida.Future<_it4lhkdu.EmployeePage> listEmployees(
    _isc.UuidValue buildingId, {
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<_it4lhkdu.EmployeePage>(
    'building',
    'listEmployees',
    {
      'buildingId': buildingId,
      'limit': limit,
      'offset': offset,
    },
  );
}

/// Address search and reverse geocoding for signed-in customers.
///
/// Proxies Nominatim so the Flutter web app is not blocked by CORS.
/// {@category Endpoint}
class EndpointCustomerPlace extends _isc.EndpointRef {
  EndpointCustomerPlace(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'customerPlace';

  /// Up to five address suggestions. Query must be 3–200 characters.
  _ida.Future<List<_ijgfn5qw.PlaceHit>> search(String query) =>
      caller.callServerEndpoint<List<_ijgfn5qw.PlaceHit>>(
        'customerPlace',
        'search',
        {'query': query},
      );

  /// Label for a coordinate the customer picked on the device.
  _ida.Future<_ijgfn5qw.PlaceHit> reverse(
    double latitude,
    double longitude,
  ) => caller.callServerEndpoint<_ijgfn5qw.PlaceHit>(
    'customerPlace',
    'reverse',
    {
      'latitude': latitude,
      'longitude': longitude,
    },
  );
}

/// Public venue cards for signed-in customers.
/// {@category Endpoint}
class EndpointCustomerVenue extends _isc.EndpointRef {
  EndpointCustomerVenue(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'customerVenue';

  /// Public venue cards, name order, or nearest first when a place is set.
  ///
  /// Customers only. [nearbyOnly] keeps venues inside 15 km of
  /// [latitude]/[longitude]. [limit] defaults to 20 and is capped at 100.
  /// Omits owner identity, staff, and order-pipeline flags.
  _ida.Future<_ihk3nm0c.CustomerVenuePage> list({
    int? limit,
    int? offset,
    double? latitude,
    double? longitude,
    required bool nearbyOnly,
  }) => caller.callServerEndpoint<_ihk3nm0c.CustomerVenuePage>(
    'customerVenue',
    'list',
    {
      'limit': limit,
      'offset': offset,
      'latitude': latitude,
      'longitude': longitude,
      'nearbyOnly': nearbyOnly,
    },
  );

  /// Venue page: free tables and the top categories and articles.
  ///
  /// Customers only. Missing venues throw [BuildingException.notFound].
  _ida.Future<_i3ttx85w.CustomerVenueDetail> detail(
    _isc.UuidValue buildingId,
  ) => caller.callServerEndpoint<_i3ttx85w.CustomerVenueDetail>(
    'customerVenue',
    'detail',
    {'buildingId': buildingId},
  );

  /// Menu window in catalog order, plus every category for the rail.
  ///
  /// Customers only. [limit] defaults to 20 articles and is capped at 100.
  _ida.Future<_i1mbazw4.CustomerMenu> menu(
    _isc.UuidValue buildingId, {
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<_i1mbazw4.CustomerMenu>(
    'customerVenue',
    'menu',
    {
      'buildingId': buildingId,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Confirms a scanned table sticker belongs to an active table.
  ///
  /// Customers only. A missing, inactive, or mismatched sticker throws
  /// [BuildingException]. Occupied tables still resolve: the customer is
  /// sitting there, and the venue page marks that seat.
  _ida.Future<_iggqoelg.CustomerSeatedTable> resolveTable(
    _isc.UuidValue buildingId,
    _isc.UuidValue tableId,
    int number,
  ) => caller.callServerEndpoint<_iggqoelg.CustomerSeatedTable>(
    'customerVenue',
    'resolveTable',
    {
      'buildingId': buildingId,
      'tableId': tableId,
      'number': number,
    },
  );
}

/// Owner-only RPC for building-scoped employee access profiles.
/// {@category Endpoint}
class EndpointEmployeeAccess extends _isc.EndpointRef {
  EndpointEmployeeAccess(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'employeeAccess';

  /// Access profiles for [buildingId], name order. Owner only.
  ///
  /// [limit] defaults to 20 and is capped at 100.
  _ida.Future<_idopbith.EmployeeAccessPage> list(
    _isc.UuidValue buildingId, {
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<_idopbith.EmployeeAccessPage>(
    'employeeAccess',
    'list',
    {
      'buildingId': buildingId,
      'limit': limit,
      'offset': offset,
    },
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

  /// Ingredients for [buildingId], name order.
  ///
  /// Owner or assigned employee. [limit] defaults to 20 and is capped at 100.
  _ida.Future<_i5p5mc8n.IngredientPage> list(
    _isc.UuidValue buildingId, {
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<_i5p5mc8n.IngredientPage>(
    'ingredient',
    'list',
    {
      'buildingId': buildingId,
      'limit': limit,
      'offset': offset,
    },
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

  /// Categories for [buildingId], name order.
  ///
  /// Owner or assigned employee. [limit] defaults to 20 and is capped at 100.
  _ida.Future<_i48lt3pj.MenuCategoryPage> list(
    _isc.UuidValue buildingId, {
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<_i48lt3pj.MenuCategoryPage>(
    'menuCategory',
    'list',
    {
      'buildingId': buildingId,
      'limit': limit,
      'offset': offset,
    },
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

/// Customer orders. Staff status changes stay on [OrderEndpoint].
/// {@category Endpoint}
class EndpointCustomerOrder extends _isc.EndpointRef {
  EndpointCustomerOrder(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'customerOrder';

  /// Places an order for the signed-in customer at a scanned table.
  ///
  /// Prices and stock come from the venue menu. The caller must be a
  /// customer. A missing table, unknown dish, occupied table, or short
  /// stock throws [OrderException].
  _ida.Future<_iiy8950w.CustomerOrderView> place(
    _i5gpmr9n.CustomerOrderPlace request,
  ) => caller.callServerEndpoint<_iiy8950w.CustomerOrderView>(
    'customerOrder',
    'place',
    {'request': request},
  );

  /// Orders this customer placed between [from] and [to], newest first.
  ///
  /// Every venue is included. [from] is inclusive and [to] is exclusive.
  /// Another customer's orders are never returned. A reversed or oversized
  /// window throws [OrderException] / [OrderErrorCode.invalidInput].
  /// [limit] defaults to 20 and is capped at 100.
  _ida.Future<_iwuqnthl.CustomerOrderPage> list(
    DateTime from,
    DateTime to, {
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<_iwuqnthl.CustomerOrderPage>(
    'customerOrder',
    'list',
    {
      'from': from,
      'to': to,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Loads one order the signed-in customer placed.
  ///
  /// Another customer's order is [OrderErrorCode.notFound].
  _ida.Future<_iiy8950w.CustomerOrderView> get(_isc.UuidValue orderId) =>
      caller.callServerEndpoint<_iiy8950w.CustomerOrderView>(
        'customerOrder',
        'get',
        {'orderId': orderId},
      );

  /// The newest order this customer still has in progress, or null.
  ///
  /// Paid and cancelled orders are ignored. Another customer's order is
  /// never returned.
  _ida.Future<_iiy8950w.CustomerOrderView?> current() =>
      caller.callServerEndpoint<_iiy8950w.CustomerOrderView?>(
        'customerOrder',
        'current',
        {},
      );

  /// Adds dishes to this customer's open order.
  ///
  /// The order must still be in progress, and the venue must allow
  /// appending. Stock is deducted the same way as a new order. A missing
  /// or foreign order is [OrderErrorCode.notFound].
  _ida.Future<_iiy8950w.CustomerOrderView> append(
    _izdy5w2j.CustomerOrderAppend request,
  ) => caller.callServerEndpoint<_iiy8950w.CustomerOrderView>(
    'customerOrder',
    'append',
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
  /// [venueTableId] limits the page to one table, so a seat lookup does not
  /// depend on the floor page. [limit] defaults to 20 and is capped at 100.
  _ida.Future<_ith3f88l.OrderPage> list(
    _isc.UuidValue buildingId,
    _iqp2kjae.OrderStatus? status, {
    _isc.UuidValue? venueTableId,
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<_ith3f88l.OrderPage>(
    'order',
    'list',
    {
      'buildingId': buildingId,
      'status': status,
      'venueTableId': venueTableId,
      'limit': limit,
      'offset': offset,
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

/// Catalog of commercial packs. Writes are super-admin only.
/// {@category Endpoint}
class EndpointPack extends _isc.EndpointRef {
  EndpointPack(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pack';

  /// Packs, including private and disabled, sort order then name.
  ///
  /// Super admin only. [limit] defaults to 20 and is capped at 100.
  _ida.Future<_iv7y27qe.PackPage> list({
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<_iv7y27qe.PackPage>(
    'pack',
    'list',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  /// Enabled public packs for the apps. Any signed-in actor.
  _ida.Future<List<_ir1kads3.PackPublicView>> listPublic() =>
      caller.callServerEndpoint<List<_ir1kads3.PackPublicView>>(
        'pack',
        'listPublic',
        {},
      );

  /// Creates a pack. [PackCreate.code] is stored lowercase and must be unique.
  _ida.Future<_ihy1alcs.PackView> create(_iuhtf04l.PackCreate request) =>
      caller.callServerEndpoint<_ihy1alcs.PackView>(
        'pack',
        'create',
        {'request': request},
      );

  /// Updates prices, flags, and capabilities.
  _ida.Future<_ihy1alcs.PackView> update(_i8gbceh6.PackUpdate request) =>
      caller.callServerEndpoint<_ihy1alcs.PackView>(
        'pack',
        'update',
        {'request': request},
      );

  /// Deletes a pack that is not the system free plan and that no venue uses.
  _ida.Future<void> delete(_isc.UuidValue id) =>
      caller.callServerEndpoint<void>(
        'pack',
        'delete',
        {'id': id},
      );
}

/// Reservations for a venue. Staff, and customers booking themselves.
/// {@category Endpoint}
class EndpointReservation extends _isc.EndpointRef {
  EndpointReservation(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'reservation';

  /// Bookings whose start falls on the UTC date of [day].
  _ida.Future<List<_ixub33vy.ReservationView>> listForDay(
    _isc.UuidValue buildingId,
    DateTime day,
  ) => caller.callServerEndpoint<List<_ixub33vy.ReservationView>>(
    'reservation',
    'listForDay',
    {
      'buildingId': buildingId,
      'day': day,
    },
  );

  /// The signed-in customer's upcoming bookings.
  _ida.Future<List<_ixub33vy.ReservationView>> listMine() =>
      caller.callServerEndpoint<List<_ixub33vy.ReservationView>>(
        'reservation',
        'listMine',
        {},
      );

  /// Owner or employee with the reservations flag.
  ///
  /// The row is confirmed immediately and still needs a table.
  _ida.Future<_ixub33vy.ReservationView> create(
    _iq3meyhi.ReservationCreate request,
  ) => caller.callServerEndpoint<_ixub33vy.ReservationView>(
    'reservation',
    'create',
    {'request': request},
  );

  /// Customer asks for a time. Staff confirm it before a table is assigned.
  _ida.Future<_ixub33vy.ReservationView> createForCustomer(
    _iwv7rt7o.CustomerReservationCreate request,
  ) => caller.callServerEndpoint<_ixub33vy.ReservationView>(
    'reservation',
    'createForCustomer',
    {'request': request},
  );

  /// Accepts a customer request. Does not assign a table.
  _ida.Future<_ixub33vy.ReservationView> confirm(_isc.UuidValue id) =>
      caller.callServerEndpoint<_ixub33vy.ReservationView>(
        'reservation',
        'confirm',
        {'id': id},
      );

  /// Attaches tables to a confirmed reservation.
  _ida.Future<_ixub33vy.ReservationView> assignTables(
    _isc.UuidValue id,
    List<_isc.UuidValue> tableIds,
  ) => caller.callServerEndpoint<_ixub33vy.ReservationView>(
    'reservation',
    'assignTables',
    {
      'id': id,
      'tableIds': tableIds,
    },
  );

  /// Name or phone search for a staff booking. At most 20 rows.
  ///
  /// A query shorter than two characters returns an empty list.
  _ida.Future<List<_io69v53p.ReservationCustomerMatch>> searchCustomers(
    _isc.UuidValue buildingId,
    String query,
  ) => caller.callServerEndpoint<List<_io69v53p.ReservationCustomerMatch>>(
    'reservation',
    'searchCustomers',
    {
      'buildingId': buildingId,
      'query': query,
    },
  );

  /// Exact phone match so staff can attach an account instead of typing a guest.
  _ida.Future<_io69v53p.ReservationCustomerMatch> findCustomer(
    _isc.UuidValue buildingId,
    String phone,
  ) => caller.callServerEndpoint<_io69v53p.ReservationCustomerMatch>(
    'reservation',
    'findCustomer',
    {
      'buildingId': buildingId,
      'phone': phone,
    },
  );

  /// Cancels a request or a confirmed reservation that has not arrived.
  _ida.Future<_ixub33vy.ReservationView> cancel(_isc.UuidValue id) =>
      caller.callServerEndpoint<_ixub33vy.ReservationView>(
        'reservation',
        'cancel',
        {'id': id},
      );

  /// Scan confirmation: the holding booking on [tableId] becomes arrived.
  _ida.Future<_ixub33vy.ReservationView> confirmByTable(
    _isc.UuidValue buildingId,
    _isc.UuidValue tableId,
  ) => caller.callServerEndpoint<_ixub33vy.ReservationView>(
    'reservation',
    'confirmByTable',
    {
      'buildingId': buildingId,
      'tableId': tableId,
    },
  );
}

/// Platform totals for the backoffice. Super admin only.
/// {@category Endpoint}
class EndpointPlatformStats extends _isc.EndpointRef {
  EndpointPlatformStats(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'platformStats';

  /// Owners, venues, orders, monthly plan total, and public-pack adoption.
  _ida.Future<_i6db8rp3.PlatformStats> summary() =>
      caller.callServerEndpoint<_i6db8rp3.PlatformStats>(
        'platformStats',
        'summary',
        {},
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
    platformDirectory = EndpointPlatformDirectory(this);
    superAdminAuth = EndpointSuperAdminAuth(this);
    building = EndpointBuilding(this);
    customerPlace = EndpointCustomerPlace(this);
    customerVenue = EndpointCustomerVenue(this);
    employeeAccess = EndpointEmployeeAccess(this);
    articleComposition = EndpointArticleComposition(this);
    ingredient = EndpointIngredient(this);
    menuArticle = EndpointMenuArticle(this);
    menuCategory = EndpointMenuCategory(this);
    customerOrder = EndpointCustomerOrder(this);
    order = EndpointOrder(this);
    pack = EndpointPack(this);
    reservation = EndpointReservation(this);
    platformStats = EndpointPlatformStats(this);
    venueTable = EndpointVenueTable(this);
    modules = Modules(this);
  }

  late final EndpointCustomerAuth customerAuth;

  late final EndpointEmployeeAuth employeeAuth;

  late final EndpointEmployee employee;

  late final EndpointOwnerAuth ownerAuth;

  late final EndpointPlatformDirectory platformDirectory;

  late final EndpointSuperAdminAuth superAdminAuth;

  late final EndpointBuilding building;

  late final EndpointCustomerPlace customerPlace;

  late final EndpointCustomerVenue customerVenue;

  late final EndpointEmployeeAccess employeeAccess;

  late final EndpointArticleComposition articleComposition;

  late final EndpointIngredient ingredient;

  late final EndpointMenuArticle menuArticle;

  late final EndpointMenuCategory menuCategory;

  late final EndpointCustomerOrder customerOrder;

  late final EndpointOrder order;

  late final EndpointPack pack;

  late final EndpointReservation reservation;

  late final EndpointPlatformStats platformStats;

  late final EndpointVenueTable venueTable;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'customerAuth': customerAuth,
    'employeeAuth': employeeAuth,
    'employee': employee,
    'ownerAuth': ownerAuth,
    'platformDirectory': platformDirectory,
    'superAdminAuth': superAdminAuth,
    'building': building,
    'customerPlace': customerPlace,
    'customerVenue': customerVenue,
    'employeeAccess': employeeAccess,
    'articleComposition': articleComposition,
    'ingredient': ingredient,
    'menuArticle': menuArticle,
    'menuCategory': menuCategory,
    'customerOrder': customerOrder,
    'order': order,
    'pack': pack,
    'reservation': reservation,
    'platformStats': platformStats,
    'venueTable': venueTable,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
