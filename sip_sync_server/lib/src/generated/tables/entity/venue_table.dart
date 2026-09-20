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
import '../../orders/entity/venue_order.dart' as _iwamn8sj;

/// A physical dining table in a venue. Floor status is computed, not stored.
abstract class VenueTable
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  VenueTable._({
    this.id,
    required this.buildingId,
    this.building,
    required this.number,
    required this.maxSeats,
    bool? isActive,
    DateTime? createdAt,
    this.orders,
  }) : isActive = isActive ?? true,
       createdAt = createdAt ?? DateTime.now();

  factory VenueTable({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    required int number,
    required int maxSeats,
    bool? isActive,
    DateTime? createdAt,
    List<_iwamn8sj.VenueOrder>? orders,
  }) = _VenueTableImpl;

  factory VenueTable.fromJson(Map<String, dynamic> jsonSerialization) {
    return VenueTable(
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
      number: jsonSerialization['number'] as int,
      maxSeats: jsonSerialization['maxSeats'] as int,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      orders: jsonSerialization['orders'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_iwamn8sj.VenueOrder>>(
              jsonSerialization['orders'],
            ),
    );
  }

  static final t = VenueTableTable();

  static const db = VenueTableRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue buildingId;

  _iaohraio.Building? building;

  int number;

  int maxSeats;

  bool isActive;

  DateTime createdAt;

  List<_iwamn8sj.VenueOrder>? orders;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [VenueTable]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VenueTable copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    _iaohraio.Building? building,
    int? number,
    int? maxSeats,
    bool? isActive,
    DateTime? createdAt,
    List<_iwamn8sj.VenueOrder>? orders,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VenueTable',
      if (id != null) 'id': id?.toJson(),
      'buildingId': buildingId.toJson(),
      if (building != null) 'building': building?.toJson(),
      'number': number,
      'maxSeats': maxSeats,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      if (orders != null)
        'orders': orders?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static VenueTableInclude include({
    _iaohraio.BuildingInclude? building,
    _iwamn8sj.VenueOrderIncludeList? orders,
  }) {
    return VenueTableInclude._(
      building: building,
      orders: orders,
    );
  }

  static VenueTableIncludeList includeList({
    _is.WhereExpressionBuilder<VenueTableTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VenueTableTable>? orderBy,
    _is.OrderByListBuilder<VenueTableTable>? orderByList,
    VenueTableInclude? include,
  }) {
    return VenueTableIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VenueTable.t),
      orderByList: orderByList?.call(VenueTable.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VenueTableImpl extends VenueTable {
  _VenueTableImpl({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    required int number,
    required int maxSeats,
    bool? isActive,
    DateTime? createdAt,
    List<_iwamn8sj.VenueOrder>? orders,
  }) : super._(
         id: id,
         buildingId: buildingId,
         building: building,
         number: number,
         maxSeats: maxSeats,
         isActive: isActive,
         createdAt: createdAt,
         orders: orders,
       );

  /// Returns a shallow copy of this [VenueTable]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VenueTable copyWith({
    Object? id = _Undefined,
    _is.UuidValue? buildingId,
    Object? building = _Undefined,
    int? number,
    int? maxSeats,
    bool? isActive,
    DateTime? createdAt,
    Object? orders = _Undefined,
  }) {
    return VenueTable(
      id: id is _is.UuidValue? ? id : this.id,
      buildingId: buildingId ?? this.buildingId,
      building: building is _iaohraio.Building?
          ? building
          : this.building?.copyWith(),
      number: number ?? this.number,
      maxSeats: maxSeats ?? this.maxSeats,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      orders: orders is List<_iwamn8sj.VenueOrder>?
          ? orders
          : this.orders?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class VenueTableUpdateTable extends _is.UpdateTable<VenueTableTable> {
  VenueTableUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> buildingId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.buildingId,
    value,
  );

  _is.ColumnValue<int, int> number(int value) => _is.ColumnValue(
    table.number,
    value,
  );

  _is.ColumnValue<int, int> maxSeats(int value) => _is.ColumnValue(
    table.maxSeats,
    value,
  );

  _is.ColumnValue<bool, bool> isActive(bool value) => _is.ColumnValue(
    table.isActive,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class VenueTableTable extends _is.Table<_is.UuidValue?> {
  VenueTableTable({super.tableRelation}) : super(tableName: 'venue_table') {
    updateTable = VenueTableUpdateTable(this);
    buildingId = _is.ColumnUuid(
      'buildingId',
      this,
    );
    number = _is.ColumnInt(
      'number',
      this,
    );
    maxSeats = _is.ColumnInt(
      'maxSeats',
      this,
    );
    isActive = _is.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final VenueTableUpdateTable updateTable;

  late final _is.ColumnUuid buildingId;

  _iaohraio.BuildingTable? _building;

  late final _is.ColumnInt number;

  late final _is.ColumnInt maxSeats;

  late final _is.ColumnBool isActive;

  late final _is.ColumnDateTime createdAt;

  _iwamn8sj.VenueOrderTable? ___orders;

  _is.ManyRelation<_iwamn8sj.VenueOrderTable>? _orders;

  _iaohraio.BuildingTable get building {
    if (_building != null) return _building!;
    _building = _is.createRelationTable(
      relationFieldName: 'building',
      field: VenueTable.t.buildingId,
      foreignField: _iaohraio.Building.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iaohraio.BuildingTable(tableRelation: foreignTableRelation),
    );
    return _building!;
  }

  _iwamn8sj.VenueOrderTable get __orders {
    if (___orders != null) return ___orders!;
    ___orders = _is.createRelationTable(
      relationFieldName: '__orders',
      field: VenueTable.t.id,
      foreignField: _iwamn8sj.VenueOrder.t.venueTableId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iwamn8sj.VenueOrderTable(tableRelation: foreignTableRelation),
    );
    return ___orders!;
  }

  _is.ManyRelation<_iwamn8sj.VenueOrderTable> get orders {
    if (_orders != null) return _orders!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'orders',
      field: VenueTable.t.id,
      foreignField: _iwamn8sj.VenueOrder.t.venueTableId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iwamn8sj.VenueOrderTable(tableRelation: foreignTableRelation),
    );
    _orders = _is.ManyRelation<_iwamn8sj.VenueOrderTable>(
      tableWithRelations: relationTable,
      table: _iwamn8sj.VenueOrderTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _orders!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    buildingId,
    number,
    maxSeats,
    isActive,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'building') {
      return building;
    }
    if (relationField == 'orders') {
      return __orders;
    }
    return null;
  }
}

class VenueTableInclude extends _is.IncludeObject {
  VenueTableInclude._({
    _iaohraio.BuildingInclude? building,
    _iwamn8sj.VenueOrderIncludeList? orders,
  }) {
    _building = building;
    _orders = orders;
  }

  _iaohraio.BuildingInclude? _building;

  _iwamn8sj.VenueOrderIncludeList? _orders;

  @override
  Map<String, _is.Include?> get includes => {
    'building': _building,
    'orders': _orders,
  };

  @override
  _is.Table<_is.UuidValue?> get table => VenueTable.t;
}

class VenueTableIncludeList extends _is.IncludeList {
  VenueTableIncludeList._({
    _is.WhereExpressionBuilder<VenueTableTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VenueTable.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => VenueTable.t;
}

class VenueTableRepository {
  const VenueTableRepository._();

  final attach = const VenueTableAttachRepository._();

  final attachRow = const VenueTableAttachRowRepository._();

  final detach = const VenueTableDetachRepository._();

  final detachRow = const VenueTableDetachRowRepository._();

  /// Returns a list of [VenueTable]s matching the given query parameters.
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
  Future<List<VenueTable>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VenueTableTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VenueTableTable>? orderBy,
    _is.OrderByListBuilder<VenueTableTable>? orderByList,
    _is.Transaction? transaction,
    VenueTableInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VenueTable>(
      where: where?.call(VenueTable.t),
      orderBy: orderBy?.call(VenueTable.t),
      orderByList: orderByList?.call(VenueTable.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VenueTable] matching the given query parameters.
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
  Future<VenueTable?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VenueTableTable>? where,
    int? offset,
    _is.OrderByBuilder<VenueTableTable>? orderBy,
    _is.OrderByListBuilder<VenueTableTable>? orderByList,
    _is.Transaction? transaction,
    VenueTableInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VenueTable>(
      where: where?.call(VenueTable.t),
      orderBy: orderBy?.call(VenueTable.t),
      orderByList: orderByList?.call(VenueTable.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VenueTable] by its [id] or null if no such row exists.
  Future<VenueTable?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    VenueTableInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VenueTable>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VenueTable]s in the list and returns the inserted rows.
  ///
  /// The returned [VenueTable]s will have their `id` fields set.
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
  Future<List<VenueTable>> insert(
    _is.DatabaseSession session,
    List<VenueTable> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<VenueTable>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [VenueTable] and returns the inserted row.
  ///
  /// The returned [VenueTable] will have its `id` field set.
  Future<VenueTable> insertRow(
    _is.DatabaseSession session,
    VenueTable row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<VenueTable>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [VenueTable]s in the list and returns the resulting rows.
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
  /// The returned [VenueTable]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VenueTable>> upsert(
    _is.DatabaseSession session,
    List<VenueTable> rows, {
    required _is.ColumnSelections<VenueTableTable> conflictColumns,
    _is.ColumnSelections<VenueTableTable>? updateColumns,
    _is.WhereExpressionBuilder<VenueTableTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<VenueTable>(
      rows,
      conflictColumns: conflictColumns(VenueTable.t),
      updateColumns: updateColumns?.call(VenueTable.t),
      updateWhere: updateWhere?.call(VenueTable.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [VenueTable] and returns the resulting row.
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
  /// The returned [VenueTable] will have its `id` field set.
  Future<VenueTable?> upsertRow(
    _is.DatabaseSession session,
    VenueTable row, {
    required _is.ColumnSelections<VenueTableTable> conflictColumns,
    _is.ColumnSelections<VenueTableTable>? updateColumns,
    _is.WhereExpressionBuilder<VenueTableTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<VenueTable>(
      row,
      conflictColumns: conflictColumns(VenueTable.t),
      updateColumns: updateColumns?.call(VenueTable.t),
      updateWhere: updateWhere?.call(VenueTable.t),
      transaction: transaction,
    );
  }

  /// Updates all [VenueTable]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VenueTable>> update(
    _is.DatabaseSession session,
    List<VenueTable> rows, {
    _is.ColumnSelections<VenueTableTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<VenueTable>(
      rows,
      columns: columns?.call(VenueTable.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [VenueTable]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VenueTable> updateRow(
    _is.DatabaseSession session,
    VenueTable row, {
    _is.ColumnSelections<VenueTableTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<VenueTable>(
      row,
      columns: columns?.call(VenueTable.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VenueTable] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VenueTable?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<VenueTableUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<VenueTable>(
      id,
      columnValues: columnValues(VenueTable.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VenueTable]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VenueTable>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<VenueTableUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<VenueTableTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VenueTableTable>? orderBy,
    _is.OrderByListBuilder<VenueTableTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<VenueTable>(
      columnValues: columnValues(VenueTable.t.updateTable),
      where: where(VenueTable.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VenueTable.t),
      orderByList: orderByList?.call(VenueTable.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [VenueTable]s in the list and returns the deleted rows.
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
  Future<List<VenueTable>> delete(
    _is.DatabaseSession session,
    List<VenueTable> rows, {
    _is.OrderByBuilder<VenueTableTable>? orderBy,
    _is.OrderByListBuilder<VenueTableTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<VenueTable>(
      rows,
      orderBy: orderBy?.call(VenueTable.t),
      orderByList: orderByList?.call(VenueTable.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [VenueTable].
  Future<VenueTable> deleteRow(
    _is.DatabaseSession session,
    VenueTable row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VenueTable>(
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
  Future<List<VenueTable>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VenueTableTable> where,
    _is.OrderByBuilder<VenueTableTable>? orderBy,
    _is.OrderByListBuilder<VenueTableTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<VenueTable>(
      where: where(VenueTable.t),
      orderBy: orderBy?.call(VenueTable.t),
      orderByList: orderByList?.call(VenueTable.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VenueTableTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<VenueTable>(
      where: where?.call(VenueTable.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VenueTable] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VenueTableTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VenueTable>(
      where: where(VenueTable.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class VenueTableAttachRepository {
  const VenueTableAttachRepository._();

  /// Creates a relation between this [VenueTable] and the given [VenueOrder]s
  /// by setting each [VenueOrder]'s foreign key `venueTableId` to refer to this [VenueTable].
  Future<void> orders(
    _is.DatabaseSession session,
    VenueTable venueTable,
    List<_iwamn8sj.VenueOrder> venueOrder, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrder.any((e) => e.id == null)) {
      throw ArgumentError.notNull('venueOrder.id');
    }
    if (venueTable.id == null) {
      throw ArgumentError.notNull('venueTable.id');
    }

    var $venueOrder = venueOrder
        .map((e) => e.copyWith(venueTableId: venueTable.id))
        .toList();
    await session.db.update<_iwamn8sj.VenueOrder>(
      $venueOrder,
      columns: [_iwamn8sj.VenueOrder.t.venueTableId],
      transaction: transaction,
    );
  }
}

class VenueTableAttachRowRepository {
  const VenueTableAttachRowRepository._();

  /// Creates a relation between the given [VenueTable] and [Building]
  /// by setting the [VenueTable]'s foreign key `buildingId` to refer to the [Building].
  Future<void> building(
    _is.DatabaseSession session,
    VenueTable venueTable,
    _iaohraio.Building building, {
    _is.Transaction? transaction,
  }) async {
    if (venueTable.id == null) {
      throw ArgumentError.notNull('venueTable.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $venueTable = venueTable.copyWith(buildingId: building.id);
    await session.db.updateRow<VenueTable>(
      $venueTable,
      columns: [VenueTable.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [VenueTable] and the given [VenueOrder]
  /// by setting the [VenueOrder]'s foreign key `venueTableId` to refer to this [VenueTable].
  Future<void> orders(
    _is.DatabaseSession session,
    VenueTable venueTable,
    _iwamn8sj.VenueOrder venueOrder, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrder.id == null) {
      throw ArgumentError.notNull('venueOrder.id');
    }
    if (venueTable.id == null) {
      throw ArgumentError.notNull('venueTable.id');
    }

    var $venueOrder = venueOrder.copyWith(venueTableId: venueTable.id);
    await session.db.updateRow<_iwamn8sj.VenueOrder>(
      $venueOrder,
      columns: [_iwamn8sj.VenueOrder.t.venueTableId],
      transaction: transaction,
    );
  }
}

class VenueTableDetachRepository {
  const VenueTableDetachRepository._();

  /// Detaches the relation between this [VenueTable] and the given [VenueOrder]
  /// by setting the [VenueOrder]'s foreign key `venueTableId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> orders(
    _is.DatabaseSession session,
    List<_iwamn8sj.VenueOrder> venueOrder, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrder.any((e) => e.id == null)) {
      throw ArgumentError.notNull('venueOrder.id');
    }

    var $venueOrder = venueOrder
        .map((e) => e.copyWith(venueTableId: null))
        .toList();
    await session.db.update<_iwamn8sj.VenueOrder>(
      $venueOrder,
      columns: [_iwamn8sj.VenueOrder.t.venueTableId],
      transaction: transaction,
    );
  }
}

class VenueTableDetachRowRepository {
  const VenueTableDetachRowRepository._();

  /// Detaches the relation between this [VenueTable] and the given [VenueOrder]
  /// by setting the [VenueOrder]'s foreign key `venueTableId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> orders(
    _is.DatabaseSession session,
    _iwamn8sj.VenueOrder venueOrder, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrder.id == null) {
      throw ArgumentError.notNull('venueOrder.id');
    }

    var $venueOrder = venueOrder.copyWith(venueTableId: null);
    await session.db.updateRow<_iwamn8sj.VenueOrder>(
      $venueOrder,
      columns: [_iwamn8sj.VenueOrder.t.venueTableId],
      transaction: transaction,
    );
  }
}
