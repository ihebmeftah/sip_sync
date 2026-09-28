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
import 'package:sip_sync_server/src/generated/auth/dtos/employee_view.dart'
    as _im8o31wm;
import 'package:sip_sync_server/src/generated/auth/dtos/super_admin_view.dart'
    as _iubtczqk;
import 'package:sip_sync_server/src/generated/buildings/dtos/admin_building_view.dart'
    as _idzabrxr;
import 'package:sip_sync_server/src/generated/buildings/dtos/building_view.dart'
    as _ihha274w;
import 'package:sip_sync_server/src/generated/employee_access/dtos/employee_access_view.dart'
    as _iwktg9rv;
import 'package:sip_sync_server/src/generated/menu/dtos/article_composition_view.dart'
    as _ismrnuo7;
import 'package:sip_sync_server/src/generated/menu/dtos/ingredient_view.dart'
    as _i9jh3lrs;
import 'package:sip_sync_server/src/generated/menu/dtos/menu_article_view.dart'
    as _iftzx4at;
import 'package:sip_sync_server/src/generated/menu/dtos/menu_category_view.dart'
    as _i87rh1jz;
import 'package:sip_sync_server/src/generated/orders/dtos/order_view.dart'
    as _i6r0fe4s;
import 'package:sip_sync_server/src/generated/tables/dtos/venue_table_view.dart'
    as _i8j8iq89;
import 'auth/dtos/account_error_code.dart' as _ipvvun4w;
import 'auth/dtos/account_exception.dart' as _ivr1zpxc;
import 'auth/dtos/actor_type.dart' as _ik5d360v;
import 'auth/dtos/auth_token_result.dart' as _ihcr17cc;
import 'auth/dtos/change_password_request.dart' as _iavw4tqb;
import 'auth/dtos/customer_session_view.dart' as _ith71up9;
import 'auth/dtos/email_login_request.dart' as _ibcfczkm;
import 'auth/dtos/email_register_create.dart' as _iokpa1pa;
import 'auth/dtos/employee_create.dart' as _iubn3z7h;
import 'auth/dtos/employee_session_view.dart' as _i5opmp1h;
import 'auth/dtos/employee_update.dart' as _i08axu9z;
import 'auth/dtos/employee_view.dart' as _inacnd8t;
import 'auth/dtos/owner_session_view.dart' as _isqlfqk2;
import 'auth/dtos/password_reset_confirm.dart' as _i9u54egm;
import 'auth/dtos/password_reset_request.dart' as _in4l34z2;
import 'auth/dtos/password_reset_request_result.dart' as _ixrmg4rs;
import 'auth/dtos/profile_update.dart' as _iul4y12k;
import 'auth/dtos/super_admin_create.dart' as _ieisqlnm;
import 'auth/dtos/super_admin_session_view.dart' as _i4itilxd;
import 'auth/dtos/super_admin_update.dart' as _iccfx1hz;
import 'auth/dtos/super_admin_view.dart' as _ima36n4q;
import 'auth/dtos/username_login_request.dart' as _i4npd3dl;
import 'auth/entity/auth_session.dart' as _i30hpih1;
import 'auth/entity/customer.dart' as _iosx2li4;
import 'auth/entity/employee.dart' as _iwpz2vh7;
import 'auth/entity/owner.dart' as _i00rpu3b;
import 'auth/entity/password_reset.dart' as _i5m9ixa9;
import 'auth/entity/super_admin.dart' as _ii4fooib;
import 'buildings/dtos/admin_building_view.dart' as _ig4j3dzf;
import 'buildings/dtos/building_create.dart' as _i8mj84pm;
import 'buildings/dtos/building_error_code.dart' as _ip56joo9;
import 'buildings/dtos/building_exception.dart' as _ihbyyehn;
import 'buildings/dtos/building_update.dart' as _irbupqdx;
import 'buildings/dtos/building_view.dart' as _i9ph7g7s;
import 'buildings/dtos/strict_mode_step.dart' as _i70klpnb;
import 'buildings/entity/building.dart' as _iit041ql;
import 'employee_access/dtos/employee_access_create.dart' as _izbvctbv;
import 'employee_access/dtos/employee_access_error_code.dart' as _ixnbpcjj;
import 'employee_access/dtos/employee_access_exception.dart' as _ilz0jt85;
import 'employee_access/dtos/employee_access_update.dart' as _ifygdwz2;
import 'employee_access/dtos/employee_access_view.dart' as _i8t0l2jw;
import 'employee_access/entity/employee_access.dart' as _in0lpay2;
import 'menu/dtos/article_composition_create.dart' as _i6nq3709;
import 'menu/dtos/article_composition_error_code.dart' as _ibkg9l4z;
import 'menu/dtos/article_composition_exception.dart' as _if82n88l;
import 'menu/dtos/article_composition_update.dart' as _ixk584py;
import 'menu/dtos/article_composition_view.dart' as _ibgf2aer;
import 'menu/dtos/ingredient_create.dart' as _ii1yylu5;
import 'menu/dtos/ingredient_error_code.dart' as _i7okswdu;
import 'menu/dtos/ingredient_exception.dart' as _i6yqbuhf;
import 'menu/dtos/ingredient_restock.dart' as _i1tfcnyz;
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
import 'menu/entity/article_composition.dart' as _i3yk9qsn;
import 'menu/entity/ingredient.dart' as _idxha5j7;
import 'menu/entity/menu_article.dart' as _iowcl7dy;
import 'menu/entity/menu_category.dart' as _iiovp1sp;
import 'orders/dtos/order_actor_view.dart' as _ic5jn53k;
import 'orders/dtos/order_add_items.dart' as _iqdnv1pi;
import 'orders/dtos/order_create.dart' as _iwmhqcsn;
import 'orders/dtos/order_error_code.dart' as _iepprhv5;
import 'orders/dtos/order_exception.dart' as _iumotmt8;
import 'orders/dtos/order_item_create_line.dart' as _ihzk2s8h;
import 'orders/dtos/order_item_status.dart' as _ihsl512g;
import 'orders/dtos/order_item_status_update.dart' as _i8vmkag3;
import 'orders/dtos/order_item_view.dart' as _in19xqkp;
import 'orders/dtos/order_status.dart' as _iaqxrbm9;
import 'orders/dtos/order_view.dart' as _i5x25q0s;
import 'orders/entity/venue_order.dart' as _ihouontj;
import 'orders/entity/venue_order_item.dart' as _ixvoqikw;
import 'tables/dtos/table_floor_status.dart' as _i64byz7d;
import 'tables/dtos/table_list_filter.dart' as _iuz62fg4;
import 'tables/dtos/venue_table_create.dart' as _iui9xd5q;
import 'tables/dtos/venue_table_error_code.dart' as _iqjhym86;
import 'tables/dtos/venue_table_exception.dart' as _iu19bhmp;
import 'tables/dtos/venue_table_update.dart' as _ie883ahu;
import 'tables/dtos/venue_table_view.dart' as _ifz0lfor;
import 'tables/entity/venue_table.dart' as _ik40dtuz;
export 'auth/dtos/account_error_code.dart';
export 'auth/dtos/account_exception.dart';
export 'auth/dtos/actor_type.dart';
export 'auth/dtos/auth_token_result.dart';
export 'auth/dtos/change_password_request.dart';
export 'auth/dtos/customer_session_view.dart';
export 'auth/dtos/email_login_request.dart';
export 'auth/dtos/email_register_create.dart';
export 'auth/dtos/employee_create.dart';
export 'auth/dtos/employee_session_view.dart';
export 'auth/dtos/employee_update.dart';
export 'auth/dtos/employee_view.dart';
export 'auth/dtos/owner_session_view.dart';
export 'auth/dtos/password_reset_confirm.dart';
export 'auth/dtos/password_reset_request.dart';
export 'auth/dtos/password_reset_request_result.dart';
export 'auth/dtos/profile_update.dart';
export 'auth/dtos/super_admin_create.dart';
export 'auth/dtos/super_admin_session_view.dart';
export 'auth/dtos/super_admin_update.dart';
export 'auth/dtos/super_admin_view.dart';
export 'auth/dtos/username_login_request.dart';
export 'auth/entity/auth_session.dart';
export 'auth/entity/customer.dart';
export 'auth/entity/employee.dart';
export 'auth/entity/owner.dart';
export 'auth/entity/password_reset.dart';
export 'auth/entity/super_admin.dart';
export 'buildings/dtos/admin_building_view.dart';
export 'buildings/dtos/building_create.dart';
export 'buildings/dtos/building_error_code.dart';
export 'buildings/dtos/building_exception.dart';
export 'buildings/dtos/building_update.dart';
export 'buildings/dtos/building_view.dart';
export 'buildings/dtos/strict_mode_step.dart';
export 'buildings/entity/building.dart';
export 'employee_access/dtos/employee_access_create.dart';
export 'employee_access/dtos/employee_access_error_code.dart';
export 'employee_access/dtos/employee_access_exception.dart';
export 'employee_access/dtos/employee_access_update.dart';
export 'employee_access/dtos/employee_access_view.dart';
export 'employee_access/entity/employee_access.dart';
export 'menu/dtos/article_composition_create.dart';
export 'menu/dtos/article_composition_error_code.dart';
export 'menu/dtos/article_composition_exception.dart';
export 'menu/dtos/article_composition_update.dart';
export 'menu/dtos/article_composition_view.dart';
export 'menu/dtos/ingredient_create.dart';
export 'menu/dtos/ingredient_error_code.dart';
export 'menu/dtos/ingredient_exception.dart';
export 'menu/dtos/ingredient_restock.dart';
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
export 'menu/entity/article_composition.dart';
export 'menu/entity/ingredient.dart';
export 'menu/entity/menu_article.dart';
export 'menu/entity/menu_category.dart';
export 'orders/dtos/order_actor_view.dart';
export 'orders/dtos/order_add_items.dart';
export 'orders/dtos/order_create.dart';
export 'orders/dtos/order_error_code.dart';
export 'orders/dtos/order_exception.dart';
export 'orders/dtos/order_item_create_line.dart';
export 'orders/dtos/order_item_status.dart';
export 'orders/dtos/order_item_status_update.dart';
export 'orders/dtos/order_item_view.dart';
export 'orders/dtos/order_status.dart';
export 'orders/dtos/order_view.dart';
export 'orders/entity/venue_order.dart';
export 'orders/entity/venue_order_item.dart';
export 'tables/dtos/table_floor_status.dart';
export 'tables/dtos/table_list_filter.dart';
export 'tables/dtos/venue_table_create.dart';
export 'tables/dtos/venue_table_error_code.dart';
export 'tables/dtos/venue_table_exception.dart';
export 'tables/dtos/venue_table_update.dart';
export 'tables/dtos/venue_table_view.dart';
export 'tables/entity/venue_table.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'article_composition',
      dartName: 'ArticleComposition',
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
          name: 'articleId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'ingredientId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'quantity',
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
          constraintName: 'article_composition_fk_0',
          columns: ['articleId'],
          referenceTable: 'menu_article',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'article_composition_fk_1',
          columns: ['ingredientId'],
          referenceTable: 'ingredient',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'article_composition_article_ingredient_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'articleId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ingredientId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'article_composition_article_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'articleId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'article_composition_ingredient_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ingredientId',
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
          name: 'phoneNumber',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'countryCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'whatsapp',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'instagram',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'facebook',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'otherLinks',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'tableMultiOrder',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'allowAppendingItemsToOrder',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'strictMode',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'strictModeSteps',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:StrictModeStep>',
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
          name: 'accessId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
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
        _isp.ForeignKeyDefinition(
          constraintName: 'employee_fk_2',
          columns: ['accessId'],
          referenceTable: 'employee_access',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.restrict,
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
        _isp.IndexDefinition(
          indexName: 'employee_access_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'accessId',
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
      name: 'employee_access',
      dartName: 'EmployeeAccess',
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
          name: 'orderCreation',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'orderPayment',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'cancelOrder',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'preparation',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'serving',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'consultAllOrders',
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
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'employee_access_fk_0',
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
          indexName: 'employee_access_building_name_idx',
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
          indexName: 'employee_access_building_idx',
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
      name: 'ingredient',
      dartName: 'Ingredient',
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
          name: 'unit',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:UnitsType',
        ),
        _isp.ColumnDefinition(
          name: 'initialStock',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'currentStock',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'thresholdStock',
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
          constraintName: 'ingredient_fk_0',
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
          indexName: 'ingredient_building_name_idx',
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
          indexName: 'ingredient_building_idx',
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
      name: 'password_reset',
      dartName: 'PasswordReset',
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
          name: 'codeHash',
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
          name: 'consumedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
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
          indexName: 'password_reset_email_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'email',
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
      name: 'venue_order',
      dartName: 'VenueOrder',
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
          name: 'venueTableId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'ref',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OrderStatus',
        ),
        _isp.ColumnDefinition(
          name: 'launchedByType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ActorType',
        ),
        _isp.ColumnDefinition(
          name: 'launchedById',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'lastPaidByType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ActorType?',
        ),
        _isp.ColumnDefinition(
          name: 'lastPaidById',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'lastPaidAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'cancelledByType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ActorType?',
        ),
        _isp.ColumnDefinition(
          name: 'cancelledById',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'cancelledAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'venue_order_fk_0',
          columns: ['buildingId'],
          referenceTable: 'building',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'venue_order_fk_1',
          columns: ['venueTableId'],
          referenceTable: 'venue_table',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'venue_order_building_idx',
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
          indexName: 'venue_order_building_status_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'buildingId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'venue_order_table_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'venueTableId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'venue_order_building_ref_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'buildingId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ref',
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
      name: 'venue_order_item',
      dartName: 'VenueOrderItem',
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
          name: 'orderId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'articleId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'articleName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'unitPrice',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OrderItemStatus',
        ),
        _isp.ColumnDefinition(
          name: 'addedByType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ActorType?',
        ),
        _isp.ColumnDefinition(
          name: 'addedById',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'passedByType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ActorType?',
        ),
        _isp.ColumnDefinition(
          name: 'passedById',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'preparedByType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ActorType?',
        ),
        _isp.ColumnDefinition(
          name: 'preparedById',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'servedByType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ActorType?',
        ),
        _isp.ColumnDefinition(
          name: 'servedById',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'paidToType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ActorType?',
        ),
        _isp.ColumnDefinition(
          name: 'paidToId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'cancelledByType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ActorType?',
        ),
        _isp.ColumnDefinition(
          name: 'cancelledById',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'preparedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'servedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'paidAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'cancelledAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'venue_order_item_fk_0',
          columns: ['orderId'],
          referenceTable: 'venue_order',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'venue_order_item_fk_1',
          columns: ['articleId'],
          referenceTable: 'menu_article',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'venue_order_item_order_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'orderId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'venue_order_item_article_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'articleId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'venue_order_item_status_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
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
    if (t == _iavw4tqb.ChangePasswordRequest) {
      return _iavw4tqb.ChangePasswordRequest.fromJson(data) as T;
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
    if (t == _i9u54egm.PasswordResetConfirm) {
      return _i9u54egm.PasswordResetConfirm.fromJson(data) as T;
    }
    if (t == _in4l34z2.PasswordResetRequest) {
      return _in4l34z2.PasswordResetRequest.fromJson(data) as T;
    }
    if (t == _ixrmg4rs.PasswordResetRequestResult) {
      return _ixrmg4rs.PasswordResetRequestResult.fromJson(data) as T;
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
    if (t == _iccfx1hz.SuperAdminUpdate) {
      return _iccfx1hz.SuperAdminUpdate.fromJson(data) as T;
    }
    if (t == _ima36n4q.SuperAdminView) {
      return _ima36n4q.SuperAdminView.fromJson(data) as T;
    }
    if (t == _i4npd3dl.UsernameLoginRequest) {
      return _i4npd3dl.UsernameLoginRequest.fromJson(data) as T;
    }
    if (t == _i30hpih1.AuthSession) {
      return _i30hpih1.AuthSession.fromJson(data) as T;
    }
    if (t == _iosx2li4.Customer) {
      return _iosx2li4.Customer.fromJson(data) as T;
    }
    if (t == _iwpz2vh7.Employee) {
      return _iwpz2vh7.Employee.fromJson(data) as T;
    }
    if (t == _i00rpu3b.Owner) {
      return _i00rpu3b.Owner.fromJson(data) as T;
    }
    if (t == _i5m9ixa9.PasswordReset) {
      return _i5m9ixa9.PasswordReset.fromJson(data) as T;
    }
    if (t == _ii4fooib.SuperAdmin) {
      return _ii4fooib.SuperAdmin.fromJson(data) as T;
    }
    if (t == _ig4j3dzf.AdminBuildingView) {
      return _ig4j3dzf.AdminBuildingView.fromJson(data) as T;
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
    if (t == _i70klpnb.StrictModeStep) {
      return _i70klpnb.StrictModeStep.fromJson(data) as T;
    }
    if (t == _iit041ql.Building) {
      return _iit041ql.Building.fromJson(data) as T;
    }
    if (t == _izbvctbv.EmployeeAccessCreate) {
      return _izbvctbv.EmployeeAccessCreate.fromJson(data) as T;
    }
    if (t == _ixnbpcjj.EmployeeAccessErrorCode) {
      return _ixnbpcjj.EmployeeAccessErrorCode.fromJson(data) as T;
    }
    if (t == _ilz0jt85.EmployeeAccessException) {
      return _ilz0jt85.EmployeeAccessException.fromJson(data) as T;
    }
    if (t == _ifygdwz2.EmployeeAccessUpdate) {
      return _ifygdwz2.EmployeeAccessUpdate.fromJson(data) as T;
    }
    if (t == _i8t0l2jw.EmployeeAccessView) {
      return _i8t0l2jw.EmployeeAccessView.fromJson(data) as T;
    }
    if (t == _in0lpay2.EmployeeAccess) {
      return _in0lpay2.EmployeeAccess.fromJson(data) as T;
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
    if (t == _i1tfcnyz.IngredientRestock) {
      return _i1tfcnyz.IngredientRestock.fromJson(data) as T;
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
    if (t == _i3yk9qsn.ArticleComposition) {
      return _i3yk9qsn.ArticleComposition.fromJson(data) as T;
    }
    if (t == _idxha5j7.Ingredient) {
      return _idxha5j7.Ingredient.fromJson(data) as T;
    }
    if (t == _iowcl7dy.MenuArticle) {
      return _iowcl7dy.MenuArticle.fromJson(data) as T;
    }
    if (t == _iiovp1sp.MenuCategory) {
      return _iiovp1sp.MenuCategory.fromJson(data) as T;
    }
    if (t == _ic5jn53k.OrderActorView) {
      return _ic5jn53k.OrderActorView.fromJson(data) as T;
    }
    if (t == _iqdnv1pi.OrderAddItems) {
      return _iqdnv1pi.OrderAddItems.fromJson(data) as T;
    }
    if (t == _iwmhqcsn.OrderCreate) {
      return _iwmhqcsn.OrderCreate.fromJson(data) as T;
    }
    if (t == _iepprhv5.OrderErrorCode) {
      return _iepprhv5.OrderErrorCode.fromJson(data) as T;
    }
    if (t == _iumotmt8.OrderException) {
      return _iumotmt8.OrderException.fromJson(data) as T;
    }
    if (t == _ihzk2s8h.OrderItemCreateLine) {
      return _ihzk2s8h.OrderItemCreateLine.fromJson(data) as T;
    }
    if (t == _ihsl512g.OrderItemStatus) {
      return _ihsl512g.OrderItemStatus.fromJson(data) as T;
    }
    if (t == _i8vmkag3.OrderItemStatusUpdate) {
      return _i8vmkag3.OrderItemStatusUpdate.fromJson(data) as T;
    }
    if (t == _in19xqkp.OrderItemView) {
      return _in19xqkp.OrderItemView.fromJson(data) as T;
    }
    if (t == _iaqxrbm9.OrderStatus) {
      return _iaqxrbm9.OrderStatus.fromJson(data) as T;
    }
    if (t == _i5x25q0s.OrderView) {
      return _i5x25q0s.OrderView.fromJson(data) as T;
    }
    if (t == _ihouontj.VenueOrder) {
      return _ihouontj.VenueOrder.fromJson(data) as T;
    }
    if (t == _ixvoqikw.VenueOrderItem) {
      return _ixvoqikw.VenueOrderItem.fromJson(data) as T;
    }
    if (t == _i64byz7d.TableFloorStatus) {
      return _i64byz7d.TableFloorStatus.fromJson(data) as T;
    }
    if (t == _iuz62fg4.TableListFilter) {
      return _iuz62fg4.TableListFilter.fromJson(data) as T;
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
    if (t == _ik40dtuz.VenueTable) {
      return _ik40dtuz.VenueTable.fromJson(data) as T;
    }
    if (t == _is.getType<_ipvvun4w.AccountErrorCode?>()) {
      return (data != null ? _ipvvun4w.AccountErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ivr1zpxc.AccountException?>()) {
      return (data != null ? _ivr1zpxc.AccountException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ik5d360v.ActorType?>()) {
      return (data != null ? _ik5d360v.ActorType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ihcr17cc.AuthTokenResult?>()) {
      return (data != null ? _ihcr17cc.AuthTokenResult.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iavw4tqb.ChangePasswordRequest?>()) {
      return (data != null
              ? _iavw4tqb.ChangePasswordRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ith71up9.CustomerSessionView?>()) {
      return (data != null
              ? _ith71up9.CustomerSessionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ibcfczkm.EmailLoginRequest?>()) {
      return (data != null ? _ibcfczkm.EmailLoginRequest.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iokpa1pa.EmailRegisterCreate?>()) {
      return (data != null
              ? _iokpa1pa.EmailRegisterCreate.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iubn3z7h.EmployeeCreate?>()) {
      return (data != null ? _iubn3z7h.EmployeeCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i5opmp1h.EmployeeSessionView?>()) {
      return (data != null
              ? _i5opmp1h.EmployeeSessionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i08axu9z.EmployeeUpdate?>()) {
      return (data != null ? _i08axu9z.EmployeeUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_inacnd8t.EmployeeView?>()) {
      return (data != null ? _inacnd8t.EmployeeView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_isqlfqk2.OwnerSessionView?>()) {
      return (data != null ? _isqlfqk2.OwnerSessionView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9u54egm.PasswordResetConfirm?>()) {
      return (data != null
              ? _i9u54egm.PasswordResetConfirm.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_in4l34z2.PasswordResetRequest?>()) {
      return (data != null
              ? _in4l34z2.PasswordResetRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ixrmg4rs.PasswordResetRequestResult?>()) {
      return (data != null
              ? _ixrmg4rs.PasswordResetRequestResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iul4y12k.ProfileUpdate?>()) {
      return (data != null ? _iul4y12k.ProfileUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ieisqlnm.SuperAdminCreate?>()) {
      return (data != null ? _ieisqlnm.SuperAdminCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i4itilxd.SuperAdminSessionView?>()) {
      return (data != null
              ? _i4itilxd.SuperAdminSessionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iccfx1hz.SuperAdminUpdate?>()) {
      return (data != null ? _iccfx1hz.SuperAdminUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ima36n4q.SuperAdminView?>()) {
      return (data != null ? _ima36n4q.SuperAdminView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i4npd3dl.UsernameLoginRequest?>()) {
      return (data != null
              ? _i4npd3dl.UsernameLoginRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i30hpih1.AuthSession?>()) {
      return (data != null ? _i30hpih1.AuthSession.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iosx2li4.Customer?>()) {
      return (data != null ? _iosx2li4.Customer.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwpz2vh7.Employee?>()) {
      return (data != null ? _iwpz2vh7.Employee.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i00rpu3b.Owner?>()) {
      return (data != null ? _i00rpu3b.Owner.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5m9ixa9.PasswordReset?>()) {
      return (data != null ? _i5m9ixa9.PasswordReset.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ii4fooib.SuperAdmin?>()) {
      return (data != null ? _ii4fooib.SuperAdmin.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ig4j3dzf.AdminBuildingView?>()) {
      return (data != null ? _ig4j3dzf.AdminBuildingView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i8mj84pm.BuildingCreate?>()) {
      return (data != null ? _i8mj84pm.BuildingCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ip56joo9.BuildingErrorCode?>()) {
      return (data != null ? _ip56joo9.BuildingErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ihbyyehn.BuildingException?>()) {
      return (data != null ? _ihbyyehn.BuildingException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_irbupqdx.BuildingUpdate?>()) {
      return (data != null ? _irbupqdx.BuildingUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9ph7g7s.BuildingView?>()) {
      return (data != null ? _i9ph7g7s.BuildingView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i70klpnb.StrictModeStep?>()) {
      return (data != null ? _i70klpnb.StrictModeStep.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iit041ql.Building?>()) {
      return (data != null ? _iit041ql.Building.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_izbvctbv.EmployeeAccessCreate?>()) {
      return (data != null
              ? _izbvctbv.EmployeeAccessCreate.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ixnbpcjj.EmployeeAccessErrorCode?>()) {
      return (data != null
              ? _ixnbpcjj.EmployeeAccessErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ilz0jt85.EmployeeAccessException?>()) {
      return (data != null
              ? _ilz0jt85.EmployeeAccessException.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ifygdwz2.EmployeeAccessUpdate?>()) {
      return (data != null
              ? _ifygdwz2.EmployeeAccessUpdate.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i8t0l2jw.EmployeeAccessView?>()) {
      return (data != null ? _i8t0l2jw.EmployeeAccessView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_in0lpay2.EmployeeAccess?>()) {
      return (data != null ? _in0lpay2.EmployeeAccess.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i6nq3709.ArticleCompositionCreate?>()) {
      return (data != null
              ? _i6nq3709.ArticleCompositionCreate.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ibkg9l4z.ArticleCompositionErrorCode?>()) {
      return (data != null
              ? _ibkg9l4z.ArticleCompositionErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_if82n88l.ArticleCompositionException?>()) {
      return (data != null
              ? _if82n88l.ArticleCompositionException.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ixk584py.ArticleCompositionUpdate?>()) {
      return (data != null
              ? _ixk584py.ArticleCompositionUpdate.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ibgf2aer.ArticleCompositionView?>()) {
      return (data != null
              ? _ibgf2aer.ArticleCompositionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ii1yylu5.IngredientCreate?>()) {
      return (data != null ? _ii1yylu5.IngredientCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i7okswdu.IngredientErrorCode?>()) {
      return (data != null
              ? _i7okswdu.IngredientErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i6yqbuhf.IngredientException?>()) {
      return (data != null
              ? _i6yqbuhf.IngredientException.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i1tfcnyz.IngredientRestock?>()) {
      return (data != null ? _i1tfcnyz.IngredientRestock.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i8smn6k1.IngredientView?>()) {
      return (data != null ? _i8smn6k1.IngredientView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ilqdzk9u.MenuArticleCreate?>()) {
      return (data != null ? _ilqdzk9u.MenuArticleCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i5kcaxik.MenuArticleErrorCode?>()) {
      return (data != null
              ? _i5kcaxik.MenuArticleErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i2u77dvq.MenuArticleException?>()) {
      return (data != null
              ? _i2u77dvq.MenuArticleException.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i0z96yjp.MenuArticleUpdate?>()) {
      return (data != null ? _i0z96yjp.MenuArticleUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_in0m6e44.MenuArticleView?>()) {
      return (data != null ? _in0m6e44.MenuArticleView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i3y2wlpl.MenuCategoryCreate?>()) {
      return (data != null ? _i3y2wlpl.MenuCategoryCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_if8o71j1.MenuCategoryErrorCode?>()) {
      return (data != null
              ? _if8o71j1.MenuCategoryErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_idwl0wi8.MenuCategoryException?>()) {
      return (data != null
              ? _idwl0wi8.MenuCategoryException.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iu0xgttg.MenuCategoryUpdate?>()) {
      return (data != null ? _iu0xgttg.MenuCategoryUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_igs74mgr.MenuCategoryView?>()) {
      return (data != null ? _igs74mgr.MenuCategoryView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ipcoxh71.UnitsType?>()) {
      return (data != null ? _ipcoxh71.UnitsType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3yk9qsn.ArticleComposition?>()) {
      return (data != null ? _i3yk9qsn.ArticleComposition.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_idxha5j7.Ingredient?>()) {
      return (data != null ? _idxha5j7.Ingredient.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iowcl7dy.MenuArticle?>()) {
      return (data != null ? _iowcl7dy.MenuArticle.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iiovp1sp.MenuCategory?>()) {
      return (data != null ? _iiovp1sp.MenuCategory.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ic5jn53k.OrderActorView?>()) {
      return (data != null ? _ic5jn53k.OrderActorView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iqdnv1pi.OrderAddItems?>()) {
      return (data != null ? _iqdnv1pi.OrderAddItems.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iwmhqcsn.OrderCreate?>()) {
      return (data != null ? _iwmhqcsn.OrderCreate.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iepprhv5.OrderErrorCode?>()) {
      return (data != null ? _iepprhv5.OrderErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iumotmt8.OrderException?>()) {
      return (data != null ? _iumotmt8.OrderException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ihzk2s8h.OrderItemCreateLine?>()) {
      return (data != null
              ? _ihzk2s8h.OrderItemCreateLine.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ihsl512g.OrderItemStatus?>()) {
      return (data != null ? _ihsl512g.OrderItemStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i8vmkag3.OrderItemStatusUpdate?>()) {
      return (data != null
              ? _i8vmkag3.OrderItemStatusUpdate.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_in19xqkp.OrderItemView?>()) {
      return (data != null ? _in19xqkp.OrderItemView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iaqxrbm9.OrderStatus?>()) {
      return (data != null ? _iaqxrbm9.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5x25q0s.OrderView?>()) {
      return (data != null ? _i5x25q0s.OrderView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ihouontj.VenueOrder?>()) {
      return (data != null ? _ihouontj.VenueOrder.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ixvoqikw.VenueOrderItem?>()) {
      return (data != null ? _ixvoqikw.VenueOrderItem.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i64byz7d.TableFloorStatus?>()) {
      return (data != null ? _i64byz7d.TableFloorStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iuz62fg4.TableListFilter?>()) {
      return (data != null ? _iuz62fg4.TableListFilter.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iui9xd5q.VenueTableCreate?>()) {
      return (data != null ? _iui9xd5q.VenueTableCreate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iqjhym86.VenueTableErrorCode?>()) {
      return (data != null
              ? _iqjhym86.VenueTableErrorCode.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iu19bhmp.VenueTableException?>()) {
      return (data != null
              ? _iu19bhmp.VenueTableException.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ie883ahu.VenueTableUpdate?>()) {
      return (data != null ? _ie883ahu.VenueTableUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ifz0lfor.VenueTableView?>()) {
      return (data != null ? _ifz0lfor.VenueTableView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ik40dtuz.VenueTable?>()) {
      return (data != null ? _ik40dtuz.VenueTable.fromJson(data) : null) as T;
    }
    if (t == List<_iit041ql.Building>) {
      return (data as List)
              .map((e) => deserialize<_iit041ql.Building>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_iit041ql.Building>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iit041ql.Building>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iwpz2vh7.Employee>) {
      return (data as List)
              .map((e) => deserialize<_iwpz2vh7.Employee>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_iwpz2vh7.Employee>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iwpz2vh7.Employee>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i70klpnb.StrictModeStep>) {
      return (data as List)
              .map((e) => deserialize<_i70klpnb.StrictModeStep>(e))
              .toList()
          as T;
    }
    if (t == List<_is.UuidValue>) {
      return (data as List).map((e) => deserialize<_is.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_in0lpay2.EmployeeAccess>) {
      return (data as List)
              .map((e) => deserialize<_in0lpay2.EmployeeAccess>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_in0lpay2.EmployeeAccess>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_in0lpay2.EmployeeAccess>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ik40dtuz.VenueTable>) {
      return (data as List)
              .map((e) => deserialize<_ik40dtuz.VenueTable>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_ik40dtuz.VenueTable>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ik40dtuz.VenueTable>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iiovp1sp.MenuCategory>) {
      return (data as List)
              .map((e) => deserialize<_iiovp1sp.MenuCategory>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_iiovp1sp.MenuCategory>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iiovp1sp.MenuCategory>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iowcl7dy.MenuArticle>) {
      return (data as List)
              .map((e) => deserialize<_iowcl7dy.MenuArticle>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_iowcl7dy.MenuArticle>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iowcl7dy.MenuArticle>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_idxha5j7.Ingredient>) {
      return (data as List)
              .map((e) => deserialize<_idxha5j7.Ingredient>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_idxha5j7.Ingredient>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_idxha5j7.Ingredient>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ihouontj.VenueOrder>) {
      return (data as List)
              .map((e) => deserialize<_ihouontj.VenueOrder>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_ihouontj.VenueOrder>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ihouontj.VenueOrder>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i3yk9qsn.ArticleComposition>) {
      return (data as List)
              .map((e) => deserialize<_i3yk9qsn.ArticleComposition>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_i3yk9qsn.ArticleComposition>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i3yk9qsn.ArticleComposition>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ixvoqikw.VenueOrderItem>) {
      return (data as List)
              .map((e) => deserialize<_ixvoqikw.VenueOrderItem>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_ixvoqikw.VenueOrderItem>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ixvoqikw.VenueOrderItem>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ihzk2s8h.OrderItemCreateLine>) {
      return (data as List)
              .map((e) => deserialize<_ihzk2s8h.OrderItemCreateLine>(e))
              .toList()
          as T;
    }
    if (t == List<_in19xqkp.OrderItemView>) {
      return (data as List)
              .map((e) => deserialize<_in19xqkp.OrderItemView>(e))
              .toList()
          as T;
    }
    if (t == List<_iubtczqk.SuperAdminView>) {
      return (data as List)
              .map((e) => deserialize<_iubtczqk.SuperAdminView>(e))
              .toList()
          as T;
    }
    if (t == List<_ihha274w.BuildingView>) {
      return (data as List)
              .map((e) => deserialize<_ihha274w.BuildingView>(e))
              .toList()
          as T;
    }
    if (t == List<_idzabrxr.AdminBuildingView>) {
      return (data as List)
              .map((e) => deserialize<_idzabrxr.AdminBuildingView>(e))
              .toList()
          as T;
    }
    if (t == List<_im8o31wm.EmployeeView>) {
      return (data as List)
              .map((e) => deserialize<_im8o31wm.EmployeeView>(e))
              .toList()
          as T;
    }
    if (t == List<_iwktg9rv.EmployeeAccessView>) {
      return (data as List)
              .map((e) => deserialize<_iwktg9rv.EmployeeAccessView>(e))
              .toList()
          as T;
    }
    if (t == List<_ismrnuo7.ArticleCompositionView>) {
      return (data as List)
              .map((e) => deserialize<_ismrnuo7.ArticleCompositionView>(e))
              .toList()
          as T;
    }
    if (t == List<_i9jh3lrs.IngredientView>) {
      return (data as List)
              .map((e) => deserialize<_i9jh3lrs.IngredientView>(e))
              .toList()
          as T;
    }
    if (t == List<_iftzx4at.MenuArticleView>) {
      return (data as List)
              .map((e) => deserialize<_iftzx4at.MenuArticleView>(e))
              .toList()
          as T;
    }
    if (t == List<_i87rh1jz.MenuCategoryView>) {
      return (data as List)
              .map((e) => deserialize<_i87rh1jz.MenuCategoryView>(e))
              .toList()
          as T;
    }
    if (t == List<_i6r0fe4s.OrderView>) {
      return (data as List)
              .map((e) => deserialize<_i6r0fe4s.OrderView>(e))
              .toList()
          as T;
    }
    if (t == List<_i8j8iq89.VenueTableView>) {
      return (data as List)
              .map((e) => deserialize<_i8j8iq89.VenueTableView>(e))
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
      _ipvvun4w.AccountErrorCode => 'AccountErrorCode',
      _ivr1zpxc.AccountException => 'AccountException',
      _ik5d360v.ActorType => 'ActorType',
      _ihcr17cc.AuthTokenResult => 'AuthTokenResult',
      _iavw4tqb.ChangePasswordRequest => 'ChangePasswordRequest',
      _ith71up9.CustomerSessionView => 'CustomerSessionView',
      _ibcfczkm.EmailLoginRequest => 'EmailLoginRequest',
      _iokpa1pa.EmailRegisterCreate => 'EmailRegisterCreate',
      _iubn3z7h.EmployeeCreate => 'EmployeeCreate',
      _i5opmp1h.EmployeeSessionView => 'EmployeeSessionView',
      _i08axu9z.EmployeeUpdate => 'EmployeeUpdate',
      _inacnd8t.EmployeeView => 'EmployeeView',
      _isqlfqk2.OwnerSessionView => 'OwnerSessionView',
      _i9u54egm.PasswordResetConfirm => 'PasswordResetConfirm',
      _in4l34z2.PasswordResetRequest => 'PasswordResetRequest',
      _ixrmg4rs.PasswordResetRequestResult => 'PasswordResetRequestResult',
      _iul4y12k.ProfileUpdate => 'ProfileUpdate',
      _ieisqlnm.SuperAdminCreate => 'SuperAdminCreate',
      _i4itilxd.SuperAdminSessionView => 'SuperAdminSessionView',
      _iccfx1hz.SuperAdminUpdate => 'SuperAdminUpdate',
      _ima36n4q.SuperAdminView => 'SuperAdminView',
      _i4npd3dl.UsernameLoginRequest => 'UsernameLoginRequest',
      _i30hpih1.AuthSession => 'AuthSession',
      _iosx2li4.Customer => 'Customer',
      _iwpz2vh7.Employee => 'Employee',
      _i00rpu3b.Owner => 'Owner',
      _i5m9ixa9.PasswordReset => 'PasswordReset',
      _ii4fooib.SuperAdmin => 'SuperAdmin',
      _ig4j3dzf.AdminBuildingView => 'AdminBuildingView',
      _i8mj84pm.BuildingCreate => 'BuildingCreate',
      _ip56joo9.BuildingErrorCode => 'BuildingErrorCode',
      _ihbyyehn.BuildingException => 'BuildingException',
      _irbupqdx.BuildingUpdate => 'BuildingUpdate',
      _i9ph7g7s.BuildingView => 'BuildingView',
      _i70klpnb.StrictModeStep => 'StrictModeStep',
      _iit041ql.Building => 'Building',
      _izbvctbv.EmployeeAccessCreate => 'EmployeeAccessCreate',
      _ixnbpcjj.EmployeeAccessErrorCode => 'EmployeeAccessErrorCode',
      _ilz0jt85.EmployeeAccessException => 'EmployeeAccessException',
      _ifygdwz2.EmployeeAccessUpdate => 'EmployeeAccessUpdate',
      _i8t0l2jw.EmployeeAccessView => 'EmployeeAccessView',
      _in0lpay2.EmployeeAccess => 'EmployeeAccess',
      _i6nq3709.ArticleCompositionCreate => 'ArticleCompositionCreate',
      _ibkg9l4z.ArticleCompositionErrorCode => 'ArticleCompositionErrorCode',
      _if82n88l.ArticleCompositionException => 'ArticleCompositionException',
      _ixk584py.ArticleCompositionUpdate => 'ArticleCompositionUpdate',
      _ibgf2aer.ArticleCompositionView => 'ArticleCompositionView',
      _ii1yylu5.IngredientCreate => 'IngredientCreate',
      _i7okswdu.IngredientErrorCode => 'IngredientErrorCode',
      _i6yqbuhf.IngredientException => 'IngredientException',
      _i1tfcnyz.IngredientRestock => 'IngredientRestock',
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
      _i3yk9qsn.ArticleComposition => 'ArticleComposition',
      _idxha5j7.Ingredient => 'Ingredient',
      _iowcl7dy.MenuArticle => 'MenuArticle',
      _iiovp1sp.MenuCategory => 'MenuCategory',
      _ic5jn53k.OrderActorView => 'OrderActorView',
      _iqdnv1pi.OrderAddItems => 'OrderAddItems',
      _iwmhqcsn.OrderCreate => 'OrderCreate',
      _iepprhv5.OrderErrorCode => 'OrderErrorCode',
      _iumotmt8.OrderException => 'OrderException',
      _ihzk2s8h.OrderItemCreateLine => 'OrderItemCreateLine',
      _ihsl512g.OrderItemStatus => 'OrderItemStatus',
      _i8vmkag3.OrderItemStatusUpdate => 'OrderItemStatusUpdate',
      _in19xqkp.OrderItemView => 'OrderItemView',
      _iaqxrbm9.OrderStatus => 'OrderStatus',
      _i5x25q0s.OrderView => 'OrderView',
      _ihouontj.VenueOrder => 'VenueOrder',
      _ixvoqikw.VenueOrderItem => 'VenueOrderItem',
      _i64byz7d.TableFloorStatus => 'TableFloorStatus',
      _iuz62fg4.TableListFilter => 'TableListFilter',
      _iui9xd5q.VenueTableCreate => 'VenueTableCreate',
      _iqjhym86.VenueTableErrorCode => 'VenueTableErrorCode',
      _iu19bhmp.VenueTableException => 'VenueTableException',
      _ie883ahu.VenueTableUpdate => 'VenueTableUpdate',
      _ifz0lfor.VenueTableView => 'VenueTableView',
      _ik40dtuz.VenueTable => 'VenueTable',
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
      case _iavw4tqb.ChangePasswordRequest():
        return 'ChangePasswordRequest';
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
      case _i9u54egm.PasswordResetConfirm():
        return 'PasswordResetConfirm';
      case _in4l34z2.PasswordResetRequest():
        return 'PasswordResetRequest';
      case _ixrmg4rs.PasswordResetRequestResult():
        return 'PasswordResetRequestResult';
      case _iul4y12k.ProfileUpdate():
        return 'ProfileUpdate';
      case _ieisqlnm.SuperAdminCreate():
        return 'SuperAdminCreate';
      case _i4itilxd.SuperAdminSessionView():
        return 'SuperAdminSessionView';
      case _iccfx1hz.SuperAdminUpdate():
        return 'SuperAdminUpdate';
      case _ima36n4q.SuperAdminView():
        return 'SuperAdminView';
      case _i4npd3dl.UsernameLoginRequest():
        return 'UsernameLoginRequest';
      case _i30hpih1.AuthSession():
        return 'AuthSession';
      case _iosx2li4.Customer():
        return 'Customer';
      case _iwpz2vh7.Employee():
        return 'Employee';
      case _i00rpu3b.Owner():
        return 'Owner';
      case _i5m9ixa9.PasswordReset():
        return 'PasswordReset';
      case _ii4fooib.SuperAdmin():
        return 'SuperAdmin';
      case _ig4j3dzf.AdminBuildingView():
        return 'AdminBuildingView';
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
      case _i70klpnb.StrictModeStep():
        return 'StrictModeStep';
      case _iit041ql.Building():
        return 'Building';
      case _izbvctbv.EmployeeAccessCreate():
        return 'EmployeeAccessCreate';
      case _ixnbpcjj.EmployeeAccessErrorCode():
        return 'EmployeeAccessErrorCode';
      case _ilz0jt85.EmployeeAccessException():
        return 'EmployeeAccessException';
      case _ifygdwz2.EmployeeAccessUpdate():
        return 'EmployeeAccessUpdate';
      case _i8t0l2jw.EmployeeAccessView():
        return 'EmployeeAccessView';
      case _in0lpay2.EmployeeAccess():
        return 'EmployeeAccess';
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
      case _i1tfcnyz.IngredientRestock():
        return 'IngredientRestock';
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
      case _i3yk9qsn.ArticleComposition():
        return 'ArticleComposition';
      case _idxha5j7.Ingredient():
        return 'Ingredient';
      case _iowcl7dy.MenuArticle():
        return 'MenuArticle';
      case _iiovp1sp.MenuCategory():
        return 'MenuCategory';
      case _ic5jn53k.OrderActorView():
        return 'OrderActorView';
      case _iqdnv1pi.OrderAddItems():
        return 'OrderAddItems';
      case _iwmhqcsn.OrderCreate():
        return 'OrderCreate';
      case _iepprhv5.OrderErrorCode():
        return 'OrderErrorCode';
      case _iumotmt8.OrderException():
        return 'OrderException';
      case _ihzk2s8h.OrderItemCreateLine():
        return 'OrderItemCreateLine';
      case _ihsl512g.OrderItemStatus():
        return 'OrderItemStatus';
      case _i8vmkag3.OrderItemStatusUpdate():
        return 'OrderItemStatusUpdate';
      case _in19xqkp.OrderItemView():
        return 'OrderItemView';
      case _iaqxrbm9.OrderStatus():
        return 'OrderStatus';
      case _i5x25q0s.OrderView():
        return 'OrderView';
      case _ihouontj.VenueOrder():
        return 'VenueOrder';
      case _ixvoqikw.VenueOrderItem():
        return 'VenueOrderItem';
      case _i64byz7d.TableFloorStatus():
        return 'TableFloorStatus';
      case _iuz62fg4.TableListFilter():
        return 'TableListFilter';
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
      case _ik40dtuz.VenueTable():
        return 'VenueTable';
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
    if (dataClassName == 'ChangePasswordRequest') {
      return deserialize<_iavw4tqb.ChangePasswordRequest>(data['data']);
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
    if (dataClassName == 'PasswordResetConfirm') {
      return deserialize<_i9u54egm.PasswordResetConfirm>(data['data']);
    }
    if (dataClassName == 'PasswordResetRequest') {
      return deserialize<_in4l34z2.PasswordResetRequest>(data['data']);
    }
    if (dataClassName == 'PasswordResetRequestResult') {
      return deserialize<_ixrmg4rs.PasswordResetRequestResult>(data['data']);
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
    if (dataClassName == 'SuperAdminUpdate') {
      return deserialize<_iccfx1hz.SuperAdminUpdate>(data['data']);
    }
    if (dataClassName == 'SuperAdminView') {
      return deserialize<_ima36n4q.SuperAdminView>(data['data']);
    }
    if (dataClassName == 'UsernameLoginRequest') {
      return deserialize<_i4npd3dl.UsernameLoginRequest>(data['data']);
    }
    if (dataClassName == 'AuthSession') {
      return deserialize<_i30hpih1.AuthSession>(data['data']);
    }
    if (dataClassName == 'Customer') {
      return deserialize<_iosx2li4.Customer>(data['data']);
    }
    if (dataClassName == 'Employee') {
      return deserialize<_iwpz2vh7.Employee>(data['data']);
    }
    if (dataClassName == 'Owner') {
      return deserialize<_i00rpu3b.Owner>(data['data']);
    }
    if (dataClassName == 'PasswordReset') {
      return deserialize<_i5m9ixa9.PasswordReset>(data['data']);
    }
    if (dataClassName == 'SuperAdmin') {
      return deserialize<_ii4fooib.SuperAdmin>(data['data']);
    }
    if (dataClassName == 'AdminBuildingView') {
      return deserialize<_ig4j3dzf.AdminBuildingView>(data['data']);
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
    if (dataClassName == 'StrictModeStep') {
      return deserialize<_i70klpnb.StrictModeStep>(data['data']);
    }
    if (dataClassName == 'Building') {
      return deserialize<_iit041ql.Building>(data['data']);
    }
    if (dataClassName == 'EmployeeAccessCreate') {
      return deserialize<_izbvctbv.EmployeeAccessCreate>(data['data']);
    }
    if (dataClassName == 'EmployeeAccessErrorCode') {
      return deserialize<_ixnbpcjj.EmployeeAccessErrorCode>(data['data']);
    }
    if (dataClassName == 'EmployeeAccessException') {
      return deserialize<_ilz0jt85.EmployeeAccessException>(data['data']);
    }
    if (dataClassName == 'EmployeeAccessUpdate') {
      return deserialize<_ifygdwz2.EmployeeAccessUpdate>(data['data']);
    }
    if (dataClassName == 'EmployeeAccessView') {
      return deserialize<_i8t0l2jw.EmployeeAccessView>(data['data']);
    }
    if (dataClassName == 'EmployeeAccess') {
      return deserialize<_in0lpay2.EmployeeAccess>(data['data']);
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
    if (dataClassName == 'IngredientRestock') {
      return deserialize<_i1tfcnyz.IngredientRestock>(data['data']);
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
    if (dataClassName == 'ArticleComposition') {
      return deserialize<_i3yk9qsn.ArticleComposition>(data['data']);
    }
    if (dataClassName == 'Ingredient') {
      return deserialize<_idxha5j7.Ingredient>(data['data']);
    }
    if (dataClassName == 'MenuArticle') {
      return deserialize<_iowcl7dy.MenuArticle>(data['data']);
    }
    if (dataClassName == 'MenuCategory') {
      return deserialize<_iiovp1sp.MenuCategory>(data['data']);
    }
    if (dataClassName == 'OrderActorView') {
      return deserialize<_ic5jn53k.OrderActorView>(data['data']);
    }
    if (dataClassName == 'OrderAddItems') {
      return deserialize<_iqdnv1pi.OrderAddItems>(data['data']);
    }
    if (dataClassName == 'OrderCreate') {
      return deserialize<_iwmhqcsn.OrderCreate>(data['data']);
    }
    if (dataClassName == 'OrderErrorCode') {
      return deserialize<_iepprhv5.OrderErrorCode>(data['data']);
    }
    if (dataClassName == 'OrderException') {
      return deserialize<_iumotmt8.OrderException>(data['data']);
    }
    if (dataClassName == 'OrderItemCreateLine') {
      return deserialize<_ihzk2s8h.OrderItemCreateLine>(data['data']);
    }
    if (dataClassName == 'OrderItemStatus') {
      return deserialize<_ihsl512g.OrderItemStatus>(data['data']);
    }
    if (dataClassName == 'OrderItemStatusUpdate') {
      return deserialize<_i8vmkag3.OrderItemStatusUpdate>(data['data']);
    }
    if (dataClassName == 'OrderItemView') {
      return deserialize<_in19xqkp.OrderItemView>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_iaqxrbm9.OrderStatus>(data['data']);
    }
    if (dataClassName == 'OrderView') {
      return deserialize<_i5x25q0s.OrderView>(data['data']);
    }
    if (dataClassName == 'VenueOrder') {
      return deserialize<_ihouontj.VenueOrder>(data['data']);
    }
    if (dataClassName == 'VenueOrderItem') {
      return deserialize<_ixvoqikw.VenueOrderItem>(data['data']);
    }
    if (dataClassName == 'TableFloorStatus') {
      return deserialize<_i64byz7d.TableFloorStatus>(data['data']);
    }
    if (dataClassName == 'TableListFilter') {
      return deserialize<_iuz62fg4.TableListFilter>(data['data']);
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
    if (dataClassName == 'VenueTable') {
      return deserialize<_ik40dtuz.VenueTable>(data['data']);
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
      case _i30hpih1.AuthSession:
        return _i30hpih1.AuthSession.t;
      case _iosx2li4.Customer:
        return _iosx2li4.Customer.t;
      case _iwpz2vh7.Employee:
        return _iwpz2vh7.Employee.t;
      case _i00rpu3b.Owner:
        return _i00rpu3b.Owner.t;
      case _i5m9ixa9.PasswordReset:
        return _i5m9ixa9.PasswordReset.t;
      case _ii4fooib.SuperAdmin:
        return _ii4fooib.SuperAdmin.t;
      case _iit041ql.Building:
        return _iit041ql.Building.t;
      case _in0lpay2.EmployeeAccess:
        return _in0lpay2.EmployeeAccess.t;
      case _i3yk9qsn.ArticleComposition:
        return _i3yk9qsn.ArticleComposition.t;
      case _idxha5j7.Ingredient:
        return _idxha5j7.Ingredient.t;
      case _iowcl7dy.MenuArticle:
        return _iowcl7dy.MenuArticle.t;
      case _iiovp1sp.MenuCategory:
        return _iiovp1sp.MenuCategory.t;
      case _ihouontj.VenueOrder:
        return _ihouontj.VenueOrder.t;
      case _ixvoqikw.VenueOrderItem:
        return _ixvoqikw.VenueOrderItem.t;
      case _ik40dtuz.VenueTable:
        return _ik40dtuz.VenueTable.t;
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
