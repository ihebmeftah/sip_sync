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
import '../../auth/dtos/actor_type.dart' as _i6ch5qy5;
import '../../buildings/entity/building.dart' as _iaohraio;
import '../../cash_register/cash_register_status.dart' as _ib16ienm;
import '../../orders/entity/venue_order.dart' as _iwamn8sj;

/// One cash-register shift for a venue. At most one row stays in progress.
abstract class CashRegisterSession
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  CashRegisterSession._({
    this.id,
    required this.buildingId,
    this.building,
    required this.status,
    required this.openedByType,
    required this.openedById,
    required this.openedAt,
    this.startCash,
    this.closedByType,
    this.closedById,
    this.closedAt,
    this.endCash,
    this.orders,
  });

  factory CashRegisterSession({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    required _ib16ienm.CashRegisterStatus status,
    required _i6ch5qy5.ActorType openedByType,
    required _is.UuidValue openedById,
    required DateTime openedAt,
    double? startCash,
    _i6ch5qy5.ActorType? closedByType,
    _is.UuidValue? closedById,
    DateTime? closedAt,
    double? endCash,
    List<_iwamn8sj.VenueOrder>? orders,
  }) = _CashRegisterSessionImpl;

  factory CashRegisterSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return CashRegisterSession(
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
      status: _ib16ienm.CashRegisterStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      openedByType: _i6ch5qy5.ActorType.fromJson(
        (jsonSerialization['openedByType'] as String),
      ),
      openedById: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['openedById'],
      ),
      openedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['openedAt'],
      ),
      startCash: (jsonSerialization['startCash'] as num?)?.toDouble(),
      closedByType: jsonSerialization['closedByType'] == null
          ? null
          : _i6ch5qy5.ActorType.fromJson(
              (jsonSerialization['closedByType'] as String),
            ),
      closedById: jsonSerialization['closedById'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['closedById'],
            ),
      closedAt: jsonSerialization['closedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['closedAt']),
      endCash: (jsonSerialization['endCash'] as num?)?.toDouble(),
      orders: jsonSerialization['orders'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_iwamn8sj.VenueOrder>>(
              jsonSerialization['orders'],
            ),
    );
  }

  static final t = CashRegisterSessionTable();

  static const db = CashRegisterSessionRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue buildingId;

  _iaohraio.Building? building;

  _ib16ienm.CashRegisterStatus status;

  _i6ch5qy5.ActorType openedByType;

  _is.UuidValue openedById;

  DateTime openedAt;

  /// Counted drawer when the shift opened. Empty when nobody counted it.
  double? startCash;

  _i6ch5qy5.ActorType? closedByType;

  _is.UuidValue? closedById;

  DateTime? closedAt;

  /// Counted drawer when the shift closed. Empty when nobody counted it.
  double? endCash;

  List<_iwamn8sj.VenueOrder>? orders;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [CashRegisterSession]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CashRegisterSession copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    _iaohraio.Building? building,
    _ib16ienm.CashRegisterStatus? status,
    _i6ch5qy5.ActorType? openedByType,
    _is.UuidValue? openedById,
    DateTime? openedAt,
    double? startCash,
    _i6ch5qy5.ActorType? closedByType,
    _is.UuidValue? closedById,
    DateTime? closedAt,
    double? endCash,
    List<_iwamn8sj.VenueOrder>? orders,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CashRegisterSession',
      if (id != null) 'id': id?.toJson(),
      'buildingId': buildingId.toJson(),
      if (building != null) 'building': building?.toJson(),
      'status': status.toJson(),
      'openedByType': openedByType.toJson(),
      'openedById': openedById.toJson(),
      'openedAt': openedAt.toJson(),
      if (startCash != null) 'startCash': startCash,
      if (closedByType != null) 'closedByType': closedByType?.toJson(),
      if (closedById != null) 'closedById': closedById?.toJson(),
      if (closedAt != null) 'closedAt': closedAt?.toJson(),
      if (endCash != null) 'endCash': endCash,
      if (orders != null)
        'orders': orders?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CashRegisterSessionInclude include({
    _iaohraio.BuildingInclude? building,
    _iwamn8sj.VenueOrderIncludeList? orders,
  }) {
    return CashRegisterSessionInclude._(
      building: building,
      orders: orders,
    );
  }

  static CashRegisterSessionIncludeList includeList({
    _is.WhereExpressionBuilder<CashRegisterSessionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CashRegisterSessionTable>? orderBy,
    _is.OrderByListBuilder<CashRegisterSessionTable>? orderByList,
    CashRegisterSessionInclude? include,
  }) {
    return CashRegisterSessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CashRegisterSession.t),
      orderByList: orderByList?.call(CashRegisterSession.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CashRegisterSessionImpl extends CashRegisterSession {
  _CashRegisterSessionImpl({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    required _ib16ienm.CashRegisterStatus status,
    required _i6ch5qy5.ActorType openedByType,
    required _is.UuidValue openedById,
    required DateTime openedAt,
    double? startCash,
    _i6ch5qy5.ActorType? closedByType,
    _is.UuidValue? closedById,
    DateTime? closedAt,
    double? endCash,
    List<_iwamn8sj.VenueOrder>? orders,
  }) : super._(
         id: id,
         buildingId: buildingId,
         building: building,
         status: status,
         openedByType: openedByType,
         openedById: openedById,
         openedAt: openedAt,
         startCash: startCash,
         closedByType: closedByType,
         closedById: closedById,
         closedAt: closedAt,
         endCash: endCash,
         orders: orders,
       );

  /// Returns a shallow copy of this [CashRegisterSession]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CashRegisterSession copyWith({
    Object? id = _Undefined,
    _is.UuidValue? buildingId,
    Object? building = _Undefined,
    _ib16ienm.CashRegisterStatus? status,
    _i6ch5qy5.ActorType? openedByType,
    _is.UuidValue? openedById,
    DateTime? openedAt,
    Object? startCash = _Undefined,
    Object? closedByType = _Undefined,
    Object? closedById = _Undefined,
    Object? closedAt = _Undefined,
    Object? endCash = _Undefined,
    Object? orders = _Undefined,
  }) {
    return CashRegisterSession(
      id: id is _is.UuidValue? ? id : this.id,
      buildingId: buildingId ?? this.buildingId,
      building: building is _iaohraio.Building?
          ? building
          : this.building?.copyWith(),
      status: status ?? this.status,
      openedByType: openedByType ?? this.openedByType,
      openedById: openedById ?? this.openedById,
      openedAt: openedAt ?? this.openedAt,
      startCash: startCash is double? ? startCash : this.startCash,
      closedByType: closedByType is _i6ch5qy5.ActorType?
          ? closedByType
          : this.closedByType,
      closedById: closedById is _is.UuidValue? ? closedById : this.closedById,
      closedAt: closedAt is DateTime? ? closedAt : this.closedAt,
      endCash: endCash is double? ? endCash : this.endCash,
      orders: orders is List<_iwamn8sj.VenueOrder>?
          ? orders
          : this.orders?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class CashRegisterSessionUpdateTable
    extends _is.UpdateTable<CashRegisterSessionTable> {
  CashRegisterSessionUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> buildingId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.buildingId,
    value,
  );

  _is.ColumnValue<_ib16ienm.CashRegisterStatus, _ib16ienm.CashRegisterStatus>
  status(_ib16ienm.CashRegisterStatus value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<_i6ch5qy5.ActorType, _i6ch5qy5.ActorType> openedByType(
    _i6ch5qy5.ActorType value,
  ) => _is.ColumnValue(
    table.openedByType,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> openedById(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.openedById,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> openedAt(DateTime value) =>
      _is.ColumnValue(
        table.openedAt,
        value,
      );

  _is.ColumnValue<double, double> startCash(double? value) => _is.ColumnValue(
    table.startCash,
    value,
  );

  _is.ColumnValue<_i6ch5qy5.ActorType, _i6ch5qy5.ActorType> closedByType(
    _i6ch5qy5.ActorType? value,
  ) => _is.ColumnValue(
    table.closedByType,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> closedById(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.closedById,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> closedAt(DateTime? value) =>
      _is.ColumnValue(
        table.closedAt,
        value,
      );

  _is.ColumnValue<double, double> endCash(double? value) => _is.ColumnValue(
    table.endCash,
    value,
  );
}

class CashRegisterSessionTable extends _is.Table<_is.UuidValue?> {
  CashRegisterSessionTable({super.tableRelation})
    : super(tableName: 'cash_register_session') {
    updateTable = CashRegisterSessionUpdateTable(this);
    buildingId = _is.ColumnUuid(
      'buildingId',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    openedByType = _is.ColumnEnum(
      'openedByType',
      this,
      _is.EnumSerialization.byName,
    );
    openedById = _is.ColumnUuid(
      'openedById',
      this,
    );
    openedAt = _is.ColumnDateTime(
      'openedAt',
      this,
    );
    startCash = _is.ColumnDouble(
      'startCash',
      this,
    );
    closedByType = _is.ColumnEnum(
      'closedByType',
      this,
      _is.EnumSerialization.byName,
    );
    closedById = _is.ColumnUuid(
      'closedById',
      this,
    );
    closedAt = _is.ColumnDateTime(
      'closedAt',
      this,
    );
    endCash = _is.ColumnDouble(
      'endCash',
      this,
    );
  }

  late final CashRegisterSessionUpdateTable updateTable;

  late final _is.ColumnUuid buildingId;

  _iaohraio.BuildingTable? _building;

  late final _is.ColumnEnum<_ib16ienm.CashRegisterStatus> status;

  late final _is.ColumnEnum<_i6ch5qy5.ActorType> openedByType;

  late final _is.ColumnUuid openedById;

  late final _is.ColumnDateTime openedAt;

  /// Counted drawer when the shift opened. Empty when nobody counted it.
  late final _is.ColumnDouble startCash;

  late final _is.ColumnEnum<_i6ch5qy5.ActorType> closedByType;

  late final _is.ColumnUuid closedById;

  late final _is.ColumnDateTime closedAt;

  /// Counted drawer when the shift closed. Empty when nobody counted it.
  late final _is.ColumnDouble endCash;

  _iwamn8sj.VenueOrderTable? ___orders;

  _is.ManyRelation<_iwamn8sj.VenueOrderTable>? _orders;

  _iaohraio.BuildingTable get building {
    if (_building != null) return _building!;
    _building = _is.createRelationTable(
      relationFieldName: 'building',
      field: CashRegisterSession.t.buildingId,
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
      field: CashRegisterSession.t.id,
      foreignField: _iwamn8sj.VenueOrder.t.cashRegisterSessionId,
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
      field: CashRegisterSession.t.id,
      foreignField: _iwamn8sj.VenueOrder.t.cashRegisterSessionId,
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
    status,
    openedByType,
    openedById,
    openedAt,
    startCash,
    closedByType,
    closedById,
    closedAt,
    endCash,
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

class CashRegisterSessionInclude extends _is.IncludeObject {
  CashRegisterSessionInclude._({
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
  _is.Table<_is.UuidValue?> get table => CashRegisterSession.t;
}

class CashRegisterSessionIncludeList extends _is.IncludeList {
  CashRegisterSessionIncludeList._({
    _is.WhereExpressionBuilder<CashRegisterSessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CashRegisterSession.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => CashRegisterSession.t;
}

class CashRegisterSessionRepository {
  const CashRegisterSessionRepository._();

  final attach = const CashRegisterSessionAttachRepository._();

  final attachRow = const CashRegisterSessionAttachRowRepository._();

  final detach = const CashRegisterSessionDetachRepository._();

  final detachRow = const CashRegisterSessionDetachRowRepository._();

  /// Returns a list of [CashRegisterSession]s matching the given query parameters.
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
  Future<List<CashRegisterSession>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CashRegisterSessionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CashRegisterSessionTable>? orderBy,
    _is.OrderByListBuilder<CashRegisterSessionTable>? orderByList,
    _is.Transaction? transaction,
    CashRegisterSessionInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CashRegisterSession>(
      where: where?.call(CashRegisterSession.t),
      orderBy: orderBy?.call(CashRegisterSession.t),
      orderByList: orderByList?.call(CashRegisterSession.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CashRegisterSession] matching the given query parameters.
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
  Future<CashRegisterSession?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CashRegisterSessionTable>? where,
    int? offset,
    _is.OrderByBuilder<CashRegisterSessionTable>? orderBy,
    _is.OrderByListBuilder<CashRegisterSessionTable>? orderByList,
    _is.Transaction? transaction,
    CashRegisterSessionInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CashRegisterSession>(
      where: where?.call(CashRegisterSession.t),
      orderBy: orderBy?.call(CashRegisterSession.t),
      orderByList: orderByList?.call(CashRegisterSession.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CashRegisterSession] by its [id] or null if no such row exists.
  Future<CashRegisterSession?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    CashRegisterSessionInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CashRegisterSession>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CashRegisterSession]s in the list and returns the inserted rows.
  ///
  /// The returned [CashRegisterSession]s will have their `id` fields set.
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
  Future<List<CashRegisterSession>> insert(
    _is.DatabaseSession session,
    List<CashRegisterSession> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CashRegisterSession>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CashRegisterSession] and returns the inserted row.
  ///
  /// The returned [CashRegisterSession] will have its `id` field set.
  Future<CashRegisterSession> insertRow(
    _is.DatabaseSession session,
    CashRegisterSession row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CashRegisterSession>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CashRegisterSession]s in the list and returns the resulting rows.
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
  /// The returned [CashRegisterSession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CashRegisterSession>> upsert(
    _is.DatabaseSession session,
    List<CashRegisterSession> rows, {
    required _is.ColumnSelections<CashRegisterSessionTable> conflictColumns,
    _is.ColumnSelections<CashRegisterSessionTable>? updateColumns,
    _is.WhereExpressionBuilder<CashRegisterSessionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CashRegisterSession>(
      rows,
      conflictColumns: conflictColumns(CashRegisterSession.t),
      updateColumns: updateColumns?.call(CashRegisterSession.t),
      updateWhere: updateWhere?.call(CashRegisterSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CashRegisterSession] and returns the resulting row.
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
  /// The returned [CashRegisterSession] will have its `id` field set.
  Future<CashRegisterSession?> upsertRow(
    _is.DatabaseSession session,
    CashRegisterSession row, {
    required _is.ColumnSelections<CashRegisterSessionTable> conflictColumns,
    _is.ColumnSelections<CashRegisterSessionTable>? updateColumns,
    _is.WhereExpressionBuilder<CashRegisterSessionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CashRegisterSession>(
      row,
      conflictColumns: conflictColumns(CashRegisterSession.t),
      updateColumns: updateColumns?.call(CashRegisterSession.t),
      updateWhere: updateWhere?.call(CashRegisterSession.t),
      transaction: transaction,
    );
  }

  /// Updates all [CashRegisterSession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CashRegisterSession>> update(
    _is.DatabaseSession session,
    List<CashRegisterSession> rows, {
    _is.ColumnSelections<CashRegisterSessionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CashRegisterSession>(
      rows,
      columns: columns?.call(CashRegisterSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CashRegisterSession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CashRegisterSession> updateRow(
    _is.DatabaseSession session,
    CashRegisterSession row, {
    _is.ColumnSelections<CashRegisterSessionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CashRegisterSession>(
      row,
      columns: columns?.call(CashRegisterSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CashRegisterSession] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CashRegisterSession?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<CashRegisterSessionUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CashRegisterSession>(
      id,
      columnValues: columnValues(CashRegisterSession.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CashRegisterSession]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CashRegisterSession>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CashRegisterSessionUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<CashRegisterSessionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CashRegisterSessionTable>? orderBy,
    _is.OrderByListBuilder<CashRegisterSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CashRegisterSession>(
      columnValues: columnValues(CashRegisterSession.t.updateTable),
      where: where(CashRegisterSession.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CashRegisterSession.t),
      orderByList: orderByList?.call(CashRegisterSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CashRegisterSession]s in the list and returns the deleted rows.
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
  Future<List<CashRegisterSession>> delete(
    _is.DatabaseSession session,
    List<CashRegisterSession> rows, {
    _is.OrderByBuilder<CashRegisterSessionTable>? orderBy,
    _is.OrderByListBuilder<CashRegisterSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CashRegisterSession>(
      rows,
      orderBy: orderBy?.call(CashRegisterSession.t),
      orderByList: orderByList?.call(CashRegisterSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CashRegisterSession].
  Future<CashRegisterSession> deleteRow(
    _is.DatabaseSession session,
    CashRegisterSession row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CashRegisterSession>(
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
  Future<List<CashRegisterSession>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CashRegisterSessionTable> where,
    _is.OrderByBuilder<CashRegisterSessionTable>? orderBy,
    _is.OrderByListBuilder<CashRegisterSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CashRegisterSession>(
      where: where(CashRegisterSession.t),
      orderBy: orderBy?.call(CashRegisterSession.t),
      orderByList: orderByList?.call(CashRegisterSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CashRegisterSessionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CashRegisterSession>(
      where: where?.call(CashRegisterSession.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CashRegisterSession] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CashRegisterSessionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CashRegisterSession>(
      where: where(CashRegisterSession.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CashRegisterSessionAttachRepository {
  const CashRegisterSessionAttachRepository._();

  /// Creates a relation between this [CashRegisterSession] and the given [VenueOrder]s
  /// by setting each [VenueOrder]'s foreign key `cashRegisterSessionId` to refer to this [CashRegisterSession].
  Future<void> orders(
    _is.DatabaseSession session,
    CashRegisterSession cashRegisterSession,
    List<_iwamn8sj.VenueOrder> venueOrder, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrder.any((e) => e.id == null)) {
      throw ArgumentError.notNull('venueOrder.id');
    }
    if (cashRegisterSession.id == null) {
      throw ArgumentError.notNull('cashRegisterSession.id');
    }

    var $venueOrder = venueOrder
        .map((e) => e.copyWith(cashRegisterSessionId: cashRegisterSession.id))
        .toList();
    await session.db.update<_iwamn8sj.VenueOrder>(
      $venueOrder,
      columns: [_iwamn8sj.VenueOrder.t.cashRegisterSessionId],
      transaction: transaction,
    );
  }
}

class CashRegisterSessionAttachRowRepository {
  const CashRegisterSessionAttachRowRepository._();

  /// Creates a relation between the given [CashRegisterSession] and [Building]
  /// by setting the [CashRegisterSession]'s foreign key `buildingId` to refer to the [Building].
  Future<void> building(
    _is.DatabaseSession session,
    CashRegisterSession cashRegisterSession,
    _iaohraio.Building building, {
    _is.Transaction? transaction,
  }) async {
    if (cashRegisterSession.id == null) {
      throw ArgumentError.notNull('cashRegisterSession.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $cashRegisterSession = cashRegisterSession.copyWith(
      buildingId: building.id,
    );
    await session.db.updateRow<CashRegisterSession>(
      $cashRegisterSession,
      columns: [CashRegisterSession.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [CashRegisterSession] and the given [VenueOrder]
  /// by setting the [VenueOrder]'s foreign key `cashRegisterSessionId` to refer to this [CashRegisterSession].
  Future<void> orders(
    _is.DatabaseSession session,
    CashRegisterSession cashRegisterSession,
    _iwamn8sj.VenueOrder venueOrder, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrder.id == null) {
      throw ArgumentError.notNull('venueOrder.id');
    }
    if (cashRegisterSession.id == null) {
      throw ArgumentError.notNull('cashRegisterSession.id');
    }

    var $venueOrder = venueOrder.copyWith(
      cashRegisterSessionId: cashRegisterSession.id,
    );
    await session.db.updateRow<_iwamn8sj.VenueOrder>(
      $venueOrder,
      columns: [_iwamn8sj.VenueOrder.t.cashRegisterSessionId],
      transaction: transaction,
    );
  }
}

class CashRegisterSessionDetachRepository {
  const CashRegisterSessionDetachRepository._();

  /// Detaches the relation between this [CashRegisterSession] and the given [VenueOrder]
  /// by setting the [VenueOrder]'s foreign key `cashRegisterSessionId` to `null`.
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
        .map((e) => e.copyWith(cashRegisterSessionId: null))
        .toList();
    await session.db.update<_iwamn8sj.VenueOrder>(
      $venueOrder,
      columns: [_iwamn8sj.VenueOrder.t.cashRegisterSessionId],
      transaction: transaction,
    );
  }
}

class CashRegisterSessionDetachRowRepository {
  const CashRegisterSessionDetachRowRepository._();

  /// Detaches the relation between this [CashRegisterSession] and the given [VenueOrder]
  /// by setting the [VenueOrder]'s foreign key `cashRegisterSessionId` to `null`.
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

    var $venueOrder = venueOrder.copyWith(cashRegisterSessionId: null);
    await session.db.updateRow<_iwamn8sj.VenueOrder>(
      $venueOrder,
      columns: [_iwamn8sj.VenueOrder.t.cashRegisterSessionId],
      transaction: transaction,
    );
  }
}
