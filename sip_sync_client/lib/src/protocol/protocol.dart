/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:sip_sync_client/src/protocol/auth/dtos/employee_view.dart'
    as _iz70mzqw;
import 'package:sip_sync_client/src/protocol/auth/dtos/super_admin_view.dart'
    as _ia930tyq;
import 'package:sip_sync_client/src/protocol/buildings/dtos/building_view.dart'
    as _ik35q5v8;
import 'package:sip_sync_client/src/protocol/menu/dtos/article_composition_view.dart'
    as _ier7rmyd;
import 'package:sip_sync_client/src/protocol/menu/dtos/ingredient_view.dart'
    as _i25phy6n;
import 'package:sip_sync_client/src/protocol/menu/dtos/menu_article_view.dart'
    as _i8rrzffs;
import 'package:sip_sync_client/src/protocol/menu/dtos/menu_category_view.dart'
    as _i6z5knea;
import 'package:sip_sync_client/src/protocol/tables/dtos/venue_table_view.dart'
    as _ihz72ioq;
import 'auth/dtos/account_error_code.dart' as _ipvvun4w;
import 'auth/dtos/account_exception.dart' as _ivr1zpxc;
import 'auth/dtos/actor_type.dart' as _ik5d360v;
import 'auth/dtos/auth_token_result.dart' as _ihcr17cc;
import 'auth/dtos/customer_session_view.dart' as _ith71up9;
import 'auth/dtos/email_login_request.dart' as _ibcfczkm;
import 'auth/dtos/email_register_create.dart' as _iokpa1pa;
import 'auth/dtos/employee_create.dart' as _iubn3z7h;
import 'auth/dtos/employee_session_view.dart' as _i5opmp1h;
import 'auth/dtos/employee_update.dart' as _i08axu9z;
import 'auth/dtos/employee_view.dart' as _inacnd8t;
import 'auth/dtos/owner_session_view.dart' as _isqlfqk2;
import 'auth/dtos/profile_update.dart' as _iul4y12k;
import 'auth/dtos/super_admin_create.dart' as _ieisqlnm;
import 'auth/dtos/super_admin_session_view.dart' as _i4itilxd;
import 'auth/dtos/super_admin_view.dart' as _ima36n4q;
import 'auth/dtos/username_login_request.dart' as _i4npd3dl;
import 'buildings/dtos/building_create.dart' as _i8mj84pm;
import 'buildings/dtos/building_error_code.dart' as _ip56joo9;
import 'buildings/dtos/building_exception.dart' as _ihbyyehn;
import 'buildings/dtos/building_update.dart' as _irbupqdx;
import 'buildings/dtos/building_view.dart' as _i9ph7g7s;
import 'menu/dtos/article_composition_create.dart' as _i6nq3709;
import 'menu/dtos/article_composition_error_code.dart' as _ibkg9l4z;
import 'menu/dtos/article_composition_exception.dart' as _if82n88l;
import 'menu/dtos/article_composition_update.dart' as _ixk584py;
import 'menu/dtos/article_composition_view.dart' as _ibgf2aer;
import 'menu/dtos/ingredient_create.dart' as _ii1yylu5;
import 'menu/dtos/ingredient_error_code.dart' as _i7okswdu;
import 'menu/dtos/ingredient_exception.dart' as _i6yqbuhf;
import 'menu/dtos/ingredient_view.dart' as _i8smn6k1;
import 'menu/dtos/menu_article_create.dart' as _ilqdzk9u;
import 'menu/dtos/menu_article_error_code.dart' as _i5kcaxik;
import 'menu/dtos/menu_article_exception.dart' as _i2u77dvq;
import 'menu/dtos/menu_article_update.dart' as _i0z96yjp;
import 'menu/dtos/menu_article_view.dart' as _in0m6e44;
import 'menu/dtos/menu_category_create.dart' as _i3y2wlpl;
import 'menu/dtos/menu_category_error_code.dart' as _if8o71j1;
import 'menu/dtos/menu_category_exception.dart' as _idwl0wi8;
import 'menu/dtos/menu_category_update.dart' as _iu0xgttg;
import 'menu/dtos/menu_category_view.dart' as _igs74mgr;
import 'menu/dtos/units_type.dart' as _ipcoxh71;
import 'tables/dtos/table_floor_status.dart' as _i64byz7d;
import 'tables/dtos/venue_table_create.dart' as _iui9xd5q;
import 'tables/dtos/venue_table_error_code.dart' as _iqjhym86;
import 'tables/dtos/venue_table_exception.dart' as _iu19bhmp;
import 'tables/dtos/venue_table_update.dart' as _ie883ahu;
import 'tables/dtos/venue_table_view.dart' as _ifz0lfor;
export 'auth/dtos/account_error_code.dart';
export 'auth/dtos/account_exception.dart';
export 'auth/dtos/actor_type.dart';
export 'auth/dtos/auth_token_result.dart';
export 'auth/dtos/customer_session_view.dart';
export 'auth/dtos/email_login_request.dart';
export 'auth/dtos/email_register_create.dart';
export 'auth/dtos/employee_create.dart';
export 'auth/dtos/employee_session_view.dart';
export 'auth/dtos/employee_update.dart';
export 'auth/dtos/employee_view.dart';
export 'auth/dtos/owner_session_view.dart';
export 'auth/dtos/profile_update.dart';
export 'auth/dtos/super_admin_create.dart';
export 'auth/dtos/super_admin_session_view.dart';
export 'auth/dtos/super_admin_view.dart';
export 'auth/dtos/username_login_request.dart';
export 'buildings/dtos/building_create.dart';
export 'buildings/dtos/building_error_code.dart';
export 'buildings/dtos/building_exception.dart';
export 'buildings/dtos/building_update.dart';
export 'buildings/dtos/building_view.dart';
export 'menu/dtos/article_composition_create.dart';
export 'menu/dtos/article_composition_error_code.dart';
export 'menu/dtos/article_composition_exception.dart';
export 'menu/dtos/article_composition_update.dart';
export 'menu/dtos/article_composition_view.dart';
export 'menu/dtos/ingredient_create.dart';
export 'menu/dtos/ingredient_error_code.dart';
export 'menu/dtos/ingredient_exception.dart';
export 'menu/dtos/ingredient_view.dart';
export 'menu/dtos/menu_article_create.dart';
export 'menu/dtos/menu_article_error_code.dart';
export 'menu/dtos/menu_article_exception.dart';
export 'menu/dtos/menu_article_update.dart';
export 'menu/dtos/menu_article_view.dart';
export 'menu/dtos/menu_category_create.dart';
export 'menu/dtos/menu_category_error_code.dart';
export 'menu/dtos/menu_category_exception.dart';
export 'menu/dtos/menu_category_update.dart';
export 'menu/dtos/menu_category_view.dart';
export 'menu/dtos/units_type.dart';
export 'tables/dtos/table_floor_status.dart';
export 'tables/dtos/venue_table_create.dart';
export 'tables/dtos/venue_table_error_code.dart';
export 'tables/dtos/venue_table_exception.dart';
export 'tables/dtos/venue_table_update.dart';
export 'tables/dtos/venue_table_view.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ipvvun4w.AccountErrorCode) {
      return _ipvvun4w.AccountErrorCode.fromJson(data) as T;
    }
    if (t == _ivr1zpxc.AccountException) {
      return _ivr1zpxc.AccountException.fromJson(data) as T;
    }
    if (t == _ik5d360v.ActorType) {
      return _ik5d360v.ActorType.fromJson(data) as T;
    }
    if (t == _ihcr17cc.AuthTokenResult) {
      return _ihcr17cc.AuthTokenResult.fromJson(data) as T;
    }
    if (t == _ith71up9.CustomerSessionView) {
      return _ith71up9.CustomerSessionView.fromJson(data) as T;
    }
    if (t == _ibcfczkm.EmailLoginRequest) {
      return _ibcfczkm.EmailLoginRequest.fromJson(data) as T;
    }
    if (t == _iokpa1pa.EmailRegisterCreate) {
      return _iokpa1pa.EmailRegisterCreate.fromJson(data) as T;
    }
    if (t == _iubn3z7h.EmployeeCreate) {
      return _iubn3z7h.EmployeeCreate.fromJson(data) as T;
    }
    if (t == _i5opmp1h.EmployeeSessionView) {
      return _i5opmp1h.EmployeeSessionView.fromJson(data) as T;
    }
    if (t == _i08axu9z.EmployeeUpdate) {
      return _i08axu9z.EmployeeUpdate.fromJson(data) as T;
    }
    if (t == _inacnd8t.EmployeeView) {
      return _inacnd8t.EmployeeView.fromJson(data) as T;
    }
    if (t == _isqlfqk2.OwnerSessionView) {
      return _isqlfqk2.OwnerSessionView.fromJson(data) as T;
    }
    if (t == _iul4y12k.ProfileUpdate) {
      return _iul4y12k.ProfileUpdate.fromJson(data) as T;
    }
    if (t == _ieisqlnm.SuperAdminCreate) {
      return _ieisqlnm.SuperAdminCreate.fromJson(data) as T;
    }
    if (t == _i4itilxd.SuperAdminSessionView) {
      return _i4itilxd.SuperAdminSessionView.fromJson(data) as T;
    }
    if (t == _ima36n4q.SuperAdminView) {
      return _ima36n4q.SuperAdminView.fromJson(data) as T;
    }
    if (t == _i4npd3dl.UsernameLoginRequest) {
      return _i4npd3dl.UsernameLoginRequest.fromJson(data) as T;
    }
    if (t == _i8mj84pm.BuildingCreate) {
      return _i8mj84pm.BuildingCreate.fromJson(data) as T;
    }
    if (t == _ip56joo9.BuildingErrorCode) {
      return _ip56joo9.BuildingErrorCode.fromJson(data) as T;
    }
    if (t == _ihbyyehn.BuildingException) {
      return _ihbyyehn.BuildingException.fromJson(data) as T;
    }
    if (t == _irbupqdx.BuildingUpdate) {
      return _irbupqdx.BuildingUpdate.fromJson(data) as T;
    }
    if (t == _i9ph7g7s.BuildingView) {
      return _i9ph7g7s.BuildingView.fromJson(data) as T;
    }
    if (t == _i6nq3709.ArticleCompositionCreate) {
      return _i6nq3709.ArticleCompositionCreate.fromJson(data) as T;
    }
    if (t == _ibkg9l4z.ArticleCompositionErrorCode) {
      return _ibkg9l4z.ArticleCompositionErrorCode.fromJson(data) as T;
    }
    if (t == _if82n88l.ArticleCompositionException) {
      return _if82n88l.ArticleCompositionException.fromJson(data) as T;
    }
    if (t == _ixk584py.ArticleCompositionUpdate) {
      return _ixk584py.ArticleCompositionUpdate.fromJson(data) as T;
    }
    if (t == _ibgf2aer.ArticleCompositionView) {
      return _ibgf2aer.ArticleCompositionView.fromJson(data) as T;
    }
    if (t == _ii1yylu5.IngredientCreate) {
      return _ii1yylu5.IngredientCreate.fromJson(data) as T;
    }
    if (t == _i7okswdu.IngredientErrorCode) {
      return _i7okswdu.IngredientErrorCode.fromJson(data) as T;
    }
    if (t == _i6yqbuhf.IngredientException) {
      return _i6yqbuhf.IngredientException.fromJson(data) as T;
    }
    if (t == _i8smn6k1.IngredientView) {
      return _i8smn6k1.IngredientView.fromJson(data) as T;
    }
    if (t == _ilqdzk9u.MenuArticleCreate) {
      return _ilqdzk9u.MenuArticleCreate.fromJson(data) as T;
    }
    if (t == _i5kcaxik.MenuArticleErrorCode) {
      return _i5kcaxik.MenuArticleErrorCode.fromJson(data) as T;
    }
    if (t == _i2u77dvq.MenuArticleException) {
      return _i2u77dvq.MenuArticleException.fromJson(data) as T;
    }
    if (t == _i0z96yjp.MenuArticleUpdate) {
      return _i0z96yjp.MenuArticleUpdate.fromJson(data) as T;
    }
    if (t == _in0m6e44.MenuArticleView) {
      return _in0m6e44.MenuArticleView.fromJson(data) as T;
    }
    if (t == _i3y2wlpl.MenuCategoryCreate) {
      return _i3y2wlpl.MenuCategoryCreate.fromJson(data) as T;
    }
    if (t == _if8o71j1.MenuCategoryErrorCode) {
      return _if8o71j1.MenuCategoryErrorCode.fromJson(data) as T;
    }
    if (t == _idwl0wi8.MenuCategoryException) {
      return _idwl0wi8.MenuCategoryException.fromJson(data) as T;
    }
    if (t == _iu0xgttg.MenuCategoryUpdate) {
      return _iu0xgttg.MenuCategoryUpdate.fromJson(data) as T;
    }
    if (t == _igs74mgr.MenuCategoryView) {
      return _igs74mgr.MenuCategoryView.fromJson(data) as T;
    }
    if (t == _ipcoxh71.UnitsType) {
      return _ipcoxh71.UnitsType.fromJson(data) as T;
    }
    if (t == _i64byz7d.TableFloorStatus) {
      return _i64byz7d.TableFloorStatus.fromJson(data) as T;
    }
    if (t == _iui9xd5q.VenueTableCreate) {
      return _iui9xd5q.VenueTableCreate.fromJson(data) as T;
    }
    if (t == _iqjhym86.VenueTableErrorCode) {
      return _iqjhym86.VenueTableErrorCode.fromJson(data) as T;
    }
    if (t == _iu19bhmp.VenueTableException) {
      return _iu19bhmp.VenueTableException.fromJson(data) as T;
    }
    if (t == _ie883ahu.VenueTableUpdate) {
      return _ie883ahu.VenueTableUpdate.fromJson(data) as T;
    }
    if (t == _ifz0lfor.VenueTableView) {
      return _ifz0lfor.VenueTableView.fromJson(data) as T;
    }
    if (t == _isc.getType<_ipvvun4w.AccountErrorCode?>()) {
      return (data != null ? _ipvvun4w.AccountErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivr1zpxc.AccountException?>()) {
      return (data != null ? _ivr1zpxc.AccountException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ik5d360v.ActorType?>()) {
      return (data != null ? _ik5d360v.ActorType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ihcr17cc.AuthTokenResult?>()) {
      return (data != null ? _ihcr17cc.AuthTokenResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ith71up9.CustomerSessionView?>()) {
      return (data != null
              ? _ith71up9.CustomerSessionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ibcfczkm.EmailLoginRequest?>()) {
      return (data != null ? _ibcfczkm.EmailLoginRequest.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iokpa1pa.EmailRegisterCreate?>()) {
      return (data != null
              ? _iokpa1pa.EmailRegisterCreate.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iubn3z7h.EmployeeCreate?>()) {
      return (data != null ? _iubn3z7h.EmployeeCreate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i5opmp1h.EmployeeSessionView?>()) {
      return (data != null
              ? _i5opmp1h.EmployeeSessionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i08axu9z.EmployeeUpdate?>()) {
      return (data != null ? _i08axu9z.EmployeeUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_inacnd8t.EmployeeView?>()) {
      return (data != null ? _inacnd8t.EmployeeView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isqlfqk2.OwnerSessionView?>()) {
      return (data != null ? _isqlfqk2.OwnerSessionView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iul4y12k.ProfileUpdate?>()) {
      return (data != null ? _iul4y12k.ProfileUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ieisqlnm.SuperAdminCreate?>()) {
      return (data != null ? _ieisqlnm.SuperAdminCreate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i4itilxd.SuperAdminSessionView?>()) {
      return (data != null
              ? _i4itilxd.SuperAdminSessionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ima36n4q.SuperAdminView?>()) {
      return (data != null ? _ima36n4q.SuperAdminView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i4npd3dl.UsernameLoginRequest?>()) {
      return (data != null
              ? _i4npd3dl.UsernameLoginRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i8mj84pm.BuildingCreate?>()) {
      return (data != null ? _i8mj84pm.BuildingCreate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ip56joo9.BuildingErrorCode?>()) {
      return (data != null ? _ip56joo9.BuildingErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ihbyyehn.BuildingException?>()) {
      return (data != null ? _ihbyyehn.BuildingException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_irbupqdx.BuildingUpdate?>()) {
      return (data != null ? _irbupqdx.BuildingUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9ph7g7s.BuildingView?>()) {
      return (data != null ? _i9ph7g7s.BuildingView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i6nq3709.ArticleCompositionCreate?>()) {
      return (data != null
              ? _i6nq3709.ArticleCompositionCreate.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ibkg9l4z.ArticleCompositionErrorCode?>()) {
      return (data != null
              ? _ibkg9l4z.ArticleCompositionErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_if82n88l.ArticleCompositionException?>()) {
      return (data != null
              ? _if82n88l.ArticleCompositionException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ixk584py.ArticleCompositionUpdate?>()) {
      return (data != null
              ? _ixk584py.ArticleCompositionUpdate.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ibgf2aer.ArticleCompositionView?>()) {
      return (data != null
              ? _ibgf2aer.ArticleCompositionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ii1yylu5.IngredientCreate?>()) {
      return (data != null ? _ii1yylu5.IngredientCreate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i7okswdu.IngredientErrorCode?>()) {
      return (data != null
              ? _i7okswdu.IngredientErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i6yqbuhf.IngredientException?>()) {
      return (data != null
              ? _i6yqbuhf.IngredientException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i8smn6k1.IngredientView?>()) {
      return (data != null ? _i8smn6k1.IngredientView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ilqdzk9u.MenuArticleCreate?>()) {
      return (data != null ? _ilqdzk9u.MenuArticleCreate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i5kcaxik.MenuArticleErrorCode?>()) {
      return (data != null
              ? _i5kcaxik.MenuArticleErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i2u77dvq.MenuArticleException?>()) {
      return (data != null
              ? _i2u77dvq.MenuArticleException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i0z96yjp.MenuArticleUpdate?>()) {
      return (data != null ? _i0z96yjp.MenuArticleUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_in0m6e44.MenuArticleView?>()) {
      return (data != null ? _in0m6e44.MenuArticleView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i3y2wlpl.MenuCategoryCreate?>()) {
      return (data != null ? _i3y2wlpl.MenuCategoryCreate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_if8o71j1.MenuCategoryErrorCode?>()) {
      return (data != null
              ? _if8o71j1.MenuCategoryErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_idwl0wi8.MenuCategoryException?>()) {
      return (data != null
              ? _idwl0wi8.MenuCategoryException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iu0xgttg.MenuCategoryUpdate?>()) {
      return (data != null ? _iu0xgttg.MenuCategoryUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_igs74mgr.MenuCategoryView?>()) {
      return (data != null ? _igs74mgr.MenuCategoryView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ipcoxh71.UnitsType?>()) {
      return (data != null ? _ipcoxh71.UnitsType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i64byz7d.TableFloorStatus?>()) {
      return (data != null ? _i64byz7d.TableFloorStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iui9xd5q.VenueTableCreate?>()) {
      return (data != null ? _iui9xd5q.VenueTableCreate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iqjhym86.VenueTableErrorCode?>()) {
      return (data != null
              ? _iqjhym86.VenueTableErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iu19bhmp.VenueTableException?>()) {
      return (data != null
              ? _iu19bhmp.VenueTableException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ie883ahu.VenueTableUpdate?>()) {
      return (data != null ? _ie883ahu.VenueTableUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ifz0lfor.VenueTableView?>()) {
      return (data != null ? _ifz0lfor.VenueTableView.fromJson(data) : null)
          as T;
    }
    if (t == List<_isc.UuidValue>) {
      return (data as List).map((e) => deserialize<_isc.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_ia930tyq.SuperAdminView>) {
      return (data as List)
              .map((e) => deserialize<_ia930tyq.SuperAdminView>(e))
              .toList()
          as T;
    }
    if (t == List<_ik35q5v8.BuildingView>) {
      return (data as List)
              .map((e) => deserialize<_ik35q5v8.BuildingView>(e))
              .toList()
          as T;
    }
    if (t == List<_iz70mzqw.EmployeeView>) {
      return (data as List)
              .map((e) => deserialize<_iz70mzqw.EmployeeView>(e))
              .toList()
          as T;
    }
    if (t == List<_ier7rmyd.ArticleCompositionView>) {
      return (data as List)
              .map((e) => deserialize<_ier7rmyd.ArticleCompositionView>(e))
              .toList()
          as T;
    }
    if (t == List<_i25phy6n.IngredientView>) {
      return (data as List)
              .map((e) => deserialize<_i25phy6n.IngredientView>(e))
              .toList()
          as T;
    }
    if (t == List<_i8rrzffs.MenuArticleView>) {
      return (data as List)
              .map((e) => deserialize<_i8rrzffs.MenuArticleView>(e))
              .toList()
          as T;
    }
    if (t == List<_i6z5knea.MenuCategoryView>) {
      return (data as List)
              .map((e) => deserialize<_i6z5knea.MenuCategoryView>(e))
              .toList()
          as T;
    }
    if (t == List<_ihz72ioq.VenueTableView>) {
      return (data as List)
              .map((e) => deserialize<_ihz72ioq.VenueTableView>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ipvvun4w.AccountErrorCode => 'AccountErrorCode',
      _ivr1zpxc.AccountException => 'AccountException',
      _ik5d360v.ActorType => 'ActorType',
      _ihcr17cc.AuthTokenResult => 'AuthTokenResult',
      _ith71up9.CustomerSessionView => 'CustomerSessionView',
      _ibcfczkm.EmailLoginRequest => 'EmailLoginRequest',
      _iokpa1pa.EmailRegisterCreate => 'EmailRegisterCreate',
      _iubn3z7h.EmployeeCreate => 'EmployeeCreate',
      _i5opmp1h.EmployeeSessionView => 'EmployeeSessionView',
      _i08axu9z.EmployeeUpdate => 'EmployeeUpdate',
      _inacnd8t.EmployeeView => 'EmployeeView',
      _isqlfqk2.OwnerSessionView => 'OwnerSessionView',
      _iul4y12k.ProfileUpdate => 'ProfileUpdate',
      _ieisqlnm.SuperAdminCreate => 'SuperAdminCreate',
      _i4itilxd.SuperAdminSessionView => 'SuperAdminSessionView',
      _ima36n4q.SuperAdminView => 'SuperAdminView',
      _i4npd3dl.UsernameLoginRequest => 'UsernameLoginRequest',
      _i8mj84pm.BuildingCreate => 'BuildingCreate',
      _ip56joo9.BuildingErrorCode => 'BuildingErrorCode',
      _ihbyyehn.BuildingException => 'BuildingException',
      _irbupqdx.BuildingUpdate => 'BuildingUpdate',
      _i9ph7g7s.BuildingView => 'BuildingView',
      _i6nq3709.ArticleCompositionCreate => 'ArticleCompositionCreate',
      _ibkg9l4z.ArticleCompositionErrorCode => 'ArticleCompositionErrorCode',
      _if82n88l.ArticleCompositionException => 'ArticleCompositionException',
      _ixk584py.ArticleCompositionUpdate => 'ArticleCompositionUpdate',
      _ibgf2aer.ArticleCompositionView => 'ArticleCompositionView',
      _ii1yylu5.IngredientCreate => 'IngredientCreate',
      _i7okswdu.IngredientErrorCode => 'IngredientErrorCode',
      _i6yqbuhf.IngredientException => 'IngredientException',
      _i8smn6k1.IngredientView => 'IngredientView',
      _ilqdzk9u.MenuArticleCreate => 'MenuArticleCreate',
      _i5kcaxik.MenuArticleErrorCode => 'MenuArticleErrorCode',
      _i2u77dvq.MenuArticleException => 'MenuArticleException',
      _i0z96yjp.MenuArticleUpdate => 'MenuArticleUpdate',
      _in0m6e44.MenuArticleView => 'MenuArticleView',
      _i3y2wlpl.MenuCategoryCreate => 'MenuCategoryCreate',
      _if8o71j1.MenuCategoryErrorCode => 'MenuCategoryErrorCode',
      _idwl0wi8.MenuCategoryException => 'MenuCategoryException',
      _iu0xgttg.MenuCategoryUpdate => 'MenuCategoryUpdate',
      _igs74mgr.MenuCategoryView => 'MenuCategoryView',
      _ipcoxh71.UnitsType => 'UnitsType',
      _i64byz7d.TableFloorStatus => 'TableFloorStatus',
      _iui9xd5q.VenueTableCreate => 'VenueTableCreate',
      _iqjhym86.VenueTableErrorCode => 'VenueTableErrorCode',
      _iu19bhmp.VenueTableException => 'VenueTableException',
      _ie883ahu.VenueTableUpdate => 'VenueTableUpdate',
      _ifz0lfor.VenueTableView => 'VenueTableView',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('sip_sync.', '');
    }

    switch (data) {
      case _ipvvun4w.AccountErrorCode():
        return 'AccountErrorCode';
      case _ivr1zpxc.AccountException():
        return 'AccountException';
      case _ik5d360v.ActorType():
        return 'ActorType';
      case _ihcr17cc.AuthTokenResult():
        return 'AuthTokenResult';
      case _ith71up9.CustomerSessionView():
        return 'CustomerSessionView';
      case _ibcfczkm.EmailLoginRequest():
        return 'EmailLoginRequest';
      case _iokpa1pa.EmailRegisterCreate():
        return 'EmailRegisterCreate';
      case _iubn3z7h.EmployeeCreate():
        return 'EmployeeCreate';
      case _i5opmp1h.EmployeeSessionView():
        return 'EmployeeSessionView';
      case _i08axu9z.EmployeeUpdate():
        return 'EmployeeUpdate';
      case _inacnd8t.EmployeeView():
        return 'EmployeeView';
      case _isqlfqk2.OwnerSessionView():
        return 'OwnerSessionView';
      case _iul4y12k.ProfileUpdate():
        return 'ProfileUpdate';
      case _ieisqlnm.SuperAdminCreate():
        return 'SuperAdminCreate';
      case _i4itilxd.SuperAdminSessionView():
        return 'SuperAdminSessionView';
      case _ima36n4q.SuperAdminView():
        return 'SuperAdminView';
      case _i4npd3dl.UsernameLoginRequest():
        return 'UsernameLoginRequest';
      case _i8mj84pm.BuildingCreate():
        return 'BuildingCreate';
      case _ip56joo9.BuildingErrorCode():
        return 'BuildingErrorCode';
      case _ihbyyehn.BuildingException():
        return 'BuildingException';
      case _irbupqdx.BuildingUpdate():
        return 'BuildingUpdate';
      case _i9ph7g7s.BuildingView():
        return 'BuildingView';
      case _i6nq3709.ArticleCompositionCreate():
        return 'ArticleCompositionCreate';
      case _ibkg9l4z.ArticleCompositionErrorCode():
        return 'ArticleCompositionErrorCode';
      case _if82n88l.ArticleCompositionException():
        return 'ArticleCompositionException';
      case _ixk584py.ArticleCompositionUpdate():
        return 'ArticleCompositionUpdate';
      case _ibgf2aer.ArticleCompositionView():
        return 'ArticleCompositionView';
      case _ii1yylu5.IngredientCreate():
        return 'IngredientCreate';
      case _i7okswdu.IngredientErrorCode():
        return 'IngredientErrorCode';
      case _i6yqbuhf.IngredientException():
        return 'IngredientException';
      case _i8smn6k1.IngredientView():
        return 'IngredientView';
      case _ilqdzk9u.MenuArticleCreate():
        return 'MenuArticleCreate';
      case _i5kcaxik.MenuArticleErrorCode():
        return 'MenuArticleErrorCode';
      case _i2u77dvq.MenuArticleException():
        return 'MenuArticleException';
      case _i0z96yjp.MenuArticleUpdate():
        return 'MenuArticleUpdate';
      case _in0m6e44.MenuArticleView():
        return 'MenuArticleView';
      case _i3y2wlpl.MenuCategoryCreate():
        return 'MenuCategoryCreate';
      case _if8o71j1.MenuCategoryErrorCode():
        return 'MenuCategoryErrorCode';
      case _idwl0wi8.MenuCategoryException():
        return 'MenuCategoryException';
      case _iu0xgttg.MenuCategoryUpdate():
        return 'MenuCategoryUpdate';
      case _igs74mgr.MenuCategoryView():
        return 'MenuCategoryView';
      case _ipcoxh71.UnitsType():
        return 'UnitsType';
      case _i64byz7d.TableFloorStatus():
        return 'TableFloorStatus';
      case _iui9xd5q.VenueTableCreate():
        return 'VenueTableCreate';
      case _iqjhym86.VenueTableErrorCode():
        return 'VenueTableErrorCode';
      case _iu19bhmp.VenueTableException():
        return 'VenueTableException';
      case _ie883ahu.VenueTableUpdate():
        return 'VenueTableUpdate';
      case _ifz0lfor.VenueTableView():
        return 'VenueTableView';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AccountErrorCode') {
      return deserialize<_ipvvun4w.AccountErrorCode>(data['data']);
    }
    if (dataClassName == 'AccountException') {
      return deserialize<_ivr1zpxc.AccountException>(data['data']);
    }
    if (dataClassName == 'ActorType') {
      return deserialize<_ik5d360v.ActorType>(data['data']);
    }
    if (dataClassName == 'AuthTokenResult') {
      return deserialize<_ihcr17cc.AuthTokenResult>(data['data']);
    }
    if (dataClassName == 'CustomerSessionView') {
      return deserialize<_ith71up9.CustomerSessionView>(data['data']);
    }
    if (dataClassName == 'EmailLoginRequest') {
      return deserialize<_ibcfczkm.EmailLoginRequest>(data['data']);
    }
    if (dataClassName == 'EmailRegisterCreate') {
      return deserialize<_iokpa1pa.EmailRegisterCreate>(data['data']);
    }
    if (dataClassName == 'EmployeeCreate') {
      return deserialize<_iubn3z7h.EmployeeCreate>(data['data']);
    }
    if (dataClassName == 'EmployeeSessionView') {
      return deserialize<_i5opmp1h.EmployeeSessionView>(data['data']);
    }
    if (dataClassName == 'EmployeeUpdate') {
      return deserialize<_i08axu9z.EmployeeUpdate>(data['data']);
    }
    if (dataClassName == 'EmployeeView') {
      return deserialize<_inacnd8t.EmployeeView>(data['data']);
    }
    if (dataClassName == 'OwnerSessionView') {
      return deserialize<_isqlfqk2.OwnerSessionView>(data['data']);
    }
    if (dataClassName == 'ProfileUpdate') {
      return deserialize<_iul4y12k.ProfileUpdate>(data['data']);
    }
    if (dataClassName == 'SuperAdminCreate') {
      return deserialize<_ieisqlnm.SuperAdminCreate>(data['data']);
    }
    if (dataClassName == 'SuperAdminSessionView') {
      return deserialize<_i4itilxd.SuperAdminSessionView>(data['data']);
    }
    if (dataClassName == 'SuperAdminView') {
      return deserialize<_ima36n4q.SuperAdminView>(data['data']);
    }
    if (dataClassName == 'UsernameLoginRequest') {
      return deserialize<_i4npd3dl.UsernameLoginRequest>(data['data']);
    }
    if (dataClassName == 'BuildingCreate') {
      return deserialize<_i8mj84pm.BuildingCreate>(data['data']);
    }
    if (dataClassName == 'BuildingErrorCode') {
      return deserialize<_ip56joo9.BuildingErrorCode>(data['data']);
    }
    if (dataClassName == 'BuildingException') {
      return deserialize<_ihbyyehn.BuildingException>(data['data']);
    }
    if (dataClassName == 'BuildingUpdate') {
      return deserialize<_irbupqdx.BuildingUpdate>(data['data']);
    }
    if (dataClassName == 'BuildingView') {
      return deserialize<_i9ph7g7s.BuildingView>(data['data']);
    }
    if (dataClassName == 'ArticleCompositionCreate') {
      return deserialize<_i6nq3709.ArticleCompositionCreate>(data['data']);
    }
    if (dataClassName == 'ArticleCompositionErrorCode') {
      return deserialize<_ibkg9l4z.ArticleCompositionErrorCode>(data['data']);
    }
    if (dataClassName == 'ArticleCompositionException') {
      return deserialize<_if82n88l.ArticleCompositionException>(data['data']);
    }
    if (dataClassName == 'ArticleCompositionUpdate') {
      return deserialize<_ixk584py.ArticleCompositionUpdate>(data['data']);
    }
    if (dataClassName == 'ArticleCompositionView') {
      return deserialize<_ibgf2aer.ArticleCompositionView>(data['data']);
    }
    if (dataClassName == 'IngredientCreate') {
      return deserialize<_ii1yylu5.IngredientCreate>(data['data']);
    }
    if (dataClassName == 'IngredientErrorCode') {
      return deserialize<_i7okswdu.IngredientErrorCode>(data['data']);
    }
    if (dataClassName == 'IngredientException') {
      return deserialize<_i6yqbuhf.IngredientException>(data['data']);
    }
    if (dataClassName == 'IngredientView') {
      return deserialize<_i8smn6k1.IngredientView>(data['data']);
    }
    if (dataClassName == 'MenuArticleCreate') {
      return deserialize<_ilqdzk9u.MenuArticleCreate>(data['data']);
    }
    if (dataClassName == 'MenuArticleErrorCode') {
      return deserialize<_i5kcaxik.MenuArticleErrorCode>(data['data']);
    }
    if (dataClassName == 'MenuArticleException') {
      return deserialize<_i2u77dvq.MenuArticleException>(data['data']);
    }
    if (dataClassName == 'MenuArticleUpdate') {
      return deserialize<_i0z96yjp.MenuArticleUpdate>(data['data']);
    }
    if (dataClassName == 'MenuArticleView') {
      return deserialize<_in0m6e44.MenuArticleView>(data['data']);
    }
    if (dataClassName == 'MenuCategoryCreate') {
      return deserialize<_i3y2wlpl.MenuCategoryCreate>(data['data']);
    }
    if (dataClassName == 'MenuCategoryErrorCode') {
      return deserialize<_if8o71j1.MenuCategoryErrorCode>(data['data']);
    }
    if (dataClassName == 'MenuCategoryException') {
      return deserialize<_idwl0wi8.MenuCategoryException>(data['data']);
    }
    if (dataClassName == 'MenuCategoryUpdate') {
      return deserialize<_iu0xgttg.MenuCategoryUpdate>(data['data']);
    }
    if (dataClassName == 'MenuCategoryView') {
      return deserialize<_igs74mgr.MenuCategoryView>(data['data']);
    }
    if (dataClassName == 'UnitsType') {
      return deserialize<_ipcoxh71.UnitsType>(data['data']);
    }
    if (dataClassName == 'TableFloorStatus') {
      return deserialize<_i64byz7d.TableFloorStatus>(data['data']);
    }
    if (dataClassName == 'VenueTableCreate') {
      return deserialize<_iui9xd5q.VenueTableCreate>(data['data']);
    }
    if (dataClassName == 'VenueTableErrorCode') {
      return deserialize<_iqjhym86.VenueTableErrorCode>(data['data']);
    }
    if (dataClassName == 'VenueTableException') {
      return deserialize<_iu19bhmp.VenueTableException>(data['data']);
    }
    if (dataClassName == 'VenueTableUpdate') {
      return deserialize<_ie883ahu.VenueTableUpdate>(data['data']);
    }
    if (dataClassName == 'VenueTableView') {
      return deserialize<_ifz0lfor.VenueTableView>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('sip_sync', this);
    _iacc.Protocol().registerHostProtocol('sip_sync', this);
  }

  @override
  String getModuleName() => 'sip_sync';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
