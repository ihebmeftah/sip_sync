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
import '../auth/employee_record.dart' as _i8nmniuq;

/// A café, restaurant, lounge, bar, or custom venue owned by one owner.
abstract class Building
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  Building._({
    this.id,
    required this.ownerAuthUserId,
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
  }) : createdAt = createdAt ?? DateTime.now();

  factory Building({
    _is.UuidValue? id,
    required _is.UuidValue ownerAuthUserId,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    DateTime? createdAt,
    List<_i8nmniuq.EmployeeRecord>? employees,
  }) = _BuildingImpl;

  factory Building.fromJson(Map<String, dynamic> jsonSerialization) {
    return Building(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerAuthUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerAuthUserId'],
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
          : _iaib1p48.Protocol().deserialize<List<_i8nmniuq.EmployeeRecord>>(
              jsonSerialization['employees'],
            ),
    );
  }

  static final t = BuildingTable();

  static const db = BuildingRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue ownerAuthUserId;

  String name;

  String type;

  String address;

  double latitude;

  double longitude;

  int openingMinutes;

  int closingMinutes;

  String currencyCode;

  DateTime createdAt;

  List<_i8nmniuq.EmployeeRecord>? employees;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Building]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Building copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerAuthUserId,
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    int? openingMinutes,
    int? closingMinutes,
    String? currencyCode,
    DateTime? createdAt,
    List<_i8nmniuq.EmployeeRecord>? employees,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Building',
      if (id != null) 'id': id?.toJson(),
      'ownerAuthUserId': ownerAuthUserId.toJson(),
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
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static BuildingInclude include({
    _i8nmniuq.EmployeeRecordIncludeList? employees,
  }) {
    return BuildingInclude._(employees: employees);
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
    required _is.UuidValue ownerAuthUserId,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    DateTime? createdAt,
    List<_i8nmniuq.EmployeeRecord>? employees,
  }) : super._(
         id: id,
         ownerAuthUserId: ownerAuthUserId,
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
       );

  /// Returns a shallow copy of this [Building]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Building copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerAuthUserId,
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
  }) {
    return Building(
      id: id is _is.UuidValue? ? id : this.id,
      ownerAuthUserId: ownerAuthUserId ?? this.ownerAuthUserId,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      openingMinutes: openingMinutes ?? this.openingMinutes,
      closingMinutes: closingMinutes ?? this.closingMinutes,
      currencyCode: currencyCode ?? this.currencyCode,
      createdAt: createdAt ?? this.createdAt,
      employees: employees is List<_i8nmniuq.EmployeeRecord>?
          ? employees
          : this.employees?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class BuildingUpdateTable extends _is.UpdateTable<BuildingTable> {
  BuildingUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerAuthUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.ownerAuthUserId,
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
    ownerAuthUserId = _is.ColumnUuid(
      'ownerAuthUserId',
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

  late final _is.ColumnUuid ownerAuthUserId;

  late final _is.ColumnString name;

  late final _is.ColumnString type;

  late final _is.ColumnString address;

  late final _is.ColumnDouble latitude;

  late final _is.ColumnDouble longitude;

  late final _is.ColumnInt openingMinutes;

  late final _is.ColumnInt closingMinutes;

  late final _is.ColumnString currencyCode;

  late final _is.ColumnDateTime createdAt;

  _i8nmniuq.EmployeeRecordTable? ___employees;

  _is.ManyRelation<_i8nmniuq.EmployeeRecordTable>? _employees;

  _i8nmniuq.EmployeeRecordTable get __employees {
    if (___employees != null) return ___employees!;
    ___employees = _is.createRelationTable(
      relationFieldName: '__employees',
      field: Building.t.id,
      foreignField: _i8nmniuq.EmployeeRecord.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8nmniuq.EmployeeRecordTable(tableRelation: foreignTableRelation),
    );
    return ___employees!;
  }

  _is.ManyRelation<_i8nmniuq.EmployeeRecordTable> get employees {
    if (_employees != null) return _employees!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'employees',
      field: Building.t.id,
      foreignField: _i8nmniuq.EmployeeRecord.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8nmniuq.EmployeeRecordTable(tableRelation: foreignTableRelation),
    );
    _employees = _is.ManyRelation<_i8nmniuq.EmployeeRecordTable>(
      tableWithRelations: relationTable,
      table: _i8nmniuq.EmployeeRecordTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _employees!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    ownerAuthUserId,
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
    if (relationField == 'employees') {
      return __employees;
    }
    return null;
  }
}

class BuildingInclude extends _is.IncludeObject {
  BuildingInclude._({_i8nmniuq.EmployeeRecordIncludeList? employees}) {
    _employees = employees;
  }

  _i8nmniuq.EmployeeRecordIncludeList? _employees;

  @override
  Map<String, _is.Include?> get includes => {'employees': _employees};

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

  /// Creates a relation between this [Building] and the given [EmployeeRecord]s
  /// by setting each [EmployeeRecord]'s foreign key `buildingId` to refer to this [Building].
  Future<void> employees(
    _is.DatabaseSession session,
    Building building,
    List<_i8nmniuq.EmployeeRecord> employeeRecord, {
    _is.Transaction? transaction,
  }) async {
    if (employeeRecord.any((e) => e.id == null)) {
      throw ArgumentError.notNull('employeeRecord.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $employeeRecord = employeeRecord
        .map((e) => e.copyWith(buildingId: building.id))
        .toList();
    await session.db.update<_i8nmniuq.EmployeeRecord>(
      $employeeRecord,
      columns: [_i8nmniuq.EmployeeRecord.t.buildingId],
      transaction: transaction,
    );
  }
}

class BuildingAttachRowRepository {
  const BuildingAttachRowRepository._();

  /// Creates a relation between this [Building] and the given [EmployeeRecord]
  /// by setting the [EmployeeRecord]'s foreign key `buildingId` to refer to this [Building].
  Future<void> employees(
    _is.DatabaseSession session,
    Building building,
    _i8nmniuq.EmployeeRecord employeeRecord, {
    _is.Transaction? transaction,
  }) async {
    if (employeeRecord.id == null) {
      throw ArgumentError.notNull('employeeRecord.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $employeeRecord = employeeRecord.copyWith(buildingId: building.id);
    await session.db.updateRow<_i8nmniuq.EmployeeRecord>(
      $employeeRecord,
      columns: [_i8nmniuq.EmployeeRecord.t.buildingId],
      transaction: transaction,
    );
  }
}
