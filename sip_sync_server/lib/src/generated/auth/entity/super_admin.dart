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

/// Platform super admin for the backoffice app.
abstract class SuperAdmin
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  SuperAdmin._({
    this.id,
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.passwordHash,
    bool? isSystemDefault,
    bool? isEnabled,
    DateTime? createdAt,
  }) : isSystemDefault = isSystemDefault ?? false,
       isEnabled = isEnabled ?? true,
       createdAt = createdAt ?? DateTime.now();

  factory SuperAdmin({
    _is.UuidValue? id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String passwordHash,
    bool? isSystemDefault,
    bool? isEnabled,
    DateTime? createdAt,
  }) = _SuperAdminImpl;

  factory SuperAdmin.fromJson(Map<String, dynamic> jsonSerialization) {
    return SuperAdmin(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      email: jsonSerialization['email'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      isSystemDefault: jsonSerialization['isSystemDefault'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['isSystemDefault'],
            ),
      isEnabled: jsonSerialization['isEnabled'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isEnabled']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = SuperAdminTable();

  static const db = SuperAdminRepository._();

  @override
  _is.UuidValue? id;

  String email;

  String phoneNumber;

  String firstName;

  String lastName;

  String passwordHash;

  bool isSystemDefault;

  /// When false, login is rejected and existing sessions are revoked.
  bool isEnabled;

  DateTime createdAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [SuperAdmin]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SuperAdmin copyWith({
    _is.UuidValue? id,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? passwordHash,
    bool? isSystemDefault,
    bool? isEnabled,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SuperAdmin',
      if (id != null) 'id': id?.toJson(),
      'email': email,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'passwordHash': passwordHash,
      'isSystemDefault': isSystemDefault,
      'isEnabled': isEnabled,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static SuperAdminInclude include() {
    return SuperAdminInclude._();
  }

  static SuperAdminIncludeList includeList({
    _is.WhereExpressionBuilder<SuperAdminTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SuperAdminTable>? orderBy,
    _is.OrderByListBuilder<SuperAdminTable>? orderByList,
    SuperAdminInclude? include,
  }) {
    return SuperAdminIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SuperAdmin.t),
      orderByList: orderByList?.call(SuperAdmin.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SuperAdminImpl extends SuperAdmin {
  _SuperAdminImpl({
    _is.UuidValue? id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String passwordHash,
    bool? isSystemDefault,
    bool? isEnabled,
    DateTime? createdAt,
  }) : super._(
         id: id,
         email: email,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         passwordHash: passwordHash,
         isSystemDefault: isSystemDefault,
         isEnabled: isEnabled,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SuperAdmin]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SuperAdmin copyWith({
    Object? id = _Undefined,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? passwordHash,
    bool? isSystemDefault,
    bool? isEnabled,
    DateTime? createdAt,
  }) {
    return SuperAdmin(
      id: id is _is.UuidValue? ? id : this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      passwordHash: passwordHash ?? this.passwordHash,
      isSystemDefault: isSystemDefault ?? this.isSystemDefault,
      isEnabled: isEnabled ?? this.isEnabled,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SuperAdminUpdateTable extends _is.UpdateTable<SuperAdminTable> {
  SuperAdminUpdateTable(super.table);

  _is.ColumnValue<String, String> email(String value) => _is.ColumnValue(
    table.email,
    value,
  );

  _is.ColumnValue<String, String> phoneNumber(String value) => _is.ColumnValue(
    table.phoneNumber,
    value,
  );

  _is.ColumnValue<String, String> firstName(String value) => _is.ColumnValue(
    table.firstName,
    value,
  );

  _is.ColumnValue<String, String> lastName(String value) => _is.ColumnValue(
    table.lastName,
    value,
  );

  _is.ColumnValue<String, String> passwordHash(String value) => _is.ColumnValue(
    table.passwordHash,
    value,
  );

  _is.ColumnValue<bool, bool> isSystemDefault(bool value) => _is.ColumnValue(
    table.isSystemDefault,
    value,
  );

  _is.ColumnValue<bool, bool> isEnabled(bool value) => _is.ColumnValue(
    table.isEnabled,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class SuperAdminTable extends _is.Table<_is.UuidValue?> {
  SuperAdminTable({super.tableRelation}) : super(tableName: 'super_admin') {
    updateTable = SuperAdminUpdateTable(this);
    email = _is.ColumnString(
      'email',
      this,
    );
    phoneNumber = _is.ColumnString(
      'phoneNumber',
      this,
    );
    firstName = _is.ColumnString(
      'firstName',
      this,
    );
    lastName = _is.ColumnString(
      'lastName',
      this,
    );
    passwordHash = _is.ColumnString(
      'passwordHash',
      this,
    );
    isSystemDefault = _is.ColumnBool(
      'isSystemDefault',
      this,
      hasDefault: true,
    );
    isEnabled = _is.ColumnBool(
      'isEnabled',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final SuperAdminUpdateTable updateTable;

  late final _is.ColumnString email;

  late final _is.ColumnString phoneNumber;

  late final _is.ColumnString firstName;

  late final _is.ColumnString lastName;

  late final _is.ColumnString passwordHash;

  late final _is.ColumnBool isSystemDefault;

  /// When false, login is rejected and existing sessions are revoked.
  late final _is.ColumnBool isEnabled;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    email,
    phoneNumber,
    firstName,
    lastName,
    passwordHash,
    isSystemDefault,
    isEnabled,
    createdAt,
  ];
}

class SuperAdminInclude extends _is.IncludeObject {
  SuperAdminInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => SuperAdmin.t;
}

class SuperAdminIncludeList extends _is.IncludeList {
  SuperAdminIncludeList._({
    _is.WhereExpressionBuilder<SuperAdminTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SuperAdmin.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => SuperAdmin.t;
}

class SuperAdminRepository {
  const SuperAdminRepository._();

  /// Returns a list of [SuperAdmin]s matching the given query parameters.
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
  Future<List<SuperAdmin>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SuperAdminTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SuperAdminTable>? orderBy,
    _is.OrderByListBuilder<SuperAdminTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SuperAdmin>(
      where: where?.call(SuperAdmin.t),
      orderBy: orderBy?.call(SuperAdmin.t),
      orderByList: orderByList?.call(SuperAdmin.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SuperAdmin] matching the given query parameters.
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
  Future<SuperAdmin?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SuperAdminTable>? where,
    int? offset,
    _is.OrderByBuilder<SuperAdminTable>? orderBy,
    _is.OrderByListBuilder<SuperAdminTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SuperAdmin>(
      where: where?.call(SuperAdmin.t),
      orderBy: orderBy?.call(SuperAdmin.t),
      orderByList: orderByList?.call(SuperAdmin.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SuperAdmin] by its [id] or null if no such row exists.
  Future<SuperAdmin?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SuperAdmin>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SuperAdmin]s in the list and returns the inserted rows.
  ///
  /// The returned [SuperAdmin]s will have their `id` fields set.
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
  Future<List<SuperAdmin>> insert(
    _is.DatabaseSession session,
    List<SuperAdmin> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SuperAdmin>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SuperAdmin] and returns the inserted row.
  ///
  /// The returned [SuperAdmin] will have its `id` field set.
  Future<SuperAdmin> insertRow(
    _is.DatabaseSession session,
    SuperAdmin row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SuperAdmin>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SuperAdmin]s in the list and returns the resulting rows.
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
  /// The returned [SuperAdmin]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SuperAdmin>> upsert(
    _is.DatabaseSession session,
    List<SuperAdmin> rows, {
    required _is.ColumnSelections<SuperAdminTable> conflictColumns,
    _is.ColumnSelections<SuperAdminTable>? updateColumns,
    _is.WhereExpressionBuilder<SuperAdminTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SuperAdmin>(
      rows,
      conflictColumns: conflictColumns(SuperAdmin.t),
      updateColumns: updateColumns?.call(SuperAdmin.t),
      updateWhere: updateWhere?.call(SuperAdmin.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SuperAdmin] and returns the resulting row.
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
  /// The returned [SuperAdmin] will have its `id` field set.
  Future<SuperAdmin?> upsertRow(
    _is.DatabaseSession session,
    SuperAdmin row, {
    required _is.ColumnSelections<SuperAdminTable> conflictColumns,
    _is.ColumnSelections<SuperAdminTable>? updateColumns,
    _is.WhereExpressionBuilder<SuperAdminTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SuperAdmin>(
      row,
      conflictColumns: conflictColumns(SuperAdmin.t),
      updateColumns: updateColumns?.call(SuperAdmin.t),
      updateWhere: updateWhere?.call(SuperAdmin.t),
      transaction: transaction,
    );
  }

  /// Updates all [SuperAdmin]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SuperAdmin>> update(
    _is.DatabaseSession session,
    List<SuperAdmin> rows, {
    _is.ColumnSelections<SuperAdminTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SuperAdmin>(
      rows,
      columns: columns?.call(SuperAdmin.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SuperAdmin]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SuperAdmin> updateRow(
    _is.DatabaseSession session,
    SuperAdmin row, {
    _is.ColumnSelections<SuperAdminTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SuperAdmin>(
      row,
      columns: columns?.call(SuperAdmin.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SuperAdmin] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SuperAdmin?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<SuperAdminUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SuperAdmin>(
      id,
      columnValues: columnValues(SuperAdmin.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SuperAdmin]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SuperAdmin>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SuperAdminUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SuperAdminTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SuperAdminTable>? orderBy,
    _is.OrderByListBuilder<SuperAdminTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SuperAdmin>(
      columnValues: columnValues(SuperAdmin.t.updateTable),
      where: where(SuperAdmin.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SuperAdmin.t),
      orderByList: orderByList?.call(SuperAdmin.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SuperAdmin]s in the list and returns the deleted rows.
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
  Future<List<SuperAdmin>> delete(
    _is.DatabaseSession session,
    List<SuperAdmin> rows, {
    _is.OrderByBuilder<SuperAdminTable>? orderBy,
    _is.OrderByListBuilder<SuperAdminTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SuperAdmin>(
      rows,
      orderBy: orderBy?.call(SuperAdmin.t),
      orderByList: orderByList?.call(SuperAdmin.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SuperAdmin].
  Future<SuperAdmin> deleteRow(
    _is.DatabaseSession session,
    SuperAdmin row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SuperAdmin>(
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
  Future<List<SuperAdmin>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SuperAdminTable> where,
    _is.OrderByBuilder<SuperAdminTable>? orderBy,
    _is.OrderByListBuilder<SuperAdminTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SuperAdmin>(
      where: where(SuperAdmin.t),
      orderBy: orderBy?.call(SuperAdmin.t),
      orderByList: orderByList?.call(SuperAdmin.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SuperAdminTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SuperAdmin>(
      where: where?.call(SuperAdmin.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SuperAdmin] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SuperAdminTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SuperAdmin>(
      where: where(SuperAdmin.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
