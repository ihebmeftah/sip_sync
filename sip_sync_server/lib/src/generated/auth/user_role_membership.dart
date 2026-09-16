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
import '../auth/app_role.dart' as _i28b61kb;

/// Additive app role for one [AuthUser]. A person may have several rows.
abstract class UserRoleMembership
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  UserRoleMembership._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.role,
  });

  factory UserRoleMembership({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required _i28b61kb.AppRole role,
  }) = _UserRoleMembershipImpl;

  factory UserRoleMembership.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRoleMembership(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      role: _i28b61kb.AppRole.fromJson((jsonSerialization['role'] as String)),
    );
  }

  static final t = UserRoleMembershipTable();

  static const db = UserRoleMembershipRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  _iacs.AuthUser? authUser;

  _i28b61kb.AppRole role;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserRoleMembership]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UserRoleMembership copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    _i28b61kb.AppRole? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRoleMembership',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'role': role.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static UserRoleMembershipInclude include({_iacs.AuthUserInclude? authUser}) {
    return UserRoleMembershipInclude._(authUser: authUser);
  }

  static UserRoleMembershipIncludeList includeList({
    _is.WhereExpressionBuilder<UserRoleMembershipTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserRoleMembershipTable>? orderBy,
    _is.OrderByListBuilder<UserRoleMembershipTable>? orderByList,
    UserRoleMembershipInclude? include,
  }) {
    return UserRoleMembershipIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserRoleMembership.t),
      orderByList: orderByList?.call(UserRoleMembership.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserRoleMembershipImpl extends UserRoleMembership {
  _UserRoleMembershipImpl({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required _i28b61kb.AppRole role,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         role: role,
       );

  /// Returns a shallow copy of this [UserRoleMembership]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UserRoleMembership copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? authUser = _Undefined,
    _i28b61kb.AppRole? role,
  }) {
    return UserRoleMembership(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      role: role ?? this.role,
    );
  }
}

class UserRoleMembershipUpdateTable
    extends _is.UpdateTable<UserRoleMembershipTable> {
  UserRoleMembershipUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<_i28b61kb.AppRole, _i28b61kb.AppRole> role(
    _i28b61kb.AppRole value,
  ) => _is.ColumnValue(
    table.role,
    value,
  );
}

class UserRoleMembershipTable extends _is.Table<int?> {
  UserRoleMembershipTable({super.tableRelation})
    : super(tableName: 'user_role_membership') {
    updateTable = UserRoleMembershipUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    role = _is.ColumnEnum(
      'role',
      this,
      _is.EnumSerialization.byName,
    );
  }

  late final UserRoleMembershipUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnEnum<_i28b61kb.AppRole> role;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: UserRoleMembership.t.authUserId,
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
    role,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class UserRoleMembershipInclude extends _is.IncludeObject {
  UserRoleMembershipInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => UserRoleMembership.t;
}

class UserRoleMembershipIncludeList extends _is.IncludeList {
  UserRoleMembershipIncludeList._({
    _is.WhereExpressionBuilder<UserRoleMembershipTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserRoleMembership.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => UserRoleMembership.t;
}

class UserRoleMembershipRepository {
  const UserRoleMembershipRepository._();

  final attachRow = const UserRoleMembershipAttachRowRepository._();

  /// Returns a list of [UserRoleMembership]s matching the given query parameters.
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
  Future<List<UserRoleMembership>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserRoleMembershipTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserRoleMembershipTable>? orderBy,
    _is.OrderByListBuilder<UserRoleMembershipTable>? orderByList,
    _is.Transaction? transaction,
    UserRoleMembershipInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserRoleMembership>(
      where: where?.call(UserRoleMembership.t),
      orderBy: orderBy?.call(UserRoleMembership.t),
      orderByList: orderByList?.call(UserRoleMembership.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserRoleMembership] matching the given query parameters.
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
  Future<UserRoleMembership?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserRoleMembershipTable>? where,
    int? offset,
    _is.OrderByBuilder<UserRoleMembershipTable>? orderBy,
    _is.OrderByListBuilder<UserRoleMembershipTable>? orderByList,
    _is.Transaction? transaction,
    UserRoleMembershipInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserRoleMembership>(
      where: where?.call(UserRoleMembership.t),
      orderBy: orderBy?.call(UserRoleMembership.t),
      orderByList: orderByList?.call(UserRoleMembership.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserRoleMembership] by its [id] or null if no such row exists.
  Future<UserRoleMembership?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    UserRoleMembershipInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserRoleMembership>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserRoleMembership]s in the list and returns the inserted rows.
  ///
  /// The returned [UserRoleMembership]s will have their `id` fields set.
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
  Future<List<UserRoleMembership>> insert(
    _is.DatabaseSession session,
    List<UserRoleMembership> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<UserRoleMembership>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [UserRoleMembership] and returns the inserted row.
  ///
  /// The returned [UserRoleMembership] will have its `id` field set.
  Future<UserRoleMembership> insertRow(
    _is.DatabaseSession session,
    UserRoleMembership row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserRoleMembership>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [UserRoleMembership]s in the list and returns the resulting rows.
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
  /// The returned [UserRoleMembership]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserRoleMembership>> upsert(
    _is.DatabaseSession session,
    List<UserRoleMembership> rows, {
    required _is.ColumnSelections<UserRoleMembershipTable> conflictColumns,
    _is.ColumnSelections<UserRoleMembershipTable>? updateColumns,
    _is.WhereExpressionBuilder<UserRoleMembershipTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<UserRoleMembership>(
      rows,
      conflictColumns: conflictColumns(UserRoleMembership.t),
      updateColumns: updateColumns?.call(UserRoleMembership.t),
      updateWhere: updateWhere?.call(UserRoleMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [UserRoleMembership] and returns the resulting row.
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
  /// The returned [UserRoleMembership] will have its `id` field set.
  Future<UserRoleMembership?> upsertRow(
    _is.DatabaseSession session,
    UserRoleMembership row, {
    required _is.ColumnSelections<UserRoleMembershipTable> conflictColumns,
    _is.ColumnSelections<UserRoleMembershipTable>? updateColumns,
    _is.WhereExpressionBuilder<UserRoleMembershipTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<UserRoleMembership>(
      row,
      conflictColumns: conflictColumns(UserRoleMembership.t),
      updateColumns: updateColumns?.call(UserRoleMembership.t),
      updateWhere: updateWhere?.call(UserRoleMembership.t),
      transaction: transaction,
    );
  }

  /// Updates all [UserRoleMembership]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserRoleMembership>> update(
    _is.DatabaseSession session,
    List<UserRoleMembership> rows, {
    _is.ColumnSelections<UserRoleMembershipTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<UserRoleMembership>(
      rows,
      columns: columns?.call(UserRoleMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [UserRoleMembership]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserRoleMembership> updateRow(
    _is.DatabaseSession session,
    UserRoleMembership row, {
    _is.ColumnSelections<UserRoleMembershipTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserRoleMembership>(
      row,
      columns: columns?.call(UserRoleMembership.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserRoleMembership] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserRoleMembership?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UserRoleMembershipUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<UserRoleMembership>(
      id,
      columnValues: columnValues(UserRoleMembership.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserRoleMembership]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserRoleMembership>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UserRoleMembershipUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<UserRoleMembershipTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserRoleMembershipTable>? orderBy,
    _is.OrderByListBuilder<UserRoleMembershipTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<UserRoleMembership>(
      columnValues: columnValues(UserRoleMembership.t.updateTable),
      where: where(UserRoleMembership.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserRoleMembership.t),
      orderByList: orderByList?.call(UserRoleMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [UserRoleMembership]s in the list and returns the deleted rows.
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
  Future<List<UserRoleMembership>> delete(
    _is.DatabaseSession session,
    List<UserRoleMembership> rows, {
    _is.OrderByBuilder<UserRoleMembershipTable>? orderBy,
    _is.OrderByListBuilder<UserRoleMembershipTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<UserRoleMembership>(
      rows,
      orderBy: orderBy?.call(UserRoleMembership.t),
      orderByList: orderByList?.call(UserRoleMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [UserRoleMembership].
  Future<UserRoleMembership> deleteRow(
    _is.DatabaseSession session,
    UserRoleMembership row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserRoleMembership>(
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
  Future<List<UserRoleMembership>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserRoleMembershipTable> where,
    _is.OrderByBuilder<UserRoleMembershipTable>? orderBy,
    _is.OrderByListBuilder<UserRoleMembershipTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<UserRoleMembership>(
      where: where(UserRoleMembership.t),
      orderBy: orderBy?.call(UserRoleMembership.t),
      orderByList: orderByList?.call(UserRoleMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserRoleMembershipTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<UserRoleMembership>(
      where: where?.call(UserRoleMembership.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserRoleMembership] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserRoleMembershipTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserRoleMembership>(
      where: where(UserRoleMembership.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class UserRoleMembershipAttachRowRepository {
  const UserRoleMembershipAttachRowRepository._();

  /// Creates a relation between the given [UserRoleMembership] and [AuthUser]
  /// by setting the [UserRoleMembership]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    UserRoleMembership userRoleMembership,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (userRoleMembership.id == null) {
      throw ArgumentError.notNull('userRoleMembership.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $userRoleMembership = userRoleMembership.copyWith(
      authUserId: authUser.id,
    );
    await session.db.updateRow<UserRoleMembership>(
      $userRoleMembership,
      columns: [UserRoleMembership.t.authUserId],
      transaction: transaction,
    );
  }
}
