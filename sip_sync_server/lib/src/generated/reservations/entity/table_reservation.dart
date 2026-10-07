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
import '../../reservations/entity/reservation.dart' as _iq51mm5o;
import '../../tables/entity/venue_table.dart' as _ilcfc7kr;

/// One table included in a reservation.
abstract class TableReservation
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  TableReservation._({
    this.id,
    required this.reservationId,
    this.reservation,
    required this.venueTableId,
    this.venueTable,
  });

  factory TableReservation({
    _is.UuidValue? id,
    required _is.UuidValue reservationId,
    _iq51mm5o.Reservation? reservation,
    required _is.UuidValue venueTableId,
    _ilcfc7kr.VenueTable? venueTable,
  }) = _TableReservationImpl;

  factory TableReservation.fromJson(Map<String, dynamic> jsonSerialization) {
    return TableReservation(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      reservationId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['reservationId'],
      ),
      reservation: jsonSerialization['reservation'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_iq51mm5o.Reservation>(
              jsonSerialization['reservation'],
            ),
      venueTableId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['venueTableId'],
      ),
      venueTable: jsonSerialization['venueTable'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_ilcfc7kr.VenueTable>(
              jsonSerialization['venueTable'],
            ),
    );
  }

  static final t = TableReservationTable();

  static const db = TableReservationRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue reservationId;

  _iq51mm5o.Reservation? reservation;

  _is.UuidValue venueTableId;

  _ilcfc7kr.VenueTable? venueTable;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [TableReservation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TableReservation copyWith({
    _is.UuidValue? id,
    _is.UuidValue? reservationId,
    _iq51mm5o.Reservation? reservation,
    _is.UuidValue? venueTableId,
    _ilcfc7kr.VenueTable? venueTable,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TableReservation',
      if (id != null) 'id': id?.toJson(),
      'reservationId': reservationId.toJson(),
      if (reservation != null) 'reservation': reservation?.toJson(),
      'venueTableId': venueTableId.toJson(),
      if (venueTable != null) 'venueTable': venueTable?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static TableReservationInclude include({
    _iq51mm5o.ReservationInclude? reservation,
    _ilcfc7kr.VenueTableInclude? venueTable,
  }) {
    return TableReservationInclude._(
      reservation: reservation,
      venueTable: venueTable,
    );
  }

  static TableReservationIncludeList includeList({
    _is.WhereExpressionBuilder<TableReservationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TableReservationTable>? orderBy,
    _is.OrderByListBuilder<TableReservationTable>? orderByList,
    TableReservationInclude? include,
  }) {
    return TableReservationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TableReservation.t),
      orderByList: orderByList?.call(TableReservation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TableReservationImpl extends TableReservation {
  _TableReservationImpl({
    _is.UuidValue? id,
    required _is.UuidValue reservationId,
    _iq51mm5o.Reservation? reservation,
    required _is.UuidValue venueTableId,
    _ilcfc7kr.VenueTable? venueTable,
  }) : super._(
         id: id,
         reservationId: reservationId,
         reservation: reservation,
         venueTableId: venueTableId,
         venueTable: venueTable,
       );

  /// Returns a shallow copy of this [TableReservation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TableReservation copyWith({
    Object? id = _Undefined,
    _is.UuidValue? reservationId,
    Object? reservation = _Undefined,
    _is.UuidValue? venueTableId,
    Object? venueTable = _Undefined,
  }) {
    return TableReservation(
      id: id is _is.UuidValue? ? id : this.id,
      reservationId: reservationId ?? this.reservationId,
      reservation: reservation is _iq51mm5o.Reservation?
          ? reservation
          : this.reservation?.copyWith(),
      venueTableId: venueTableId ?? this.venueTableId,
      venueTable: venueTable is _ilcfc7kr.VenueTable?
          ? venueTable
          : this.venueTable?.copyWith(),
    );
  }
}

class TableReservationUpdateTable
    extends _is.UpdateTable<TableReservationTable> {
  TableReservationUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> reservationId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.reservationId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> venueTableId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.venueTableId,
    value,
  );
}

class TableReservationTable extends _is.Table<_is.UuidValue?> {
  TableReservationTable({super.tableRelation})
    : super(tableName: 'table_reservation') {
    updateTable = TableReservationUpdateTable(this);
    reservationId = _is.ColumnUuid(
      'reservationId',
      this,
    );
    venueTableId = _is.ColumnUuid(
      'venueTableId',
      this,
    );
  }

  late final TableReservationUpdateTable updateTable;

  late final _is.ColumnUuid reservationId;

  _iq51mm5o.ReservationTable? _reservation;

  late final _is.ColumnUuid venueTableId;

  _ilcfc7kr.VenueTableTable? _venueTable;

  _iq51mm5o.ReservationTable get reservation {
    if (_reservation != null) return _reservation!;
    _reservation = _is.createRelationTable(
      relationFieldName: 'reservation',
      field: TableReservation.t.reservationId,
      foreignField: _iq51mm5o.Reservation.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iq51mm5o.ReservationTable(tableRelation: foreignTableRelation),
    );
    return _reservation!;
  }

  _ilcfc7kr.VenueTableTable get venueTable {
    if (_venueTable != null) return _venueTable!;
    _venueTable = _is.createRelationTable(
      relationFieldName: 'venueTable',
      field: TableReservation.t.venueTableId,
      foreignField: _ilcfc7kr.VenueTable.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ilcfc7kr.VenueTableTable(tableRelation: foreignTableRelation),
    );
    return _venueTable!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    reservationId,
    venueTableId,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'reservation') {
      return reservation;
    }
    if (relationField == 'venueTable') {
      return venueTable;
    }
    return null;
  }
}

class TableReservationInclude extends _is.IncludeObject {
  TableReservationInclude._({
    _iq51mm5o.ReservationInclude? reservation,
    _ilcfc7kr.VenueTableInclude? venueTable,
  }) {
    _reservation = reservation;
    _venueTable = venueTable;
  }

  _iq51mm5o.ReservationInclude? _reservation;

  _ilcfc7kr.VenueTableInclude? _venueTable;

  @override
  Map<String, _is.Include?> get includes => {
    'reservation': _reservation,
    'venueTable': _venueTable,
  };

  @override
  _is.Table<_is.UuidValue?> get table => TableReservation.t;
}

class TableReservationIncludeList extends _is.IncludeList {
  TableReservationIncludeList._({
    _is.WhereExpressionBuilder<TableReservationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TableReservation.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => TableReservation.t;
}

class TableReservationRepository {
  const TableReservationRepository._();

  final attachRow = const TableReservationAttachRowRepository._();

  /// Returns a list of [TableReservation]s matching the given query parameters.
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
  Future<List<TableReservation>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TableReservationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TableReservationTable>? orderBy,
    _is.OrderByListBuilder<TableReservationTable>? orderByList,
    _is.Transaction? transaction,
    TableReservationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TableReservation>(
      where: where?.call(TableReservation.t),
      orderBy: orderBy?.call(TableReservation.t),
      orderByList: orderByList?.call(TableReservation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TableReservation] matching the given query parameters.
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
  Future<TableReservation?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TableReservationTable>? where,
    int? offset,
    _is.OrderByBuilder<TableReservationTable>? orderBy,
    _is.OrderByListBuilder<TableReservationTable>? orderByList,
    _is.Transaction? transaction,
    TableReservationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TableReservation>(
      where: where?.call(TableReservation.t),
      orderBy: orderBy?.call(TableReservation.t),
      orderByList: orderByList?.call(TableReservation.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TableReservation] by its [id] or null if no such row exists.
  Future<TableReservation?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    TableReservationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TableReservation>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TableReservation]s in the list and returns the inserted rows.
  ///
  /// The returned [TableReservation]s will have their `id` fields set.
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
  Future<List<TableReservation>> insert(
    _is.DatabaseSession session,
    List<TableReservation> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TableReservation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TableReservation] and returns the inserted row.
  ///
  /// The returned [TableReservation] will have its `id` field set.
  Future<TableReservation> insertRow(
    _is.DatabaseSession session,
    TableReservation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TableReservation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TableReservation]s in the list and returns the resulting rows.
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
  /// The returned [TableReservation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TableReservation>> upsert(
    _is.DatabaseSession session,
    List<TableReservation> rows, {
    required _is.ColumnSelections<TableReservationTable> conflictColumns,
    _is.ColumnSelections<TableReservationTable>? updateColumns,
    _is.WhereExpressionBuilder<TableReservationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TableReservation>(
      rows,
      conflictColumns: conflictColumns(TableReservation.t),
      updateColumns: updateColumns?.call(TableReservation.t),
      updateWhere: updateWhere?.call(TableReservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TableReservation] and returns the resulting row.
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
  /// The returned [TableReservation] will have its `id` field set.
  Future<TableReservation?> upsertRow(
    _is.DatabaseSession session,
    TableReservation row, {
    required _is.ColumnSelections<TableReservationTable> conflictColumns,
    _is.ColumnSelections<TableReservationTable>? updateColumns,
    _is.WhereExpressionBuilder<TableReservationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TableReservation>(
      row,
      conflictColumns: conflictColumns(TableReservation.t),
      updateColumns: updateColumns?.call(TableReservation.t),
      updateWhere: updateWhere?.call(TableReservation.t),
      transaction: transaction,
    );
  }

  /// Updates all [TableReservation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TableReservation>> update(
    _is.DatabaseSession session,
    List<TableReservation> rows, {
    _is.ColumnSelections<TableReservationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TableReservation>(
      rows,
      columns: columns?.call(TableReservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TableReservation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TableReservation> updateRow(
    _is.DatabaseSession session,
    TableReservation row, {
    _is.ColumnSelections<TableReservationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TableReservation>(
      row,
      columns: columns?.call(TableReservation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TableReservation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TableReservation?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<TableReservationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TableReservation>(
      id,
      columnValues: columnValues(TableReservation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TableReservation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TableReservation>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TableReservationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<TableReservationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TableReservationTable>? orderBy,
    _is.OrderByListBuilder<TableReservationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TableReservation>(
      columnValues: columnValues(TableReservation.t.updateTable),
      where: where(TableReservation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TableReservation.t),
      orderByList: orderByList?.call(TableReservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TableReservation]s in the list and returns the deleted rows.
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
  Future<List<TableReservation>> delete(
    _is.DatabaseSession session,
    List<TableReservation> rows, {
    _is.OrderByBuilder<TableReservationTable>? orderBy,
    _is.OrderByListBuilder<TableReservationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TableReservation>(
      rows,
      orderBy: orderBy?.call(TableReservation.t),
      orderByList: orderByList?.call(TableReservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TableReservation].
  Future<TableReservation> deleteRow(
    _is.DatabaseSession session,
    TableReservation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TableReservation>(
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
  Future<List<TableReservation>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TableReservationTable> where,
    _is.OrderByBuilder<TableReservationTable>? orderBy,
    _is.OrderByListBuilder<TableReservationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TableReservation>(
      where: where(TableReservation.t),
      orderBy: orderBy?.call(TableReservation.t),
      orderByList: orderByList?.call(TableReservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TableReservationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TableReservation>(
      where: where?.call(TableReservation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TableReservation] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TableReservationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TableReservation>(
      where: where(TableReservation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TableReservationAttachRowRepository {
  const TableReservationAttachRowRepository._();

  /// Creates a relation between the given [TableReservation] and [Reservation]
  /// by setting the [TableReservation]'s foreign key `reservationId` to refer to the [Reservation].
  Future<void> reservation(
    _is.DatabaseSession session,
    TableReservation tableReservation,
    _iq51mm5o.Reservation reservation, {
    _is.Transaction? transaction,
  }) async {
    if (tableReservation.id == null) {
      throw ArgumentError.notNull('tableReservation.id');
    }
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }

    var $tableReservation = tableReservation.copyWith(
      reservationId: reservation.id,
    );
    await session.db.updateRow<TableReservation>(
      $tableReservation,
      columns: [TableReservation.t.reservationId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TableReservation] and [VenueTable]
  /// by setting the [TableReservation]'s foreign key `venueTableId` to refer to the [VenueTable].
  Future<void> venueTable(
    _is.DatabaseSession session,
    TableReservation tableReservation,
    _ilcfc7kr.VenueTable venueTable, {
    _is.Transaction? transaction,
  }) async {
    if (tableReservation.id == null) {
      throw ArgumentError.notNull('tableReservation.id');
    }
    if (venueTable.id == null) {
      throw ArgumentError.notNull('venueTable.id');
    }

    var $tableReservation = tableReservation.copyWith(
      venueTableId: venueTable.id,
    );
    await session.db.updateRow<TableReservation>(
      $tableReservation,
      columns: [TableReservation.t.venueTableId],
      transaction: transaction,
    );
  }
}
