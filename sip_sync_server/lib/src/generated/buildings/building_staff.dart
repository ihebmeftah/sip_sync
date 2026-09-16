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

/// Staff assigned to one building. The employee must already belong to the owner.
abstract class BuildingStaff
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  BuildingStaff._({
    this.id,
    required this.buildingId,
    this.building,
    required this.employeeAuthUserId,
  });

  factory BuildingStaff({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _idz3611u.Building? building,
    required _is.UuidValue employeeAuthUserId,
  }) = _BuildingStaffImpl;

  factory BuildingStaff.fromJson(Map<String, dynamic> jsonSerialization) {
    return BuildingStaff(
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
      employeeAuthUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['employeeAuthUserId'],
      ),
    );
  }

  static final t = BuildingStaffTable();

  static const db = BuildingStaffRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue buildingId;

  _idz3611u.Building? building;

  _is.UuidValue employeeAuthUserId;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [BuildingStaff]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BuildingStaff copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    _idz3611u.Building? building,
    _is.UuidValue? employeeAuthUserId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BuildingStaff',
      if (id != null) 'id': id?.toJson(),
      'buildingId': buildingId.toJson(),
      if (building != null) 'building': building?.toJson(),
      'employeeAuthUserId': employeeAuthUserId.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static BuildingStaffInclude include({_idz3611u.BuildingInclude? building}) {
    return BuildingStaffInclude._(building: building);
  }

  static BuildingStaffIncludeList includeList({
    _is.WhereExpressionBuilder<BuildingStaffTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BuildingStaffTable>? orderBy,
    _is.OrderByListBuilder<BuildingStaffTable>? orderByList,
    BuildingStaffInclude? include,
  }) {
    return BuildingStaffIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BuildingStaff.t),
      orderByList: orderByList?.call(BuildingStaff.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BuildingStaffImpl extends BuildingStaff {
  _BuildingStaffImpl({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _idz3611u.Building? building,
    required _is.UuidValue employeeAuthUserId,
  }) : super._(
         id: id,
         buildingId: buildingId,
         building: building,
         employeeAuthUserId: employeeAuthUserId,
       );

  /// Returns a shallow copy of this [BuildingStaff]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BuildingStaff copyWith({
    Object? id = _Undefined,
    _is.UuidValue? buildingId,
    Object? building = _Undefined,
    _is.UuidValue? employeeAuthUserId,
  }) {
    return BuildingStaff(
      id: id is _is.UuidValue? ? id : this.id,
      buildingId: buildingId ?? this.buildingId,
      building: building is _idz3611u.Building?
          ? building
          : this.building?.copyWith(),
      employeeAuthUserId: employeeAuthUserId ?? this.employeeAuthUserId,
    );
  }
}

class BuildingStaffUpdateTable extends _is.UpdateTable<BuildingStaffTable> {
  BuildingStaffUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> buildingId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.buildingId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> employeeAuthUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.employeeAuthUserId,
    value,
  );
}

class BuildingStaffTable extends _is.Table<_is.UuidValue?> {
  BuildingStaffTable({super.tableRelation})
    : super(tableName: 'building_staff') {
    updateTable = BuildingStaffUpdateTable(this);
    buildingId = _is.ColumnUuid(
      'buildingId',
      this,
    );
    employeeAuthUserId = _is.ColumnUuid(
      'employeeAuthUserId',
      this,
    );
  }

  late final BuildingStaffUpdateTable updateTable;

  late final _is.ColumnUuid buildingId;

  _idz3611u.BuildingTable? _building;

  late final _is.ColumnUuid employeeAuthUserId;

  _idz3611u.BuildingTable get building {
    if (_building != null) return _building!;
    _building = _is.createRelationTable(
      relationFieldName: 'building',
      field: BuildingStaff.t.buildingId,
      foreignField: _idz3611u.Building.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _idz3611u.BuildingTable(tableRelation: foreignTableRelation),
    );
    return _building!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    buildingId,
    employeeAuthUserId,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'building') {
      return building;
    }
    return null;
  }
}

class BuildingStaffInclude extends _is.IncludeObject {
  BuildingStaffInclude._({_idz3611u.BuildingInclude? building}) {
    _building = building;
  }

  _idz3611u.BuildingInclude? _building;

  @override
  Map<String, _is.Include?> get includes => {'building': _building};

  @override
  _is.Table<_is.UuidValue?> get table => BuildingStaff.t;
}

class BuildingStaffIncludeList extends _is.IncludeList {
  BuildingStaffIncludeList._({
    _is.WhereExpressionBuilder<BuildingStaffTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BuildingStaff.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => BuildingStaff.t;
}

class BuildingStaffRepository {
  const BuildingStaffRepository._();

  final attachRow = const BuildingStaffAttachRowRepository._();

  /// Returns a list of [BuildingStaff]s matching the given query parameters.
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
  Future<List<BuildingStaff>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BuildingStaffTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BuildingStaffTable>? orderBy,
    _is.OrderByListBuilder<BuildingStaffTable>? orderByList,
    _is.Transaction? transaction,
    BuildingStaffInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BuildingStaff>(
      where: where?.call(BuildingStaff.t),
      orderBy: orderBy?.call(BuildingStaff.t),
      orderByList: orderByList?.call(BuildingStaff.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BuildingStaff] matching the given query parameters.
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
  Future<BuildingStaff?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BuildingStaffTable>? where,
    int? offset,
    _is.OrderByBuilder<BuildingStaffTable>? orderBy,
    _is.OrderByListBuilder<BuildingStaffTable>? orderByList,
    _is.Transaction? transaction,
    BuildingStaffInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BuildingStaff>(
      where: where?.call(BuildingStaff.t),
      orderBy: orderBy?.call(BuildingStaff.t),
      orderByList: orderByList?.call(BuildingStaff.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BuildingStaff] by its [id] or null if no such row exists.
  Future<BuildingStaff?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    BuildingStaffInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BuildingStaff>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BuildingStaff]s in the list and returns the inserted rows.
  ///
  /// The returned [BuildingStaff]s will have their `id` fields set.
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
  Future<List<BuildingStaff>> insert(
    _is.DatabaseSession session,
    List<BuildingStaff> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BuildingStaff>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BuildingStaff] and returns the inserted row.
  ///
  /// The returned [BuildingStaff] will have its `id` field set.
  Future<BuildingStaff> insertRow(
    _is.DatabaseSession session,
    BuildingStaff row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BuildingStaff>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [BuildingStaff]s in the list and returns the resulting rows.
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
  /// The returned [BuildingStaff]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BuildingStaff>> upsert(
    _is.DatabaseSession session,
    List<BuildingStaff> rows, {
    required _is.ColumnSelections<BuildingStaffTable> conflictColumns,
    _is.ColumnSelections<BuildingStaffTable>? updateColumns,
    _is.WhereExpressionBuilder<BuildingStaffTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BuildingStaff>(
      rows,
      conflictColumns: conflictColumns(BuildingStaff.t),
      updateColumns: updateColumns?.call(BuildingStaff.t),
      updateWhere: updateWhere?.call(BuildingStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BuildingStaff] and returns the resulting row.
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
  /// The returned [BuildingStaff] will have its `id` field set.
  Future<BuildingStaff?> upsertRow(
    _is.DatabaseSession session,
    BuildingStaff row, {
    required _is.ColumnSelections<BuildingStaffTable> conflictColumns,
    _is.ColumnSelections<BuildingStaffTable>? updateColumns,
    _is.WhereExpressionBuilder<BuildingStaffTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BuildingStaff>(
      row,
      conflictColumns: conflictColumns(BuildingStaff.t),
      updateColumns: updateColumns?.call(BuildingStaff.t),
      updateWhere: updateWhere?.call(BuildingStaff.t),
      transaction: transaction,
    );
  }

  /// Updates all [BuildingStaff]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BuildingStaff>> update(
    _is.DatabaseSession session,
    List<BuildingStaff> rows, {
    _is.ColumnSelections<BuildingStaffTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BuildingStaff>(
      rows,
      columns: columns?.call(BuildingStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BuildingStaff]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BuildingStaff> updateRow(
    _is.DatabaseSession session,
    BuildingStaff row, {
    _is.ColumnSelections<BuildingStaffTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BuildingStaff>(
      row,
      columns: columns?.call(BuildingStaff.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BuildingStaff] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BuildingStaff?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<BuildingStaffUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BuildingStaff>(
      id,
      columnValues: columnValues(BuildingStaff.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BuildingStaff]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BuildingStaff>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BuildingStaffUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BuildingStaffTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BuildingStaffTable>? orderBy,
    _is.OrderByListBuilder<BuildingStaffTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BuildingStaff>(
      columnValues: columnValues(BuildingStaff.t.updateTable),
      where: where(BuildingStaff.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BuildingStaff.t),
      orderByList: orderByList?.call(BuildingStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BuildingStaff]s in the list and returns the deleted rows.
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
  Future<List<BuildingStaff>> delete(
    _is.DatabaseSession session,
    List<BuildingStaff> rows, {
    _is.OrderByBuilder<BuildingStaffTable>? orderBy,
    _is.OrderByListBuilder<BuildingStaffTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BuildingStaff>(
      rows,
      orderBy: orderBy?.call(BuildingStaff.t),
      orderByList: orderByList?.call(BuildingStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BuildingStaff].
  Future<BuildingStaff> deleteRow(
    _is.DatabaseSession session,
    BuildingStaff row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BuildingStaff>(
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
  Future<List<BuildingStaff>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BuildingStaffTable> where,
    _is.OrderByBuilder<BuildingStaffTable>? orderBy,
    _is.OrderByListBuilder<BuildingStaffTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BuildingStaff>(
      where: where(BuildingStaff.t),
      orderBy: orderBy?.call(BuildingStaff.t),
      orderByList: orderByList?.call(BuildingStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BuildingStaffTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BuildingStaff>(
      where: where?.call(BuildingStaff.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BuildingStaff] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BuildingStaffTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BuildingStaff>(
      where: where(BuildingStaff.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class BuildingStaffAttachRowRepository {
  const BuildingStaffAttachRowRepository._();

  /// Creates a relation between the given [BuildingStaff] and [Building]
  /// by setting the [BuildingStaff]'s foreign key `buildingId` to refer to the [Building].
  Future<void> building(
    _is.DatabaseSession session,
    BuildingStaff buildingStaff,
    _idz3611u.Building building, {
    _is.Transaction? transaction,
  }) async {
    if (buildingStaff.id == null) {
      throw ArgumentError.notNull('buildingStaff.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $buildingStaff = buildingStaff.copyWith(buildingId: building.id);
    await session.db.updateRow<BuildingStaff>(
      $buildingStaff,
      columns: [BuildingStaff.t.buildingId],
      transaction: transaction,
    );
  }
}
