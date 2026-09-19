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
import '../../auth/entity/owner.dart' as _i2wy11ca;
import '../../buildings/entity/building.dart' as _iaohraio;

/// Staff account for one building. Username login; password hashed locally.
abstract class Employee
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  Employee._({
    this.id,
    required this.ownerId,
    this.owner,
    required this.buildingId,
    this.building,
    required this.username,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.passwordHash,
    bool? isEnabled,
    DateTime? createdAt,
  }) : isEnabled = isEnabled ?? true,
       createdAt = createdAt ?? DateTime.now();

  factory Employee({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    _i2wy11ca.Owner? owner,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String passwordHash,
    bool? isEnabled,
    DateTime? createdAt,
  }) = _EmployeeImpl;

  factory Employee.fromJson(Map<String, dynamic> jsonSerialization) {
    return Employee(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      owner: jsonSerialization['owner'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_i2wy11ca.Owner>(
              jsonSerialization['owner'],
            ),
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      building: jsonSerialization['building'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_iaohraio.Building>(
              jsonSerialization['building'],
            ),
      username: jsonSerialization['username'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      isEnabled: jsonSerialization['isEnabled'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isEnabled']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = EmployeeTable();

  static const db = EmployeeRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue ownerId;

  _i2wy11ca.Owner? owner;

  _is.UuidValue buildingId;

  _iaohraio.Building? building;

  String username;

  String phoneNumber;

  String firstName;

  String lastName;

  String passwordHash;

  bool isEnabled;

  DateTime createdAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Employee]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Employee copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    _i2wy11ca.Owner? owner,
    _is.UuidValue? buildingId,
    _iaohraio.Building? building,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? passwordHash,
    bool? isEnabled,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Employee',
      if (id != null) 'id': id?.toJson(),
      'ownerId': ownerId.toJson(),
      if (owner != null) 'owner': owner?.toJson(),
      'buildingId': buildingId.toJson(),
      if (building != null) 'building': building?.toJson(),
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'passwordHash': passwordHash,
      'isEnabled': isEnabled,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static EmployeeInclude include({
    _i2wy11ca.OwnerInclude? owner,
    _iaohraio.BuildingInclude? building,
  }) {
    return EmployeeInclude._(
      owner: owner,
      building: building,
    );
  }

  static EmployeeIncludeList includeList({
    _is.WhereExpressionBuilder<EmployeeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmployeeTable>? orderBy,
    _is.OrderByListBuilder<EmployeeTable>? orderByList,
    EmployeeInclude? include,
  }) {
    return EmployeeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Employee.t),
      orderByList: orderByList?.call(Employee.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmployeeImpl extends Employee {
  _EmployeeImpl({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    _i2wy11ca.Owner? owner,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String passwordHash,
    bool? isEnabled,
    DateTime? createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         owner: owner,
         buildingId: buildingId,
         building: building,
         username: username,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         passwordHash: passwordHash,
         isEnabled: isEnabled,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Employee]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Employee copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
    Object? owner = _Undefined,
    _is.UuidValue? buildingId,
    Object? building = _Undefined,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? passwordHash,
    bool? isEnabled,
    DateTime? createdAt,
  }) {
    return Employee(
      id: id is _is.UuidValue? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      owner: owner is _i2wy11ca.Owner? ? owner : this.owner?.copyWith(),
      buildingId: buildingId ?? this.buildingId,
      building: building is _iaohraio.Building?
          ? building
          : this.building?.copyWith(),
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      passwordHash: passwordHash ?? this.passwordHash,
      isEnabled: isEnabled ?? this.isEnabled,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class EmployeeUpdateTable extends _is.UpdateTable<EmployeeTable> {
  EmployeeUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> buildingId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.buildingId,
    value,
  );

  _is.ColumnValue<String, String> username(String value) => _is.ColumnValue(
    table.username,
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

class EmployeeTable extends _is.Table<_is.UuidValue?> {
  EmployeeTable({super.tableRelation}) : super(tableName: 'employee') {
    updateTable = EmployeeUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    buildingId = _is.ColumnUuid(
      'buildingId',
      this,
    );
    username = _is.ColumnString(
      'username',
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

  late final EmployeeUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  _i2wy11ca.OwnerTable? _owner;

  late final _is.ColumnUuid buildingId;

  _iaohraio.BuildingTable? _building;

  late final _is.ColumnString username;

  late final _is.ColumnString phoneNumber;

  late final _is.ColumnString firstName;

  late final _is.ColumnString lastName;

  late final _is.ColumnString passwordHash;

  late final _is.ColumnBool isEnabled;

  late final _is.ColumnDateTime createdAt;

  _i2wy11ca.OwnerTable get owner {
    if (_owner != null) return _owner!;
    _owner = _is.createRelationTable(
      relationFieldName: 'owner',
      field: Employee.t.ownerId,
      foreignField: _i2wy11ca.Owner.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2wy11ca.OwnerTable(tableRelation: foreignTableRelation),
    );
    return _owner!;
  }

  _iaohraio.BuildingTable get building {
    if (_building != null) return _building!;
    _building = _is.createRelationTable(
      relationFieldName: 'building',
      field: Employee.t.buildingId,
      foreignField: _iaohraio.Building.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iaohraio.BuildingTable(tableRelation: foreignTableRelation),
    );
    return _building!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    buildingId,
    username,
    phoneNumber,
    firstName,
    lastName,
    passwordHash,
    isEnabled,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'owner') {
      return owner;
    }
    if (relationField == 'building') {
      return building;
    }
    return null;
  }
}

class EmployeeInclude extends _is.IncludeObject {
  EmployeeInclude._({
    _i2wy11ca.OwnerInclude? owner,
    _iaohraio.BuildingInclude? building,
  }) {
    _owner = owner;
    _building = building;
  }

  _i2wy11ca.OwnerInclude? _owner;

  _iaohraio.BuildingInclude? _building;

  @override
  Map<String, _is.Include?> get includes => {
    'owner': _owner,
    'building': _building,
  };

  @override
  _is.Table<_is.UuidValue?> get table => Employee.t;
}

class EmployeeIncludeList extends _is.IncludeList {
  EmployeeIncludeList._({
    _is.WhereExpressionBuilder<EmployeeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Employee.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => Employee.t;
}

class EmployeeRepository {
  const EmployeeRepository._();

  final attachRow = const EmployeeAttachRowRepository._();

  /// Returns a list of [Employee]s matching the given query parameters.
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
  Future<List<Employee>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmployeeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmployeeTable>? orderBy,
    _is.OrderByListBuilder<EmployeeTable>? orderByList,
    _is.Transaction? transaction,
    EmployeeInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Employee>(
      where: where?.call(Employee.t),
      orderBy: orderBy?.call(Employee.t),
      orderByList: orderByList?.call(Employee.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Employee] matching the given query parameters.
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
  Future<Employee?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmployeeTable>? where,
    int? offset,
    _is.OrderByBuilder<EmployeeTable>? orderBy,
    _is.OrderByListBuilder<EmployeeTable>? orderByList,
    _is.Transaction? transaction,
    EmployeeInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Employee>(
      where: where?.call(Employee.t),
      orderBy: orderBy?.call(Employee.t),
      orderByList: orderByList?.call(Employee.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Employee] by its [id] or null if no such row exists.
  Future<Employee?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    EmployeeInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Employee>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Employee]s in the list and returns the inserted rows.
  ///
  /// The returned [Employee]s will have their `id` fields set.
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
  Future<List<Employee>> insert(
    _is.DatabaseSession session,
    List<Employee> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Employee>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Employee] and returns the inserted row.
  ///
  /// The returned [Employee] will have its `id` field set.
  Future<Employee> insertRow(
    _is.DatabaseSession session,
    Employee row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Employee>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Employee]s in the list and returns the resulting rows.
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
  /// The returned [Employee]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Employee>> upsert(
    _is.DatabaseSession session,
    List<Employee> rows, {
    required _is.ColumnSelections<EmployeeTable> conflictColumns,
    _is.ColumnSelections<EmployeeTable>? updateColumns,
    _is.WhereExpressionBuilder<EmployeeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Employee>(
      rows,
      conflictColumns: conflictColumns(Employee.t),
      updateColumns: updateColumns?.call(Employee.t),
      updateWhere: updateWhere?.call(Employee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Employee] and returns the resulting row.
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
  /// The returned [Employee] will have its `id` field set.
  Future<Employee?> upsertRow(
    _is.DatabaseSession session,
    Employee row, {
    required _is.ColumnSelections<EmployeeTable> conflictColumns,
    _is.ColumnSelections<EmployeeTable>? updateColumns,
    _is.WhereExpressionBuilder<EmployeeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Employee>(
      row,
      conflictColumns: conflictColumns(Employee.t),
      updateColumns: updateColumns?.call(Employee.t),
      updateWhere: updateWhere?.call(Employee.t),
      transaction: transaction,
    );
  }

  /// Updates all [Employee]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Employee>> update(
    _is.DatabaseSession session,
    List<Employee> rows, {
    _is.ColumnSelections<EmployeeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Employee>(
      rows,
      columns: columns?.call(Employee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Employee]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Employee> updateRow(
    _is.DatabaseSession session,
    Employee row, {
    _is.ColumnSelections<EmployeeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Employee>(
      row,
      columns: columns?.call(Employee.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Employee] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Employee?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<EmployeeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Employee>(
      id,
      columnValues: columnValues(Employee.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Employee]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Employee>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EmployeeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<EmployeeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmployeeTable>? orderBy,
    _is.OrderByListBuilder<EmployeeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Employee>(
      columnValues: columnValues(Employee.t.updateTable),
      where: where(Employee.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Employee.t),
      orderByList: orderByList?.call(Employee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Employee]s in the list and returns the deleted rows.
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
  Future<List<Employee>> delete(
    _is.DatabaseSession session,
    List<Employee> rows, {
    _is.OrderByBuilder<EmployeeTable>? orderBy,
    _is.OrderByListBuilder<EmployeeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Employee>(
      rows,
      orderBy: orderBy?.call(Employee.t),
      orderByList: orderByList?.call(Employee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Employee].
  Future<Employee> deleteRow(
    _is.DatabaseSession session,
    Employee row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Employee>(
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
  Future<List<Employee>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EmployeeTable> where,
    _is.OrderByBuilder<EmployeeTable>? orderBy,
    _is.OrderByListBuilder<EmployeeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Employee>(
      where: where(Employee.t),
      orderBy: orderBy?.call(Employee.t),
      orderByList: orderByList?.call(Employee.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmployeeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Employee>(
      where: where?.call(Employee.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Employee] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EmployeeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Employee>(
      where: where(Employee.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class EmployeeAttachRowRepository {
  const EmployeeAttachRowRepository._();

  /// Creates a relation between the given [Employee] and [Owner]
  /// by setting the [Employee]'s foreign key `ownerId` to refer to the [Owner].
  Future<void> owner(
    _is.DatabaseSession session,
    Employee employee,
    _i2wy11ca.Owner owner, {
    _is.Transaction? transaction,
  }) async {
    if (employee.id == null) {
      throw ArgumentError.notNull('employee.id');
    }
    if (owner.id == null) {
      throw ArgumentError.notNull('owner.id');
    }

    var $employee = employee.copyWith(ownerId: owner.id);
    await session.db.updateRow<Employee>(
      $employee,
      columns: [Employee.t.ownerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Employee] and [Building]
  /// by setting the [Employee]'s foreign key `buildingId` to refer to the [Building].
  Future<void> building(
    _is.DatabaseSession session,
    Employee employee,
    _iaohraio.Building building, {
    _is.Transaction? transaction,
  }) async {
    if (employee.id == null) {
      throw ArgumentError.notNull('employee.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $employee = employee.copyWith(buildingId: building.id);
    await session.db.updateRow<Employee>(
      $employee,
      columns: [Employee.t.buildingId],
      transaction: transaction,
    );
  }
}
