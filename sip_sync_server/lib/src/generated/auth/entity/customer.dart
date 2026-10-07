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

/// Customer account for the consumer app.
abstract class Customer
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  Customer._({
    this.id,
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.passwordHash,
    DateTime? createdAt,
    this.reservations,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Customer({
    _is.UuidValue? id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String passwordHash,
    DateTime? createdAt,
    List<_iq51mm5o.Reservation>? reservations,
  }) = _CustomerImpl;

  factory Customer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Customer(
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
      reservations: jsonSerialization['reservations'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_iq51mm5o.Reservation>>(
              jsonSerialization['reservations'],
            ),
    );
  }

  static final t = CustomerTable();

  static const db = CustomerRepository._();

  @override
  _is.UuidValue? id;

  String email;

  String phoneNumber;

  String firstName;

  String lastName;

  String passwordHash;

  DateTime createdAt;

  List<_iq51mm5o.Reservation>? reservations;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Customer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Customer copyWith({
    _is.UuidValue? id,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? passwordHash,
    DateTime? createdAt,
    List<_iq51mm5o.Reservation>? reservations,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Customer',
      if (id != null) 'id': id?.toJson(),
      'email': email,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'passwordHash': passwordHash,
      'createdAt': createdAt.toJson(),
      if (reservations != null)
        'reservations': reservations?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CustomerInclude include({
    _iq51mm5o.ReservationIncludeList? reservations,
  }) {
    return CustomerInclude._(reservations: reservations);
  }

  static CustomerIncludeList includeList({
    _is.WhereExpressionBuilder<CustomerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CustomerTable>? orderBy,
    _is.OrderByListBuilder<CustomerTable>? orderByList,
    CustomerInclude? include,
  }) {
    return CustomerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Customer.t),
      orderByList: orderByList?.call(Customer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerImpl extends Customer {
  _CustomerImpl({
    _is.UuidValue? id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String passwordHash,
    DateTime? createdAt,
    List<_iq51mm5o.Reservation>? reservations,
  }) : super._(
         id: id,
         email: email,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         passwordHash: passwordHash,
         createdAt: createdAt,
         reservations: reservations,
       );

  /// Returns a shallow copy of this [Customer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Customer copyWith({
    Object? id = _Undefined,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? passwordHash,
    DateTime? createdAt,
    Object? reservations = _Undefined,
  }) {
    return Customer(
      id: id is _is.UuidValue? ? id : this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      passwordHash: passwordHash ?? this.passwordHash,
      createdAt: createdAt ?? this.createdAt,
      reservations: reservations is List<_iq51mm5o.Reservation>?
          ? reservations
          : this.reservations?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class CustomerUpdateTable extends _is.UpdateTable<CustomerTable> {
  CustomerUpdateTable(super.table);

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

class CustomerTable extends _is.Table<_is.UuidValue?> {
  CustomerTable({super.tableRelation}) : super(tableName: 'customer') {
    updateTable = CustomerUpdateTable(this);
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

  late final CustomerUpdateTable updateTable;

  late final _is.ColumnString email;

  late final _is.ColumnString phoneNumber;

  late final _is.ColumnString firstName;

  late final _is.ColumnString lastName;

  late final _is.ColumnString passwordHash;

  late final _is.ColumnDateTime createdAt;

  _iq51mm5o.ReservationTable? ___reservations;

  _is.ManyRelation<_iq51mm5o.ReservationTable>? _reservations;

  _iq51mm5o.ReservationTable get __reservations {
    if (___reservations != null) return ___reservations!;
    ___reservations = _is.createRelationTable(
      relationFieldName: '__reservations',
      field: Customer.t.id,
      foreignField: _iq51mm5o.Reservation.t.customerId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iq51mm5o.ReservationTable(tableRelation: foreignTableRelation),
    );
    return ___reservations!;
  }

  _is.ManyRelation<_iq51mm5o.ReservationTable> get reservations {
    if (_reservations != null) return _reservations!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'reservations',
      field: Customer.t.id,
      foreignField: _iq51mm5o.Reservation.t.customerId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iq51mm5o.ReservationTable(tableRelation: foreignTableRelation),
    );
    _reservations = _is.ManyRelation<_iq51mm5o.ReservationTable>(
      tableWithRelations: relationTable,
      table: _iq51mm5o.ReservationTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _reservations!;
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
    if (relationField == 'reservations') {
      return __reservations;
    }
    return null;
  }
}

class CustomerInclude extends _is.IncludeObject {
  CustomerInclude._({_iq51mm5o.ReservationIncludeList? reservations}) {
    _reservations = reservations;
  }

  _iq51mm5o.ReservationIncludeList? _reservations;

  @override
  Map<String, _is.Include?> get includes => {'reservations': _reservations};

  @override
  _is.Table<_is.UuidValue?> get table => Customer.t;
}

class CustomerIncludeList extends _is.IncludeList {
  CustomerIncludeList._({
    _is.WhereExpressionBuilder<CustomerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Customer.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => Customer.t;
}

class CustomerRepository {
  const CustomerRepository._();

  final attach = const CustomerAttachRepository._();

  final attachRow = const CustomerAttachRowRepository._();

  final detach = const CustomerDetachRepository._();

  final detachRow = const CustomerDetachRowRepository._();

  /// Returns a list of [Customer]s matching the given query parameters.
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
  Future<List<Customer>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CustomerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CustomerTable>? orderBy,
    _is.OrderByListBuilder<CustomerTable>? orderByList,
    _is.Transaction? transaction,
    CustomerInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Customer>(
      where: where?.call(Customer.t),
      orderBy: orderBy?.call(Customer.t),
      orderByList: orderByList?.call(Customer.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Customer] matching the given query parameters.
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
  Future<Customer?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CustomerTable>? where,
    int? offset,
    _is.OrderByBuilder<CustomerTable>? orderBy,
    _is.OrderByListBuilder<CustomerTable>? orderByList,
    _is.Transaction? transaction,
    CustomerInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Customer>(
      where: where?.call(Customer.t),
      orderBy: orderBy?.call(Customer.t),
      orderByList: orderByList?.call(Customer.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Customer] by its [id] or null if no such row exists.
  Future<Customer?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    CustomerInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Customer>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Customer]s in the list and returns the inserted rows.
  ///
  /// The returned [Customer]s will have their `id` fields set.
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
  Future<List<Customer>> insert(
    _is.DatabaseSession session,
    List<Customer> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Customer>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Customer] and returns the inserted row.
  ///
  /// The returned [Customer] will have its `id` field set.
  Future<Customer> insertRow(
    _is.DatabaseSession session,
    Customer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Customer>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Customer]s in the list and returns the resulting rows.
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
  /// The returned [Customer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Customer>> upsert(
    _is.DatabaseSession session,
    List<Customer> rows, {
    required _is.ColumnSelections<CustomerTable> conflictColumns,
    _is.ColumnSelections<CustomerTable>? updateColumns,
    _is.WhereExpressionBuilder<CustomerTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Customer>(
      rows,
      conflictColumns: conflictColumns(Customer.t),
      updateColumns: updateColumns?.call(Customer.t),
      updateWhere: updateWhere?.call(Customer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Customer] and returns the resulting row.
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
  /// The returned [Customer] will have its `id` field set.
  Future<Customer?> upsertRow(
    _is.DatabaseSession session,
    Customer row, {
    required _is.ColumnSelections<CustomerTable> conflictColumns,
    _is.ColumnSelections<CustomerTable>? updateColumns,
    _is.WhereExpressionBuilder<CustomerTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Customer>(
      row,
      conflictColumns: conflictColumns(Customer.t),
      updateColumns: updateColumns?.call(Customer.t),
      updateWhere: updateWhere?.call(Customer.t),
      transaction: transaction,
    );
  }

  /// Updates all [Customer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Customer>> update(
    _is.DatabaseSession session,
    List<Customer> rows, {
    _is.ColumnSelections<CustomerTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Customer>(
      rows,
      columns: columns?.call(Customer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Customer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Customer> updateRow(
    _is.DatabaseSession session,
    Customer row, {
    _is.ColumnSelections<CustomerTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Customer>(
      row,
      columns: columns?.call(Customer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Customer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Customer?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<CustomerUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Customer>(
      id,
      columnValues: columnValues(Customer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Customer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Customer>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CustomerUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CustomerTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CustomerTable>? orderBy,
    _is.OrderByListBuilder<CustomerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Customer>(
      columnValues: columnValues(Customer.t.updateTable),
      where: where(Customer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Customer.t),
      orderByList: orderByList?.call(Customer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Customer]s in the list and returns the deleted rows.
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
  Future<List<Customer>> delete(
    _is.DatabaseSession session,
    List<Customer> rows, {
    _is.OrderByBuilder<CustomerTable>? orderBy,
    _is.OrderByListBuilder<CustomerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Customer>(
      rows,
      orderBy: orderBy?.call(Customer.t),
      orderByList: orderByList?.call(Customer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Customer].
  Future<Customer> deleteRow(
    _is.DatabaseSession session,
    Customer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Customer>(
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
  Future<List<Customer>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CustomerTable> where,
    _is.OrderByBuilder<CustomerTable>? orderBy,
    _is.OrderByListBuilder<CustomerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Customer>(
      where: where(Customer.t),
      orderBy: orderBy?.call(Customer.t),
      orderByList: orderByList?.call(Customer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CustomerTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Customer>(
      where: where?.call(Customer.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Customer] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CustomerTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Customer>(
      where: where(Customer.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CustomerAttachRepository {
  const CustomerAttachRepository._();

  /// Creates a relation between this [Customer] and the given [Reservation]s
  /// by setting each [Reservation]'s foreign key `customerId` to refer to this [Customer].
  Future<void> reservations(
    _is.DatabaseSession session,
    Customer customer,
    List<_iq51mm5o.Reservation> reservation, {
    _is.Transaction? transaction,
  }) async {
    if (reservation.any((e) => e.id == null)) {
      throw ArgumentError.notNull('reservation.id');
    }
    if (customer.id == null) {
      throw ArgumentError.notNull('customer.id');
    }

    var $reservation = reservation
        .map((e) => e.copyWith(customerId: customer.id))
        .toList();
    await session.db.update<_iq51mm5o.Reservation>(
      $reservation,
      columns: [_iq51mm5o.Reservation.t.customerId],
      transaction: transaction,
    );
  }
}

class CustomerAttachRowRepository {
  const CustomerAttachRowRepository._();

  /// Creates a relation between this [Customer] and the given [Reservation]
  /// by setting the [Reservation]'s foreign key `customerId` to refer to this [Customer].
  Future<void> reservations(
    _is.DatabaseSession session,
    Customer customer,
    _iq51mm5o.Reservation reservation, {
    _is.Transaction? transaction,
  }) async {
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }
    if (customer.id == null) {
      throw ArgumentError.notNull('customer.id');
    }

    var $reservation = reservation.copyWith(customerId: customer.id);
    await session.db.updateRow<_iq51mm5o.Reservation>(
      $reservation,
      columns: [_iq51mm5o.Reservation.t.customerId],
      transaction: transaction,
    );
  }
}

class CustomerDetachRepository {
  const CustomerDetachRepository._();

  /// Detaches the relation between this [Customer] and the given [Reservation]
  /// by setting the [Reservation]'s foreign key `customerId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> reservations(
    _is.DatabaseSession session,
    List<_iq51mm5o.Reservation> reservation, {
    _is.Transaction? transaction,
  }) async {
    if (reservation.any((e) => e.id == null)) {
      throw ArgumentError.notNull('reservation.id');
    }

    var $reservation = reservation
        .map((e) => e.copyWith(customerId: null))
        .toList();
    await session.db.update<_iq51mm5o.Reservation>(
      $reservation,
      columns: [_iq51mm5o.Reservation.t.customerId],
      transaction: transaction,
    );
  }
}

class CustomerDetachRowRepository {
  const CustomerDetachRowRepository._();

  /// Detaches the relation between this [Customer] and the given [Reservation]
  /// by setting the [Reservation]'s foreign key `customerId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> reservations(
    _is.DatabaseSession session,
    _iq51mm5o.Reservation reservation, {
    _is.Transaction? transaction,
  }) async {
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }

    var $reservation = reservation.copyWith(customerId: null);
    await session.db.updateRow<_iq51mm5o.Reservation>(
      $reservation,
      columns: [_iq51mm5o.Reservation.t.customerId],
      transaction: transaction,
    );
  }
}
