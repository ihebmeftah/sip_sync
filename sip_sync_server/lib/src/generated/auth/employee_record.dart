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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:sip_sync_server/src/generated/protocol.dart' as _iaib1p48;

/// Links an employee identity to the owner who added them.
abstract class EmployeeRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  EmployeeRecord._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.ownerAuthUserId,
  });

  factory EmployeeRecord({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required _is.UuidValue ownerAuthUserId,
  }) = _EmployeeRecordImpl;

  factory EmployeeRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmployeeRecord(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      ownerAuthUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerAuthUserId'],
      ),
    );
  }

  static final t = EmployeeRecordTable();

  static const db = EmployeeRecordRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  _iacs.AuthUser? authUser;

  _is.UuidValue ownerAuthUserId;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EmployeeRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EmployeeRecord copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    _is.UuidValue? ownerAuthUserId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmployeeRecord',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'ownerAuthUserId': ownerAuthUserId.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static EmployeeRecordInclude include({_iacs.AuthUserInclude? authUser}) {
    return EmployeeRecordInclude._(authUser: authUser);
  }

  static EmployeeRecordIncludeList includeList({
    _is.WhereExpressionBuilder<EmployeeRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmployeeRecordTable>? orderBy,
    _is.OrderByListBuilder<EmployeeRecordTable>? orderByList,
    EmployeeRecordInclude? include,
  }) {
    return EmployeeRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmployeeRecord.t),
      orderByList: orderByList?.call(EmployeeRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmployeeRecordImpl extends EmployeeRecord {
  _EmployeeRecordImpl({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required _is.UuidValue ownerAuthUserId,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         ownerAuthUserId: ownerAuthUserId,
       );

  /// Returns a shallow copy of this [EmployeeRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EmployeeRecord copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? authUser = _Undefined,
    _is.UuidValue? ownerAuthUserId,
  }) {
    return EmployeeRecord(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      ownerAuthUserId: ownerAuthUserId ?? this.ownerAuthUserId,
    );
  }
}

class EmployeeRecordUpdateTable extends _is.UpdateTable<EmployeeRecordTable> {
  EmployeeRecordUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerAuthUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.ownerAuthUserId,
    value,
  );
}

class EmployeeRecordTable extends _is.Table<int?> {
  EmployeeRecordTable({super.tableRelation})
    : super(tableName: 'employee_record') {
    updateTable = EmployeeRecordUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    ownerAuthUserId = _is.ColumnUuid(
      'ownerAuthUserId',
      this,
    );
  }

  late final EmployeeRecordUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnUuid ownerAuthUserId;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: EmployeeRecord.t.authUserId,
      foreignField: _iacs.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iacs.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    ownerAuthUserId,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class EmployeeRecordInclude extends _is.IncludeObject {
  EmployeeRecordInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => EmployeeRecord.t;
}

class EmployeeRecordIncludeList extends _is.IncludeList {
  EmployeeRecordIncludeList._({
    _is.WhereExpressionBuilder<EmployeeRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EmployeeRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EmployeeRecord.t;
}

class EmployeeRecordRepository {
  const EmployeeRecordRepository._();

  final attachRow = const EmployeeRecordAttachRowRepository._();

  /// Returns a list of [EmployeeRecord]s matching the given query parameters.
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
  Future<List<EmployeeRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmployeeRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmployeeRecordTable>? orderBy,
    _is.OrderByListBuilder<EmployeeRecordTable>? orderByList,
    _is.Transaction? transaction,
    EmployeeRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EmployeeRecord>(
      where: where?.call(EmployeeRecord.t),
      orderBy: orderBy?.call(EmployeeRecord.t),
      orderByList: orderByList?.call(EmployeeRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EmployeeRecord] matching the given query parameters.
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
  Future<EmployeeRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmployeeRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<EmployeeRecordTable>? orderBy,
    _is.OrderByListBuilder<EmployeeRecordTable>? orderByList,
    _is.Transaction? transaction,
    EmployeeRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EmployeeRecord>(
      where: where?.call(EmployeeRecord.t),
      orderBy: orderBy?.call(EmployeeRecord.t),
      orderByList: orderByList?.call(EmployeeRecord.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EmployeeRecord] by its [id] or null if no such row exists.
  Future<EmployeeRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    EmployeeRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EmployeeRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EmployeeRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [EmployeeRecord]s will have their `id` fields set.
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
  Future<List<EmployeeRecord>> insert(
    _is.DatabaseSession session,
    List<EmployeeRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EmployeeRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EmployeeRecord] and returns the inserted row.
  ///
  /// The returned [EmployeeRecord] will have its `id` field set.
  Future<EmployeeRecord> insertRow(
    _is.DatabaseSession session,
    EmployeeRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EmployeeRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EmployeeRecord]s in the list and returns the resulting rows.
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
  /// The returned [EmployeeRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmployeeRecord>> upsert(
    _is.DatabaseSession session,
    List<EmployeeRecord> rows, {
    required _is.ColumnSelections<EmployeeRecordTable> conflictColumns,
    _is.ColumnSelections<EmployeeRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<EmployeeRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EmployeeRecord>(
      rows,
      conflictColumns: conflictColumns(EmployeeRecord.t),
      updateColumns: updateColumns?.call(EmployeeRecord.t),
      updateWhere: updateWhere?.call(EmployeeRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EmployeeRecord] and returns the resulting row.
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
  /// The returned [EmployeeRecord] will have its `id` field set.
  Future<EmployeeRecord?> upsertRow(
    _is.DatabaseSession session,
    EmployeeRecord row, {
    required _is.ColumnSelections<EmployeeRecordTable> conflictColumns,
    _is.ColumnSelections<EmployeeRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<EmployeeRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EmployeeRecord>(
      row,
      conflictColumns: conflictColumns(EmployeeRecord.t),
      updateColumns: updateColumns?.call(EmployeeRecord.t),
      updateWhere: updateWhere?.call(EmployeeRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [EmployeeRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmployeeRecord>> update(
    _is.DatabaseSession session,
    List<EmployeeRecord> rows, {
    _is.ColumnSelections<EmployeeRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EmployeeRecord>(
      rows,
      columns: columns?.call(EmployeeRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EmployeeRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EmployeeRecord> updateRow(
    _is.DatabaseSession session,
    EmployeeRecord row, {
    _is.ColumnSelections<EmployeeRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EmployeeRecord>(
      row,
      columns: columns?.call(EmployeeRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EmployeeRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EmployeeRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EmployeeRecordUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EmployeeRecord>(
      id,
      columnValues: columnValues(EmployeeRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EmployeeRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmployeeRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EmployeeRecordUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<EmployeeRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmployeeRecordTable>? orderBy,
    _is.OrderByListBuilder<EmployeeRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EmployeeRecord>(
      columnValues: columnValues(EmployeeRecord.t.updateTable),
      where: where(EmployeeRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmployeeRecord.t),
      orderByList: orderByList?.call(EmployeeRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EmployeeRecord]s in the list and returns the deleted rows.
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
  Future<List<EmployeeRecord>> delete(
    _is.DatabaseSession session,
    List<EmployeeRecord> rows, {
    _is.OrderByBuilder<EmployeeRecordTable>? orderBy,
    _is.OrderByListBuilder<EmployeeRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EmployeeRecord>(
      rows,
      orderBy: orderBy?.call(EmployeeRecord.t),
      orderByList: orderByList?.call(EmployeeRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EmployeeRecord].
  Future<EmployeeRecord> deleteRow(
    _is.DatabaseSession session,
    EmployeeRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EmployeeRecord>(
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
  Future<List<EmployeeRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EmployeeRecordTable> where,
    _is.OrderByBuilder<EmployeeRecordTable>? orderBy,
    _is.OrderByListBuilder<EmployeeRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EmployeeRecord>(
      where: where(EmployeeRecord.t),
      orderBy: orderBy?.call(EmployeeRecord.t),
      orderByList: orderByList?.call(EmployeeRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmployeeRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EmployeeRecord>(
      where: where?.call(EmployeeRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EmployeeRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EmployeeRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EmployeeRecord>(
      where: where(EmployeeRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class EmployeeRecordAttachRowRepository {
  const EmployeeRecordAttachRowRepository._();

  /// Creates a relation between the given [EmployeeRecord] and [AuthUser]
  /// by setting the [EmployeeRecord]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    EmployeeRecord employeeRecord,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (employeeRecord.id == null) {
      throw ArgumentError.notNull('employeeRecord.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $employeeRecord = employeeRecord.copyWith(authUserId: authUser.id);
    await session.db.updateRow<EmployeeRecord>(
      $employeeRecord,
      columns: [EmployeeRecord.t.authUserId],
      transaction: transaction,
    );
  }
}
