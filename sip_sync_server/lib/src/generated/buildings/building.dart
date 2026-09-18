/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import 'package:sip_sync_server/src/generated/protocol.dart' as _iaib1p48;
import '../auth/employee.dart' as _iujgysn6;
import '../auth/owner.dart' as _it5d988d;
import '../menu/menu_article.dart' as _if01ezzg;
import '../menu/menu_category.dart' as _iotiu00c;
import '../tables/venue_table.dart' as _inhrqiu4;

/// A café, restaurant, lounge, bar, or custom venue owned by one owner.
abstract class Building
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  Building._({
    this.id,
    required this.ownerId,
    this.owner,
    required this.name,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.openingMinutes,
    required this.closingMinutes,
    required this.currencyCode,
    DateTime? createdAt,
    this.employees,
    this.tables,
    this.menuCategories,
    this.menuArticles,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Building({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    _it5d988d.Owner? owner,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    DateTime? createdAt,
    List<_iujgysn6.Employee>? employees,
    List<_inhrqiu4.VenueTable>? tables,
    List<_iotiu00c.MenuCategory>? menuCategories,
    List<_if01ezzg.MenuArticle>? menuArticles,
  }) = _BuildingImpl;

  factory Building.fromJson(Map<String, dynamic> jsonSerialization) {
    return Building(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      owner: jsonSerialization['owner'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_it5d988d.Owner>(
              jsonSerialization['owner'],
            ),
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      address: jsonSerialization['address'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      openingMinutes: jsonSerialization['openingMinutes'] as int,
      closingMinutes: jsonSerialization['closingMinutes'] as int,
      currencyCode: jsonSerialization['currencyCode'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      employees: jsonSerialization['employees'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_iujgysn6.Employee>>(
              jsonSerialization['employees'],
            ),
      tables: jsonSerialization['tables'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_inhrqiu4.VenueTable>>(
              jsonSerialization['tables'],
            ),
      menuCategories: jsonSerialization['menuCategories'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_iotiu00c.MenuCategory>>(
              jsonSerialization['menuCategories'],
            ),
      menuArticles: jsonSerialization['menuArticles'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_if01ezzg.MenuArticle>>(
              jsonSerialization['menuArticles'],
            ),
    );
  }

  static final t = BuildingTable();

  static const db = BuildingRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue ownerId;

  _it5d988d.Owner? owner;

  String name;

  String type;

  String address;

  double latitude;

  double longitude;

  int openingMinutes;

  int closingMinutes;

  String currencyCode;

  DateTime createdAt;

  List<_iujgysn6.Employee>? employees;

  List<_inhrqiu4.VenueTable>? tables;

  List<_iotiu00c.MenuCategory>? menuCategories;

  List<_if01ezzg.MenuArticle>? menuArticles;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Building]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Building copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    _it5d988d.Owner? owner,
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    int? openingMinutes,
    int? closingMinutes,
    String? currencyCode,
    DateTime? createdAt,
    List<_iujgysn6.Employee>? employees,
    List<_inhrqiu4.VenueTable>? tables,
    List<_iotiu00c.MenuCategory>? menuCategories,
    List<_if01ezzg.MenuArticle>? menuArticles,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Building',
      if (id != null) 'id': id?.toJson(),
      'ownerId': ownerId.toJson(),
      if (owner != null) 'owner': owner?.toJson(),
      'name': name,
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'openingMinutes': openingMinutes,
      'closingMinutes': closingMinutes,
      'currencyCode': currencyCode,
      'createdAt': createdAt.toJson(),
      if (employees != null)
        'employees': employees?.toJson(valueToJson: (v) => v.toJson()),
      if (tables != null)
        'tables': tables?.toJson(valueToJson: (v) => v.toJson()),
      if (menuCategories != null)
        'menuCategories': menuCategories?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (menuArticles != null)
        'menuArticles': menuArticles?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static BuildingInclude include({
    _it5d988d.OwnerInclude? owner,
    _iujgysn6.EmployeeIncludeList? employees,
    _inhrqiu4.VenueTableIncludeList? tables,
    _iotiu00c.MenuCategoryIncludeList? menuCategories,
    _if01ezzg.MenuArticleIncludeList? menuArticles,
  }) {
    return BuildingInclude._(
      owner: owner,
      employees: employees,
      tables: tables,
      menuCategories: menuCategories,
      menuArticles: menuArticles,
    );
  }

  static BuildingIncludeList includeList({
    _is.WhereExpressionBuilder<BuildingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BuildingTable>? orderBy,
    _is.OrderByListBuilder<BuildingTable>? orderByList,
    BuildingInclude? include,
  }) {
    return BuildingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Building.t),
      orderByList: orderByList?.call(Building.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BuildingImpl extends Building {
  _BuildingImpl({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    _it5d988d.Owner? owner,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    DateTime? createdAt,
    List<_iujgysn6.Employee>? employees,
    List<_inhrqiu4.VenueTable>? tables,
    List<_iotiu00c.MenuCategory>? menuCategories,
    List<_if01ezzg.MenuArticle>? menuArticles,
  }) : super._(
         id: id,
         ownerId: ownerId,
         owner: owner,
         name: name,
         type: type,
         address: address,
         latitude: latitude,
         longitude: longitude,
         openingMinutes: openingMinutes,
         closingMinutes: closingMinutes,
         currencyCode: currencyCode,
         createdAt: createdAt,
         employees: employees,
         tables: tables,
         menuCategories: menuCategories,
         menuArticles: menuArticles,
       );

  /// Returns a shallow copy of this [Building]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Building copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
    Object? owner = _Undefined,
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    int? openingMinutes,
    int? closingMinutes,
    String? currencyCode,
    DateTime? createdAt,
    Object? employees = _Undefined,
    Object? tables = _Undefined,
    Object? menuCategories = _Undefined,
    Object? menuArticles = _Undefined,
  }) {
    return Building(
      id: id is _is.UuidValue? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      owner: owner is _it5d988d.Owner? ? owner : this.owner?.copyWith(),
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      openingMinutes: openingMinutes ?? this.openingMinutes,
      closingMinutes: closingMinutes ?? this.closingMinutes,
      currencyCode: currencyCode ?? this.currencyCode,
      createdAt: createdAt ?? this.createdAt,
      employees: employees is List<_iujgysn6.Employee>?
          ? employees
          : this.employees?.map((e0) => e0.copyWith()).toList(),
      tables: tables is List<_inhrqiu4.VenueTable>?
          ? tables
          : this.tables?.map((e0) => e0.copyWith()).toList(),
      menuCategories: menuCategories is List<_iotiu00c.MenuCategory>?
          ? menuCategories
          : this.menuCategories?.map((e0) => e0.copyWith()).toList(),
      menuArticles: menuArticles is List<_if01ezzg.MenuArticle>?
          ? menuArticles
          : this.menuArticles?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class BuildingUpdateTable extends _is.UpdateTable<BuildingTable> {
  BuildingUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> type(String value) => _is.ColumnValue(
    table.type,
    value,
  );

  _is.ColumnValue<String, String> address(String value) => _is.ColumnValue(
    table.address,
    value,
  );

  _is.ColumnValue<double, double> latitude(double value) => _is.ColumnValue(
    table.latitude,
    value,
  );

  _is.ColumnValue<double, double> longitude(double value) => _is.ColumnValue(
    table.longitude,
    value,
  );

  _is.ColumnValue<int, int> openingMinutes(int value) => _is.ColumnValue(
    table.openingMinutes,
    value,
  );

  _is.ColumnValue<int, int> closingMinutes(int value) => _is.ColumnValue(
    table.closingMinutes,
    value,
  );

  _is.ColumnValue<String, String> currencyCode(String value) => _is.ColumnValue(
    table.currencyCode,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class BuildingTable extends _is.Table<_is.UuidValue?> {
  BuildingTable({super.tableRelation}) : super(tableName: 'building') {
    updateTable = BuildingUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    type = _is.ColumnString(
      'type',
      this,
    );
    address = _is.ColumnString(
      'address',
      this,
    );
    latitude = _is.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _is.ColumnDouble(
      'longitude',
      this,
    );
    openingMinutes = _is.ColumnInt(
      'openingMinutes',
      this,
    );
    closingMinutes = _is.ColumnInt(
      'closingMinutes',
      this,
    );
    currencyCode = _is.ColumnString(
      'currencyCode',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final BuildingUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  _it5d988d.OwnerTable? _owner;

  late final _is.ColumnString name;

  late final _is.ColumnString type;

  late final _is.ColumnString address;

  late final _is.ColumnDouble latitude;

  late final _is.ColumnDouble longitude;

  late final _is.ColumnInt openingMinutes;

  late final _is.ColumnInt closingMinutes;

  late final _is.ColumnString currencyCode;

  late final _is.ColumnDateTime createdAt;

  _iujgysn6.EmployeeTable? ___employees;

  _is.ManyRelation<_iujgysn6.EmployeeTable>? _employees;

  _inhrqiu4.VenueTableTable? ___tables;

  _is.ManyRelation<_inhrqiu4.VenueTableTable>? _tables;

  _iotiu00c.MenuCategoryTable? ___menuCategories;

  _is.ManyRelation<_iotiu00c.MenuCategoryTable>? _menuCategories;

  _if01ezzg.MenuArticleTable? ___menuArticles;

  _is.ManyRelation<_if01ezzg.MenuArticleTable>? _menuArticles;

  _it5d988d.OwnerTable get owner {
    if (_owner != null) return _owner!;
    _owner = _is.createRelationTable(
      relationFieldName: 'owner',
      field: Building.t.ownerId,
      foreignField: _it5d988d.Owner.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _it5d988d.OwnerTable(tableRelation: foreignTableRelation),
    );
    return _owner!;
  }

  _iujgysn6.EmployeeTable get __employees {
    if (___employees != null) return ___employees!;
    ___employees = _is.createRelationTable(
      relationFieldName: '__employees',
      field: Building.t.id,
      foreignField: _iujgysn6.Employee.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iujgysn6.EmployeeTable(tableRelation: foreignTableRelation),
    );
    return ___employees!;
  }

  _inhrqiu4.VenueTableTable get __tables {
    if (___tables != null) return ___tables!;
    ___tables = _is.createRelationTable(
      relationFieldName: '__tables',
      field: Building.t.id,
      foreignField: _inhrqiu4.VenueTable.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _inhrqiu4.VenueTableTable(tableRelation: foreignTableRelation),
    );
    return ___tables!;
  }

  _iotiu00c.MenuCategoryTable get __menuCategories {
    if (___menuCategories != null) return ___menuCategories!;
    ___menuCategories = _is.createRelationTable(
      relationFieldName: '__menuCategories',
      field: Building.t.id,
      foreignField: _iotiu00c.MenuCategory.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iotiu00c.MenuCategoryTable(tableRelation: foreignTableRelation),
    );
    return ___menuCategories!;
  }

  _if01ezzg.MenuArticleTable get __menuArticles {
    if (___menuArticles != null) return ___menuArticles!;
    ___menuArticles = _is.createRelationTable(
      relationFieldName: '__menuArticles',
      field: Building.t.id,
      foreignField: _if01ezzg.MenuArticle.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _if01ezzg.MenuArticleTable(tableRelation: foreignTableRelation),
    );
    return ___menuArticles!;
  }

  _is.ManyRelation<_iujgysn6.EmployeeTable> get employees {
    if (_employees != null) return _employees!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'employees',
      field: Building.t.id,
      foreignField: _iujgysn6.Employee.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iujgysn6.EmployeeTable(tableRelation: foreignTableRelation),
    );
    _employees = _is.ManyRelation<_iujgysn6.EmployeeTable>(
      tableWithRelations: relationTable,
      table: _iujgysn6.EmployeeTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _employees!;
  }

  _is.ManyRelation<_inhrqiu4.VenueTableTable> get tables {
    if (_tables != null) return _tables!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'tables',
      field: Building.t.id,
      foreignField: _inhrqiu4.VenueTable.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _inhrqiu4.VenueTableTable(tableRelation: foreignTableRelation),
    );
    _tables = _is.ManyRelation<_inhrqiu4.VenueTableTable>(
      tableWithRelations: relationTable,
      table: _inhrqiu4.VenueTableTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _tables!;
  }

  _is.ManyRelation<_iotiu00c.MenuCategoryTable> get menuCategories {
    if (_menuCategories != null) return _menuCategories!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'menuCategories',
      field: Building.t.id,
      foreignField: _iotiu00c.MenuCategory.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iotiu00c.MenuCategoryTable(tableRelation: foreignTableRelation),
    );
    _menuCategories = _is.ManyRelation<_iotiu00c.MenuCategoryTable>(
      tableWithRelations: relationTable,
      table: _iotiu00c.MenuCategoryTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _menuCategories!;
  }

  _is.ManyRelation<_if01ezzg.MenuArticleTable> get menuArticles {
    if (_menuArticles != null) return _menuArticles!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'menuArticles',
      field: Building.t.id,
      foreignField: _if01ezzg.MenuArticle.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _if01ezzg.MenuArticleTable(tableRelation: foreignTableRelation),
    );
    _menuArticles = _is.ManyRelation<_if01ezzg.MenuArticleTable>(
      tableWithRelations: relationTable,
      table: _if01ezzg.MenuArticleTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _menuArticles!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    name,
    type,
    address,
    latitude,
    longitude,
    openingMinutes,
    closingMinutes,
    currencyCode,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'owner') {
      return owner;
    }
    if (relationField == 'employees') {
      return __employees;
    }
    if (relationField == 'tables') {
      return __tables;
    }
    if (relationField == 'menuCategories') {
      return __menuCategories;
    }
    if (relationField == 'menuArticles') {
      return __menuArticles;
    }
    return null;
  }
}

class BuildingInclude extends _is.IncludeObject {
  BuildingInclude._({
    _it5d988d.OwnerInclude? owner,
    _iujgysn6.EmployeeIncludeList? employees,
    _inhrqiu4.VenueTableIncludeList? tables,
    _iotiu00c.MenuCategoryIncludeList? menuCategories,
    _if01ezzg.MenuArticleIncludeList? menuArticles,
  }) {
    _owner = owner;
    _employees = employees;
    _tables = tables;
    _menuCategories = menuCategories;
    _menuArticles = menuArticles;
  }

  _it5d988d.OwnerInclude? _owner;

  _iujgysn6.EmployeeIncludeList? _employees;

  _inhrqiu4.VenueTableIncludeList? _tables;

  _iotiu00c.MenuCategoryIncludeList? _menuCategories;

  _if01ezzg.MenuArticleIncludeList? _menuArticles;

  @override
  Map<String, _is.Include?> get includes => {
    'owner': _owner,
    'employees': _employees,
    'tables': _tables,
    'menuCategories': _menuCategories,
    'menuArticles': _menuArticles,
  };

  @override
  _is.Table<_is.UuidValue?> get table => Building.t;
}

class BuildingIncludeList extends _is.IncludeList {
  BuildingIncludeList._({
    _is.WhereExpressionBuilder<BuildingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Building.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => Building.t;
}

class BuildingRepository {
  const BuildingRepository._();

  final attach = const BuildingAttachRepository._();

  final attachRow = const BuildingAttachRowRepository._();

  /// Returns a list of [Building]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Building>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BuildingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BuildingTable>? orderBy,
    _is.OrderByListBuilder<BuildingTable>? orderByList,
    _is.Transaction? transaction,
    BuildingInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Building>(
      where: where?.call(Building.t),
      orderBy: orderBy?.call(Building.t),
      orderByList: orderByList?.call(Building.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Building] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Building?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BuildingTable>? where,
    int? offset,
    _is.OrderByBuilder<BuildingTable>? orderBy,
    _is.OrderByListBuilder<BuildingTable>? orderByList,
    _is.Transaction? transaction,
    BuildingInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Building>(
      where: where?.call(Building.t),
      orderBy: orderBy?.call(Building.t),
      orderByList: orderByList?.call(Building.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Building] by its [id] or null if no such row exists.
  Future<Building?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    BuildingInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Building>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Building]s in the list and returns the inserted rows.
  ///
  /// The returned [Building]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Building>> insert(
    _is.DatabaseSession session,
    List<Building> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Building>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Building] and returns the inserted row.
  ///
  /// The returned [Building] will have its `id` field set.
  Future<Building> insertRow(
    _is.DatabaseSession session,
    Building row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Building>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Building]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Building]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Building>> upsert(
    _is.DatabaseSession session,
    List<Building> rows, {
    required _is.ColumnSelections<BuildingTable> conflictColumns,
    _is.ColumnSelections<BuildingTable>? updateColumns,
    _is.WhereExpressionBuilder<BuildingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Building>(
      rows,
      conflictColumns: conflictColumns(Building.t),
      updateColumns: updateColumns?.call(Building.t),
      updateWhere: updateWhere?.call(Building.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Building] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Building] will have its `id` field set.
  Future<Building?> upsertRow(
    _is.DatabaseSession session,
    Building row, {
    required _is.ColumnSelections<BuildingTable> conflictColumns,
    _is.ColumnSelections<BuildingTable>? updateColumns,
    _is.WhereExpressionBuilder<BuildingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Building>(
      row,
      conflictColumns: conflictColumns(Building.t),
      updateColumns: updateColumns?.call(Building.t),
      updateWhere: updateWhere?.call(Building.t),
      transaction: transaction,
    );
  }

  /// Updates all [Building]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Building>> update(
    _is.DatabaseSession session,
    List<Building> rows, {
    _is.ColumnSelections<BuildingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Building>(
      rows,
      columns: columns?.call(Building.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Building]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Building> updateRow(
    _is.DatabaseSession session,
    Building row, {
    _is.ColumnSelections<BuildingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Building>(
      row,
      columns: columns?.call(Building.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Building] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Building?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<BuildingUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Building>(
      id,
      columnValues: columnValues(Building.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Building]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Building>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BuildingUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BuildingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BuildingTable>? orderBy,
    _is.OrderByListBuilder<BuildingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Building>(
      columnValues: columnValues(Building.t.updateTable),
      where: where(Building.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Building.t),
      orderByList: orderByList?.call(Building.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Building]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Building>> delete(
    _is.DatabaseSession session,
    List<Building> rows, {
    _is.OrderByBuilder<BuildingTable>? orderBy,
    _is.OrderByListBuilder<BuildingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Building>(
      rows,
      orderBy: orderBy?.call(Building.t),
      orderByList: orderByList?.call(Building.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Building].
  Future<Building> deleteRow(
    _is.DatabaseSession session,
    Building row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Building>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Building>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BuildingTable> where,
    _is.OrderByBuilder<BuildingTable>? orderBy,
    _is.OrderByListBuilder<BuildingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Building>(
      where: where(Building.t),
      orderBy: orderBy?.call(Building.t),
      orderByList: orderByList?.call(Building.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BuildingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Building>(
      where: where?.call(Building.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Building] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BuildingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Building>(
      where: where(Building.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class BuildingAttachRepository {
  const BuildingAttachRepository._();

  /// Creates a relation between this [Building] and the given [Employee]s
  /// by setting each [Employee]'s foreign key `buildingId` to refer to this [Building].
  Future<void> employees(
    _is.DatabaseSession session,
    Building building,
    List<_iujgysn6.Employee> employee, {
    _is.Transaction? transaction,
  }) async {
    if (employee.any((e) => e.id == null)) {
      throw ArgumentError.notNull('employee.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $employee = employee
        .map((e) => e.copyWith(buildingId: building.id))
        .toList();
    await session.db.update<_iujgysn6.Employee>(
      $employee,
      columns: [_iujgysn6.Employee.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [VenueTable]s
  /// by setting each [VenueTable]'s foreign key `buildingId` to refer to this [Building].
  Future<void> tables(
    _is.DatabaseSession session,
    Building building,
    List<_inhrqiu4.VenueTable> venueTable, {
    _is.Transaction? transaction,
  }) async {
    if (venueTable.any((e) => e.id == null)) {
      throw ArgumentError.notNull('venueTable.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $venueTable = venueTable
        .map((e) => e.copyWith(buildingId: building.id))
        .toList();
    await session.db.update<_inhrqiu4.VenueTable>(
      $venueTable,
      columns: [_inhrqiu4.VenueTable.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [MenuCategory]s
  /// by setting each [MenuCategory]'s foreign key `buildingId` to refer to this [Building].
  Future<void> menuCategories(
    _is.DatabaseSession session,
    Building building,
    List<_iotiu00c.MenuCategory> menuCategory, {
    _is.Transaction? transaction,
  }) async {
    if (menuCategory.any((e) => e.id == null)) {
      throw ArgumentError.notNull('menuCategory.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $menuCategory = menuCategory
        .map((e) => e.copyWith(buildingId: building.id))
        .toList();
    await session.db.update<_iotiu00c.MenuCategory>(
      $menuCategory,
      columns: [_iotiu00c.MenuCategory.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [MenuArticle]s
  /// by setting each [MenuArticle]'s foreign key `buildingId` to refer to this [Building].
  Future<void> menuArticles(
    _is.DatabaseSession session,
    Building building,
    List<_if01ezzg.MenuArticle> menuArticle, {
    _is.Transaction? transaction,
  }) async {
    if (menuArticle.any((e) => e.id == null)) {
      throw ArgumentError.notNull('menuArticle.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $menuArticle = menuArticle
        .map((e) => e.copyWith(buildingId: building.id))
        .toList();
    await session.db.update<_if01ezzg.MenuArticle>(
      $menuArticle,
      columns: [_if01ezzg.MenuArticle.t.buildingId],
      transaction: transaction,
    );
  }
}

class BuildingAttachRowRepository {
  const BuildingAttachRowRepository._();

  /// Creates a relation between the given [Building] and [Owner]
  /// by setting the [Building]'s foreign key `ownerId` to refer to the [Owner].
  Future<void> owner(
    _is.DatabaseSession session,
    Building building,
    _it5d988d.Owner owner, {
    _is.Transaction? transaction,
  }) async {
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }
    if (owner.id == null) {
      throw ArgumentError.notNull('owner.id');
    }

    var $building = building.copyWith(ownerId: owner.id);
    await session.db.updateRow<Building>(
      $building,
      columns: [Building.t.ownerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [Employee]
  /// by setting the [Employee]'s foreign key `buildingId` to refer to this [Building].
  Future<void> employees(
    _is.DatabaseSession session,
    Building building,
    _iujgysn6.Employee employee, {
    _is.Transaction? transaction,
  }) async {
    if (employee.id == null) {
      throw ArgumentError.notNull('employee.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $employee = employee.copyWith(buildingId: building.id);
    await session.db.updateRow<_iujgysn6.Employee>(
      $employee,
      columns: [_iujgysn6.Employee.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [VenueTable]
  /// by setting the [VenueTable]'s foreign key `buildingId` to refer to this [Building].
  Future<void> tables(
    _is.DatabaseSession session,
    Building building,
    _inhrqiu4.VenueTable venueTable, {
    _is.Transaction? transaction,
  }) async {
    if (venueTable.id == null) {
      throw ArgumentError.notNull('venueTable.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $venueTable = venueTable.copyWith(buildingId: building.id);
    await session.db.updateRow<_inhrqiu4.VenueTable>(
      $venueTable,
      columns: [_inhrqiu4.VenueTable.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [MenuCategory]
  /// by setting the [MenuCategory]'s foreign key `buildingId` to refer to this [Building].
  Future<void> menuCategories(
    _is.DatabaseSession session,
    Building building,
    _iotiu00c.MenuCategory menuCategory, {
    _is.Transaction? transaction,
  }) async {
    if (menuCategory.id == null) {
      throw ArgumentError.notNull('menuCategory.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $menuCategory = menuCategory.copyWith(buildingId: building.id);
    await session.db.updateRow<_iotiu00c.MenuCategory>(
      $menuCategory,
      columns: [_iotiu00c.MenuCategory.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [MenuArticle]
  /// by setting the [MenuArticle]'s foreign key `buildingId` to refer to this [Building].
  Future<void> menuArticles(
    _is.DatabaseSession session,
    Building building,
    _if01ezzg.MenuArticle menuArticle, {
    _is.Transaction? transaction,
  }) async {
    if (menuArticle.id == null) {
      throw ArgumentError.notNull('menuArticle.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $menuArticle = menuArticle.copyWith(buildingId: building.id);
    await session.db.updateRow<_if01ezzg.MenuArticle>(
      $menuArticle,
      columns: [_if01ezzg.MenuArticle.t.buildingId],
      transaction: transaction,
    );
  }
}
