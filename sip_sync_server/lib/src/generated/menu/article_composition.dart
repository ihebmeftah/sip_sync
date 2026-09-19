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
import '../menu/ingredient.dart' as _ir4v63ce;
import '../menu/menu_article.dart' as _if01ezzg;

/// One ingredient line in an article recipe. Articles may have zero lines.
abstract class ArticleComposition
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  ArticleComposition._({
    this.id,
    required this.articleId,
    this.article,
    required this.ingredientId,
    this.ingredient,
    required this.quantity,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ArticleComposition({
    _is.UuidValue? id,
    required _is.UuidValue articleId,
    _if01ezzg.MenuArticle? article,
    required _is.UuidValue ingredientId,
    _ir4v63ce.Ingredient? ingredient,
    required double quantity,
    DateTime? createdAt,
  }) = _ArticleCompositionImpl;

  factory ArticleComposition.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArticleComposition(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      articleId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['articleId'],
      ),
      article: jsonSerialization['article'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_if01ezzg.MenuArticle>(
              jsonSerialization['article'],
            ),
      ingredientId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ingredientId'],
      ),
      ingredient: jsonSerialization['ingredient'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_ir4v63ce.Ingredient>(
              jsonSerialization['ingredient'],
            ),
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ArticleCompositionTable();

  static const db = ArticleCompositionRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue articleId;

  _if01ezzg.MenuArticle? article;

  _is.UuidValue ingredientId;

  _ir4v63ce.Ingredient? ingredient;

  double quantity;

  DateTime createdAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [ArticleComposition]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ArticleComposition copyWith({
    _is.UuidValue? id,
    _is.UuidValue? articleId,
    _if01ezzg.MenuArticle? article,
    _is.UuidValue? ingredientId,
    _ir4v63ce.Ingredient? ingredient,
    double? quantity,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArticleComposition',
      if (id != null) 'id': id?.toJson(),
      'articleId': articleId.toJson(),
      if (article != null) 'article': article?.toJson(),
      'ingredientId': ingredientId.toJson(),
      if (ingredient != null) 'ingredient': ingredient?.toJson(),
      'quantity': quantity,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static ArticleCompositionInclude include({
    _if01ezzg.MenuArticleInclude? article,
    _ir4v63ce.IngredientInclude? ingredient,
  }) {
    return ArticleCompositionInclude._(
      article: article,
      ingredient: ingredient,
    );
  }

  static ArticleCompositionIncludeList includeList({
    _is.WhereExpressionBuilder<ArticleCompositionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ArticleCompositionTable>? orderBy,
    _is.OrderByListBuilder<ArticleCompositionTable>? orderByList,
    ArticleCompositionInclude? include,
  }) {
    return ArticleCompositionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ArticleComposition.t),
      orderByList: orderByList?.call(ArticleComposition.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ArticleCompositionImpl extends ArticleComposition {
  _ArticleCompositionImpl({
    _is.UuidValue? id,
    required _is.UuidValue articleId,
    _if01ezzg.MenuArticle? article,
    required _is.UuidValue ingredientId,
    _ir4v63ce.Ingredient? ingredient,
    required double quantity,
    DateTime? createdAt,
  }) : super._(
         id: id,
         articleId: articleId,
         article: article,
         ingredientId: ingredientId,
         ingredient: ingredient,
         quantity: quantity,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ArticleComposition]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ArticleComposition copyWith({
    Object? id = _Undefined,
    _is.UuidValue? articleId,
    Object? article = _Undefined,
    _is.UuidValue? ingredientId,
    Object? ingredient = _Undefined,
    double? quantity,
    DateTime? createdAt,
  }) {
    return ArticleComposition(
      id: id is _is.UuidValue? ? id : this.id,
      articleId: articleId ?? this.articleId,
      article: article is _if01ezzg.MenuArticle?
          ? article
          : this.article?.copyWith(),
      ingredientId: ingredientId ?? this.ingredientId,
      ingredient: ingredient is _ir4v63ce.Ingredient?
          ? ingredient
          : this.ingredient?.copyWith(),
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ArticleCompositionUpdateTable
    extends _is.UpdateTable<ArticleCompositionTable> {
  ArticleCompositionUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> articleId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.articleId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ingredientId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.ingredientId,
    value,
  );

  _is.ColumnValue<double, double> quantity(double value) => _is.ColumnValue(
    table.quantity,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ArticleCompositionTable extends _is.Table<_is.UuidValue?> {
  ArticleCompositionTable({super.tableRelation})
    : super(tableName: 'article_composition') {
    updateTable = ArticleCompositionUpdateTable(this);
    articleId = _is.ColumnUuid(
      'articleId',
      this,
    );
    ingredientId = _is.ColumnUuid(
      'ingredientId',
      this,
    );
    quantity = _is.ColumnDouble(
      'quantity',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ArticleCompositionUpdateTable updateTable;

  late final _is.ColumnUuid articleId;

  _if01ezzg.MenuArticleTable? _article;

  late final _is.ColumnUuid ingredientId;

  _ir4v63ce.IngredientTable? _ingredient;

  late final _is.ColumnDouble quantity;

  late final _is.ColumnDateTime createdAt;

  _if01ezzg.MenuArticleTable get article {
    if (_article != null) return _article!;
    _article = _is.createRelationTable(
      relationFieldName: 'article',
      field: ArticleComposition.t.articleId,
      foreignField: _if01ezzg.MenuArticle.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _if01ezzg.MenuArticleTable(tableRelation: foreignTableRelation),
    );
    return _article!;
  }

  _ir4v63ce.IngredientTable get ingredient {
    if (_ingredient != null) return _ingredient!;
    _ingredient = _is.createRelationTable(
      relationFieldName: 'ingredient',
      field: ArticleComposition.t.ingredientId,
      foreignField: _ir4v63ce.Ingredient.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ir4v63ce.IngredientTable(tableRelation: foreignTableRelation),
    );
    return _ingredient!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    articleId,
    ingredientId,
    quantity,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'article') {
      return article;
    }
    if (relationField == 'ingredient') {
      return ingredient;
    }
    return null;
  }
}

class ArticleCompositionInclude extends _is.IncludeObject {
  ArticleCompositionInclude._({
    _if01ezzg.MenuArticleInclude? article,
    _ir4v63ce.IngredientInclude? ingredient,
  }) {
    _article = article;
    _ingredient = ingredient;
  }

  _if01ezzg.MenuArticleInclude? _article;

  _ir4v63ce.IngredientInclude? _ingredient;

  @override
  Map<String, _is.Include?> get includes => {
    'article': _article,
    'ingredient': _ingredient,
  };

  @override
  _is.Table<_is.UuidValue?> get table => ArticleComposition.t;
}

class ArticleCompositionIncludeList extends _is.IncludeList {
  ArticleCompositionIncludeList._({
    _is.WhereExpressionBuilder<ArticleCompositionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ArticleComposition.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => ArticleComposition.t;
}

class ArticleCompositionRepository {
  const ArticleCompositionRepository._();

  final attachRow = const ArticleCompositionAttachRowRepository._();

  /// Returns a list of [ArticleComposition]s matching the given query parameters.
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
  Future<List<ArticleComposition>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ArticleCompositionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ArticleCompositionTable>? orderBy,
    _is.OrderByListBuilder<ArticleCompositionTable>? orderByList,
    _is.Transaction? transaction,
    ArticleCompositionInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ArticleComposition>(
      where: where?.call(ArticleComposition.t),
      orderBy: orderBy?.call(ArticleComposition.t),
      orderByList: orderByList?.call(ArticleComposition.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ArticleComposition] matching the given query parameters.
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
  Future<ArticleComposition?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ArticleCompositionTable>? where,
    int? offset,
    _is.OrderByBuilder<ArticleCompositionTable>? orderBy,
    _is.OrderByListBuilder<ArticleCompositionTable>? orderByList,
    _is.Transaction? transaction,
    ArticleCompositionInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ArticleComposition>(
      where: where?.call(ArticleComposition.t),
      orderBy: orderBy?.call(ArticleComposition.t),
      orderByList: orderByList?.call(ArticleComposition.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ArticleComposition] by its [id] or null if no such row exists.
  Future<ArticleComposition?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    ArticleCompositionInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ArticleComposition>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ArticleComposition]s in the list and returns the inserted rows.
  ///
  /// The returned [ArticleComposition]s will have their `id` fields set.
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
  Future<List<ArticleComposition>> insert(
    _is.DatabaseSession session,
    List<ArticleComposition> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ArticleComposition>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ArticleComposition] and returns the inserted row.
  ///
  /// The returned [ArticleComposition] will have its `id` field set.
  Future<ArticleComposition> insertRow(
    _is.DatabaseSession session,
    ArticleComposition row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ArticleComposition>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ArticleComposition]s in the list and returns the resulting rows.
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
  /// The returned [ArticleComposition]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ArticleComposition>> upsert(
    _is.DatabaseSession session,
    List<ArticleComposition> rows, {
    required _is.ColumnSelections<ArticleCompositionTable> conflictColumns,
    _is.ColumnSelections<ArticleCompositionTable>? updateColumns,
    _is.WhereExpressionBuilder<ArticleCompositionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ArticleComposition>(
      rows,
      conflictColumns: conflictColumns(ArticleComposition.t),
      updateColumns: updateColumns?.call(ArticleComposition.t),
      updateWhere: updateWhere?.call(ArticleComposition.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ArticleComposition] and returns the resulting row.
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
  /// The returned [ArticleComposition] will have its `id` field set.
  Future<ArticleComposition?> upsertRow(
    _is.DatabaseSession session,
    ArticleComposition row, {
    required _is.ColumnSelections<ArticleCompositionTable> conflictColumns,
    _is.ColumnSelections<ArticleCompositionTable>? updateColumns,
    _is.WhereExpressionBuilder<ArticleCompositionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ArticleComposition>(
      row,
      conflictColumns: conflictColumns(ArticleComposition.t),
      updateColumns: updateColumns?.call(ArticleComposition.t),
      updateWhere: updateWhere?.call(ArticleComposition.t),
      transaction: transaction,
    );
  }

  /// Updates all [ArticleComposition]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ArticleComposition>> update(
    _is.DatabaseSession session,
    List<ArticleComposition> rows, {
    _is.ColumnSelections<ArticleCompositionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ArticleComposition>(
      rows,
      columns: columns?.call(ArticleComposition.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ArticleComposition]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ArticleComposition> updateRow(
    _is.DatabaseSession session,
    ArticleComposition row, {
    _is.ColumnSelections<ArticleCompositionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ArticleComposition>(
      row,
      columns: columns?.call(ArticleComposition.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ArticleComposition] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ArticleComposition?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<ArticleCompositionUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ArticleComposition>(
      id,
      columnValues: columnValues(ArticleComposition.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ArticleComposition]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ArticleComposition>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ArticleCompositionUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ArticleCompositionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ArticleCompositionTable>? orderBy,
    _is.OrderByListBuilder<ArticleCompositionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ArticleComposition>(
      columnValues: columnValues(ArticleComposition.t.updateTable),
      where: where(ArticleComposition.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ArticleComposition.t),
      orderByList: orderByList?.call(ArticleComposition.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ArticleComposition]s in the list and returns the deleted rows.
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
  Future<List<ArticleComposition>> delete(
    _is.DatabaseSession session,
    List<ArticleComposition> rows, {
    _is.OrderByBuilder<ArticleCompositionTable>? orderBy,
    _is.OrderByListBuilder<ArticleCompositionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ArticleComposition>(
      rows,
      orderBy: orderBy?.call(ArticleComposition.t),
      orderByList: orderByList?.call(ArticleComposition.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ArticleComposition].
  Future<ArticleComposition> deleteRow(
    _is.DatabaseSession session,
    ArticleComposition row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ArticleComposition>(
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
  Future<List<ArticleComposition>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ArticleCompositionTable> where,
    _is.OrderByBuilder<ArticleCompositionTable>? orderBy,
    _is.OrderByListBuilder<ArticleCompositionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ArticleComposition>(
      where: where(ArticleComposition.t),
      orderBy: orderBy?.call(ArticleComposition.t),
      orderByList: orderByList?.call(ArticleComposition.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ArticleCompositionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ArticleComposition>(
      where: where?.call(ArticleComposition.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ArticleComposition] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ArticleCompositionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ArticleComposition>(
      where: where(ArticleComposition.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ArticleCompositionAttachRowRepository {
  const ArticleCompositionAttachRowRepository._();

  /// Creates a relation between the given [ArticleComposition] and [MenuArticle]
  /// by setting the [ArticleComposition]'s foreign key `articleId` to refer to the [MenuArticle].
  Future<void> article(
    _is.DatabaseSession session,
    ArticleComposition articleComposition,
    _if01ezzg.MenuArticle article, {
    _is.Transaction? transaction,
  }) async {
    if (articleComposition.id == null) {
      throw ArgumentError.notNull('articleComposition.id');
    }
    if (article.id == null) {
      throw ArgumentError.notNull('article.id');
    }

    var $articleComposition = articleComposition.copyWith(
      articleId: article.id,
    );
    await session.db.updateRow<ArticleComposition>(
      $articleComposition,
      columns: [ArticleComposition.t.articleId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ArticleComposition] and [Ingredient]
  /// by setting the [ArticleComposition]'s foreign key `ingredientId` to refer to the [Ingredient].
  Future<void> ingredient(
    _is.DatabaseSession session,
    ArticleComposition articleComposition,
    _ir4v63ce.Ingredient ingredient, {
    _is.Transaction? transaction,
  }) async {
    if (articleComposition.id == null) {
      throw ArgumentError.notNull('articleComposition.id');
    }
    if (ingredient.id == null) {
      throw ArgumentError.notNull('ingredient.id');
    }

    var $articleComposition = articleComposition.copyWith(
      ingredientId: ingredient.id,
    );
    await session.db.updateRow<ArticleComposition>(
      $articleComposition,
      columns: [ArticleComposition.t.ingredientId],
      transaction: transaction,
    );
  }
}
