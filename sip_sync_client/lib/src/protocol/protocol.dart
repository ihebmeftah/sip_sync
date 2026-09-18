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
import 'package:sip_sync_client/src/protocol/auth/employee_view.dart'
    as _ix96cplr;
import 'package:sip_sync_client/src/protocol/auth/super_admin_view.dart'
    as _iddpd7et;
import 'package:sip_sync_client/src/protocol/buildings/building_view.dart'
    as _ia8vsgay;
import 'package:sip_sync_client/src/protocol/tables/venue_table_view.dart'
    as _i6tmc6jw;
import 'auth/account_error_code.dart' as _i4a4wzkt;
import 'auth/account_exception.dart' as _ibhqro64;
import 'auth/actor_type.dart' as _i350eaix;
import 'auth/auth_token_result.dart' as _itpbqj0d;
import 'auth/customer_session_view.dart' as _i1o3zw63;
import 'auth/email_login_request.dart' as _ibs93nxz;
import 'auth/email_register_create.dart' as _i6a2khfu;
import 'auth/employee_create.dart' as _iedt4kib;
import 'auth/employee_session_view.dart' as _i4i3smcx;
import 'auth/employee_update.dart' as _iidaq8tj;
import 'auth/employee_view.dart' as _igp37ocx;
import 'auth/owner_session_view.dart' as _ijssep5h;
import 'auth/profile_update.dart' as _irdmlmfi;
import 'auth/super_admin_create.dart' as _iru1pmbh;
import 'auth/super_admin_session_view.dart' as _id5qrr5o;
import 'auth/super_admin_view.dart' as _ivpekvgb;
import 'auth/username_login_request.dart' as _imdgiusd;
import 'buildings/building_create.dart' as _i4cz4s4m;
import 'buildings/building_error_code.dart' as _isz6zhld;
import 'buildings/building_exception.dart' as _i7fakgop;
import 'buildings/building_update.dart' as _ivqpqa05;
import 'buildings/building_view.dart' as _iyqmhcrr;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'tables/table_floor_status.dart' as _issw8is0;
import 'tables/venue_table_create.dart' as _iwle9uzy;
import 'tables/venue_table_error_code.dart' as _igqdoyb7;
import 'tables/venue_table_exception.dart' as _iigq9ewv;
import 'tables/venue_table_update.dart' as _i04zcocb;
import 'tables/venue_table_view.dart' as _iu0tyr2r;
export 'auth/account_error_code.dart';
export 'auth/account_exception.dart';
export 'auth/actor_type.dart';
export 'auth/auth_token_result.dart';
export 'auth/customer_session_view.dart';
export 'auth/email_login_request.dart';
export 'auth/email_register_create.dart';
export 'auth/employee_create.dart';
export 'auth/employee_session_view.dart';
export 'auth/employee_update.dart';
export 'auth/employee_view.dart';
export 'auth/owner_session_view.dart';
export 'auth/profile_update.dart';
export 'auth/super_admin_create.dart';
export 'auth/super_admin_session_view.dart';
export 'auth/super_admin_view.dart';
export 'auth/username_login_request.dart';
export 'buildings/building_create.dart';
export 'buildings/building_error_code.dart';
export 'buildings/building_exception.dart';
export 'buildings/building_update.dart';
export 'buildings/building_view.dart';
export 'greetings/greeting.dart';
export 'tables/table_floor_status.dart';
export 'tables/venue_table_create.dart';
export 'tables/venue_table_error_code.dart';
export 'tables/venue_table_exception.dart';
export 'tables/venue_table_update.dart';
export 'tables/venue_table_view.dart';
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

    if (t == _i4a4wzkt.AccountErrorCode) {
      return _i4a4wzkt.AccountErrorCode.fromJson(data) as T;
    }
    if (t == _ibhqro64.AccountException) {
      return _ibhqro64.AccountException.fromJson(data) as T;
    }
    if (t == _i350eaix.ActorType) {
      return _i350eaix.ActorType.fromJson(data) as T;
    }
    if (t == _itpbqj0d.AuthTokenResult) {
      return _itpbqj0d.AuthTokenResult.fromJson(data) as T;
    }
    if (t == _i1o3zw63.CustomerSessionView) {
      return _i1o3zw63.CustomerSessionView.fromJson(data) as T;
    }
    if (t == _ibs93nxz.EmailLoginRequest) {
      return _ibs93nxz.EmailLoginRequest.fromJson(data) as T;
    }
    if (t == _i6a2khfu.EmailRegisterCreate) {
      return _i6a2khfu.EmailRegisterCreate.fromJson(data) as T;
    }
    if (t == _iedt4kib.EmployeeCreate) {
      return _iedt4kib.EmployeeCreate.fromJson(data) as T;
    }
    if (t == _i4i3smcx.EmployeeSessionView) {
      return _i4i3smcx.EmployeeSessionView.fromJson(data) as T;
    }
    if (t == _iidaq8tj.EmployeeUpdate) {
      return _iidaq8tj.EmployeeUpdate.fromJson(data) as T;
    }
    if (t == _igp37ocx.EmployeeView) {
      return _igp37ocx.EmployeeView.fromJson(data) as T;
    }
    if (t == _ijssep5h.OwnerSessionView) {
      return _ijssep5h.OwnerSessionView.fromJson(data) as T;
    }
    if (t == _irdmlmfi.ProfileUpdate) {
      return _irdmlmfi.ProfileUpdate.fromJson(data) as T;
    }
    if (t == _iru1pmbh.SuperAdminCreate) {
      return _iru1pmbh.SuperAdminCreate.fromJson(data) as T;
    }
    if (t == _id5qrr5o.SuperAdminSessionView) {
      return _id5qrr5o.SuperAdminSessionView.fromJson(data) as T;
    }
    if (t == _ivpekvgb.SuperAdminView) {
      return _ivpekvgb.SuperAdminView.fromJson(data) as T;
    }
    if (t == _imdgiusd.UsernameLoginRequest) {
      return _imdgiusd.UsernameLoginRequest.fromJson(data) as T;
    }
    if (t == _i4cz4s4m.BuildingCreate) {
      return _i4cz4s4m.BuildingCreate.fromJson(data) as T;
    }
    if (t == _isz6zhld.BuildingErrorCode) {
      return _isz6zhld.BuildingErrorCode.fromJson(data) as T;
    }
    if (t == _i7fakgop.BuildingException) {
      return _i7fakgop.BuildingException.fromJson(data) as T;
    }
    if (t == _ivqpqa05.BuildingUpdate) {
      return _ivqpqa05.BuildingUpdate.fromJson(data) as T;
    }
    if (t == _iyqmhcrr.BuildingView) {
      return _iyqmhcrr.BuildingView.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _issw8is0.TableFloorStatus) {
      return _issw8is0.TableFloorStatus.fromJson(data) as T;
    }
    if (t == _iwle9uzy.VenueTableCreate) {
      return _iwle9uzy.VenueTableCreate.fromJson(data) as T;
    }
    if (t == _igqdoyb7.VenueTableErrorCode) {
      return _igqdoyb7.VenueTableErrorCode.fromJson(data) as T;
    }
    if (t == _iigq9ewv.VenueTableException) {
      return _iigq9ewv.VenueTableException.fromJson(data) as T;
    }
    if (t == _i04zcocb.VenueTableUpdate) {
      return _i04zcocb.VenueTableUpdate.fromJson(data) as T;
    }
    if (t == _iu0tyr2r.VenueTableView) {
      return _iu0tyr2r.VenueTableView.fromJson(data) as T;
    }
    if (t == _isc.getType<_i4a4wzkt.AccountErrorCode?>()) {
      return (data != null ? _i4a4wzkt.AccountErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ibhqro64.AccountException?>()) {
      return (data != null ? _ibhqro64.AccountException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i350eaix.ActorType?>()) {
      return (data != null ? _i350eaix.ActorType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itpbqj0d.AuthTokenResult?>()) {
      return (data != null ? _itpbqj0d.AuthTokenResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1o3zw63.CustomerSessionView?>()) {
      return (data != null
              ? _i1o3zw63.CustomerSessionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ibs93nxz.EmailLoginRequest?>()) {
      return (data != null ? _ibs93nxz.EmailLoginRequest.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i6a2khfu.EmailRegisterCreate?>()) {
      return (data != null
              ? _i6a2khfu.EmailRegisterCreate.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iedt4kib.EmployeeCreate?>()) {
      return (data != null ? _iedt4kib.EmployeeCreate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i4i3smcx.EmployeeSessionView?>()) {
      return (data != null
              ? _i4i3smcx.EmployeeSessionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iidaq8tj.EmployeeUpdate?>()) {
      return (data != null ? _iidaq8tj.EmployeeUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_igp37ocx.EmployeeView?>()) {
      return (data != null ? _igp37ocx.EmployeeView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijssep5h.OwnerSessionView?>()) {
      return (data != null ? _ijssep5h.OwnerSessionView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_irdmlmfi.ProfileUpdate?>()) {
      return (data != null ? _irdmlmfi.ProfileUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iru1pmbh.SuperAdminCreate?>()) {
      return (data != null ? _iru1pmbh.SuperAdminCreate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_id5qrr5o.SuperAdminSessionView?>()) {
      return (data != null
              ? _id5qrr5o.SuperAdminSessionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ivpekvgb.SuperAdminView?>()) {
      return (data != null ? _ivpekvgb.SuperAdminView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_imdgiusd.UsernameLoginRequest?>()) {
      return (data != null
              ? _imdgiusd.UsernameLoginRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i4cz4s4m.BuildingCreate?>()) {
      return (data != null ? _i4cz4s4m.BuildingCreate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_isz6zhld.BuildingErrorCode?>()) {
      return (data != null ? _isz6zhld.BuildingErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i7fakgop.BuildingException?>()) {
      return (data != null ? _i7fakgop.BuildingException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivqpqa05.BuildingUpdate?>()) {
      return (data != null ? _ivqpqa05.BuildingUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iyqmhcrr.BuildingView?>()) {
      return (data != null ? _iyqmhcrr.BuildingView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_issw8is0.TableFloorStatus?>()) {
      return (data != null ? _issw8is0.TableFloorStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iwle9uzy.VenueTableCreate?>()) {
      return (data != null ? _iwle9uzy.VenueTableCreate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_igqdoyb7.VenueTableErrorCode?>()) {
      return (data != null
              ? _igqdoyb7.VenueTableErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iigq9ewv.VenueTableException?>()) {
      return (data != null
              ? _iigq9ewv.VenueTableException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i04zcocb.VenueTableUpdate?>()) {
      return (data != null ? _i04zcocb.VenueTableUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iu0tyr2r.VenueTableView?>()) {
      return (data != null ? _iu0tyr2r.VenueTableView.fromJson(data) : null)
          as T;
    }
    if (t == List<_isc.UuidValue>) {
      return (data as List).map((e) => deserialize<_isc.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_iddpd7et.SuperAdminView>) {
      return (data as List)
              .map((e) => deserialize<_iddpd7et.SuperAdminView>(e))
              .toList()
          as T;
    }
    if (t == List<_ia8vsgay.BuildingView>) {
      return (data as List)
              .map((e) => deserialize<_ia8vsgay.BuildingView>(e))
              .toList()
          as T;
    }
    if (t == List<_ix96cplr.EmployeeView>) {
      return (data as List)
              .map((e) => deserialize<_ix96cplr.EmployeeView>(e))
              .toList()
          as T;
    }
    if (t == List<_i6tmc6jw.VenueTableView>) {
      return (data as List)
              .map((e) => deserialize<_i6tmc6jw.VenueTableView>(e))
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
      _i4a4wzkt.AccountErrorCode => 'AccountErrorCode',
      _ibhqro64.AccountException => 'AccountException',
      _i350eaix.ActorType => 'ActorType',
      _itpbqj0d.AuthTokenResult => 'AuthTokenResult',
      _i1o3zw63.CustomerSessionView => 'CustomerSessionView',
      _ibs93nxz.EmailLoginRequest => 'EmailLoginRequest',
      _i6a2khfu.EmailRegisterCreate => 'EmailRegisterCreate',
      _iedt4kib.EmployeeCreate => 'EmployeeCreate',
      _i4i3smcx.EmployeeSessionView => 'EmployeeSessionView',
      _iidaq8tj.EmployeeUpdate => 'EmployeeUpdate',
      _igp37ocx.EmployeeView => 'EmployeeView',
      _ijssep5h.OwnerSessionView => 'OwnerSessionView',
      _irdmlmfi.ProfileUpdate => 'ProfileUpdate',
      _iru1pmbh.SuperAdminCreate => 'SuperAdminCreate',
      _id5qrr5o.SuperAdminSessionView => 'SuperAdminSessionView',
      _ivpekvgb.SuperAdminView => 'SuperAdminView',
      _imdgiusd.UsernameLoginRequest => 'UsernameLoginRequest',
      _i4cz4s4m.BuildingCreate => 'BuildingCreate',
      _isz6zhld.BuildingErrorCode => 'BuildingErrorCode',
      _i7fakgop.BuildingException => 'BuildingException',
      _ivqpqa05.BuildingUpdate => 'BuildingUpdate',
      _iyqmhcrr.BuildingView => 'BuildingView',
      _izw8z7ou.Greeting => 'Greeting',
      _issw8is0.TableFloorStatus => 'TableFloorStatus',
      _iwle9uzy.VenueTableCreate => 'VenueTableCreate',
      _igqdoyb7.VenueTableErrorCode => 'VenueTableErrorCode',
      _iigq9ewv.VenueTableException => 'VenueTableException',
      _i04zcocb.VenueTableUpdate => 'VenueTableUpdate',
      _iu0tyr2r.VenueTableView => 'VenueTableView',
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
      case _i4a4wzkt.AccountErrorCode():
        return 'AccountErrorCode';
      case _ibhqro64.AccountException():
        return 'AccountException';
      case _i350eaix.ActorType():
        return 'ActorType';
      case _itpbqj0d.AuthTokenResult():
        return 'AuthTokenResult';
      case _i1o3zw63.CustomerSessionView():
        return 'CustomerSessionView';
      case _ibs93nxz.EmailLoginRequest():
        return 'EmailLoginRequest';
      case _i6a2khfu.EmailRegisterCreate():
        return 'EmailRegisterCreate';
      case _iedt4kib.EmployeeCreate():
        return 'EmployeeCreate';
      case _i4i3smcx.EmployeeSessionView():
        return 'EmployeeSessionView';
      case _iidaq8tj.EmployeeUpdate():
        return 'EmployeeUpdate';
      case _igp37ocx.EmployeeView():
        return 'EmployeeView';
      case _ijssep5h.OwnerSessionView():
        return 'OwnerSessionView';
      case _irdmlmfi.ProfileUpdate():
        return 'ProfileUpdate';
      case _iru1pmbh.SuperAdminCreate():
        return 'SuperAdminCreate';
      case _id5qrr5o.SuperAdminSessionView():
        return 'SuperAdminSessionView';
      case _ivpekvgb.SuperAdminView():
        return 'SuperAdminView';
      case _imdgiusd.UsernameLoginRequest():
        return 'UsernameLoginRequest';
      case _i4cz4s4m.BuildingCreate():
        return 'BuildingCreate';
      case _isz6zhld.BuildingErrorCode():
        return 'BuildingErrorCode';
      case _i7fakgop.BuildingException():
        return 'BuildingException';
      case _ivqpqa05.BuildingUpdate():
        return 'BuildingUpdate';
      case _iyqmhcrr.BuildingView():
        return 'BuildingView';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _issw8is0.TableFloorStatus():
        return 'TableFloorStatus';
      case _iwle9uzy.VenueTableCreate():
        return 'VenueTableCreate';
      case _igqdoyb7.VenueTableErrorCode():
        return 'VenueTableErrorCode';
      case _iigq9ewv.VenueTableException():
        return 'VenueTableException';
      case _i04zcocb.VenueTableUpdate():
        return 'VenueTableUpdate';
      case _iu0tyr2r.VenueTableView():
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
      return deserialize<_i4a4wzkt.AccountErrorCode>(data['data']);
    }
    if (dataClassName == 'AccountException') {
      return deserialize<_ibhqro64.AccountException>(data['data']);
    }
    if (dataClassName == 'ActorType') {
      return deserialize<_i350eaix.ActorType>(data['data']);
    }
    if (dataClassName == 'AuthTokenResult') {
      return deserialize<_itpbqj0d.AuthTokenResult>(data['data']);
    }
    if (dataClassName == 'CustomerSessionView') {
      return deserialize<_i1o3zw63.CustomerSessionView>(data['data']);
    }
    if (dataClassName == 'EmailLoginRequest') {
      return deserialize<_ibs93nxz.EmailLoginRequest>(data['data']);
    }
    if (dataClassName == 'EmailRegisterCreate') {
      return deserialize<_i6a2khfu.EmailRegisterCreate>(data['data']);
    }
    if (dataClassName == 'EmployeeCreate') {
      return deserialize<_iedt4kib.EmployeeCreate>(data['data']);
    }
    if (dataClassName == 'EmployeeSessionView') {
      return deserialize<_i4i3smcx.EmployeeSessionView>(data['data']);
    }
    if (dataClassName == 'EmployeeUpdate') {
      return deserialize<_iidaq8tj.EmployeeUpdate>(data['data']);
    }
    if (dataClassName == 'EmployeeView') {
      return deserialize<_igp37ocx.EmployeeView>(data['data']);
    }
    if (dataClassName == 'OwnerSessionView') {
      return deserialize<_ijssep5h.OwnerSessionView>(data['data']);
    }
    if (dataClassName == 'ProfileUpdate') {
      return deserialize<_irdmlmfi.ProfileUpdate>(data['data']);
    }
    if (dataClassName == 'SuperAdminCreate') {
      return deserialize<_iru1pmbh.SuperAdminCreate>(data['data']);
    }
    if (dataClassName == 'SuperAdminSessionView') {
      return deserialize<_id5qrr5o.SuperAdminSessionView>(data['data']);
    }
    if (dataClassName == 'SuperAdminView') {
      return deserialize<_ivpekvgb.SuperAdminView>(data['data']);
    }
    if (dataClassName == 'UsernameLoginRequest') {
      return deserialize<_imdgiusd.UsernameLoginRequest>(data['data']);
    }
    if (dataClassName == 'BuildingCreate') {
      return deserialize<_i4cz4s4m.BuildingCreate>(data['data']);
    }
    if (dataClassName == 'BuildingErrorCode') {
      return deserialize<_isz6zhld.BuildingErrorCode>(data['data']);
    }
    if (dataClassName == 'BuildingException') {
      return deserialize<_i7fakgop.BuildingException>(data['data']);
    }
    if (dataClassName == 'BuildingUpdate') {
      return deserialize<_ivqpqa05.BuildingUpdate>(data['data']);
    }
    if (dataClassName == 'BuildingView') {
      return deserialize<_iyqmhcrr.BuildingView>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'TableFloorStatus') {
      return deserialize<_issw8is0.TableFloorStatus>(data['data']);
    }
    if (dataClassName == 'VenueTableCreate') {
      return deserialize<_iwle9uzy.VenueTableCreate>(data['data']);
    }
    if (dataClassName == 'VenueTableErrorCode') {
      return deserialize<_igqdoyb7.VenueTableErrorCode>(data['data']);
    }
    if (dataClassName == 'VenueTableException') {
      return deserialize<_iigq9ewv.VenueTableException>(data['data']);
    }
    if (dataClassName == 'VenueTableUpdate') {
      return deserialize<_i04zcocb.VenueTableUpdate>(data['data']);
    }
    if (dataClassName == 'VenueTableView') {
      return deserialize<_iu0tyr2r.VenueTableView>(data['data']);
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
