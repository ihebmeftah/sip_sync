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
import 'package:sip_sync_client/src/protocol/auth/backoffice_user_view.dart'
    as _ian6jh4a;
import 'package:sip_sync_client/src/protocol/auth/profile_view.dart'
    as _i64758c0;
import 'auth/account_error_code.dart' as _i4a4wzkt;
import 'auth/account_exception.dart' as _ibhqro64;
import 'auth/account_session_view.dart' as _io80wa8m;
import 'auth/app_role.dart' as _i87vpzmk;
import 'auth/auth_session_result.dart' as _i9zpdl2u;
import 'auth/backoffice_user_create.dart' as _i9kd7km5;
import 'auth/backoffice_user_view.dart' as _itl1aokg;
import 'auth/employee_create.dart' as _iedt4kib;
import 'auth/login_request.dart' as _ir2e8vdz;
import 'auth/profile_update.dart' as _irdmlmfi;
import 'auth/profile_view.dart' as _iz95i0di;
import 'auth/self_register_create.dart' as _i90p781y;
import 'auth/sip_app.dart' as _iztspa7i;
import 'greetings/greeting.dart' as _izw8z7ou;
export 'auth/account_error_code.dart';
export 'auth/account_exception.dart';
export 'auth/account_session_view.dart';
export 'auth/app_role.dart';
export 'auth/auth_session_result.dart';
export 'auth/backoffice_user_create.dart';
export 'auth/backoffice_user_view.dart';
export 'auth/employee_create.dart';
export 'auth/login_request.dart';
export 'auth/profile_update.dart';
export 'auth/profile_view.dart';
export 'auth/self_register_create.dart';
export 'auth/sip_app.dart';
export 'greetings/greeting.dart';
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
    if (t == _io80wa8m.AccountSessionView) {
      return _io80wa8m.AccountSessionView.fromJson(data) as T;
    }
    if (t == _i87vpzmk.AppRole) {
      return _i87vpzmk.AppRole.fromJson(data) as T;
    }
    if (t == _i9zpdl2u.AuthSessionResult) {
      return _i9zpdl2u.AuthSessionResult.fromJson(data) as T;
    }
    if (t == _i9kd7km5.BackofficeUserCreate) {
      return _i9kd7km5.BackofficeUserCreate.fromJson(data) as T;
    }
    if (t == _itl1aokg.BackofficeUserView) {
      return _itl1aokg.BackofficeUserView.fromJson(data) as T;
    }
    if (t == _iedt4kib.EmployeeCreate) {
      return _iedt4kib.EmployeeCreate.fromJson(data) as T;
    }
    if (t == _ir2e8vdz.LoginRequest) {
      return _ir2e8vdz.LoginRequest.fromJson(data) as T;
    }
    if (t == _irdmlmfi.ProfileUpdate) {
      return _irdmlmfi.ProfileUpdate.fromJson(data) as T;
    }
    if (t == _iz95i0di.ProfileView) {
      return _iz95i0di.ProfileView.fromJson(data) as T;
    }
    if (t == _i90p781y.SelfRegisterCreate) {
      return _i90p781y.SelfRegisterCreate.fromJson(data) as T;
    }
    if (t == _iztspa7i.SipApp) {
      return _iztspa7i.SipApp.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _isc.getType<_i4a4wzkt.AccountErrorCode?>()) {
      return (data != null ? _i4a4wzkt.AccountErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ibhqro64.AccountException?>()) {
      return (data != null ? _ibhqro64.AccountException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_io80wa8m.AccountSessionView?>()) {
      return (data != null ? _io80wa8m.AccountSessionView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i87vpzmk.AppRole?>()) {
      return (data != null ? _i87vpzmk.AppRole.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i9zpdl2u.AuthSessionResult?>()) {
      return (data != null ? _i9zpdl2u.AuthSessionResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9kd7km5.BackofficeUserCreate?>()) {
      return (data != null
              ? _i9kd7km5.BackofficeUserCreate.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_itl1aokg.BackofficeUserView?>()) {
      return (data != null ? _itl1aokg.BackofficeUserView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iedt4kib.EmployeeCreate?>()) {
      return (data != null ? _iedt4kib.EmployeeCreate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ir2e8vdz.LoginRequest?>()) {
      return (data != null ? _ir2e8vdz.LoginRequest.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_irdmlmfi.ProfileUpdate?>()) {
      return (data != null ? _irdmlmfi.ProfileUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iz95i0di.ProfileView?>()) {
      return (data != null ? _iz95i0di.ProfileView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i90p781y.SelfRegisterCreate?>()) {
      return (data != null ? _i90p781y.SelfRegisterCreate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iztspa7i.SipApp?>()) {
      return (data != null ? _iztspa7i.SipApp.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i64758c0.ProfileView>) {
      return (data as List)
              .map((e) => deserialize<_i64758c0.ProfileView>(e))
              .toList()
          as T;
    }
    if (t == List<_ian6jh4a.BackofficeUserView>) {
      return (data as List)
              .map((e) => deserialize<_ian6jh4a.BackofficeUserView>(e))
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
      _io80wa8m.AccountSessionView => 'AccountSessionView',
      _i87vpzmk.AppRole => 'AppRole',
      _i9zpdl2u.AuthSessionResult => 'AuthSessionResult',
      _i9kd7km5.BackofficeUserCreate => 'BackofficeUserCreate',
      _itl1aokg.BackofficeUserView => 'BackofficeUserView',
      _iedt4kib.EmployeeCreate => 'EmployeeCreate',
      _ir2e8vdz.LoginRequest => 'LoginRequest',
      _irdmlmfi.ProfileUpdate => 'ProfileUpdate',
      _iz95i0di.ProfileView => 'ProfileView',
      _i90p781y.SelfRegisterCreate => 'SelfRegisterCreate',
      _iztspa7i.SipApp => 'SipApp',
      _izw8z7ou.Greeting => 'Greeting',
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
      case _io80wa8m.AccountSessionView():
        return 'AccountSessionView';
      case _i87vpzmk.AppRole():
        return 'AppRole';
      case _i9zpdl2u.AuthSessionResult():
        return 'AuthSessionResult';
      case _i9kd7km5.BackofficeUserCreate():
        return 'BackofficeUserCreate';
      case _itl1aokg.BackofficeUserView():
        return 'BackofficeUserView';
      case _iedt4kib.EmployeeCreate():
        return 'EmployeeCreate';
      case _ir2e8vdz.LoginRequest():
        return 'LoginRequest';
      case _irdmlmfi.ProfileUpdate():
        return 'ProfileUpdate';
      case _iz95i0di.ProfileView():
        return 'ProfileView';
      case _i90p781y.SelfRegisterCreate():
        return 'SelfRegisterCreate';
      case _iztspa7i.SipApp():
        return 'SipApp';
      case _izw8z7ou.Greeting():
        return 'Greeting';
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
    if (dataClassName == 'AccountSessionView') {
      return deserialize<_io80wa8m.AccountSessionView>(data['data']);
    }
    if (dataClassName == 'AppRole') {
      return deserialize<_i87vpzmk.AppRole>(data['data']);
    }
    if (dataClassName == 'AuthSessionResult') {
      return deserialize<_i9zpdl2u.AuthSessionResult>(data['data']);
    }
    if (dataClassName == 'BackofficeUserCreate') {
      return deserialize<_i9kd7km5.BackofficeUserCreate>(data['data']);
    }
    if (dataClassName == 'BackofficeUserView') {
      return deserialize<_itl1aokg.BackofficeUserView>(data['data']);
    }
    if (dataClassName == 'EmployeeCreate') {
      return deserialize<_iedt4kib.EmployeeCreate>(data['data']);
    }
    if (dataClassName == 'LoginRequest') {
      return deserialize<_ir2e8vdz.LoginRequest>(data['data']);
    }
    if (dataClassName == 'ProfileUpdate') {
      return deserialize<_irdmlmfi.ProfileUpdate>(data['data']);
    }
    if (dataClassName == 'ProfileView') {
      return deserialize<_iz95i0di.ProfileView>(data['data']);
    }
    if (dataClassName == 'SelfRegisterCreate') {
      return deserialize<_i90p781y.SelfRegisterCreate>(data['data']);
    }
    if (dataClassName == 'SipApp') {
      return deserialize<_iztspa7i.SipApp>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
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
