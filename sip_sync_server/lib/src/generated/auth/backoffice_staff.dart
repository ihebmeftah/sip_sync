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

/// Backoffice membership flags. [isSystemDefault] marks the seeded admin,
/// which must never be deleted.
abstract class BackofficeStaff
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  BackofficeStaff._({
    this.id,
    required this.authUserId,
    this.authUser,
    bool? isAdmin,
    bool? isSystemDefault,
  }) : isAdmin = isAdmin ?? false,
       isSystemDefault = isSystemDefault ?? false;

  factory BackofficeStaff({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    bool? isAdmin,
    bool? isSystemDefault,
  }) = _BackofficeStaffImpl;

  factory BackofficeStaff.fromJson(Map<String, dynamic> jsonSerialization) {
    return BackofficeStaff(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      isAdmin: jsonSerialization['isAdmin'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isAdmin']),
      isSystemDefault: jsonSerialization['isSystemDefault'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['isSystemDefault'],
            ),
    );
  }

  static final t = BackofficeStaffTable();

  static const db = BackofficeStaffRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  _iacs.AuthUser? authUser;

  bool isAdmin;

  bool isSystemDefault;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [BackofficeStaff]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BackofficeStaff copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    bool? isAdmin,
    bool? isSystemDefault,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BackofficeStaff',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'isAdmin': isAdmin,
      'isSystemDefault': isSystemDefault,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static BackofficeStaffInclude include({_iacs.AuthUserInclude? authUser}) {
    return BackofficeStaffInclude._(authUser: authUser);
  }

  static BackofficeStaffIncludeList includeList({
    _is.WhereExpressionBuilder<BackofficeStaffTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BackofficeStaffTable>? orderBy,
    _is.OrderByListBuilder<BackofficeStaffTable>? orderByList,
    BackofficeStaffInclude? include,
  }) {
    return BackofficeStaffIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BackofficeStaff.t),
      orderByList: orderByList?.call(BackofficeStaff.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BackofficeStaffImpl extends BackofficeStaff {
  _BackofficeStaffImpl({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    bool? isAdmin,
    bool? isSystemDefault,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         isAdmin: isAdmin,
         isSystemDefault: isSystemDefault,
       );

  /// Returns a shallow copy of this [BackofficeStaff]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BackofficeStaff copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? authUser = _Undefined,
    bool? isAdmin,
    bool? isSystemDefault,
  }) {
    return BackofficeStaff(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      isAdmin: isAdmin ?? this.isAdmin,
      isSystemDefault: isSystemDefault ?? this.isSystemDefault,
    );
  }
}

class BackofficeStaffUpdateTable extends _is.UpdateTable<BackofficeStaffTable> {
  BackofficeStaffUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<bool, bool> isAdmin(bool value) => _is.ColumnValue(
    table.isAdmin,
    value,
  );

  _is.ColumnValue<bool, bool> isSystemDefault(bool value) => _is.ColumnValue(
    table.isSystemDefault,
    value,
  );
}

class BackofficeStaffTable extends _is.Table<int?> {
  BackofficeStaffTable({super.tableRelation})
    : super(tableName: 'backoffice_staff') {
    updateTable = BackofficeStaffUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    isAdmin = _is.ColumnBool(
      'isAdmin',
      this,
      hasDefault: true,
    );
    isSystemDefault = _is.ColumnBool(
      'isSystemDefault',
      this,
      hasDefault: true,
    );
  }

  late final BackofficeStaffUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnBool isAdmin;

  late final _is.ColumnBool isSystemDefault;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: BackofficeStaff.t.authUserId,
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
    isAdmin,
    isSystemDefault,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class BackofficeStaffInclude extends _is.IncludeObject {
  BackofficeStaffInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => BackofficeStaff.t;
}

class BackofficeStaffIncludeList extends _is.IncludeList {
  BackofficeStaffIncludeList._({
    _is.WhereExpressionBuilder<BackofficeStaffTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BackofficeStaff.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => BackofficeStaff.t;
}

class BackofficeStaffRepository {
  const BackofficeStaffRepository._();

  final attachRow = const BackofficeStaffAttachRowRepository._();

  /// Returns a list of [BackofficeStaff]s matching the given query parameters.
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
  Future<List<BackofficeStaff>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BackofficeStaffTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BackofficeStaffTable>? orderBy,
    _is.OrderByListBuilder<BackofficeStaffTable>? orderByList,
    _is.Transaction? transaction,
    BackofficeStaffInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BackofficeStaff>(
      where: where?.call(BackofficeStaff.t),
      orderBy: orderBy?.call(BackofficeStaff.t),
      orderByList: orderByList?.call(BackofficeStaff.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BackofficeStaff] matching the given query parameters.
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
  Future<BackofficeStaff?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BackofficeStaffTable>? where,
    int? offset,
    _is.OrderByBuilder<BackofficeStaffTable>? orderBy,
    _is.OrderByListBuilder<BackofficeStaffTable>? orderByList,
    _is.Transaction? transaction,
    BackofficeStaffInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BackofficeStaff>(
      where: where?.call(BackofficeStaff.t),
      orderBy: orderBy?.call(BackofficeStaff.t),
      orderByList: orderByList?.call(BackofficeStaff.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BackofficeStaff] by its [id] or null if no such row exists.
  Future<BackofficeStaff?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    BackofficeStaffInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BackofficeStaff>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BackofficeStaff]s in the list and returns the inserted rows.
  ///
  /// The returned [BackofficeStaff]s will have their `id` fields set.
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
  Future<List<BackofficeStaff>> insert(
    _is.DatabaseSession session,
    List<BackofficeStaff> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BackofficeStaff>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BackofficeStaff] and returns the inserted row.
  ///
  /// The returned [BackofficeStaff] will have its `id` field set.
  Future<BackofficeStaff> insertRow(
    _is.DatabaseSession session,
    BackofficeStaff row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BackofficeStaff>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [BackofficeStaff]s in the list and returns the resulting rows.
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
  /// The returned [BackofficeStaff]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BackofficeStaff>> upsert(
    _is.DatabaseSession session,
    List<BackofficeStaff> rows, {
    required _is.ColumnSelections<BackofficeStaffTable> conflictColumns,
    _is.ColumnSelections<BackofficeStaffTable>? updateColumns,
    _is.WhereExpressionBuilder<BackofficeStaffTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BackofficeStaff>(
      rows,
      conflictColumns: conflictColumns(BackofficeStaff.t),
      updateColumns: updateColumns?.call(BackofficeStaff.t),
      updateWhere: updateWhere?.call(BackofficeStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BackofficeStaff] and returns the resulting row.
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
  /// The returned [BackofficeStaff] will have its `id` field set.
  Future<BackofficeStaff?> upsertRow(
    _is.DatabaseSession session,
    BackofficeStaff row, {
    required _is.ColumnSelections<BackofficeStaffTable> conflictColumns,
    _is.ColumnSelections<BackofficeStaffTable>? updateColumns,
    _is.WhereExpressionBuilder<BackofficeStaffTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BackofficeStaff>(
      row,
      conflictColumns: conflictColumns(BackofficeStaff.t),
      updateColumns: updateColumns?.call(BackofficeStaff.t),
      updateWhere: updateWhere?.call(BackofficeStaff.t),
      transaction: transaction,
    );
  }

  /// Updates all [BackofficeStaff]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BackofficeStaff>> update(
    _is.DatabaseSession session,
    List<BackofficeStaff> rows, {
    _is.ColumnSelections<BackofficeStaffTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BackofficeStaff>(
      rows,
      columns: columns?.call(BackofficeStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BackofficeStaff]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BackofficeStaff> updateRow(
    _is.DatabaseSession session,
    BackofficeStaff row, {
    _is.ColumnSelections<BackofficeStaffTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BackofficeStaff>(
      row,
      columns: columns?.call(BackofficeStaff.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BackofficeStaff] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BackofficeStaff?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BackofficeStaffUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BackofficeStaff>(
      id,
      columnValues: columnValues(BackofficeStaff.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BackofficeStaff]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BackofficeStaff>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BackofficeStaffUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<BackofficeStaffTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BackofficeStaffTable>? orderBy,
    _is.OrderByListBuilder<BackofficeStaffTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BackofficeStaff>(
      columnValues: columnValues(BackofficeStaff.t.updateTable),
      where: where(BackofficeStaff.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BackofficeStaff.t),
      orderByList: orderByList?.call(BackofficeStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BackofficeStaff]s in the list and returns the deleted rows.
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
  Future<List<BackofficeStaff>> delete(
    _is.DatabaseSession session,
    List<BackofficeStaff> rows, {
    _is.OrderByBuilder<BackofficeStaffTable>? orderBy,
    _is.OrderByListBuilder<BackofficeStaffTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BackofficeStaff>(
      rows,
      orderBy: orderBy?.call(BackofficeStaff.t),
      orderByList: orderByList?.call(BackofficeStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BackofficeStaff].
  Future<BackofficeStaff> deleteRow(
    _is.DatabaseSession session,
    BackofficeStaff row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BackofficeStaff>(
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
  Future<List<BackofficeStaff>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BackofficeStaffTable> where,
    _is.OrderByBuilder<BackofficeStaffTable>? orderBy,
    _is.OrderByListBuilder<BackofficeStaffTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BackofficeStaff>(
      where: where(BackofficeStaff.t),
      orderBy: orderBy?.call(BackofficeStaff.t),
      orderByList: orderByList?.call(BackofficeStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BackofficeStaffTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BackofficeStaff>(
      where: where?.call(BackofficeStaff.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BackofficeStaff] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BackofficeStaffTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BackofficeStaff>(
      where: where(BackofficeStaff.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class BackofficeStaffAttachRowRepository {
  const BackofficeStaffAttachRowRepository._();

  /// Creates a relation between the given [BackofficeStaff] and [AuthUser]
  /// by setting the [BackofficeStaff]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    BackofficeStaff backofficeStaff,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (backofficeStaff.id == null) {
      throw ArgumentError.notNull('backofficeStaff.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $backofficeStaff = backofficeStaff.copyWith(authUserId: authUser.id);
    await session.db.updateRow<BackofficeStaff>(
      $backofficeStaff,
      columns: [BackofficeStaff.t.authUserId],
      transaction: transaction,
    );
  }
}
