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
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:sip_sync_server/src/generated/auth/backoffice_user_view.dart'
    as _iea1ilrj;
import 'package:sip_sync_server/src/generated/auth/profile_view.dart'
    as _ilvz914s;
import 'auth/account_error_code.dart' as _i4a4wzkt;
import 'auth/account_exception.dart' as _ibhqro64;
import 'auth/account_session_view.dart' as _io80wa8m;
import 'auth/app_role.dart' as _i87vpzmk;
import 'auth/auth_session_result.dart' as _i9zpdl2u;
import 'auth/backoffice_staff.dart' as _iay10z7i;
import 'auth/backoffice_user_create.dart' as _i9kd7km5;
import 'auth/backoffice_user_view.dart' as _itl1aokg;
import 'auth/employee_create.dart' as _iedt4kib;
import 'auth/employee_record.dart' as _im6hyfbr;
import 'auth/login_request.dart' as _ir2e8vdz;
import 'auth/profile_update.dart' as _irdmlmfi;
import 'auth/profile_view.dart' as _iz95i0di;
import 'auth/self_register_create.dart' as _i90p781y;
import 'auth/sip_app.dart' as _iztspa7i;
import 'auth/sip_sync_profile.dart' as _iow4lxxs;
import 'auth/user_role_membership.dart' as _ilsup31p;
import 'greetings/greeting.dart' as _izw8z7ou;
export 'auth/account_error_code.dart';
export 'auth/account_exception.dart';
export 'auth/account_session_view.dart';
export 'auth/app_role.dart';
export 'auth/auth_session_result.dart';
export 'auth/backoffice_staff.dart';
export 'auth/backoffice_user_create.dart';
export 'auth/backoffice_user_view.dart';
export 'auth/employee_create.dart';
export 'auth/employee_record.dart';
export 'auth/login_request.dart';
export 'auth/profile_update.dart';
export 'auth/profile_view.dart';
export 'auth/self_register_create.dart';
export 'auth/sip_app.dart';
export 'auth/sip_sync_profile.dart';
export 'auth/user_role_membership.dart';
export 'greetings/greeting.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'backoffice_staff',
      dartName: 'BackofficeStaff',
      schema: 'public',
      module: 'sip_sync',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'isAdmin',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'isSystemDefault',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'backoffice_staff_fk_0',
          columns: ['authUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'backoffice_staff_auth_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'employee_record',
      dartName: 'EmployeeRecord',
      schema: 'public',
      module: 'sip_sync',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'ownerAuthUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'employee_record_fk_0',
          columns: ['authUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'employee_record_auth_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'employee_record_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerAuthUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'sip_sync_profile',
      dartName: 'SipSyncProfile',
      schema: 'public',
      module: 'sip_sync',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'username',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'phoneNumber',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'firstName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'lastName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'sip_sync_profile_fk_0',
          columns: ['authUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'sip_sync_profile_auth_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'sip_sync_profile_username_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'username',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'sip_sync_profile_email_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'sip_sync_profile_phone_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'phoneNumber',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'user_role_membership',
      dartName: 'UserRoleMembership',
      schema: 'public',
      module: 'sip_sync',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AppRole',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'user_role_membership_fk_0',
          columns: ['authUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'user_role_membership_auth_role_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'role',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

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
      } on _is.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _iay10z7i.BackofficeStaff) {
      return _iay10z7i.BackofficeStaff.fromJson(data) as T;
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
    if (t == _im6hyfbr.EmployeeRecord) {
      return _im6hyfbr.EmployeeRecord.fromJson(data) as T;
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
    if (t == _iow4lxxs.SipSyncProfile) {
      return _iow4lxxs.SipSyncProfile.fromJson(data) as T;
    }
    if (t == _ilsup31p.UserRoleMembership) {
      return _ilsup31p.UserRoleMembership.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _is.getType<_i4a4wzkt.AccountErrorCode?>()) {
      return (data != null ? _i4a4wzkt.AccountErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ibhqro64.AccountException?>()) {
      return (data != null ? _ibhqro64.AccountException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_io80wa8m.AccountSessionView?>()) {
      return (data != null ? _io80wa8m.AccountSessionView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i87vpzmk.AppRole?>()) {
      return (data != null ? _i87vpzmk.AppRole.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i9zpdl2u.AuthSessionResult?>()) {
      return (data != null ? _i9zpdl2u.AuthSessionResult.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iay10z7i.BackofficeStaff?>()) {
      return (data != null ? _iay10z7i.BackofficeStaff.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9kd7km5.BackofficeUserCreate?>()) {
      return (data != null
              ? _i9kd7km5.BackofficeUserCreate.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_itl1aokg.BackofficeUserView?>()) {
      return (data != null ? _itl1aokg.BackofficeUserView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iedt4kib.EmployeeCreate?>()) {
      return (data != null ? _iedt4kib.EmployeeCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_im6hyfbr.EmployeeRecord?>()) {
      return (data != null ? _im6hyfbr.EmployeeRecord.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ir2e8vdz.LoginRequest?>()) {
      return (data != null ? _ir2e8vdz.LoginRequest.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_irdmlmfi.ProfileUpdate?>()) {
      return (data != null ? _irdmlmfi.ProfileUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iz95i0di.ProfileView?>()) {
      return (data != null ? _iz95i0di.ProfileView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i90p781y.SelfRegisterCreate?>()) {
      return (data != null ? _i90p781y.SelfRegisterCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iztspa7i.SipApp?>()) {
      return (data != null ? _iztspa7i.SipApp.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iow4lxxs.SipSyncProfile?>()) {
      return (data != null ? _iow4lxxs.SipSyncProfile.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ilsup31p.UserRoleMembership?>()) {
      return (data != null ? _ilsup31p.UserRoleMembership.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ilvz914s.ProfileView>) {
      return (data as List)
              .map((e) => deserialize<_ilvz914s.ProfileView>(e))
              .toList()
          as T;
    }
    if (t == List<_iea1ilrj.BackofficeUserView>) {
      return (data as List)
              .map((e) => deserialize<_iea1ilrj.BackofficeUserView>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i4a4wzkt.AccountErrorCode => 'AccountErrorCode',
      _ibhqro64.AccountException => 'AccountException',
      _io80wa8m.AccountSessionView => 'AccountSessionView',
      _i87vpzmk.AppRole => 'AppRole',
      _i9zpdl2u.AuthSessionResult => 'AuthSessionResult',
      _iay10z7i.BackofficeStaff => 'BackofficeStaff',
      _i9kd7km5.BackofficeUserCreate => 'BackofficeUserCreate',
      _itl1aokg.BackofficeUserView => 'BackofficeUserView',
      _iedt4kib.EmployeeCreate => 'EmployeeCreate',
      _im6hyfbr.EmployeeRecord => 'EmployeeRecord',
      _ir2e8vdz.LoginRequest => 'LoginRequest',
      _irdmlmfi.ProfileUpdate => 'ProfileUpdate',
      _iz95i0di.ProfileView => 'ProfileView',
      _i90p781y.SelfRegisterCreate => 'SelfRegisterCreate',
      _iztspa7i.SipApp => 'SipApp',
      _iow4lxxs.SipSyncProfile => 'SipSyncProfile',
      _ilsup31p.UserRoleMembership => 'UserRoleMembership',
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
      case _iay10z7i.BackofficeStaff():
        return 'BackofficeStaff';
      case _i9kd7km5.BackofficeUserCreate():
        return 'BackofficeUserCreate';
      case _itl1aokg.BackofficeUserView():
        return 'BackofficeUserView';
      case _iedt4kib.EmployeeCreate():
        return 'EmployeeCreate';
      case _im6hyfbr.EmployeeRecord():
        return 'EmployeeRecord';
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
      case _iow4lxxs.SipSyncProfile():
        return 'SipSyncProfile';
      case _ilsup31p.UserRoleMembership():
        return 'UserRoleMembership';
      case _izw8z7ou.Greeting():
        return 'Greeting';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
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
    if (dataClassName == 'BackofficeStaff') {
      return deserialize<_iay10z7i.BackofficeStaff>(data['data']);
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
    if (dataClassName == 'EmployeeRecord') {
      return deserialize<_im6hyfbr.EmployeeRecord>(data['data']);
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
    if (dataClassName == 'SipSyncProfile') {
      return deserialize<_iow4lxxs.SipSyncProfile>(data['data']);
    }
    if (dataClassName == 'UserRoleMembership') {
      return deserialize<_ilsup31p.UserRoleMembership>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('sip_sync', this);
    _iacs.Protocol().registerHostProtocol('sip_sync', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _iay10z7i.BackofficeStaff:
        return _iay10z7i.BackofficeStaff.t;
      case _im6hyfbr.EmployeeRecord:
        return _im6hyfbr.EmployeeRecord.t;
      case _iow4lxxs.SipSyncProfile:
        return _iow4lxxs.SipSyncProfile.t;
      case _ilsup31p.UserRoleMembership:
        return _ilsup31p.UserRoleMembership.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

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
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
