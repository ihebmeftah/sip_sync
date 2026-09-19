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
import '../../buildings/entity/building.dart' as _iaohraio;
import '../../menu/entity/article_composition.dart' as _ifzlh5t7;
import '../../menu/entity/menu_category.dart' as _illkjvef;

/// A sellable menu article in one building, belonging to a category.
abstract class MenuArticle
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  MenuArticle._({
    this.id,
    required this.buildingId,
    this.building,
    required this.categoryId,
    this.category,
    required this.name,
    this.description,
    required this.price,
    DateTime? createdAt,
    this.compositions,
  }) : createdAt = createdAt ?? DateTime.now();

  factory MenuArticle({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    required _is.UuidValue categoryId,
    _illkjvef.MenuCategory? category,
    required String name,
    String? description,
    required double price,
    DateTime? createdAt,
    List<_ifzlh5t7.ArticleComposition>? compositions,
  }) = _MenuArticleImpl;

  factory MenuArticle.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuArticle(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      building: jsonSerialization['building'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_iaohraio.Building>(
              jsonSerialization['building'],
            ),
      categoryId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['categoryId'],
      ),
      category: jsonSerialization['category'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_illkjvef.MenuCategory>(
              jsonSerialization['category'],
            ),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      price: (jsonSerialization['price'] as num).toDouble(),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      compositions: jsonSerialization['compositions'] == null
          ? null
          : _iaib1p48.Protocol()
                .deserialize<List<_ifzlh5t7.ArticleComposition>>(
                  jsonSerialization['compositions'],
                ),
    );
  }

  static final t = MenuArticleTable();

  static const db = MenuArticleRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue buildingId;

  _iaohraio.Building? building;

  _is.UuidValue categoryId;

  _illkjvef.MenuCategory? category;

  String name;

  String? description;

  double price;

  DateTime createdAt;

  List<_ifzlh5t7.ArticleComposition>? compositions;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [MenuArticle]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MenuArticle copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    _iaohraio.Building? building,
    _is.UuidValue? categoryId,
    _illkjvef.MenuCategory? category,
    String? name,
    String? description,
    double? price,
    DateTime? createdAt,
    List<_ifzlh5t7.ArticleComposition>? compositions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuArticle',
      if (id != null) 'id': id?.toJson(),
      'buildingId': buildingId.toJson(),
      if (building != null) 'building': building?.toJson(),
      'categoryId': categoryId.toJson(),
      if (category != null) 'category': category?.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'price': price,
      'createdAt': createdAt.toJson(),
      if (compositions != null)
        'compositions': compositions?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static MenuArticleInclude include({
    _iaohraio.BuildingInclude? building,
    _illkjvef.MenuCategoryInclude? category,
    _ifzlh5t7.ArticleCompositionIncludeList? compositions,
  }) {
    return MenuArticleInclude._(
      building: building,
      category: category,
      compositions: compositions,
    );
  }

  static MenuArticleIncludeList includeList({
    _is.WhereExpressionBuilder<MenuArticleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MenuArticleTable>? orderBy,
    _is.OrderByListBuilder<MenuArticleTable>? orderByList,
    MenuArticleInclude? include,
  }) {
    return MenuArticleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MenuArticle.t),
      orderByList: orderByList?.call(MenuArticle.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MenuArticleImpl extends MenuArticle {
  _MenuArticleImpl({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    required _is.UuidValue categoryId,
    _illkjvef.MenuCategory? category,
    required String name,
    String? description,
    required double price,
    DateTime? createdAt,
    List<_ifzlh5t7.ArticleComposition>? compositions,
  }) : super._(
         id: id,
         buildingId: buildingId,
         building: building,
         categoryId: categoryId,
         category: category,
         name: name,
         description: description,
         price: price,
         createdAt: createdAt,
         compositions: compositions,
       );

  /// Returns a shallow copy of this [MenuArticle]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MenuArticle copyWith({
    Object? id = _Undefined,
    _is.UuidValue? buildingId,
    Object? building = _Undefined,
    _is.UuidValue? categoryId,
    Object? category = _Undefined,
    String? name,
    Object? description = _Undefined,
    double? price,
    DateTime? createdAt,
    Object? compositions = _Undefined,
  }) {
    return MenuArticle(
      id: id is _is.UuidValue? ? id : this.id,
      buildingId: buildingId ?? this.buildingId,
      building: building is _iaohraio.Building?
          ? building
          : this.building?.copyWith(),
      categoryId: categoryId ?? this.categoryId,
      category: category is _illkjvef.MenuCategory?
          ? category
          : this.category?.copyWith(),
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      compositions: compositions is List<_ifzlh5t7.ArticleComposition>?
          ? compositions
          : this.compositions?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class MenuArticleUpdateTable extends _is.UpdateTable<MenuArticleTable> {
  MenuArticleUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> buildingId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.buildingId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> categoryId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.categoryId,
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

  _is.ColumnValue<double, double> price(double value) => _is.ColumnValue(
    table.price,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class MenuArticleTable extends _is.Table<_is.UuidValue?> {
  MenuArticleTable({super.tableRelation}) : super(tableName: 'menu_article') {
    updateTable = MenuArticleUpdateTable(this);
    buildingId = _is.ColumnUuid(
      'buildingId',
      this,
    );
    categoryId = _is.ColumnUuid(
      'categoryId',
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
    price = _is.ColumnDouble(
      'price',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final MenuArticleUpdateTable updateTable;

  late final _is.ColumnUuid buildingId;

  _iaohraio.BuildingTable? _building;

  late final _is.ColumnUuid categoryId;

  _illkjvef.MenuCategoryTable? _category;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnDouble price;

  late final _is.ColumnDateTime createdAt;

  _ifzlh5t7.ArticleCompositionTable? ___compositions;

  _is.ManyRelation<_ifzlh5t7.ArticleCompositionTable>? _compositions;

  _iaohraio.BuildingTable get building {
    if (_building != null) return _building!;
    _building = _is.createRelationTable(
      relationFieldName: 'building',
      field: MenuArticle.t.buildingId,
      foreignField: _iaohraio.Building.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iaohraio.BuildingTable(tableRelation: foreignTableRelation),
    );
    return _building!;
  }

  _illkjvef.MenuCategoryTable get category {
    if (_category != null) return _category!;
    _category = _is.createRelationTable(
      relationFieldName: 'category',
      field: MenuArticle.t.categoryId,
      foreignField: _illkjvef.MenuCategory.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _illkjvef.MenuCategoryTable(tableRelation: foreignTableRelation),
    );
    return _category!;
  }

  _ifzlh5t7.ArticleCompositionTable get __compositions {
    if (___compositions != null) return ___compositions!;
    ___compositions = _is.createRelationTable(
      relationFieldName: '__compositions',
      field: MenuArticle.t.id,
      foreignField: _ifzlh5t7.ArticleComposition.t.articleId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _ifzlh5t7.ArticleCompositionTable(
        tableRelation: foreignTableRelation,
      ),
    );
    return ___compositions!;
  }

  _is.ManyRelation<_ifzlh5t7.ArticleCompositionTable> get compositions {
    if (_compositions != null) return _compositions!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'compositions',
      field: MenuArticle.t.id,
      foreignField: _ifzlh5t7.ArticleComposition.t.articleId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _ifzlh5t7.ArticleCompositionTable(
        tableRelation: foreignTableRelation,
      ),
    );
    _compositions = _is.ManyRelation<_ifzlh5t7.ArticleCompositionTable>(
      tableWithRelations: relationTable,
      table: _ifzlh5t7.ArticleCompositionTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _compositions!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    buildingId,
    categoryId,
    name,
    description,
    price,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'building') {
      return building;
    }
    if (relationField == 'category') {
      return category;
    }
    if (relationField == 'compositions') {
      return __compositions;
    }
    return null;
  }
}

class MenuArticleInclude extends _is.IncludeObject {
  MenuArticleInclude._({
    _iaohraio.BuildingInclude? building,
    _illkjvef.MenuCategoryInclude? category,
    _ifzlh5t7.ArticleCompositionIncludeList? compositions,
  }) {
    _building = building;
    _category = category;
    _compositions = compositions;
  }

  _iaohraio.BuildingInclude? _building;

  _illkjvef.MenuCategoryInclude? _category;

  _ifzlh5t7.ArticleCompositionIncludeList? _compositions;

  @override
  Map<String, _is.Include?> get includes => {
    'building': _building,
    'category': _category,
    'compositions': _compositions,
  };

  @override
  _is.Table<_is.UuidValue?> get table => MenuArticle.t;
}

class MenuArticleIncludeList extends _is.IncludeList {
  MenuArticleIncludeList._({
    _is.WhereExpressionBuilder<MenuArticleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MenuArticle.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => MenuArticle.t;
}

class MenuArticleRepository {
  const MenuArticleRepository._();

  final attach = const MenuArticleAttachRepository._();

  final attachRow = const MenuArticleAttachRowRepository._();

  /// Returns a list of [MenuArticle]s matching the given query parameters.
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
  Future<List<MenuArticle>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MenuArticleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MenuArticleTable>? orderBy,
    _is.OrderByListBuilder<MenuArticleTable>? orderByList,
    _is.Transaction? transaction,
    MenuArticleInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MenuArticle>(
      where: where?.call(MenuArticle.t),
      orderBy: orderBy?.call(MenuArticle.t),
      orderByList: orderByList?.call(MenuArticle.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MenuArticle] matching the given query parameters.
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
  Future<MenuArticle?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MenuArticleTable>? where,
    int? offset,
    _is.OrderByBuilder<MenuArticleTable>? orderBy,
    _is.OrderByListBuilder<MenuArticleTable>? orderByList,
    _is.Transaction? transaction,
    MenuArticleInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MenuArticle>(
      where: where?.call(MenuArticle.t),
      orderBy: orderBy?.call(MenuArticle.t),
      orderByList: orderByList?.call(MenuArticle.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MenuArticle] by its [id] or null if no such row exists.
  Future<MenuArticle?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    MenuArticleInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MenuArticle>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MenuArticle]s in the list and returns the inserted rows.
  ///
  /// The returned [MenuArticle]s will have their `id` fields set.
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
  Future<List<MenuArticle>> insert(
    _is.DatabaseSession session,
    List<MenuArticle> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MenuArticle>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MenuArticle] and returns the inserted row.
  ///
  /// The returned [MenuArticle] will have its `id` field set.
  Future<MenuArticle> insertRow(
    _is.DatabaseSession session,
    MenuArticle row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MenuArticle>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [MenuArticle]s in the list and returns the resulting rows.
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
  /// The returned [MenuArticle]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MenuArticle>> upsert(
    _is.DatabaseSession session,
    List<MenuArticle> rows, {
    required _is.ColumnSelections<MenuArticleTable> conflictColumns,
    _is.ColumnSelections<MenuArticleTable>? updateColumns,
    _is.WhereExpressionBuilder<MenuArticleTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MenuArticle>(
      rows,
      conflictColumns: conflictColumns(MenuArticle.t),
      updateColumns: updateColumns?.call(MenuArticle.t),
      updateWhere: updateWhere?.call(MenuArticle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MenuArticle] and returns the resulting row.
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
  /// The returned [MenuArticle] will have its `id` field set.
  Future<MenuArticle?> upsertRow(
    _is.DatabaseSession session,
    MenuArticle row, {
    required _is.ColumnSelections<MenuArticleTable> conflictColumns,
    _is.ColumnSelections<MenuArticleTable>? updateColumns,
    _is.WhereExpressionBuilder<MenuArticleTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MenuArticle>(
      row,
      conflictColumns: conflictColumns(MenuArticle.t),
      updateColumns: updateColumns?.call(MenuArticle.t),
      updateWhere: updateWhere?.call(MenuArticle.t),
      transaction: transaction,
    );
  }

  /// Updates all [MenuArticle]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MenuArticle>> update(
    _is.DatabaseSession session,
    List<MenuArticle> rows, {
    _is.ColumnSelections<MenuArticleTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MenuArticle>(
      rows,
      columns: columns?.call(MenuArticle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MenuArticle]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MenuArticle> updateRow(
    _is.DatabaseSession session,
    MenuArticle row, {
    _is.ColumnSelections<MenuArticleTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MenuArticle>(
      row,
      columns: columns?.call(MenuArticle.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MenuArticle] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MenuArticle?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<MenuArticleUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MenuArticle>(
      id,
      columnValues: columnValues(MenuArticle.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MenuArticle]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MenuArticle>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MenuArticleUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MenuArticleTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MenuArticleTable>? orderBy,
    _is.OrderByListBuilder<MenuArticleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MenuArticle>(
      columnValues: columnValues(MenuArticle.t.updateTable),
      where: where(MenuArticle.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MenuArticle.t),
      orderByList: orderByList?.call(MenuArticle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MenuArticle]s in the list and returns the deleted rows.
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
  Future<List<MenuArticle>> delete(
    _is.DatabaseSession session,
    List<MenuArticle> rows, {
    _is.OrderByBuilder<MenuArticleTable>? orderBy,
    _is.OrderByListBuilder<MenuArticleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MenuArticle>(
      rows,
      orderBy: orderBy?.call(MenuArticle.t),
      orderByList: orderByList?.call(MenuArticle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MenuArticle].
  Future<MenuArticle> deleteRow(
    _is.DatabaseSession session,
    MenuArticle row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MenuArticle>(
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
  Future<List<MenuArticle>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MenuArticleTable> where,
    _is.OrderByBuilder<MenuArticleTable>? orderBy,
    _is.OrderByListBuilder<MenuArticleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MenuArticle>(
      where: where(MenuArticle.t),
      orderBy: orderBy?.call(MenuArticle.t),
      orderByList: orderByList?.call(MenuArticle.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MenuArticleTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MenuArticle>(
      where: where?.call(MenuArticle.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MenuArticle] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MenuArticleTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MenuArticle>(
      where: where(MenuArticle.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class MenuArticleAttachRepository {
  const MenuArticleAttachRepository._();

  /// Creates a relation between this [MenuArticle] and the given [ArticleComposition]s
  /// by setting each [ArticleComposition]'s foreign key `articleId` to refer to this [MenuArticle].
  Future<void> compositions(
    _is.DatabaseSession session,
    MenuArticle menuArticle,
    List<_ifzlh5t7.ArticleComposition> articleComposition, {
    _is.Transaction? transaction,
  }) async {
    if (articleComposition.any((e) => e.id == null)) {
      throw ArgumentError.notNull('articleComposition.id');
    }
    if (menuArticle.id == null) {
      throw ArgumentError.notNull('menuArticle.id');
    }

    var $articleComposition = articleComposition
        .map((e) => e.copyWith(articleId: menuArticle.id))
        .toList();
    await session.db.update<_ifzlh5t7.ArticleComposition>(
      $articleComposition,
      columns: [_ifzlh5t7.ArticleComposition.t.articleId],
      transaction: transaction,
    );
  }
}

class MenuArticleAttachRowRepository {
  const MenuArticleAttachRowRepository._();

  /// Creates a relation between the given [MenuArticle] and [Building]
  /// by setting the [MenuArticle]'s foreign key `buildingId` to refer to the [Building].
  Future<void> building(
    _is.DatabaseSession session,
    MenuArticle menuArticle,
    _iaohraio.Building building, {
    _is.Transaction? transaction,
  }) async {
    if (menuArticle.id == null) {
      throw ArgumentError.notNull('menuArticle.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $menuArticle = menuArticle.copyWith(buildingId: building.id);
    await session.db.updateRow<MenuArticle>(
      $menuArticle,
      columns: [MenuArticle.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [MenuArticle] and [MenuCategory]
  /// by setting the [MenuArticle]'s foreign key `categoryId` to refer to the [MenuCategory].
  Future<void> category(
    _is.DatabaseSession session,
    MenuArticle menuArticle,
    _illkjvef.MenuCategory category, {
    _is.Transaction? transaction,
  }) async {
    if (menuArticle.id == null) {
      throw ArgumentError.notNull('menuArticle.id');
    }
    if (category.id == null) {
      throw ArgumentError.notNull('category.id');
    }

    var $menuArticle = menuArticle.copyWith(categoryId: category.id);
    await session.db.updateRow<MenuArticle>(
      $menuArticle,
      columns: [MenuArticle.t.categoryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [MenuArticle] and the given [ArticleComposition]
  /// by setting the [ArticleComposition]'s foreign key `articleId` to refer to this [MenuArticle].
  Future<void> compositions(
    _is.DatabaseSession session,
    MenuArticle menuArticle,
    _ifzlh5t7.ArticleComposition articleComposition, {
    _is.Transaction? transaction,
  }) async {
    if (articleComposition.id == null) {
      throw ArgumentError.notNull('articleComposition.id');
    }
    if (menuArticle.id == null) {
      throw ArgumentError.notNull('menuArticle.id');
    }

    var $articleComposition = articleComposition.copyWith(
      articleId: menuArticle.id,
    );
    await session.db.updateRow<_ifzlh5t7.ArticleComposition>(
      $articleComposition,
      columns: [_ifzlh5t7.ArticleComposition.t.articleId],
      transaction: transaction,
    );
  }
}
