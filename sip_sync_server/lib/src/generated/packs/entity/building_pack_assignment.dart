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
import '../../packs/dtos/building_pack_end_reason.dart' as _ie6yrju5;
import '../../packs/dtos/pack_billing_period.dart' as _iohcjejn;
import '../../packs/entity/pack.dart' as _iqwmqtub;

/// One stretch of time a venue spent on a pack. The row with a null [endedAt] is current.
abstract class BuildingPackAssignment
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  BuildingPackAssignment._({
    this.id,
    required this.buildingId,
    this.building,
    required this.packId,
    this.pack,
    this.billingPeriod,
    DateTime? startedAt,
    this.expiresAt,
    this.endedAt,
    this.endReason,
  }) : startedAt = startedAt ?? DateTime.now();

  factory BuildingPackAssignment({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    required _is.UuidValue packId,
    _iqwmqtub.Pack? pack,
    _iohcjejn.PackBillingPeriod? billingPeriod,
    DateTime? startedAt,
    DateTime? expiresAt,
    DateTime? endedAt,
    _ie6yrju5.BuildingPackEndReason? endReason,
  }) = _BuildingPackAssignmentImpl;

  factory BuildingPackAssignment.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BuildingPackAssignment(
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
      packId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['packId']),
      pack: jsonSerialization['pack'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_iqwmqtub.Pack>(
              jsonSerialization['pack'],
            ),
      billingPeriod: jsonSerialization['billingPeriod'] == null
          ? null
          : _iohcjejn.PackBillingPeriod.fromJson(
              (jsonSerialization['billingPeriod'] as String),
            ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      endReason: jsonSerialization['endReason'] == null
          ? null
          : _ie6yrju5.BuildingPackEndReason.fromJson(
              (jsonSerialization['endReason'] as String),
            ),
    );
  }

  static final t = BuildingPackAssignmentTable();

  static const db = BuildingPackAssignmentRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue buildingId;

  _iaohraio.Building? building;

  _is.UuidValue packId;

  _iqwmqtub.Pack? pack;

  _iohcjejn.PackBillingPeriod? billingPeriod;

  DateTime startedAt;

  DateTime? expiresAt;

  DateTime? endedAt;

  _ie6yrju5.BuildingPackEndReason? endReason;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [BuildingPackAssignment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BuildingPackAssignment copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    _iaohraio.Building? building,
    _is.UuidValue? packId,
    _iqwmqtub.Pack? pack,
    _iohcjejn.PackBillingPeriod? billingPeriod,
    DateTime? startedAt,
    DateTime? expiresAt,
    DateTime? endedAt,
    _ie6yrju5.BuildingPackEndReason? endReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BuildingPackAssignment',
      if (id != null) 'id': id?.toJson(),
      'buildingId': buildingId.toJson(),
      if (building != null) 'building': building?.toJson(),
      'packId': packId.toJson(),
      if (pack != null) 'pack': pack?.toJson(),
      if (billingPeriod != null) 'billingPeriod': billingPeriod?.toJson(),
      'startedAt': startedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (endReason != null) 'endReason': endReason?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static BuildingPackAssignmentInclude include({
    _iaohraio.BuildingInclude? building,
    _iqwmqtub.PackInclude? pack,
  }) {
    return BuildingPackAssignmentInclude._(
      building: building,
      pack: pack,
    );
  }

  static BuildingPackAssignmentIncludeList includeList({
    _is.WhereExpressionBuilder<BuildingPackAssignmentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BuildingPackAssignmentTable>? orderBy,
    _is.OrderByListBuilder<BuildingPackAssignmentTable>? orderByList,
    BuildingPackAssignmentInclude? include,
  }) {
    return BuildingPackAssignmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BuildingPackAssignment.t),
      orderByList: orderByList?.call(BuildingPackAssignment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BuildingPackAssignmentImpl extends BuildingPackAssignment {
  _BuildingPackAssignmentImpl({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    required _is.UuidValue packId,
    _iqwmqtub.Pack? pack,
    _iohcjejn.PackBillingPeriod? billingPeriod,
    DateTime? startedAt,
    DateTime? expiresAt,
    DateTime? endedAt,
    _ie6yrju5.BuildingPackEndReason? endReason,
  }) : super._(
         id: id,
         buildingId: buildingId,
         building: building,
         packId: packId,
         pack: pack,
         billingPeriod: billingPeriod,
         startedAt: startedAt,
         expiresAt: expiresAt,
         endedAt: endedAt,
         endReason: endReason,
       );

  /// Returns a shallow copy of this [BuildingPackAssignment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BuildingPackAssignment copyWith({
    Object? id = _Undefined,
    _is.UuidValue? buildingId,
    Object? building = _Undefined,
    _is.UuidValue? packId,
    Object? pack = _Undefined,
    Object? billingPeriod = _Undefined,
    DateTime? startedAt,
    Object? expiresAt = _Undefined,
    Object? endedAt = _Undefined,
    Object? endReason = _Undefined,
  }) {
    return BuildingPackAssignment(
      id: id is _is.UuidValue? ? id : this.id,
      buildingId: buildingId ?? this.buildingId,
      building: building is _iaohraio.Building?
          ? building
          : this.building?.copyWith(),
      packId: packId ?? this.packId,
      pack: pack is _iqwmqtub.Pack? ? pack : this.pack?.copyWith(),
      billingPeriod: billingPeriod is _iohcjejn.PackBillingPeriod?
          ? billingPeriod
          : this.billingPeriod,
      startedAt: startedAt ?? this.startedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
      endReason: endReason is _ie6yrju5.BuildingPackEndReason?
          ? endReason
          : this.endReason,
    );
  }
}

class BuildingPackAssignmentUpdateTable
    extends _is.UpdateTable<BuildingPackAssignmentTable> {
  BuildingPackAssignmentUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> buildingId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.buildingId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> packId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.packId,
        value,
      );

  _is.ColumnValue<_iohcjejn.PackBillingPeriod, _iohcjejn.PackBillingPeriod>
  billingPeriod(_iohcjejn.PackBillingPeriod? value) => _is.ColumnValue(
    table.billingPeriod,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime? value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> endedAt(DateTime? value) =>
      _is.ColumnValue(
        table.endedAt,
        value,
      );

  _is.ColumnValue<
    _ie6yrju5.BuildingPackEndReason,
    _ie6yrju5.BuildingPackEndReason
  >
  endReason(_ie6yrju5.BuildingPackEndReason? value) => _is.ColumnValue(
    table.endReason,
    value,
  );
}

class BuildingPackAssignmentTable extends _is.Table<_is.UuidValue?> {
  BuildingPackAssignmentTable({super.tableRelation})
    : super(tableName: 'building_pack_assignment') {
    updateTable = BuildingPackAssignmentUpdateTable(this);
    buildingId = _is.ColumnUuid(
      'buildingId',
      this,
    );
    packId = _is.ColumnUuid(
      'packId',
      this,
    );
    billingPeriod = _is.ColumnEnum(
      'billingPeriod',
      this,
      _is.EnumSerialization.byName,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
      hasDefault: true,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
    endedAt = _is.ColumnDateTime(
      'endedAt',
      this,
    );
    endReason = _is.ColumnEnum(
      'endReason',
      this,
      _is.EnumSerialization.byName,
    );
  }

  late final BuildingPackAssignmentUpdateTable updateTable;

  late final _is.ColumnUuid buildingId;

  _iaohraio.BuildingTable? _building;

  late final _is.ColumnUuid packId;

  _iqwmqtub.PackTable? _pack;

  late final _is.ColumnEnum<_iohcjejn.PackBillingPeriod> billingPeriod;

  late final _is.ColumnDateTime startedAt;

  late final _is.ColumnDateTime expiresAt;

  late final _is.ColumnDateTime endedAt;

  late final _is.ColumnEnum<_ie6yrju5.BuildingPackEndReason> endReason;

  _iaohraio.BuildingTable get building {
    if (_building != null) return _building!;
    _building = _is.createRelationTable(
      relationFieldName: 'building',
      field: BuildingPackAssignment.t.buildingId,
      foreignField: _iaohraio.Building.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iaohraio.BuildingTable(tableRelation: foreignTableRelation),
    );
    return _building!;
  }

  _iqwmqtub.PackTable get pack {
    if (_pack != null) return _pack!;
    _pack = _is.createRelationTable(
      relationFieldName: 'pack',
      field: BuildingPackAssignment.t.packId,
      foreignField: _iqwmqtub.Pack.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iqwmqtub.PackTable(tableRelation: foreignTableRelation),
    );
    return _pack!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    buildingId,
    packId,
    billingPeriod,
    startedAt,
    expiresAt,
    endedAt,
    endReason,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'building') {
      return building;
    }
    if (relationField == 'pack') {
      return pack;
    }
    return null;
  }
}

class BuildingPackAssignmentInclude extends _is.IncludeObject {
  BuildingPackAssignmentInclude._({
    _iaohraio.BuildingInclude? building,
    _iqwmqtub.PackInclude? pack,
  }) {
    _building = building;
    _pack = pack;
  }

  _iaohraio.BuildingInclude? _building;

  _iqwmqtub.PackInclude? _pack;

  @override
  Map<String, _is.Include?> get includes => {
    'building': _building,
    'pack': _pack,
  };

  @override
  _is.Table<_is.UuidValue?> get table => BuildingPackAssignment.t;
}

class BuildingPackAssignmentIncludeList extends _is.IncludeList {
  BuildingPackAssignmentIncludeList._({
    _is.WhereExpressionBuilder<BuildingPackAssignmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BuildingPackAssignment.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => BuildingPackAssignment.t;
}

class BuildingPackAssignmentRepository {
  const BuildingPackAssignmentRepository._();

  final attachRow = const BuildingPackAssignmentAttachRowRepository._();

  /// Returns a list of [BuildingPackAssignment]s matching the given query parameters.
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
  Future<List<BuildingPackAssignment>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BuildingPackAssignmentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BuildingPackAssignmentTable>? orderBy,
    _is.OrderByListBuilder<BuildingPackAssignmentTable>? orderByList,
    _is.Transaction? transaction,
    BuildingPackAssignmentInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BuildingPackAssignment>(
      where: where?.call(BuildingPackAssignment.t),
      orderBy: orderBy?.call(BuildingPackAssignment.t),
      orderByList: orderByList?.call(BuildingPackAssignment.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BuildingPackAssignment] matching the given query parameters.
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
  Future<BuildingPackAssignment?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BuildingPackAssignmentTable>? where,
    int? offset,
    _is.OrderByBuilder<BuildingPackAssignmentTable>? orderBy,
    _is.OrderByListBuilder<BuildingPackAssignmentTable>? orderByList,
    _is.Transaction? transaction,
    BuildingPackAssignmentInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BuildingPackAssignment>(
      where: where?.call(BuildingPackAssignment.t),
      orderBy: orderBy?.call(BuildingPackAssignment.t),
      orderByList: orderByList?.call(BuildingPackAssignment.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BuildingPackAssignment] by its [id] or null if no such row exists.
  Future<BuildingPackAssignment?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    BuildingPackAssignmentInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BuildingPackAssignment>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BuildingPackAssignment]s in the list and returns the inserted rows.
  ///
  /// The returned [BuildingPackAssignment]s will have their `id` fields set.
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
  Future<List<BuildingPackAssignment>> insert(
    _is.DatabaseSession session,
    List<BuildingPackAssignment> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BuildingPackAssignment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BuildingPackAssignment] and returns the inserted row.
  ///
  /// The returned [BuildingPackAssignment] will have its `id` field set.
  Future<BuildingPackAssignment> insertRow(
    _is.DatabaseSession session,
    BuildingPackAssignment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BuildingPackAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [BuildingPackAssignment]s in the list and returns the resulting rows.
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
  /// The returned [BuildingPackAssignment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BuildingPackAssignment>> upsert(
    _is.DatabaseSession session,
    List<BuildingPackAssignment> rows, {
    required _is.ColumnSelections<BuildingPackAssignmentTable> conflictColumns,
    _is.ColumnSelections<BuildingPackAssignmentTable>? updateColumns,
    _is.WhereExpressionBuilder<BuildingPackAssignmentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BuildingPackAssignment>(
      rows,
      conflictColumns: conflictColumns(BuildingPackAssignment.t),
      updateColumns: updateColumns?.call(BuildingPackAssignment.t),
      updateWhere: updateWhere?.call(BuildingPackAssignment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BuildingPackAssignment] and returns the resulting row.
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
  /// The returned [BuildingPackAssignment] will have its `id` field set.
  Future<BuildingPackAssignment?> upsertRow(
    _is.DatabaseSession session,
    BuildingPackAssignment row, {
    required _is.ColumnSelections<BuildingPackAssignmentTable> conflictColumns,
    _is.ColumnSelections<BuildingPackAssignmentTable>? updateColumns,
    _is.WhereExpressionBuilder<BuildingPackAssignmentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BuildingPackAssignment>(
      row,
      conflictColumns: conflictColumns(BuildingPackAssignment.t),
      updateColumns: updateColumns?.call(BuildingPackAssignment.t),
      updateWhere: updateWhere?.call(BuildingPackAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates all [BuildingPackAssignment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BuildingPackAssignment>> update(
    _is.DatabaseSession session,
    List<BuildingPackAssignment> rows, {
    _is.ColumnSelections<BuildingPackAssignmentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BuildingPackAssignment>(
      rows,
      columns: columns?.call(BuildingPackAssignment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BuildingPackAssignment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BuildingPackAssignment> updateRow(
    _is.DatabaseSession session,
    BuildingPackAssignment row, {
    _is.ColumnSelections<BuildingPackAssignmentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BuildingPackAssignment>(
      row,
      columns: columns?.call(BuildingPackAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BuildingPackAssignment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BuildingPackAssignment?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<BuildingPackAssignmentUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BuildingPackAssignment>(
      id,
      columnValues: columnValues(BuildingPackAssignment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BuildingPackAssignment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BuildingPackAssignment>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BuildingPackAssignmentUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<BuildingPackAssignmentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BuildingPackAssignmentTable>? orderBy,
    _is.OrderByListBuilder<BuildingPackAssignmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BuildingPackAssignment>(
      columnValues: columnValues(BuildingPackAssignment.t.updateTable),
      where: where(BuildingPackAssignment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BuildingPackAssignment.t),
      orderByList: orderByList?.call(BuildingPackAssignment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BuildingPackAssignment]s in the list and returns the deleted rows.
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
  Future<List<BuildingPackAssignment>> delete(
    _is.DatabaseSession session,
    List<BuildingPackAssignment> rows, {
    _is.OrderByBuilder<BuildingPackAssignmentTable>? orderBy,
    _is.OrderByListBuilder<BuildingPackAssignmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BuildingPackAssignment>(
      rows,
      orderBy: orderBy?.call(BuildingPackAssignment.t),
      orderByList: orderByList?.call(BuildingPackAssignment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BuildingPackAssignment].
  Future<BuildingPackAssignment> deleteRow(
    _is.DatabaseSession session,
    BuildingPackAssignment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BuildingPackAssignment>(
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
  Future<List<BuildingPackAssignment>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BuildingPackAssignmentTable> where,
    _is.OrderByBuilder<BuildingPackAssignmentTable>? orderBy,
    _is.OrderByListBuilder<BuildingPackAssignmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BuildingPackAssignment>(
      where: where(BuildingPackAssignment.t),
      orderBy: orderBy?.call(BuildingPackAssignment.t),
      orderByList: orderByList?.call(BuildingPackAssignment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BuildingPackAssignmentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BuildingPackAssignment>(
      where: where?.call(BuildingPackAssignment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BuildingPackAssignment] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BuildingPackAssignmentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BuildingPackAssignment>(
      where: where(BuildingPackAssignment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class BuildingPackAssignmentAttachRowRepository {
  const BuildingPackAssignmentAttachRowRepository._();

  /// Creates a relation between the given [BuildingPackAssignment] and [Building]
  /// by setting the [BuildingPackAssignment]'s foreign key `buildingId` to refer to the [Building].
  Future<void> building(
    _is.DatabaseSession session,
    BuildingPackAssignment buildingPackAssignment,
    _iaohraio.Building building, {
    _is.Transaction? transaction,
  }) async {
    if (buildingPackAssignment.id == null) {
      throw ArgumentError.notNull('buildingPackAssignment.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $buildingPackAssignment = buildingPackAssignment.copyWith(
      buildingId: building.id,
    );
    await session.db.updateRow<BuildingPackAssignment>(
      $buildingPackAssignment,
      columns: [BuildingPackAssignment.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [BuildingPackAssignment] and [Pack]
  /// by setting the [BuildingPackAssignment]'s foreign key `packId` to refer to the [Pack].
  Future<void> pack(
    _is.DatabaseSession session,
    BuildingPackAssignment buildingPackAssignment,
    _iqwmqtub.Pack pack, {
    _is.Transaction? transaction,
  }) async {
    if (buildingPackAssignment.id == null) {
      throw ArgumentError.notNull('buildingPackAssignment.id');
    }
    if (pack.id == null) {
      throw ArgumentError.notNull('pack.id');
    }

    var $buildingPackAssignment = buildingPackAssignment.copyWith(
      packId: pack.id,
    );
    await session.db.updateRow<BuildingPackAssignment>(
      $buildingPackAssignment,
      columns: [BuildingPackAssignment.t.packId],
      transaction: transaction,
    );
  }
}
