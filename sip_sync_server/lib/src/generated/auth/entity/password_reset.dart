/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

/// One-time owner password reset codes (hashed). Email delivery TBD — code is logged in development.
abstract class PasswordReset
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  PasswordReset._({
    this.id,
    required this.email,
    required this.codeHash,
    required this.expiresAt,
    this.consumedAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory PasswordReset({
    _is.UuidValue? id,
    required String email,
    required String codeHash,
    required DateTime expiresAt,
    DateTime? consumedAt,
    DateTime? createdAt,
  }) = _PasswordResetImpl;

  factory PasswordReset.fromJson(Map<String, dynamic> jsonSerialization) {
    return PasswordReset(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      email: jsonSerialization['email'] as String,
      codeHash: jsonSerialization['codeHash'] as String,
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      consumedAt: jsonSerialization['consumedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['consumedAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = PasswordResetTable();

  static const db = PasswordResetRepository._();

  @override
  _is.UuidValue? id;

  String email;

  String codeHash;

  DateTime expiresAt;

  DateTime? consumedAt;

  DateTime createdAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PasswordReset]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PasswordReset copyWith({
    _is.UuidValue? id,
    String? email,
    String? codeHash,
    DateTime? expiresAt,
    DateTime? consumedAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PasswordReset',
      if (id != null) 'id': id?.toJson(),
      'email': email,
      'codeHash': codeHash,
      'expiresAt': expiresAt.toJson(),
      if (consumedAt != null) 'consumedAt': consumedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static PasswordResetInclude include() {
    return PasswordResetInclude._();
  }

  static PasswordResetIncludeList includeList({
    _is.WhereExpressionBuilder<PasswordResetTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PasswordResetTable>? orderBy,
    _is.OrderByListBuilder<PasswordResetTable>? orderByList,
    PasswordResetInclude? include,
  }) {
    return PasswordResetIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PasswordReset.t),
      orderByList: orderByList?.call(PasswordReset.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PasswordResetImpl extends PasswordReset {
  _PasswordResetImpl({
    _is.UuidValue? id,
    required String email,
    required String codeHash,
    required DateTime expiresAt,
    DateTime? consumedAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         email: email,
         codeHash: codeHash,
         expiresAt: expiresAt,
         consumedAt: consumedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PasswordReset]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PasswordReset copyWith({
    Object? id = _Undefined,
    String? email,
    String? codeHash,
    DateTime? expiresAt,
    Object? consumedAt = _Undefined,
    DateTime? createdAt,
  }) {
    return PasswordReset(
      id: id is _is.UuidValue? ? id : this.id,
      email: email ?? this.email,
      codeHash: codeHash ?? this.codeHash,
      expiresAt: expiresAt ?? this.expiresAt,
      consumedAt: consumedAt is DateTime? ? consumedAt : this.consumedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PasswordResetUpdateTable extends _is.UpdateTable<PasswordResetTable> {
  PasswordResetUpdateTable(super.table);

  _is.ColumnValue<String, String> email(String value) => _is.ColumnValue(
    table.email,
    value,
  );

  _is.ColumnValue<String, String> codeHash(String value) => _is.ColumnValue(
    table.codeHash,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> consumedAt(DateTime? value) =>
      _is.ColumnValue(
        table.consumedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PasswordResetTable extends _is.Table<_is.UuidValue?> {
  PasswordResetTable({super.tableRelation})
    : super(tableName: 'password_reset') {
    updateTable = PasswordResetUpdateTable(this);
    email = _is.ColumnString(
      'email',
      this,
    );
    codeHash = _is.ColumnString(
      'codeHash',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
    consumedAt = _is.ColumnDateTime(
      'consumedAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PasswordResetUpdateTable updateTable;

  late final _is.ColumnString email;

  late final _is.ColumnString codeHash;

  late final _is.ColumnDateTime expiresAt;

  late final _is.ColumnDateTime consumedAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    email,
    codeHash,
    expiresAt,
    consumedAt,
    createdAt,
  ];
}

class PasswordResetInclude extends _is.IncludeObject {
  PasswordResetInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => PasswordReset.t;
}

class PasswordResetIncludeList extends _is.IncludeList {
  PasswordResetIncludeList._({
    _is.WhereExpressionBuilder<PasswordResetTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PasswordReset.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => PasswordReset.t;
}

class PasswordResetRepository {
  const PasswordResetRepository._();

  /// Returns a list of [PasswordReset]s matching the given query parameters.
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
  Future<List<PasswordReset>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PasswordResetTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PasswordResetTable>? orderBy,
    _is.OrderByListBuilder<PasswordResetTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PasswordReset>(
      where: where?.call(PasswordReset.t),
      orderBy: orderBy?.call(PasswordReset.t),
      orderByList: orderByList?.call(PasswordReset.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PasswordReset] matching the given query parameters.
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
  Future<PasswordReset?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PasswordResetTable>? where,
    int? offset,
    _is.OrderByBuilder<PasswordResetTable>? orderBy,
    _is.OrderByListBuilder<PasswordResetTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PasswordReset>(
      where: where?.call(PasswordReset.t),
      orderBy: orderBy?.call(PasswordReset.t),
      orderByList: orderByList?.call(PasswordReset.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PasswordReset] by its [id] or null if no such row exists.
  Future<PasswordReset?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PasswordReset>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PasswordReset]s in the list and returns the inserted rows.
  ///
  /// The returned [PasswordReset]s will have their `id` fields set.
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
  Future<List<PasswordReset>> insert(
    _is.DatabaseSession session,
    List<PasswordReset> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PasswordReset>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PasswordReset] and returns the inserted row.
  ///
  /// The returned [PasswordReset] will have its `id` field set.
  Future<PasswordReset> insertRow(
    _is.DatabaseSession session,
    PasswordReset row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PasswordReset>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PasswordReset]s in the list and returns the resulting rows.
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
  /// The returned [PasswordReset]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PasswordReset>> upsert(
    _is.DatabaseSession session,
    List<PasswordReset> rows, {
    required _is.ColumnSelections<PasswordResetTable> conflictColumns,
    _is.ColumnSelections<PasswordResetTable>? updateColumns,
    _is.WhereExpressionBuilder<PasswordResetTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PasswordReset>(
      rows,
      conflictColumns: conflictColumns(PasswordReset.t),
      updateColumns: updateColumns?.call(PasswordReset.t),
      updateWhere: updateWhere?.call(PasswordReset.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PasswordReset] and returns the resulting row.
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
  /// The returned [PasswordReset] will have its `id` field set.
  Future<PasswordReset?> upsertRow(
    _is.DatabaseSession session,
    PasswordReset row, {
    required _is.ColumnSelections<PasswordResetTable> conflictColumns,
    _is.ColumnSelections<PasswordResetTable>? updateColumns,
    _is.WhereExpressionBuilder<PasswordResetTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PasswordReset>(
      row,
      conflictColumns: conflictColumns(PasswordReset.t),
      updateColumns: updateColumns?.call(PasswordReset.t),
      updateWhere: updateWhere?.call(PasswordReset.t),
      transaction: transaction,
    );
  }

  /// Updates all [PasswordReset]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PasswordReset>> update(
    _is.DatabaseSession session,
    List<PasswordReset> rows, {
    _is.ColumnSelections<PasswordResetTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PasswordReset>(
      rows,
      columns: columns?.call(PasswordReset.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PasswordReset]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PasswordReset> updateRow(
    _is.DatabaseSession session,
    PasswordReset row, {
    _is.ColumnSelections<PasswordResetTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PasswordReset>(
      row,
      columns: columns?.call(PasswordReset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PasswordReset] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PasswordReset?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<PasswordResetUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PasswordReset>(
      id,
      columnValues: columnValues(PasswordReset.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PasswordReset]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PasswordReset>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PasswordResetUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PasswordResetTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PasswordResetTable>? orderBy,
    _is.OrderByListBuilder<PasswordResetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PasswordReset>(
      columnValues: columnValues(PasswordReset.t.updateTable),
      where: where(PasswordReset.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PasswordReset.t),
      orderByList: orderByList?.call(PasswordReset.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PasswordReset]s in the list and returns the deleted rows.
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
  Future<List<PasswordReset>> delete(
    _is.DatabaseSession session,
    List<PasswordReset> rows, {
    _is.OrderByBuilder<PasswordResetTable>? orderBy,
    _is.OrderByListBuilder<PasswordResetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PasswordReset>(
      rows,
      orderBy: orderBy?.call(PasswordReset.t),
      orderByList: orderByList?.call(PasswordReset.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PasswordReset].
  Future<PasswordReset> deleteRow(
    _is.DatabaseSession session,
    PasswordReset row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PasswordReset>(
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
  Future<List<PasswordReset>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PasswordResetTable> where,
    _is.OrderByBuilder<PasswordResetTable>? orderBy,
    _is.OrderByListBuilder<PasswordResetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PasswordReset>(
      where: where(PasswordReset.t),
      orderBy: orderBy?.call(PasswordReset.t),
      orderByList: orderByList?.call(PasswordReset.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PasswordResetTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PasswordReset>(
      where: where?.call(PasswordReset.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PasswordReset] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PasswordResetTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PasswordReset>(
      where: where(PasswordReset.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
