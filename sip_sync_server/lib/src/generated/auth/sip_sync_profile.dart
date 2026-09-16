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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:sip_sync_server/src/generated/protocol.dart' as _iaib1p48;

/// Platform profile attached 1:1 to a Serverpod [AuthUser].
///
/// Email is unique. Username is unique when set (employees only).
abstract class SipSyncProfile
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SipSyncProfile._({
    this.id,
    required this.authUserId,
    this.authUser,
    this.username,
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory SipSyncProfile({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    String? username,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    DateTime? createdAt,
  }) = _SipSyncProfileImpl;

  factory SipSyncProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return SipSyncProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      username: jsonSerialization['username'] as String?,
      email: jsonSerialization['email'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = SipSyncProfileTable();

  static const db = SipSyncProfileRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  _iacs.AuthUser? authUser;

  String? username;

  String email;

  String phoneNumber;

  String firstName;

  String lastName;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SipSyncProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SipSyncProfile copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    String? username,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SipSyncProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      if (username != null) 'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static SipSyncProfileInclude include({_iacs.AuthUserInclude? authUser}) {
    return SipSyncProfileInclude._(authUser: authUser);
  }

  static SipSyncProfileIncludeList includeList({
    _is.WhereExpressionBuilder<SipSyncProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SipSyncProfileTable>? orderBy,
    _is.OrderByListBuilder<SipSyncProfileTable>? orderByList,
    SipSyncProfileInclude? include,
  }) {
    return SipSyncProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SipSyncProfile.t),
      orderByList: orderByList?.call(SipSyncProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SipSyncProfileImpl extends SipSyncProfile {
  _SipSyncProfileImpl({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    String? username,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         username: username,
         email: email,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SipSyncProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SipSyncProfile copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? authUser = _Undefined,
    Object? username = _Undefined,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    DateTime? createdAt,
  }) {
    return SipSyncProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      username: username is String? ? username : this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SipSyncProfileUpdateTable extends _is.UpdateTable<SipSyncProfileTable> {
  SipSyncProfileUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> username(String? value) => _is.ColumnValue(
    table.username,
    value,
  );

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

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class SipSyncProfileTable extends _is.Table<int?> {
  SipSyncProfileTable({super.tableRelation})
    : super(tableName: 'sip_sync_profile') {
    updateTable = SipSyncProfileUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    username = _is.ColumnString(
      'username',
      this,
    );
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
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final SipSyncProfileUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnString username;

  late final _is.ColumnString email;

  late final _is.ColumnString phoneNumber;

  late final _is.ColumnString firstName;

  late final _is.ColumnString lastName;

  late final _is.ColumnDateTime createdAt;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: SipSyncProfile.t.authUserId,
      foreignField: _iacs.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iacs.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    username,
    email,
    phoneNumber,
    firstName,
    lastName,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class SipSyncProfileInclude extends _is.IncludeObject {
  SipSyncProfileInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => SipSyncProfile.t;
}

class SipSyncProfileIncludeList extends _is.IncludeList {
  SipSyncProfileIncludeList._({
    _is.WhereExpressionBuilder<SipSyncProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SipSyncProfile.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SipSyncProfile.t;
}

class SipSyncProfileRepository {
  const SipSyncProfileRepository._();

  final attachRow = const SipSyncProfileAttachRowRepository._();

  /// Returns a list of [SipSyncProfile]s matching the given query parameters.
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
  Future<List<SipSyncProfile>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SipSyncProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SipSyncProfileTable>? orderBy,
    _is.OrderByListBuilder<SipSyncProfileTable>? orderByList,
    _is.Transaction? transaction,
    SipSyncProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SipSyncProfile>(
      where: where?.call(SipSyncProfile.t),
      orderBy: orderBy?.call(SipSyncProfile.t),
      orderByList: orderByList?.call(SipSyncProfile.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SipSyncProfile] matching the given query parameters.
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
  Future<SipSyncProfile?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SipSyncProfileTable>? where,
    int? offset,
    _is.OrderByBuilder<SipSyncProfileTable>? orderBy,
    _is.OrderByListBuilder<SipSyncProfileTable>? orderByList,
    _is.Transaction? transaction,
    SipSyncProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SipSyncProfile>(
      where: where?.call(SipSyncProfile.t),
      orderBy: orderBy?.call(SipSyncProfile.t),
      orderByList: orderByList?.call(SipSyncProfile.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SipSyncProfile] by its [id] or null if no such row exists.
  Future<SipSyncProfile?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    SipSyncProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SipSyncProfile>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SipSyncProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [SipSyncProfile]s will have their `id` fields set.
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
  Future<List<SipSyncProfile>> insert(
    _is.DatabaseSession session,
    List<SipSyncProfile> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SipSyncProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SipSyncProfile] and returns the inserted row.
  ///
  /// The returned [SipSyncProfile] will have its `id` field set.
  Future<SipSyncProfile> insertRow(
    _is.DatabaseSession session,
    SipSyncProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SipSyncProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SipSyncProfile]s in the list and returns the resulting rows.
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
  /// The returned [SipSyncProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SipSyncProfile>> upsert(
    _is.DatabaseSession session,
    List<SipSyncProfile> rows, {
    required _is.ColumnSelections<SipSyncProfileTable> conflictColumns,
    _is.ColumnSelections<SipSyncProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<SipSyncProfileTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SipSyncProfile>(
      rows,
      conflictColumns: conflictColumns(SipSyncProfile.t),
      updateColumns: updateColumns?.call(SipSyncProfile.t),
      updateWhere: updateWhere?.call(SipSyncProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SipSyncProfile] and returns the resulting row.
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
  /// The returned [SipSyncProfile] will have its `id` field set.
  Future<SipSyncProfile?> upsertRow(
    _is.DatabaseSession session,
    SipSyncProfile row, {
    required _is.ColumnSelections<SipSyncProfileTable> conflictColumns,
    _is.ColumnSelections<SipSyncProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<SipSyncProfileTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SipSyncProfile>(
      row,
      conflictColumns: conflictColumns(SipSyncProfile.t),
      updateColumns: updateColumns?.call(SipSyncProfile.t),
      updateWhere: updateWhere?.call(SipSyncProfile.t),
      transaction: transaction,
    );
  }

  /// Updates all [SipSyncProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SipSyncProfile>> update(
    _is.DatabaseSession session,
    List<SipSyncProfile> rows, {
    _is.ColumnSelections<SipSyncProfileTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SipSyncProfile>(
      rows,
      columns: columns?.call(SipSyncProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SipSyncProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SipSyncProfile> updateRow(
    _is.DatabaseSession session,
    SipSyncProfile row, {
    _is.ColumnSelections<SipSyncProfileTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SipSyncProfile>(
      row,
      columns: columns?.call(SipSyncProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SipSyncProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SipSyncProfile?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SipSyncProfileUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SipSyncProfile>(
      id,
      columnValues: columnValues(SipSyncProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SipSyncProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SipSyncProfile>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SipSyncProfileUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SipSyncProfileTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SipSyncProfileTable>? orderBy,
    _is.OrderByListBuilder<SipSyncProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SipSyncProfile>(
      columnValues: columnValues(SipSyncProfile.t.updateTable),
      where: where(SipSyncProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SipSyncProfile.t),
      orderByList: orderByList?.call(SipSyncProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SipSyncProfile]s in the list and returns the deleted rows.
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
  Future<List<SipSyncProfile>> delete(
    _is.DatabaseSession session,
    List<SipSyncProfile> rows, {
    _is.OrderByBuilder<SipSyncProfileTable>? orderBy,
    _is.OrderByListBuilder<SipSyncProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SipSyncProfile>(
      rows,
      orderBy: orderBy?.call(SipSyncProfile.t),
      orderByList: orderByList?.call(SipSyncProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SipSyncProfile].
  Future<SipSyncProfile> deleteRow(
    _is.DatabaseSession session,
    SipSyncProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SipSyncProfile>(
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
  Future<List<SipSyncProfile>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SipSyncProfileTable> where,
    _is.OrderByBuilder<SipSyncProfileTable>? orderBy,
    _is.OrderByListBuilder<SipSyncProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SipSyncProfile>(
      where: where(SipSyncProfile.t),
      orderBy: orderBy?.call(SipSyncProfile.t),
      orderByList: orderByList?.call(SipSyncProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SipSyncProfileTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SipSyncProfile>(
      where: where?.call(SipSyncProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SipSyncProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SipSyncProfileTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SipSyncProfile>(
      where: where(SipSyncProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SipSyncProfileAttachRowRepository {
  const SipSyncProfileAttachRowRepository._();

  /// Creates a relation between the given [SipSyncProfile] and [AuthUser]
  /// by setting the [SipSyncProfile]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    SipSyncProfile sipSyncProfile,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (sipSyncProfile.id == null) {
      throw ArgumentError.notNull('sipSyncProfile.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $sipSyncProfile = sipSyncProfile.copyWith(authUserId: authUser.id);
    await session.db.updateRow<SipSyncProfile>(
      $sipSyncProfile,
      columns: [SipSyncProfile.t.authUserId],
      transaction: transaction,
    );
  }
}
