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
import '../buildings/building.dart' as _idz3611u;

/// Café / venue owner account. Passwords are hashed locally (not Serverpod IDP).
abstract class Owner
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  Owner._({
    this.id,
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.passwordHash,
    DateTime? createdAt,
    this.buildings,
    this.employees,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Owner({
    _is.UuidValue? id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String passwordHash,
    DateTime? createdAt,
    List<_idz3611u.Building>? buildings,
    List<_iujgysn6.Employee>? employees,
  }) = _OwnerImpl;

  factory Owner.fromJson(Map<String, dynamic> jsonSerialization) {
    return Owner(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      email: jsonSerialization['email'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      buildings: jsonSerialization['buildings'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_idz3611u.Building>>(
              jsonSerialization['buildings'],
            ),
      employees: jsonSerialization['employees'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_iujgysn6.Employee>>(
              jsonSerialization['employees'],
            ),
    );
  }

  static final t = OwnerTable();

  static const db = OwnerRepository._();

  @override
  _is.UuidValue? id;

  String email;

  String phoneNumber;

  String firstName;

  String lastName;

  String passwordHash;

  DateTime createdAt;

  List<_idz3611u.Building>? buildings;

  List<_iujgysn6.Employee>? employees;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Owner]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Owner copyWith({
    _is.UuidValue? id,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? passwordHash,
    DateTime? createdAt,
    List<_idz3611u.Building>? buildings,
    List<_iujgysn6.Employee>? employees,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Owner',
      if (id != null) 'id': id?.toJson(),
      'email': email,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'passwordHash': passwordHash,
      'createdAt': createdAt.toJson(),
      if (buildings != null)
        'buildings': buildings?.toJson(valueToJson: (v) => v.toJson()),
      if (employees != null)
        'employees': employees?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static OwnerInclude include({
    _idz3611u.BuildingIncludeList? buildings,
    _iujgysn6.EmployeeIncludeList? employees,
  }) {
    return OwnerInclude._(
      buildings: buildings,
      employees: employees,
    );
  }

  static OwnerIncludeList includeList({
    _is.WhereExpressionBuilder<OwnerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OwnerTable>? orderBy,
    _is.OrderByListBuilder<OwnerTable>? orderByList,
    OwnerInclude? include,
  }) {
    return OwnerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Owner.t),
      orderByList: orderByList?.call(Owner.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OwnerImpl extends Owner {
  _OwnerImpl({
    _is.UuidValue? id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String passwordHash,
    DateTime? createdAt,
    List<_idz3611u.Building>? buildings,
    List<_iujgysn6.Employee>? employees,
  }) : super._(
         id: id,
         email: email,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         passwordHash: passwordHash,
         createdAt: createdAt,
         buildings: buildings,
         employees: employees,
       );

  /// Returns a shallow copy of this [Owner]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Owner copyWith({
    Object? id = _Undefined,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? passwordHash,
    DateTime? createdAt,
    Object? buildings = _Undefined,
    Object? employees = _Undefined,
  }) {
    return Owner(
      id: id is _is.UuidValue? ? id : this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      passwordHash: passwordHash ?? this.passwordHash,
      createdAt: createdAt ?? this.createdAt,
      buildings: buildings is List<_idz3611u.Building>?
          ? buildings
          : this.buildings?.map((e0) => e0.copyWith()).toList(),
      employees: employees is List<_iujgysn6.Employee>?
          ? employees
          : this.employees?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class OwnerUpdateTable extends _is.UpdateTable<OwnerTable> {
  OwnerUpdateTable(super.table);

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

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class OwnerTable extends _is.Table<_is.UuidValue?> {
  OwnerTable({super.tableRelation}) : super(tableName: 'owner') {
    updateTable = OwnerUpdateTable(this);
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
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final OwnerUpdateTable updateTable;

  late final _is.ColumnString email;

  late final _is.ColumnString phoneNumber;

  late final _is.ColumnString firstName;

  late final _is.ColumnString lastName;

  late final _is.ColumnString passwordHash;

  late final _is.ColumnDateTime createdAt;

  _idz3611u.BuildingTable? ___buildings;

  _is.ManyRelation<_idz3611u.BuildingTable>? _buildings;

  _iujgysn6.EmployeeTable? ___employees;

  _is.ManyRelation<_iujgysn6.EmployeeTable>? _employees;

  _idz3611u.BuildingTable get __buildings {
    if (___buildings != null) return ___buildings!;
    ___buildings = _is.createRelationTable(
      relationFieldName: '__buildings',
      field: Owner.t.id,
      foreignField: _idz3611u.Building.t.ownerId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _idz3611u.BuildingTable(tableRelation: foreignTableRelation),
    );
    return ___buildings!;
  }

  _iujgysn6.EmployeeTable get __employees {
    if (___employees != null) return ___employees!;
    ___employees = _is.createRelationTable(
      relationFieldName: '__employees',
      field: Owner.t.id,
      foreignField: _iujgysn6.Employee.t.ownerId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iujgysn6.EmployeeTable(tableRelation: foreignTableRelation),
    );
    return ___employees!;
  }

  _is.ManyRelation<_idz3611u.BuildingTable> get buildings {
    if (_buildings != null) return _buildings!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'buildings',
      field: Owner.t.id,
      foreignField: _idz3611u.Building.t.ownerId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _idz3611u.BuildingTable(tableRelation: foreignTableRelation),
    );
    _buildings = _is.ManyRelation<_idz3611u.BuildingTable>(
      tableWithRelations: relationTable,
      table: _idz3611u.BuildingTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _buildings!;
  }

  _is.ManyRelation<_iujgysn6.EmployeeTable> get employees {
    if (_employees != null) return _employees!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'employees',
      field: Owner.t.id,
      foreignField: _iujgysn6.Employee.t.ownerId,
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

  @override
  List<_is.Column> get columns => [
    id,
    email,
    phoneNumber,
    firstName,
    lastName,
    passwordHash,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'buildings') {
      return __buildings;
    }
    if (relationField == 'employees') {
      return __employees;
    }
    return null;
  }
}

class OwnerInclude extends _is.IncludeObject {
  OwnerInclude._({
    _idz3611u.BuildingIncludeList? buildings,
    _iujgysn6.EmployeeIncludeList? employees,
  }) {
    _buildings = buildings;
    _employees = employees;
  }

  _idz3611u.BuildingIncludeList? _buildings;

  _iujgysn6.EmployeeIncludeList? _employees;

  @override
  Map<String, _is.Include?> get includes => {
    'buildings': _buildings,
    'employees': _employees,
  };

  @override
  _is.Table<_is.UuidValue?> get table => Owner.t;
}

class OwnerIncludeList extends _is.IncludeList {
  OwnerIncludeList._({
    _is.WhereExpressionBuilder<OwnerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Owner.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => Owner.t;
}

class OwnerRepository {
  const OwnerRepository._();

  final attach = const OwnerAttachRepository._();

  final attachRow = const OwnerAttachRowRepository._();

  /// Returns a list of [Owner]s matching the given query parameters.
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
  Future<List<Owner>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OwnerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OwnerTable>? orderBy,
    _is.OrderByListBuilder<OwnerTable>? orderByList,
    _is.Transaction? transaction,
    OwnerInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Owner>(
      where: where?.call(Owner.t),
      orderBy: orderBy?.call(Owner.t),
      orderByList: orderByList?.call(Owner.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Owner] matching the given query parameters.
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
  Future<Owner?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OwnerTable>? where,
    int? offset,
    _is.OrderByBuilder<OwnerTable>? orderBy,
    _is.OrderByListBuilder<OwnerTable>? orderByList,
    _is.Transaction? transaction,
    OwnerInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Owner>(
      where: where?.call(Owner.t),
      orderBy: orderBy?.call(Owner.t),
      orderByList: orderByList?.call(Owner.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Owner] by its [id] or null if no such row exists.
  Future<Owner?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    OwnerInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Owner>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Owner]s in the list and returns the inserted rows.
  ///
  /// The returned [Owner]s will have their `id` fields set.
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
  Future<List<Owner>> insert(
    _is.DatabaseSession session,
    List<Owner> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Owner>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Owner] and returns the inserted row.
  ///
  /// The returned [Owner] will have its `id` field set.
  Future<Owner> insertRow(
    _is.DatabaseSession session,
    Owner row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Owner>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Owner]s in the list and returns the resulting rows.
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
  /// The returned [Owner]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Owner>> upsert(
    _is.DatabaseSession session,
    List<Owner> rows, {
    required _is.ColumnSelections<OwnerTable> conflictColumns,
    _is.ColumnSelections<OwnerTable>? updateColumns,
    _is.WhereExpressionBuilder<OwnerTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Owner>(
      rows,
      conflictColumns: conflictColumns(Owner.t),
      updateColumns: updateColumns?.call(Owner.t),
      updateWhere: updateWhere?.call(Owner.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Owner] and returns the resulting row.
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
  /// The returned [Owner] will have its `id` field set.
  Future<Owner?> upsertRow(
    _is.DatabaseSession session,
    Owner row, {
    required _is.ColumnSelections<OwnerTable> conflictColumns,
    _is.ColumnSelections<OwnerTable>? updateColumns,
    _is.WhereExpressionBuilder<OwnerTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Owner>(
      row,
      conflictColumns: conflictColumns(Owner.t),
      updateColumns: updateColumns?.call(Owner.t),
      updateWhere: updateWhere?.call(Owner.t),
      transaction: transaction,
    );
  }

  /// Updates all [Owner]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Owner>> update(
    _is.DatabaseSession session,
    List<Owner> rows, {
    _is.ColumnSelections<OwnerTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Owner>(
      rows,
      columns: columns?.call(Owner.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Owner]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Owner> updateRow(
    _is.DatabaseSession session,
    Owner row, {
    _is.ColumnSelections<OwnerTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Owner>(
      row,
      columns: columns?.call(Owner.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Owner] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Owner?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<OwnerUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Owner>(
      id,
      columnValues: columnValues(Owner.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Owner]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Owner>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<OwnerUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<OwnerTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OwnerTable>? orderBy,
    _is.OrderByListBuilder<OwnerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Owner>(
      columnValues: columnValues(Owner.t.updateTable),
      where: where(Owner.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Owner.t),
      orderByList: orderByList?.call(Owner.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Owner]s in the list and returns the deleted rows.
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
  Future<List<Owner>> delete(
    _is.DatabaseSession session,
    List<Owner> rows, {
    _is.OrderByBuilder<OwnerTable>? orderBy,
    _is.OrderByListBuilder<OwnerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Owner>(
      rows,
      orderBy: orderBy?.call(Owner.t),
      orderByList: orderByList?.call(Owner.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Owner].
  Future<Owner> deleteRow(
    _is.DatabaseSession session,
    Owner row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Owner>(
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
  Future<List<Owner>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OwnerTable> where,
    _is.OrderByBuilder<OwnerTable>? orderBy,
    _is.OrderByListBuilder<OwnerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Owner>(
      where: where(Owner.t),
      orderBy: orderBy?.call(Owner.t),
      orderByList: orderByList?.call(Owner.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OwnerTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Owner>(
      where: where?.call(Owner.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Owner] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OwnerTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Owner>(
      where: where(Owner.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class OwnerAttachRepository {
  const OwnerAttachRepository._();

  /// Creates a relation between this [Owner] and the given [Building]s
  /// by setting each [Building]'s foreign key `ownerId` to refer to this [Owner].
  Future<void> buildings(
    _is.DatabaseSession session,
    Owner owner,
    List<_idz3611u.Building> building, {
    _is.Transaction? transaction,
  }) async {
    if (building.any((e) => e.id == null)) {
      throw ArgumentError.notNull('building.id');
    }
    if (owner.id == null) {
      throw ArgumentError.notNull('owner.id');
    }

    var $building = building.map((e) => e.copyWith(ownerId: owner.id)).toList();
    await session.db.update<_idz3611u.Building>(
      $building,
      columns: [_idz3611u.Building.t.ownerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Owner] and the given [Employee]s
  /// by setting each [Employee]'s foreign key `ownerId` to refer to this [Owner].
  Future<void> employees(
    _is.DatabaseSession session,
    Owner owner,
    List<_iujgysn6.Employee> employee, {
    _is.Transaction? transaction,
  }) async {
    if (employee.any((e) => e.id == null)) {
      throw ArgumentError.notNull('employee.id');
    }
    if (owner.id == null) {
      throw ArgumentError.notNull('owner.id');
    }

    var $employee = employee.map((e) => e.copyWith(ownerId: owner.id)).toList();
    await session.db.update<_iujgysn6.Employee>(
      $employee,
      columns: [_iujgysn6.Employee.t.ownerId],
      transaction: transaction,
    );
  }
}

class OwnerAttachRowRepository {
  const OwnerAttachRowRepository._();

  /// Creates a relation between this [Owner] and the given [Building]
  /// by setting the [Building]'s foreign key `ownerId` to refer to this [Owner].
  Future<void> buildings(
    _is.DatabaseSession session,
    Owner owner,
    _idz3611u.Building building, {
    _is.Transaction? transaction,
  }) async {
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }
    if (owner.id == null) {
      throw ArgumentError.notNull('owner.id');
    }

    var $building = building.copyWith(ownerId: owner.id);
    await session.db.updateRow<_idz3611u.Building>(
      $building,
      columns: [_idz3611u.Building.t.ownerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Owner] and the given [Employee]
  /// by setting the [Employee]'s foreign key `ownerId` to refer to this [Owner].
  Future<void> employees(
    _is.DatabaseSession session,
    Owner owner,
    _iujgysn6.Employee employee, {
    _is.Transaction? transaction,
  }) async {
    if (employee.id == null) {
      throw ArgumentError.notNull('employee.id');
    }
    if (owner.id == null) {
      throw ArgumentError.notNull('owner.id');
    }

    var $employee = employee.copyWith(ownerId: owner.id);
    await session.db.updateRow<_iujgysn6.Employee>(
      $employee,
      columns: [_iujgysn6.Employee.t.ownerId],
      transaction: transaction,
    );
  }
}
