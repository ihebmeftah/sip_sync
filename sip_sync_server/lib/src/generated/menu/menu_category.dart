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
import '../buildings/building.dart' as _idz3611u;
import '../menu/menu_article.dart' as _if01ezzg;

/// A menu category scoped to one building.
abstract class MenuCategory
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  MenuCategory._({
    this.id,
    required this.buildingId,
    this.building,
    required this.name,
    this.description,
    DateTime? createdAt,
    this.articles,
  }) : createdAt = createdAt ?? DateTime.now();

  factory MenuCategory({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _idz3611u.Building? building,
    required String name,
    String? description,
    DateTime? createdAt,
    List<_if01ezzg.MenuArticle>? articles,
  }) = _MenuCategoryImpl;

  factory MenuCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuCategory(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      building: jsonSerialization['building'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_idz3611u.Building>(
              jsonSerialization['building'],
            ),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      articles: jsonSerialization['articles'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_if01ezzg.MenuArticle>>(
              jsonSerialization['articles'],
            ),
    );
  }

  static final t = MenuCategoryTable();

  static const db = MenuCategoryRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue buildingId;

  _idz3611u.Building? building;

  String name;

  String? description;

  DateTime createdAt;

  List<_if01ezzg.MenuArticle>? articles;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [MenuCategory]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MenuCategory copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    _idz3611u.Building? building,
    String? name,
    String? description,
    DateTime? createdAt,
    List<_if01ezzg.MenuArticle>? articles,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuCategory',
      if (id != null) 'id': id?.toJson(),
      'buildingId': buildingId.toJson(),
      if (building != null) 'building': building?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
      if (articles != null)
        'articles': articles?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static MenuCategoryInclude include({
    _idz3611u.BuildingInclude? building,
    _if01ezzg.MenuArticleIncludeList? articles,
  }) {
    return MenuCategoryInclude._(
      building: building,
      articles: articles,
    );
  }

  static MenuCategoryIncludeList includeList({
    _is.WhereExpressionBuilder<MenuCategoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MenuCategoryTable>? orderBy,
    _is.OrderByListBuilder<MenuCategoryTable>? orderByList,
    MenuCategoryInclude? include,
  }) {
    return MenuCategoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MenuCategory.t),
      orderByList: orderByList?.call(MenuCategory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MenuCategoryImpl extends MenuCategory {
  _MenuCategoryImpl({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _idz3611u.Building? building,
    required String name,
    String? description,
    DateTime? createdAt,
    List<_if01ezzg.MenuArticle>? articles,
  }) : super._(
         id: id,
         buildingId: buildingId,
         building: building,
         name: name,
         description: description,
         createdAt: createdAt,
         articles: articles,
       );

  /// Returns a shallow copy of this [MenuCategory]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MenuCategory copyWith({
    Object? id = _Undefined,
    _is.UuidValue? buildingId,
    Object? building = _Undefined,
    String? name,
    Object? description = _Undefined,
    DateTime? createdAt,
    Object? articles = _Undefined,
  }) {
    return MenuCategory(
      id: id is _is.UuidValue? ? id : this.id,
      buildingId: buildingId ?? this.buildingId,
      building: building is _idz3611u.Building?
          ? building
          : this.building?.copyWith(),
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      createdAt: createdAt ?? this.createdAt,
      articles: articles is List<_if01ezzg.MenuArticle>?
          ? articles
          : this.articles?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class MenuCategoryUpdateTable extends _is.UpdateTable<MenuCategoryTable> {
  MenuCategoryUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> buildingId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.buildingId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class MenuCategoryTable extends _is.Table<_is.UuidValue?> {
  MenuCategoryTable({super.tableRelation}) : super(tableName: 'menu_category') {
    updateTable = MenuCategoryUpdateTable(this);
    buildingId = _is.ColumnUuid(
      'buildingId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final MenuCategoryUpdateTable updateTable;

  late final _is.ColumnUuid buildingId;

  _idz3611u.BuildingTable? _building;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnDateTime createdAt;

  _if01ezzg.MenuArticleTable? ___articles;

  _is.ManyRelation<_if01ezzg.MenuArticleTable>? _articles;

  _idz3611u.BuildingTable get building {
    if (_building != null) return _building!;
    _building = _is.createRelationTable(
      relationFieldName: 'building',
      field: MenuCategory.t.buildingId,
      foreignField: _idz3611u.Building.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _idz3611u.BuildingTable(tableRelation: foreignTableRelation),
    );
    return _building!;
  }

  _if01ezzg.MenuArticleTable get __articles {
    if (___articles != null) return ___articles!;
    ___articles = _is.createRelationTable(
      relationFieldName: '__articles',
      field: MenuCategory.t.id,
      foreignField: _if01ezzg.MenuArticle.t.categoryId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _if01ezzg.MenuArticleTable(tableRelation: foreignTableRelation),
    );
    return ___articles!;
  }

  _is.ManyRelation<_if01ezzg.MenuArticleTable> get articles {
    if (_articles != null) return _articles!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'articles',
      field: MenuCategory.t.id,
      foreignField: _if01ezzg.MenuArticle.t.categoryId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _if01ezzg.MenuArticleTable(tableRelation: foreignTableRelation),
    );
    _articles = _is.ManyRelation<_if01ezzg.MenuArticleTable>(
      tableWithRelations: relationTable,
      table: _if01ezzg.MenuArticleTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _articles!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    buildingId,
    name,
    description,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'building') {
      return building;
    }
    if (relationField == 'articles') {
      return __articles;
    }
    return null;
  }
}

class MenuCategoryInclude extends _is.IncludeObject {
  MenuCategoryInclude._({
    _idz3611u.BuildingInclude? building,
    _if01ezzg.MenuArticleIncludeList? articles,
  }) {
    _building = building;
    _articles = articles;
  }

  _idz3611u.BuildingInclude? _building;

  _if01ezzg.MenuArticleIncludeList? _articles;

  @override
  Map<String, _is.Include?> get includes => {
    'building': _building,
    'articles': _articles,
  };

  @override
  _is.Table<_is.UuidValue?> get table => MenuCategory.t;
}

class MenuCategoryIncludeList extends _is.IncludeList {
  MenuCategoryIncludeList._({
    _is.WhereExpressionBuilder<MenuCategoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MenuCategory.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => MenuCategory.t;
}

class MenuCategoryRepository {
  const MenuCategoryRepository._();

  final attach = const MenuCategoryAttachRepository._();

  final attachRow = const MenuCategoryAttachRowRepository._();

  /// Returns a list of [MenuCategory]s matching the given query parameters.
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
  Future<List<MenuCategory>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MenuCategoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MenuCategoryTable>? orderBy,
    _is.OrderByListBuilder<MenuCategoryTable>? orderByList,
    _is.Transaction? transaction,
    MenuCategoryInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MenuCategory>(
      where: where?.call(MenuCategory.t),
      orderBy: orderBy?.call(MenuCategory.t),
      orderByList: orderByList?.call(MenuCategory.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MenuCategory] matching the given query parameters.
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
  Future<MenuCategory?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MenuCategoryTable>? where,
    int? offset,
    _is.OrderByBuilder<MenuCategoryTable>? orderBy,
    _is.OrderByListBuilder<MenuCategoryTable>? orderByList,
    _is.Transaction? transaction,
    MenuCategoryInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MenuCategory>(
      where: where?.call(MenuCategory.t),
      orderBy: orderBy?.call(MenuCategory.t),
      orderByList: orderByList?.call(MenuCategory.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MenuCategory] by its [id] or null if no such row exists.
  Future<MenuCategory?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    MenuCategoryInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MenuCategory>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MenuCategory]s in the list and returns the inserted rows.
  ///
  /// The returned [MenuCategory]s will have their `id` fields set.
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
  Future<List<MenuCategory>> insert(
    _is.DatabaseSession session,
    List<MenuCategory> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MenuCategory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MenuCategory] and returns the inserted row.
  ///
  /// The returned [MenuCategory] will have its `id` field set.
  Future<MenuCategory> insertRow(
    _is.DatabaseSession session,
    MenuCategory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MenuCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [MenuCategory]s in the list and returns the resulting rows.
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
  /// The returned [MenuCategory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MenuCategory>> upsert(
    _is.DatabaseSession session,
    List<MenuCategory> rows, {
    required _is.ColumnSelections<MenuCategoryTable> conflictColumns,
    _is.ColumnSelections<MenuCategoryTable>? updateColumns,
    _is.WhereExpressionBuilder<MenuCategoryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MenuCategory>(
      rows,
      conflictColumns: conflictColumns(MenuCategory.t),
      updateColumns: updateColumns?.call(MenuCategory.t),
      updateWhere: updateWhere?.call(MenuCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MenuCategory] and returns the resulting row.
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
  /// The returned [MenuCategory] will have its `id` field set.
  Future<MenuCategory?> upsertRow(
    _is.DatabaseSession session,
    MenuCategory row, {
    required _is.ColumnSelections<MenuCategoryTable> conflictColumns,
    _is.ColumnSelections<MenuCategoryTable>? updateColumns,
    _is.WhereExpressionBuilder<MenuCategoryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MenuCategory>(
      row,
      conflictColumns: conflictColumns(MenuCategory.t),
      updateColumns: updateColumns?.call(MenuCategory.t),
      updateWhere: updateWhere?.call(MenuCategory.t),
      transaction: transaction,
    );
  }

  /// Updates all [MenuCategory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MenuCategory>> update(
    _is.DatabaseSession session,
    List<MenuCategory> rows, {
    _is.ColumnSelections<MenuCategoryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MenuCategory>(
      rows,
      columns: columns?.call(MenuCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MenuCategory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MenuCategory> updateRow(
    _is.DatabaseSession session,
    MenuCategory row, {
    _is.ColumnSelections<MenuCategoryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MenuCategory>(
      row,
      columns: columns?.call(MenuCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MenuCategory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MenuCategory?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<MenuCategoryUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MenuCategory>(
      id,
      columnValues: columnValues(MenuCategory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MenuCategory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MenuCategory>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MenuCategoryUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MenuCategoryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MenuCategoryTable>? orderBy,
    _is.OrderByListBuilder<MenuCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MenuCategory>(
      columnValues: columnValues(MenuCategory.t.updateTable),
      where: where(MenuCategory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MenuCategory.t),
      orderByList: orderByList?.call(MenuCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MenuCategory]s in the list and returns the deleted rows.
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
  Future<List<MenuCategory>> delete(
    _is.DatabaseSession session,
    List<MenuCategory> rows, {
    _is.OrderByBuilder<MenuCategoryTable>? orderBy,
    _is.OrderByListBuilder<MenuCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MenuCategory>(
      rows,
      orderBy: orderBy?.call(MenuCategory.t),
      orderByList: orderByList?.call(MenuCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MenuCategory].
  Future<MenuCategory> deleteRow(
    _is.DatabaseSession session,
    MenuCategory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MenuCategory>(
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
  Future<List<MenuCategory>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MenuCategoryTable> where,
    _is.OrderByBuilder<MenuCategoryTable>? orderBy,
    _is.OrderByListBuilder<MenuCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MenuCategory>(
      where: where(MenuCategory.t),
      orderBy: orderBy?.call(MenuCategory.t),
      orderByList: orderByList?.call(MenuCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MenuCategoryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MenuCategory>(
      where: where?.call(MenuCategory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MenuCategory] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MenuCategoryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MenuCategory>(
      where: where(MenuCategory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class MenuCategoryAttachRepository {
  const MenuCategoryAttachRepository._();

  /// Creates a relation between this [MenuCategory] and the given [MenuArticle]s
  /// by setting each [MenuArticle]'s foreign key `categoryId` to refer to this [MenuCategory].
  Future<void> articles(
    _is.DatabaseSession session,
    MenuCategory menuCategory,
    List<_if01ezzg.MenuArticle> menuArticle, {
    _is.Transaction? transaction,
  }) async {
    if (menuArticle.any((e) => e.id == null)) {
      throw ArgumentError.notNull('menuArticle.id');
    }
    if (menuCategory.id == null) {
      throw ArgumentError.notNull('menuCategory.id');
    }

    var $menuArticle = menuArticle
        .map((e) => e.copyWith(categoryId: menuCategory.id))
        .toList();
    await session.db.update<_if01ezzg.MenuArticle>(
      $menuArticle,
      columns: [_if01ezzg.MenuArticle.t.categoryId],
      transaction: transaction,
    );
  }
}

class MenuCategoryAttachRowRepository {
  const MenuCategoryAttachRowRepository._();

  /// Creates a relation between the given [MenuCategory] and [Building]
  /// by setting the [MenuCategory]'s foreign key `buildingId` to refer to the [Building].
  Future<void> building(
    _is.DatabaseSession session,
    MenuCategory menuCategory,
    _idz3611u.Building building, {
    _is.Transaction? transaction,
  }) async {
    if (menuCategory.id == null) {
      throw ArgumentError.notNull('menuCategory.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $menuCategory = menuCategory.copyWith(buildingId: building.id);
    await session.db.updateRow<MenuCategory>(
      $menuCategory,
      columns: [MenuCategory.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [MenuCategory] and the given [MenuArticle]
  /// by setting the [MenuArticle]'s foreign key `categoryId` to refer to this [MenuCategory].
  Future<void> articles(
    _is.DatabaseSession session,
    MenuCategory menuCategory,
    _if01ezzg.MenuArticle menuArticle, {
    _is.Transaction? transaction,
  }) async {
    if (menuArticle.id == null) {
      throw ArgumentError.notNull('menuArticle.id');
    }
    if (menuCategory.id == null) {
      throw ArgumentError.notNull('menuCategory.id');
    }

    var $menuArticle = menuArticle.copyWith(categoryId: menuCategory.id);
    await session.db.updateRow<_if01ezzg.MenuArticle>(
      $menuArticle,
      columns: [_if01ezzg.MenuArticle.t.categoryId],
      transaction: transaction,
    );
  }
}
