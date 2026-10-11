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
import '../../auth/entity/employee.dart' as _ie30fksv;
import '../../buildings/entity/building.dart' as _iaohraio;

/// Named permission set for staff in one building.
abstract class EmployeeAccess
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  EmployeeAccess._({
    this.id,
    required this.buildingId,
    this.building,
    required this.name,
    bool? orderCreation,
    bool? orderPayment,
    bool? cancelOrder,
    bool? preparation,
    bool? serving,
    bool? consultAllOrders,
    bool? reservations,
    DateTime? createdAt,
    this.employees,
  }) : orderCreation = orderCreation ?? false,
       orderPayment = orderPayment ?? false,
       cancelOrder = cancelOrder ?? false,
       preparation = preparation ?? false,
       serving = serving ?? false,
       consultAllOrders = consultAllOrders ?? false,
       reservations = reservations ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory EmployeeAccess({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    required String name,
    bool? orderCreation,
    bool? orderPayment,
    bool? cancelOrder,
    bool? preparation,
    bool? serving,
    bool? consultAllOrders,
    bool? reservations,
    DateTime? createdAt,
    List<_ie30fksv.Employee>? employees,
  }) = _EmployeeAccessImpl;

  factory EmployeeAccess.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmployeeAccess(
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
      name: jsonSerialization['name'] as String,
      orderCreation: jsonSerialization['orderCreation'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['orderCreation']),
      orderPayment: jsonSerialization['orderPayment'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['orderPayment']),
      cancelOrder: jsonSerialization['cancelOrder'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['cancelOrder']),
      preparation: jsonSerialization['preparation'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['preparation']),
      serving: jsonSerialization['serving'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['serving']),
      consultAllOrders: jsonSerialization['consultAllOrders'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['consultAllOrders'],
            ),
      reservations: jsonSerialization['reservations'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['reservations']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      employees: jsonSerialization['employees'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_ie30fksv.Employee>>(
              jsonSerialization['employees'],
            ),
    );
  }

  static final t = EmployeeAccessTable();

  static const db = EmployeeAccessRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue buildingId;

  _iaohraio.Building? building;

  String name;

  bool orderCreation;

  bool orderPayment;

  bool cancelOrder;

  bool preparation;

  bool serving;

  bool consultAllOrders;

  /// Create, confirm, cancel, and assign tables for reservations in this building.
  bool reservations;

  DateTime createdAt;

  List<_ie30fksv.Employee>? employees;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [EmployeeAccess]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EmployeeAccess copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    _iaohraio.Building? building,
    String? name,
    bool? orderCreation,
    bool? orderPayment,
    bool? cancelOrder,
    bool? preparation,
    bool? serving,
    bool? consultAllOrders,
    bool? reservations,
    DateTime? createdAt,
    List<_ie30fksv.Employee>? employees,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmployeeAccess',
      if (id != null) 'id': id?.toJson(),
      'buildingId': buildingId.toJson(),
      if (building != null) 'building': building?.toJson(),
      'name': name,
      'orderCreation': orderCreation,
      'orderPayment': orderPayment,
      'cancelOrder': cancelOrder,
      'preparation': preparation,
      'serving': serving,
      'consultAllOrders': consultAllOrders,
      'reservations': reservations,
      'createdAt': createdAt.toJson(),
      if (employees != null)
        'employees': employees?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static EmployeeAccessInclude include({
    _iaohraio.BuildingInclude? building,
    _ie30fksv.EmployeeIncludeList? employees,
  }) {
    return EmployeeAccessInclude._(
      building: building,
      employees: employees,
    );
  }

  static EmployeeAccessIncludeList includeList({
    _is.WhereExpressionBuilder<EmployeeAccessTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmployeeAccessTable>? orderBy,
    _is.OrderByListBuilder<EmployeeAccessTable>? orderByList,
    EmployeeAccessInclude? include,
  }) {
    return EmployeeAccessIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmployeeAccess.t),
      orderByList: orderByList?.call(EmployeeAccess.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmployeeAccessImpl extends EmployeeAccess {
  _EmployeeAccessImpl({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    required String name,
    bool? orderCreation,
    bool? orderPayment,
    bool? cancelOrder,
    bool? preparation,
    bool? serving,
    bool? consultAllOrders,
    bool? reservations,
    DateTime? createdAt,
    List<_ie30fksv.Employee>? employees,
  }) : super._(
         id: id,
         buildingId: buildingId,
         building: building,
         name: name,
         orderCreation: orderCreation,
         orderPayment: orderPayment,
         cancelOrder: cancelOrder,
         preparation: preparation,
         serving: serving,
         consultAllOrders: consultAllOrders,
         reservations: reservations,
         createdAt: createdAt,
         employees: employees,
       );

  /// Returns a shallow copy of this [EmployeeAccess]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EmployeeAccess copyWith({
    Object? id = _Undefined,
    _is.UuidValue? buildingId,
    Object? building = _Undefined,
    String? name,
    bool? orderCreation,
    bool? orderPayment,
    bool? cancelOrder,
    bool? preparation,
    bool? serving,
    bool? consultAllOrders,
    bool? reservations,
    DateTime? createdAt,
    Object? employees = _Undefined,
  }) {
    return EmployeeAccess(
      id: id is _is.UuidValue? ? id : this.id,
      buildingId: buildingId ?? this.buildingId,
      building: building is _iaohraio.Building?
          ? building
          : this.building?.copyWith(),
      name: name ?? this.name,
      orderCreation: orderCreation ?? this.orderCreation,
      orderPayment: orderPayment ?? this.orderPayment,
      cancelOrder: cancelOrder ?? this.cancelOrder,
      preparation: preparation ?? this.preparation,
      serving: serving ?? this.serving,
      consultAllOrders: consultAllOrders ?? this.consultAllOrders,
      reservations: reservations ?? this.reservations,
      createdAt: createdAt ?? this.createdAt,
      employees: employees is List<_ie30fksv.Employee>?
          ? employees
          : this.employees?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class EmployeeAccessUpdateTable extends _is.UpdateTable<EmployeeAccessTable> {
  EmployeeAccessUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> buildingId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.buildingId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<bool, bool> orderCreation(bool value) => _is.ColumnValue(
    table.orderCreation,
    value,
  );

  _is.ColumnValue<bool, bool> orderPayment(bool value) => _is.ColumnValue(
    table.orderPayment,
    value,
  );

  _is.ColumnValue<bool, bool> cancelOrder(bool value) => _is.ColumnValue(
    table.cancelOrder,
    value,
  );

  _is.ColumnValue<bool, bool> preparation(bool value) => _is.ColumnValue(
    table.preparation,
    value,
  );

  _is.ColumnValue<bool, bool> serving(bool value) => _is.ColumnValue(
    table.serving,
    value,
  );

  _is.ColumnValue<bool, bool> consultAllOrders(bool value) => _is.ColumnValue(
    table.consultAllOrders,
    value,
  );

  _is.ColumnValue<bool, bool> reservations(bool value) => _is.ColumnValue(
    table.reservations,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class EmployeeAccessTable extends _is.Table<_is.UuidValue?> {
  EmployeeAccessTable({super.tableRelation})
    : super(tableName: 'employee_access') {
    updateTable = EmployeeAccessUpdateTable(this);
    buildingId = _is.ColumnUuid(
      'buildingId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    orderCreation = _is.ColumnBool(
      'orderCreation',
      this,
      hasDefault: true,
    );
    orderPayment = _is.ColumnBool(
      'orderPayment',
      this,
      hasDefault: true,
    );
    cancelOrder = _is.ColumnBool(
      'cancelOrder',
      this,
      hasDefault: true,
    );
    preparation = _is.ColumnBool(
      'preparation',
      this,
      hasDefault: true,
    );
    serving = _is.ColumnBool(
      'serving',
      this,
      hasDefault: true,
    );
    consultAllOrders = _is.ColumnBool(
      'consultAllOrders',
      this,
      hasDefault: true,
    );
    reservations = _is.ColumnBool(
      'reservations',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final EmployeeAccessUpdateTable updateTable;

  late final _is.ColumnUuid buildingId;

  _iaohraio.BuildingTable? _building;

  late final _is.ColumnString name;

  late final _is.ColumnBool orderCreation;

  late final _is.ColumnBool orderPayment;

  late final _is.ColumnBool cancelOrder;

  late final _is.ColumnBool preparation;

  late final _is.ColumnBool serving;

  late final _is.ColumnBool consultAllOrders;

  /// Create, confirm, cancel, and assign tables for reservations in this building.
  late final _is.ColumnBool reservations;

  late final _is.ColumnDateTime createdAt;

  _ie30fksv.EmployeeTable? ___employees;

  _is.ManyRelation<_ie30fksv.EmployeeTable>? _employees;

  _iaohraio.BuildingTable get building {
    if (_building != null) return _building!;
    _building = _is.createRelationTable(
      relationFieldName: 'building',
      field: EmployeeAccess.t.buildingId,
      foreignField: _iaohraio.Building.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iaohraio.BuildingTable(tableRelation: foreignTableRelation),
    );
    return _building!;
  }

  _ie30fksv.EmployeeTable get __employees {
    if (___employees != null) return ___employees!;
    ___employees = _is.createRelationTable(
      relationFieldName: '__employees',
      field: EmployeeAccess.t.id,
      foreignField: _ie30fksv.Employee.t.accessId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ie30fksv.EmployeeTable(tableRelation: foreignTableRelation),
    );
    return ___employees!;
  }

  _is.ManyRelation<_ie30fksv.EmployeeTable> get employees {
    if (_employees != null) return _employees!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'employees',
      field: EmployeeAccess.t.id,
      foreignField: _ie30fksv.Employee.t.accessId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ie30fksv.EmployeeTable(tableRelation: foreignTableRelation),
    );
    _employees = _is.ManyRelation<_ie30fksv.EmployeeTable>(
      tableWithRelations: relationTable,
      table: _ie30fksv.EmployeeTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _employees!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    buildingId,
    name,
    orderCreation,
    orderPayment,
    cancelOrder,
    preparation,
    serving,
    consultAllOrders,
    reservations,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'building') {
      return building;
    }
    if (relationField == 'employees') {
      return __employees;
    }
    return null;
  }
}

class EmployeeAccessInclude extends _is.IncludeObject {
  EmployeeAccessInclude._({
    _iaohraio.BuildingInclude? building,
    _ie30fksv.EmployeeIncludeList? employees,
  }) {
    _building = building;
    _employees = employees;
  }

  _iaohraio.BuildingInclude? _building;

  _ie30fksv.EmployeeIncludeList? _employees;

  @override
  Map<String, _is.Include?> get includes => {
    'building': _building,
    'employees': _employees,
  };

  @override
  _is.Table<_is.UuidValue?> get table => EmployeeAccess.t;
}

class EmployeeAccessIncludeList extends _is.IncludeList {
  EmployeeAccessIncludeList._({
    _is.WhereExpressionBuilder<EmployeeAccessTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EmployeeAccess.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => EmployeeAccess.t;
}

class EmployeeAccessRepository {
  const EmployeeAccessRepository._();

  final attach = const EmployeeAccessAttachRepository._();

  final attachRow = const EmployeeAccessAttachRowRepository._();

  final detach = const EmployeeAccessDetachRepository._();

  final detachRow = const EmployeeAccessDetachRowRepository._();

  /// Returns a list of [EmployeeAccess]s matching the given query parameters.
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
  Future<List<EmployeeAccess>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmployeeAccessTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmployeeAccessTable>? orderBy,
    _is.OrderByListBuilder<EmployeeAccessTable>? orderByList,
    _is.Transaction? transaction,
    EmployeeAccessInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EmployeeAccess>(
      where: where?.call(EmployeeAccess.t),
      orderBy: orderBy?.call(EmployeeAccess.t),
      orderByList: orderByList?.call(EmployeeAccess.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EmployeeAccess] matching the given query parameters.
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
  Future<EmployeeAccess?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmployeeAccessTable>? where,
    int? offset,
    _is.OrderByBuilder<EmployeeAccessTable>? orderBy,
    _is.OrderByListBuilder<EmployeeAccessTable>? orderByList,
    _is.Transaction? transaction,
    EmployeeAccessInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EmployeeAccess>(
      where: where?.call(EmployeeAccess.t),
      orderBy: orderBy?.call(EmployeeAccess.t),
      orderByList: orderByList?.call(EmployeeAccess.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EmployeeAccess] by its [id] or null if no such row exists.
  Future<EmployeeAccess?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    EmployeeAccessInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EmployeeAccess>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EmployeeAccess]s in the list and returns the inserted rows.
  ///
  /// The returned [EmployeeAccess]s will have their `id` fields set.
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
  Future<List<EmployeeAccess>> insert(
    _is.DatabaseSession session,
    List<EmployeeAccess> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EmployeeAccess>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EmployeeAccess] and returns the inserted row.
  ///
  /// The returned [EmployeeAccess] will have its `id` field set.
  Future<EmployeeAccess> insertRow(
    _is.DatabaseSession session,
    EmployeeAccess row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EmployeeAccess>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EmployeeAccess]s in the list and returns the resulting rows.
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
  /// The returned [EmployeeAccess]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmployeeAccess>> upsert(
    _is.DatabaseSession session,
    List<EmployeeAccess> rows, {
    required _is.ColumnSelections<EmployeeAccessTable> conflictColumns,
    _is.ColumnSelections<EmployeeAccessTable>? updateColumns,
    _is.WhereExpressionBuilder<EmployeeAccessTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EmployeeAccess>(
      rows,
      conflictColumns: conflictColumns(EmployeeAccess.t),
      updateColumns: updateColumns?.call(EmployeeAccess.t),
      updateWhere: updateWhere?.call(EmployeeAccess.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EmployeeAccess] and returns the resulting row.
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
  /// The returned [EmployeeAccess] will have its `id` field set.
  Future<EmployeeAccess?> upsertRow(
    _is.DatabaseSession session,
    EmployeeAccess row, {
    required _is.ColumnSelections<EmployeeAccessTable> conflictColumns,
    _is.ColumnSelections<EmployeeAccessTable>? updateColumns,
    _is.WhereExpressionBuilder<EmployeeAccessTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EmployeeAccess>(
      row,
      conflictColumns: conflictColumns(EmployeeAccess.t),
      updateColumns: updateColumns?.call(EmployeeAccess.t),
      updateWhere: updateWhere?.call(EmployeeAccess.t),
      transaction: transaction,
    );
  }

  /// Updates all [EmployeeAccess]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmployeeAccess>> update(
    _is.DatabaseSession session,
    List<EmployeeAccess> rows, {
    _is.ColumnSelections<EmployeeAccessTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EmployeeAccess>(
      rows,
      columns: columns?.call(EmployeeAccess.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EmployeeAccess]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EmployeeAccess> updateRow(
    _is.DatabaseSession session,
    EmployeeAccess row, {
    _is.ColumnSelections<EmployeeAccessTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EmployeeAccess>(
      row,
      columns: columns?.call(EmployeeAccess.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EmployeeAccess] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EmployeeAccess?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<EmployeeAccessUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EmployeeAccess>(
      id,
      columnValues: columnValues(EmployeeAccess.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EmployeeAccess]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmployeeAccess>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EmployeeAccessUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<EmployeeAccessTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmployeeAccessTable>? orderBy,
    _is.OrderByListBuilder<EmployeeAccessTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EmployeeAccess>(
      columnValues: columnValues(EmployeeAccess.t.updateTable),
      where: where(EmployeeAccess.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmployeeAccess.t),
      orderByList: orderByList?.call(EmployeeAccess.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EmployeeAccess]s in the list and returns the deleted rows.
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
  Future<List<EmployeeAccess>> delete(
    _is.DatabaseSession session,
    List<EmployeeAccess> rows, {
    _is.OrderByBuilder<EmployeeAccessTable>? orderBy,
    _is.OrderByListBuilder<EmployeeAccessTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EmployeeAccess>(
      rows,
      orderBy: orderBy?.call(EmployeeAccess.t),
      orderByList: orderByList?.call(EmployeeAccess.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EmployeeAccess].
  Future<EmployeeAccess> deleteRow(
    _is.DatabaseSession session,
    EmployeeAccess row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EmployeeAccess>(
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
  Future<List<EmployeeAccess>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EmployeeAccessTable> where,
    _is.OrderByBuilder<EmployeeAccessTable>? orderBy,
    _is.OrderByListBuilder<EmployeeAccessTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EmployeeAccess>(
      where: where(EmployeeAccess.t),
      orderBy: orderBy?.call(EmployeeAccess.t),
      orderByList: orderByList?.call(EmployeeAccess.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmployeeAccessTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EmployeeAccess>(
      where: where?.call(EmployeeAccess.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EmployeeAccess] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EmployeeAccessTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EmployeeAccess>(
      where: where(EmployeeAccess.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class EmployeeAccessAttachRepository {
  const EmployeeAccessAttachRepository._();

  /// Creates a relation between this [EmployeeAccess] and the given [Employee]s
  /// by setting each [Employee]'s foreign key `accessId` to refer to this [EmployeeAccess].
  Future<void> employees(
    _is.DatabaseSession session,
    EmployeeAccess employeeAccess,
    List<_ie30fksv.Employee> employee, {
    _is.Transaction? transaction,
  }) async {
    if (employee.any((e) => e.id == null)) {
      throw ArgumentError.notNull('employee.id');
    }
    if (employeeAccess.id == null) {
      throw ArgumentError.notNull('employeeAccess.id');
    }

    var $employee = employee
        .map((e) => e.copyWith(accessId: employeeAccess.id))
        .toList();
    await session.db.update<_ie30fksv.Employee>(
      $employee,
      columns: [_ie30fksv.Employee.t.accessId],
      transaction: transaction,
    );
  }
}

class EmployeeAccessAttachRowRepository {
  const EmployeeAccessAttachRowRepository._();

  /// Creates a relation between the given [EmployeeAccess] and [Building]
  /// by setting the [EmployeeAccess]'s foreign key `buildingId` to refer to the [Building].
  Future<void> building(
    _is.DatabaseSession session,
    EmployeeAccess employeeAccess,
    _iaohraio.Building building, {
    _is.Transaction? transaction,
  }) async {
    if (employeeAccess.id == null) {
      throw ArgumentError.notNull('employeeAccess.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $employeeAccess = employeeAccess.copyWith(buildingId: building.id);
    await session.db.updateRow<EmployeeAccess>(
      $employeeAccess,
      columns: [EmployeeAccess.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [EmployeeAccess] and the given [Employee]
  /// by setting the [Employee]'s foreign key `accessId` to refer to this [EmployeeAccess].
  Future<void> employees(
    _is.DatabaseSession session,
    EmployeeAccess employeeAccess,
    _ie30fksv.Employee employee, {
    _is.Transaction? transaction,
  }) async {
    if (employee.id == null) {
      throw ArgumentError.notNull('employee.id');
    }
    if (employeeAccess.id == null) {
      throw ArgumentError.notNull('employeeAccess.id');
    }

    var $employee = employee.copyWith(accessId: employeeAccess.id);
    await session.db.updateRow<_ie30fksv.Employee>(
      $employee,
      columns: [_ie30fksv.Employee.t.accessId],
      transaction: transaction,
    );
  }
}

class EmployeeAccessDetachRepository {
  const EmployeeAccessDetachRepository._();

  /// Detaches the relation between this [EmployeeAccess] and the given [Employee]
  /// by setting the [Employee]'s foreign key `accessId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> employees(
    _is.DatabaseSession session,
    List<_ie30fksv.Employee> employee, {
    _is.Transaction? transaction,
  }) async {
    if (employee.any((e) => e.id == null)) {
      throw ArgumentError.notNull('employee.id');
    }

    var $employee = employee.map((e) => e.copyWith(accessId: null)).toList();
    await session.db.update<_ie30fksv.Employee>(
      $employee,
      columns: [_ie30fksv.Employee.t.accessId],
      transaction: transaction,
    );
  }
}

class EmployeeAccessDetachRowRepository {
  const EmployeeAccessDetachRowRepository._();

  /// Detaches the relation between this [EmployeeAccess] and the given [Employee]
  /// by setting the [Employee]'s foreign key `accessId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> employees(
    _is.DatabaseSession session,
    _ie30fksv.Employee employee, {
    _is.Transaction? transaction,
  }) async {
    if (employee.id == null) {
      throw ArgumentError.notNull('employee.id');
    }

    var $employee = employee.copyWith(accessId: null);
    await session.db.updateRow<_ie30fksv.Employee>(
      $employee,
      columns: [_ie30fksv.Employee.t.accessId],
      transaction: transaction,
    );
  }
}
