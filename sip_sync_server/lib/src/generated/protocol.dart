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
import 'package:sip_sync_server/src/generated/auth/employee_view.dart'
    as _iusy412g;
import 'package:sip_sync_server/src/generated/auth/super_admin_view.dart'
    as _i3qefl0x;
import 'package:sip_sync_server/src/generated/buildings/building_view.dart'
    as _iughhy8g;
import 'package:sip_sync_server/src/generated/menu/menu_article_view.dart'
    as _ilv9ypte;
import 'package:sip_sync_server/src/generated/menu/menu_category_view.dart'
    as _iwilrax0;
import 'package:sip_sync_server/src/generated/tables/venue_table_view.dart'
    as _icmpx87d;
import 'auth/account_error_code.dart' as _i4a4wzkt;
import 'auth/account_exception.dart' as _ibhqro64;
import 'auth/actor_type.dart' as _i350eaix;
import 'auth/auth_session.dart' as _i9bd7h9s;
import 'auth/auth_token_result.dart' as _itpbqj0d;
import 'auth/customer.dart' as _i3o13w2y;
import 'auth/customer_session_view.dart' as _i1o3zw63;
import 'auth/email_login_request.dart' as _ibs93nxz;
import 'auth/email_register_create.dart' as _i6a2khfu;
import 'auth/employee.dart' as _iqh9awfy;
import 'auth/employee_create.dart' as _iedt4kib;
import 'auth/employee_session_view.dart' as _i4i3smcx;
import 'auth/employee_update.dart' as _iidaq8tj;
import 'auth/employee_view.dart' as _igp37ocx;
import 'auth/owner.dart' as _i21zwh9b;
import 'auth/owner_session_view.dart' as _ijssep5h;
import 'auth/profile_update.dart' as _irdmlmfi;
import 'auth/super_admin.dart' as _iyiwchf3;
import 'auth/super_admin_create.dart' as _iru1pmbh;
import 'auth/super_admin_session_view.dart' as _id5qrr5o;
import 'auth/super_admin_view.dart' as _ivpekvgb;
import 'auth/username_login_request.dart' as _imdgiusd;
import 'buildings/building.dart' as _i60s6nd2;
import 'buildings/building_create.dart' as _i4cz4s4m;
import 'buildings/building_error_code.dart' as _isz6zhld;
import 'buildings/building_exception.dart' as _i7fakgop;
import 'buildings/building_update.dart' as _ivqpqa05;
import 'buildings/building_view.dart' as _iyqmhcrr;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'menu/menu_article.dart' as _ip0o9c0i;
import 'menu/menu_article_create.dart' as _i7hj1jb2;
import 'menu/menu_article_error_code.dart' as _i46cm0v4;
import 'menu/menu_article_exception.dart' as _iwbmeh47;
import 'menu/menu_article_update.dart' as _iwetmqfn;
import 'menu/menu_article_view.dart' as _irzndnzc;
import 'menu/menu_category.dart' as _i7sxg44v;
import 'menu/menu_category_create.dart' as _i8xl75s4;
import 'menu/menu_category_error_code.dart' as _ifc6ty9l;
import 'menu/menu_category_exception.dart' as _ikojmx8s;
import 'menu/menu_category_update.dart' as _i152aql3;
import 'menu/menu_category_view.dart' as _i9ogfgfu;
import 'tables/table_floor_status.dart' as _issw8is0;
import 'tables/venue_table.dart' as _i4t52k6g;
import 'tables/venue_table_create.dart' as _iwle9uzy;
import 'tables/venue_table_error_code.dart' as _igqdoyb7;
import 'tables/venue_table_exception.dart' as _iigq9ewv;
import 'tables/venue_table_update.dart' as _i04zcocb;
import 'tables/venue_table_view.dart' as _iu0tyr2r;
export 'auth/account_error_code.dart';
export 'auth/account_exception.dart';
export 'auth/actor_type.dart';
export 'auth/auth_session.dart';
export 'auth/auth_token_result.dart';
export 'auth/customer.dart';
export 'auth/customer_session_view.dart';
export 'auth/email_login_request.dart';
export 'auth/email_register_create.dart';
export 'auth/employee.dart';
export 'auth/employee_create.dart';
export 'auth/employee_session_view.dart';
export 'auth/employee_update.dart';
export 'auth/employee_view.dart';
export 'auth/owner.dart';
export 'auth/owner_session_view.dart';
export 'auth/profile_update.dart';
export 'auth/super_admin.dart';
export 'auth/super_admin_create.dart';
export 'auth/super_admin_session_view.dart';
export 'auth/super_admin_view.dart';
export 'auth/username_login_request.dart';
export 'buildings/building.dart';
export 'buildings/building_create.dart';
export 'buildings/building_error_code.dart';
export 'buildings/building_exception.dart';
export 'buildings/building_update.dart';
export 'buildings/building_view.dart';
export 'greetings/greeting.dart';
export 'menu/menu_article.dart';
export 'menu/menu_article_create.dart';
export 'menu/menu_article_error_code.dart';
export 'menu/menu_article_exception.dart';
export 'menu/menu_article_update.dart';
export 'menu/menu_article_view.dart';
export 'menu/menu_category.dart';
export 'menu/menu_category_create.dart';
export 'menu/menu_category_error_code.dart';
export 'menu/menu_category_exception.dart';
export 'menu/menu_category_update.dart';
export 'menu/menu_category_view.dart';
export 'tables/table_floor_status.dart';
export 'tables/venue_table.dart';
export 'tables/venue_table_create.dart';
export 'tables/venue_table_error_code.dart';
export 'tables/venue_table_exception.dart';
export 'tables/venue_table_update.dart';
export 'tables/venue_table_view.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'auth_session',
      dartName: 'AuthSession',
      schema: 'public',
      module: 'sip_sync',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'actorType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ActorType',
        ),
        _isp.ColumnDefinition(
          name: 'actorId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'tokenHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'refreshTokenHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'auth_session_token_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'tokenHash',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'auth_session_refresh_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'refreshTokenHash',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'auth_session_actor_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'actorType',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'actorId',
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
      name: 'building',
      dartName: 'Building',
      schema: 'public',
      module: 'sip_sync',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'address',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'latitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'longitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'openingMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'closingMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'currencyCode',
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
          constraintName: 'building_fk_0',
          columns: ['ownerId'],
          referenceTable: 'owner',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'building_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
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
      name: 'customer',
      dartName: 'Customer',
      schema: 'public',
      module: 'sip_sync',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
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
          name: 'passwordHash',
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
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'customer_email_idx',
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
          indexName: 'customer_phone_idx',
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
      name: 'employee',
      dartName: 'Employee',
      schema: 'public',
      module: 'sip_sync',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'buildingId',
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
          name: 'passwordHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'isEnabled',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
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
          constraintName: 'employee_fk_0',
          columns: ['ownerId'],
          referenceTable: 'owner',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'employee_fk_1',
          columns: ['buildingId'],
          referenceTable: 'building',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'employee_username_idx',
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
          indexName: 'employee_phone_idx',
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
        _isp.IndexDefinition(
          indexName: 'employee_building_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'buildingId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'employee_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
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
      name: 'menu_article',
      dartName: 'MenuArticle',
      schema: 'public',
      module: 'sip_sync',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'buildingId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'categoryId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'price',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
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
          constraintName: 'menu_article_fk_0',
          columns: ['buildingId'],
          referenceTable: 'building',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'menu_article_fk_1',
          columns: ['categoryId'],
          referenceTable: 'menu_category',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'menu_article_building_name_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'buildingId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'menu_article_building_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'buildingId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'menu_article_category_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'categoryId',
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
      name: 'menu_category',
      dartName: 'MenuCategory',
      schema: 'public',
      module: 'sip_sync',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'buildingId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
          constraintName: 'menu_category_fk_0',
          columns: ['buildingId'],
          referenceTable: 'building',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'menu_category_building_name_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'buildingId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'menu_category_building_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'buildingId',
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
      name: 'owner',
      dartName: 'Owner',
      schema: 'public',
      module: 'sip_sync',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
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
          name: 'passwordHash',
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
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'owner_email_idx',
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
          indexName: 'owner_phone_idx',
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
      name: 'super_admin',
      dartName: 'SuperAdmin',
      schema: 'public',
      module: 'sip_sync',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
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
          name: 'passwordHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'isSystemDefault',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'super_admin_email_idx',
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
          indexName: 'super_admin_phone_idx',
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
      name: 'venue_table',
      dartName: 'VenueTable',
      schema: 'public',
      module: 'sip_sync',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'buildingId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'number',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'maxSeats',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'isActive',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
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
          constraintName: 'venue_table_fk_0',
          columns: ['buildingId'],
          referenceTable: 'building',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'venue_table_building_number_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'buildingId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'number',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'venue_table_building_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'buildingId',
            ),
          ],
          type: 'btree',
          isUnique: false,
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
    if (t == _i350eaix.ActorType) {
      return _i350eaix.ActorType.fromJson(data) as T;
    }
    if (t == _i9bd7h9s.AuthSession) {
      return _i9bd7h9s.AuthSession.fromJson(data) as T;
    }
    if (t == _itpbqj0d.AuthTokenResult) {
      return _itpbqj0d.AuthTokenResult.fromJson(data) as T;
    }
    if (t == _i3o13w2y.Customer) {
      return _i3o13w2y.Customer.fromJson(data) as T;
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
    if (t == _iqh9awfy.Employee) {
      return _iqh9awfy.Employee.fromJson(data) as T;
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
    if (t == _i21zwh9b.Owner) {
      return _i21zwh9b.Owner.fromJson(data) as T;
    }
    if (t == _ijssep5h.OwnerSessionView) {
      return _ijssep5h.OwnerSessionView.fromJson(data) as T;
    }
    if (t == _irdmlmfi.ProfileUpdate) {
      return _irdmlmfi.ProfileUpdate.fromJson(data) as T;
    }
    if (t == _iyiwchf3.SuperAdmin) {
      return _iyiwchf3.SuperAdmin.fromJson(data) as T;
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
    if (t == _i60s6nd2.Building) {
      return _i60s6nd2.Building.fromJson(data) as T;
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
    if (t == _ip0o9c0i.MenuArticle) {
      return _ip0o9c0i.MenuArticle.fromJson(data) as T;
    }
    if (t == _i7hj1jb2.MenuArticleCreate) {
      return _i7hj1jb2.MenuArticleCreate.fromJson(data) as T;
    }
    if (t == _i46cm0v4.MenuArticleErrorCode) {
      return _i46cm0v4.MenuArticleErrorCode.fromJson(data) as T;
    }
    if (t == _iwbmeh47.MenuArticleException) {
      return _iwbmeh47.MenuArticleException.fromJson(data) as T;
    }
    if (t == _iwetmqfn.MenuArticleUpdate) {
      return _iwetmqfn.MenuArticleUpdate.fromJson(data) as T;
    }
    if (t == _irzndnzc.MenuArticleView) {
      return _irzndnzc.MenuArticleView.fromJson(data) as T;
    }
    if (t == _i7sxg44v.MenuCategory) {
      return _i7sxg44v.MenuCategory.fromJson(data) as T;
    }
    if (t == _i8xl75s4.MenuCategoryCreate) {
      return _i8xl75s4.MenuCategoryCreate.fromJson(data) as T;
    }
    if (t == _ifc6ty9l.MenuCategoryErrorCode) {
      return _ifc6ty9l.MenuCategoryErrorCode.fromJson(data) as T;
    }
    if (t == _ikojmx8s.MenuCategoryException) {
      return _ikojmx8s.MenuCategoryException.fromJson(data) as T;
    }
    if (t == _i152aql3.MenuCategoryUpdate) {
      return _i152aql3.MenuCategoryUpdate.fromJson(data) as T;
    }
    if (t == _i9ogfgfu.MenuCategoryView) {
      return _i9ogfgfu.MenuCategoryView.fromJson(data) as T;
    }
    if (t == _issw8is0.TableFloorStatus) {
      return _issw8is0.TableFloorStatus.fromJson(data) as T;
    }
    if (t == _i4t52k6g.VenueTable) {
      return _i4t52k6g.VenueTable.fromJson(data) as T;
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
    if (t == _is.getType<_i4a4wzkt.AccountErrorCode?>()) {
      return (data != null ? _i4a4wzkt.AccountErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ibhqro64.AccountException?>()) {
      return (data != null ? _ibhqro64.AccountException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i350eaix.ActorType?>()) {
      return (data != null ? _i350eaix.ActorType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i9bd7h9s.AuthSession?>()) {
      return (data != null ? _i9bd7h9s.AuthSession.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_itpbqj0d.AuthTokenResult?>()) {
      return (data != null ? _itpbqj0d.AuthTokenResult.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i3o13w2y.Customer?>()) {
      return (data != null ? _i3o13w2y.Customer.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i1o3zw63.CustomerSessionView?>()) {
      return (data != null
              ? _i1o3zw63.CustomerSessionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ibs93nxz.EmailLoginRequest?>()) {
      return (data != null ? _ibs93nxz.EmailLoginRequest.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i6a2khfu.EmailRegisterCreate?>()) {
      return (data != null
              ? _i6a2khfu.EmailRegisterCreate.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iqh9awfy.Employee?>()) {
      return (data != null ? _iqh9awfy.Employee.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iedt4kib.EmployeeCreate?>()) {
      return (data != null ? _iedt4kib.EmployeeCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i4i3smcx.EmployeeSessionView?>()) {
      return (data != null
              ? _i4i3smcx.EmployeeSessionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iidaq8tj.EmployeeUpdate?>()) {
      return (data != null ? _iidaq8tj.EmployeeUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_igp37ocx.EmployeeView?>()) {
      return (data != null ? _igp37ocx.EmployeeView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i21zwh9b.Owner?>()) {
      return (data != null ? _i21zwh9b.Owner.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ijssep5h.OwnerSessionView?>()) {
      return (data != null ? _ijssep5h.OwnerSessionView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_irdmlmfi.ProfileUpdate?>()) {
      return (data != null ? _irdmlmfi.ProfileUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iyiwchf3.SuperAdmin?>()) {
      return (data != null ? _iyiwchf3.SuperAdmin.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iru1pmbh.SuperAdminCreate?>()) {
      return (data != null ? _iru1pmbh.SuperAdminCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_id5qrr5o.SuperAdminSessionView?>()) {
      return (data != null
              ? _id5qrr5o.SuperAdminSessionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ivpekvgb.SuperAdminView?>()) {
      return (data != null ? _ivpekvgb.SuperAdminView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_imdgiusd.UsernameLoginRequest?>()) {
      return (data != null
              ? _imdgiusd.UsernameLoginRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i60s6nd2.Building?>()) {
      return (data != null ? _i60s6nd2.Building.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i4cz4s4m.BuildingCreate?>()) {
      return (data != null ? _i4cz4s4m.BuildingCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_isz6zhld.BuildingErrorCode?>()) {
      return (data != null ? _isz6zhld.BuildingErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i7fakgop.BuildingException?>()) {
      return (data != null ? _i7fakgop.BuildingException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ivqpqa05.BuildingUpdate?>()) {
      return (data != null ? _ivqpqa05.BuildingUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iyqmhcrr.BuildingView?>()) {
      return (data != null ? _iyqmhcrr.BuildingView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ip0o9c0i.MenuArticle?>()) {
      return (data != null ? _ip0o9c0i.MenuArticle.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7hj1jb2.MenuArticleCreate?>()) {
      return (data != null ? _i7hj1jb2.MenuArticleCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i46cm0v4.MenuArticleErrorCode?>()) {
      return (data != null
              ? _i46cm0v4.MenuArticleErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iwbmeh47.MenuArticleException?>()) {
      return (data != null
              ? _iwbmeh47.MenuArticleException.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iwetmqfn.MenuArticleUpdate?>()) {
      return (data != null ? _iwetmqfn.MenuArticleUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_irzndnzc.MenuArticleView?>()) {
      return (data != null ? _irzndnzc.MenuArticleView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i7sxg44v.MenuCategory?>()) {
      return (data != null ? _i7sxg44v.MenuCategory.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8xl75s4.MenuCategoryCreate?>()) {
      return (data != null ? _i8xl75s4.MenuCategoryCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ifc6ty9l.MenuCategoryErrorCode?>()) {
      return (data != null
              ? _ifc6ty9l.MenuCategoryErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ikojmx8s.MenuCategoryException?>()) {
      return (data != null
              ? _ikojmx8s.MenuCategoryException.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i152aql3.MenuCategoryUpdate?>()) {
      return (data != null ? _i152aql3.MenuCategoryUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9ogfgfu.MenuCategoryView?>()) {
      return (data != null ? _i9ogfgfu.MenuCategoryView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_issw8is0.TableFloorStatus?>()) {
      return (data != null ? _issw8is0.TableFloorStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i4t52k6g.VenueTable?>()) {
      return (data != null ? _i4t52k6g.VenueTable.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwle9uzy.VenueTableCreate?>()) {
      return (data != null ? _iwle9uzy.VenueTableCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_igqdoyb7.VenueTableErrorCode?>()) {
      return (data != null
              ? _igqdoyb7.VenueTableErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iigq9ewv.VenueTableException?>()) {
      return (data != null
              ? _iigq9ewv.VenueTableException.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i04zcocb.VenueTableUpdate?>()) {
      return (data != null ? _i04zcocb.VenueTableUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iu0tyr2r.VenueTableView?>()) {
      return (data != null ? _iu0tyr2r.VenueTableView.fromJson(data) : null)
          as T;
    }
    if (t == List<_i60s6nd2.Building>) {
      return (data as List)
              .map((e) => deserialize<_i60s6nd2.Building>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_i60s6nd2.Building>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i60s6nd2.Building>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iqh9awfy.Employee>) {
      return (data as List)
              .map((e) => deserialize<_iqh9awfy.Employee>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_iqh9awfy.Employee>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iqh9awfy.Employee>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i4t52k6g.VenueTable>) {
      return (data as List)
              .map((e) => deserialize<_i4t52k6g.VenueTable>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_i4t52k6g.VenueTable>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i4t52k6g.VenueTable>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i7sxg44v.MenuCategory>) {
      return (data as List)
              .map((e) => deserialize<_i7sxg44v.MenuCategory>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_i7sxg44v.MenuCategory>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i7sxg44v.MenuCategory>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ip0o9c0i.MenuArticle>) {
      return (data as List)
              .map((e) => deserialize<_ip0o9c0i.MenuArticle>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_ip0o9c0i.MenuArticle>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ip0o9c0i.MenuArticle>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_is.UuidValue>) {
      return (data as List).map((e) => deserialize<_is.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_i3qefl0x.SuperAdminView>) {
      return (data as List)
              .map((e) => deserialize<_i3qefl0x.SuperAdminView>(e))
              .toList()
          as T;
    }
    if (t == List<_iughhy8g.BuildingView>) {
      return (data as List)
              .map((e) => deserialize<_iughhy8g.BuildingView>(e))
              .toList()
          as T;
    }
    if (t == List<_iusy412g.EmployeeView>) {
      return (data as List)
              .map((e) => deserialize<_iusy412g.EmployeeView>(e))
              .toList()
          as T;
    }
    if (t == List<_ilv9ypte.MenuArticleView>) {
      return (data as List)
              .map((e) => deserialize<_ilv9ypte.MenuArticleView>(e))
              .toList()
          as T;
    }
    if (t == List<_iwilrax0.MenuCategoryView>) {
      return (data as List)
              .map((e) => deserialize<_iwilrax0.MenuCategoryView>(e))
              .toList()
          as T;
    }
    if (t == List<_icmpx87d.VenueTableView>) {
      return (data as List)
              .map((e) => deserialize<_icmpx87d.VenueTableView>(e))
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
      _i350eaix.ActorType => 'ActorType',
      _i9bd7h9s.AuthSession => 'AuthSession',
      _itpbqj0d.AuthTokenResult => 'AuthTokenResult',
      _i3o13w2y.Customer => 'Customer',
      _i1o3zw63.CustomerSessionView => 'CustomerSessionView',
      _ibs93nxz.EmailLoginRequest => 'EmailLoginRequest',
      _i6a2khfu.EmailRegisterCreate => 'EmailRegisterCreate',
      _iqh9awfy.Employee => 'Employee',
      _iedt4kib.EmployeeCreate => 'EmployeeCreate',
      _i4i3smcx.EmployeeSessionView => 'EmployeeSessionView',
      _iidaq8tj.EmployeeUpdate => 'EmployeeUpdate',
      _igp37ocx.EmployeeView => 'EmployeeView',
      _i21zwh9b.Owner => 'Owner',
      _ijssep5h.OwnerSessionView => 'OwnerSessionView',
      _irdmlmfi.ProfileUpdate => 'ProfileUpdate',
      _iyiwchf3.SuperAdmin => 'SuperAdmin',
      _iru1pmbh.SuperAdminCreate => 'SuperAdminCreate',
      _id5qrr5o.SuperAdminSessionView => 'SuperAdminSessionView',
      _ivpekvgb.SuperAdminView => 'SuperAdminView',
      _imdgiusd.UsernameLoginRequest => 'UsernameLoginRequest',
      _i60s6nd2.Building => 'Building',
      _i4cz4s4m.BuildingCreate => 'BuildingCreate',
      _isz6zhld.BuildingErrorCode => 'BuildingErrorCode',
      _i7fakgop.BuildingException => 'BuildingException',
      _ivqpqa05.BuildingUpdate => 'BuildingUpdate',
      _iyqmhcrr.BuildingView => 'BuildingView',
      _izw8z7ou.Greeting => 'Greeting',
      _ip0o9c0i.MenuArticle => 'MenuArticle',
      _i7hj1jb2.MenuArticleCreate => 'MenuArticleCreate',
      _i46cm0v4.MenuArticleErrorCode => 'MenuArticleErrorCode',
      _iwbmeh47.MenuArticleException => 'MenuArticleException',
      _iwetmqfn.MenuArticleUpdate => 'MenuArticleUpdate',
      _irzndnzc.MenuArticleView => 'MenuArticleView',
      _i7sxg44v.MenuCategory => 'MenuCategory',
      _i8xl75s4.MenuCategoryCreate => 'MenuCategoryCreate',
      _ifc6ty9l.MenuCategoryErrorCode => 'MenuCategoryErrorCode',
      _ikojmx8s.MenuCategoryException => 'MenuCategoryException',
      _i152aql3.MenuCategoryUpdate => 'MenuCategoryUpdate',
      _i9ogfgfu.MenuCategoryView => 'MenuCategoryView',
      _issw8is0.TableFloorStatus => 'TableFloorStatus',
      _i4t52k6g.VenueTable => 'VenueTable',
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
      case _i9bd7h9s.AuthSession():
        return 'AuthSession';
      case _itpbqj0d.AuthTokenResult():
        return 'AuthTokenResult';
      case _i3o13w2y.Customer():
        return 'Customer';
      case _i1o3zw63.CustomerSessionView():
        return 'CustomerSessionView';
      case _ibs93nxz.EmailLoginRequest():
        return 'EmailLoginRequest';
      case _i6a2khfu.EmailRegisterCreate():
        return 'EmailRegisterCreate';
      case _iqh9awfy.Employee():
        return 'Employee';
      case _iedt4kib.EmployeeCreate():
        return 'EmployeeCreate';
      case _i4i3smcx.EmployeeSessionView():
        return 'EmployeeSessionView';
      case _iidaq8tj.EmployeeUpdate():
        return 'EmployeeUpdate';
      case _igp37ocx.EmployeeView():
        return 'EmployeeView';
      case _i21zwh9b.Owner():
        return 'Owner';
      case _ijssep5h.OwnerSessionView():
        return 'OwnerSessionView';
      case _irdmlmfi.ProfileUpdate():
        return 'ProfileUpdate';
      case _iyiwchf3.SuperAdmin():
        return 'SuperAdmin';
      case _iru1pmbh.SuperAdminCreate():
        return 'SuperAdminCreate';
      case _id5qrr5o.SuperAdminSessionView():
        return 'SuperAdminSessionView';
      case _ivpekvgb.SuperAdminView():
        return 'SuperAdminView';
      case _imdgiusd.UsernameLoginRequest():
        return 'UsernameLoginRequest';
      case _i60s6nd2.Building():
        return 'Building';
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
      case _ip0o9c0i.MenuArticle():
        return 'MenuArticle';
      case _i7hj1jb2.MenuArticleCreate():
        return 'MenuArticleCreate';
      case _i46cm0v4.MenuArticleErrorCode():
        return 'MenuArticleErrorCode';
      case _iwbmeh47.MenuArticleException():
        return 'MenuArticleException';
      case _iwetmqfn.MenuArticleUpdate():
        return 'MenuArticleUpdate';
      case _irzndnzc.MenuArticleView():
        return 'MenuArticleView';
      case _i7sxg44v.MenuCategory():
        return 'MenuCategory';
      case _i8xl75s4.MenuCategoryCreate():
        return 'MenuCategoryCreate';
      case _ifc6ty9l.MenuCategoryErrorCode():
        return 'MenuCategoryErrorCode';
      case _ikojmx8s.MenuCategoryException():
        return 'MenuCategoryException';
      case _i152aql3.MenuCategoryUpdate():
        return 'MenuCategoryUpdate';
      case _i9ogfgfu.MenuCategoryView():
        return 'MenuCategoryView';
      case _issw8is0.TableFloorStatus():
        return 'TableFloorStatus';
      case _i4t52k6g.VenueTable():
        return 'VenueTable';
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
    if (dataClassName == 'ActorType') {
      return deserialize<_i350eaix.ActorType>(data['data']);
    }
    if (dataClassName == 'AuthSession') {
      return deserialize<_i9bd7h9s.AuthSession>(data['data']);
    }
    if (dataClassName == 'AuthTokenResult') {
      return deserialize<_itpbqj0d.AuthTokenResult>(data['data']);
    }
    if (dataClassName == 'Customer') {
      return deserialize<_i3o13w2y.Customer>(data['data']);
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
    if (dataClassName == 'Employee') {
      return deserialize<_iqh9awfy.Employee>(data['data']);
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
    if (dataClassName == 'Owner') {
      return deserialize<_i21zwh9b.Owner>(data['data']);
    }
    if (dataClassName == 'OwnerSessionView') {
      return deserialize<_ijssep5h.OwnerSessionView>(data['data']);
    }
    if (dataClassName == 'ProfileUpdate') {
      return deserialize<_irdmlmfi.ProfileUpdate>(data['data']);
    }
    if (dataClassName == 'SuperAdmin') {
      return deserialize<_iyiwchf3.SuperAdmin>(data['data']);
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
    if (dataClassName == 'Building') {
      return deserialize<_i60s6nd2.Building>(data['data']);
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
    if (dataClassName == 'MenuArticle') {
      return deserialize<_ip0o9c0i.MenuArticle>(data['data']);
    }
    if (dataClassName == 'MenuArticleCreate') {
      return deserialize<_i7hj1jb2.MenuArticleCreate>(data['data']);
    }
    if (dataClassName == 'MenuArticleErrorCode') {
      return deserialize<_i46cm0v4.MenuArticleErrorCode>(data['data']);
    }
    if (dataClassName == 'MenuArticleException') {
      return deserialize<_iwbmeh47.MenuArticleException>(data['data']);
    }
    if (dataClassName == 'MenuArticleUpdate') {
      return deserialize<_iwetmqfn.MenuArticleUpdate>(data['data']);
    }
    if (dataClassName == 'MenuArticleView') {
      return deserialize<_irzndnzc.MenuArticleView>(data['data']);
    }
    if (dataClassName == 'MenuCategory') {
      return deserialize<_i7sxg44v.MenuCategory>(data['data']);
    }
    if (dataClassName == 'MenuCategoryCreate') {
      return deserialize<_i8xl75s4.MenuCategoryCreate>(data['data']);
    }
    if (dataClassName == 'MenuCategoryErrorCode') {
      return deserialize<_ifc6ty9l.MenuCategoryErrorCode>(data['data']);
    }
    if (dataClassName == 'MenuCategoryException') {
      return deserialize<_ikojmx8s.MenuCategoryException>(data['data']);
    }
    if (dataClassName == 'MenuCategoryUpdate') {
      return deserialize<_i152aql3.MenuCategoryUpdate>(data['data']);
    }
    if (dataClassName == 'MenuCategoryView') {
      return deserialize<_i9ogfgfu.MenuCategoryView>(data['data']);
    }
    if (dataClassName == 'TableFloorStatus') {
      return deserialize<_issw8is0.TableFloorStatus>(data['data']);
    }
    if (dataClassName == 'VenueTable') {
      return deserialize<_i4t52k6g.VenueTable>(data['data']);
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
      case _i9bd7h9s.AuthSession:
        return _i9bd7h9s.AuthSession.t;
      case _i3o13w2y.Customer:
        return _i3o13w2y.Customer.t;
      case _iqh9awfy.Employee:
        return _iqh9awfy.Employee.t;
      case _i21zwh9b.Owner:
        return _i21zwh9b.Owner.t;
      case _iyiwchf3.SuperAdmin:
        return _iyiwchf3.SuperAdmin.t;
      case _i60s6nd2.Building:
        return _i60s6nd2.Building.t;
      case _ip0o9c0i.MenuArticle:
        return _ip0o9c0i.MenuArticle.t;
      case _i7sxg44v.MenuCategory:
        return _i7sxg44v.MenuCategory.t;
      case _i4t52k6g.VenueTable:
        return _i4t52k6g.VenueTable.t;
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
