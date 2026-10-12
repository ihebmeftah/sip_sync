/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import '../../auth/dtos/actor_type.dart' as _i6ch5qy5;
import '../../notifications/dtos/app_notification_kind.dart' as _icpt1wso;
import '../../orders/dtos/order_cancellation_reason.dart' as _i9x1n0bn;
import '../../orders/dtos/order_item_status.dart' as _iw3cmuga;
import '../../orders/dtos/order_status.dart' as _iij1ihnv;
import '../../reservations/reservation_status.dart' as _isnodepe;

/// One stored alert. [subjectId] is the order, reservation, or later management record that a tap opens.
abstract class AppNotification
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  AppNotification._({
    this.id,
    required this.recipientType,
    required this.recipientId,
    required this.buildingId,
    required this.venueName,
    required this.subjectId,
    required this.kind,
    this.orderItemId,
    this.orderRef,
    this.articleName,
    this.itemStatus,
    this.orderStatus,
    this.reservationStatus,
    this.cancellationReason,
    this.readAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AppNotification({
    _is.UuidValue? id,
    required _i6ch5qy5.ActorType recipientType,
    required _is.UuidValue recipientId,
    required _is.UuidValue buildingId,
    required String venueName,
    required _is.UuidValue subjectId,
    required _icpt1wso.AppNotificationKind kind,
    _is.UuidValue? orderItemId,
    int? orderRef,
    String? articleName,
    _iw3cmuga.OrderItemStatus? itemStatus,
    _iij1ihnv.OrderStatus? orderStatus,
    _isnodepe.ReservationStatus? reservationStatus,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    DateTime? readAt,
    DateTime? createdAt,
  }) = _AppNotificationImpl;

  factory AppNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppNotification(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      recipientType: _i6ch5qy5.ActorType.fromJson(
        (jsonSerialization['recipientType'] as String),
      ),
      recipientId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['recipientId'],
      ),
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      venueName: jsonSerialization['venueName'] as String,
      subjectId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['subjectId'],
      ),
      kind: _icpt1wso.AppNotificationKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      orderItemId: jsonSerialization['orderItemId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['orderItemId'],
            ),
      orderRef: jsonSerialization['orderRef'] as int?,
      articleName: jsonSerialization['articleName'] as String?,
      itemStatus: jsonSerialization['itemStatus'] == null
          ? null
          : _iw3cmuga.OrderItemStatus.fromJson(
              (jsonSerialization['itemStatus'] as String),
            ),
      orderStatus: jsonSerialization['orderStatus'] == null
          ? null
          : _iij1ihnv.OrderStatus.fromJson(
              (jsonSerialization['orderStatus'] as String),
            ),
      reservationStatus: jsonSerialization['reservationStatus'] == null
          ? null
          : _isnodepe.ReservationStatus.fromJson(
              (jsonSerialization['reservationStatus'] as String),
            ),
      cancellationReason: jsonSerialization['cancellationReason'] == null
          ? null
          : _i9x1n0bn.OrderCancellationReason.fromJson(
              (jsonSerialization['cancellationReason'] as String),
            ),
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = AppNotificationTable();

  static const db = AppNotificationRepository._();

  @override
  _is.UuidValue? id;

  _i6ch5qy5.ActorType recipientType;

  _is.UuidValue recipientId;

  _is.UuidValue buildingId;

  String venueName;

  /// Order id, reservation id, or a later management record.
  _is.UuidValue subjectId;

  _icpt1wso.AppNotificationKind kind;

  _is.UuidValue? orderItemId;

  int? orderRef;

  String? articleName;

  _iw3cmuga.OrderItemStatus? itemStatus;

  _iij1ihnv.OrderStatus? orderStatus;

  _isnodepe.ReservationStatus? reservationStatus;

  _i9x1n0bn.OrderCancellationReason? cancellationReason;

  /// Null until the recipient opens this alert.
  DateTime? readAt;

  DateTime createdAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [AppNotification]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AppNotification copyWith({
    _is.UuidValue? id,
    _i6ch5qy5.ActorType? recipientType,
    _is.UuidValue? recipientId,
    _is.UuidValue? buildingId,
    String? venueName,
    _is.UuidValue? subjectId,
    _icpt1wso.AppNotificationKind? kind,
    _is.UuidValue? orderItemId,
    int? orderRef,
    String? articleName,
    _iw3cmuga.OrderItemStatus? itemStatus,
    _iij1ihnv.OrderStatus? orderStatus,
    _isnodepe.ReservationStatus? reservationStatus,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    DateTime? readAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppNotification',
      if (id != null) 'id': id?.toJson(),
      'recipientType': recipientType.toJson(),
      'recipientId': recipientId.toJson(),
      'buildingId': buildingId.toJson(),
      'venueName': venueName,
      'subjectId': subjectId.toJson(),
      'kind': kind.toJson(),
      if (orderItemId != null) 'orderItemId': orderItemId?.toJson(),
      if (orderRef != null) 'orderRef': orderRef,
      if (articleName != null) 'articleName': articleName,
      if (itemStatus != null) 'itemStatus': itemStatus?.toJson(),
      if (orderStatus != null) 'orderStatus': orderStatus?.toJson(),
      if (reservationStatus != null)
        'reservationStatus': reservationStatus?.toJson(),
      if (cancellationReason != null)
        'cancellationReason': cancellationReason?.toJson(),
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static AppNotificationInclude include() {
    return AppNotificationInclude._();
  }

  static AppNotificationIncludeList includeList({
    _is.WhereExpressionBuilder<AppNotificationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppNotificationTable>? orderBy,
    _is.OrderByListBuilder<AppNotificationTable>? orderByList,
    AppNotificationInclude? include,
  }) {
    return AppNotificationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppNotification.t),
      orderByList: orderByList?.call(AppNotification.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppNotificationImpl extends AppNotification {
  _AppNotificationImpl({
    _is.UuidValue? id,
    required _i6ch5qy5.ActorType recipientType,
    required _is.UuidValue recipientId,
    required _is.UuidValue buildingId,
    required String venueName,
    required _is.UuidValue subjectId,
    required _icpt1wso.AppNotificationKind kind,
    _is.UuidValue? orderItemId,
    int? orderRef,
    String? articleName,
    _iw3cmuga.OrderItemStatus? itemStatus,
    _iij1ihnv.OrderStatus? orderStatus,
    _isnodepe.ReservationStatus? reservationStatus,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    DateTime? readAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         recipientType: recipientType,
         recipientId: recipientId,
         buildingId: buildingId,
         venueName: venueName,
         subjectId: subjectId,
         kind: kind,
         orderItemId: orderItemId,
         orderRef: orderRef,
         articleName: articleName,
         itemStatus: itemStatus,
         orderStatus: orderStatus,
         reservationStatus: reservationStatus,
         cancellationReason: cancellationReason,
         readAt: readAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AppNotification]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AppNotification copyWith({
    Object? id = _Undefined,
    _i6ch5qy5.ActorType? recipientType,
    _is.UuidValue? recipientId,
    _is.UuidValue? buildingId,
    String? venueName,
    _is.UuidValue? subjectId,
    _icpt1wso.AppNotificationKind? kind,
    Object? orderItemId = _Undefined,
    Object? orderRef = _Undefined,
    Object? articleName = _Undefined,
    Object? itemStatus = _Undefined,
    Object? orderStatus = _Undefined,
    Object? reservationStatus = _Undefined,
    Object? cancellationReason = _Undefined,
    Object? readAt = _Undefined,
    DateTime? createdAt,
  }) {
    return AppNotification(
      id: id is _is.UuidValue? ? id : this.id,
      recipientType: recipientType ?? this.recipientType,
      recipientId: recipientId ?? this.recipientId,
      buildingId: buildingId ?? this.buildingId,
      venueName: venueName ?? this.venueName,
      subjectId: subjectId ?? this.subjectId,
      kind: kind ?? this.kind,
      orderItemId: orderItemId is _is.UuidValue?
          ? orderItemId
          : this.orderItemId,
      orderRef: orderRef is int? ? orderRef : this.orderRef,
      articleName: articleName is String? ? articleName : this.articleName,
      itemStatus: itemStatus is _iw3cmuga.OrderItemStatus?
          ? itemStatus
          : this.itemStatus,
      orderStatus: orderStatus is _iij1ihnv.OrderStatus?
          ? orderStatus
          : this.orderStatus,
      reservationStatus: reservationStatus is _isnodepe.ReservationStatus?
          ? reservationStatus
          : this.reservationStatus,
      cancellationReason:
          cancellationReason is _i9x1n0bn.OrderCancellationReason?
          ? cancellationReason
          : this.cancellationReason,
      readAt: readAt is DateTime? ? readAt : this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AppNotificationUpdateTable extends _is.UpdateTable<AppNotificationTable> {
  AppNotificationUpdateTable(super.table);

  _is.ColumnValue<_i6ch5qy5.ActorType, _i6ch5qy5.ActorType> recipientType(
    _i6ch5qy5.ActorType value,
  ) => _is.ColumnValue(
    table.recipientType,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> recipientId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.recipientId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> buildingId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.buildingId,
    value,
  );

  _is.ColumnValue<String, String> venueName(String value) => _is.ColumnValue(
    table.venueName,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> subjectId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.subjectId,
    value,
  );

  _is.ColumnValue<_icpt1wso.AppNotificationKind, _icpt1wso.AppNotificationKind>
  kind(_icpt1wso.AppNotificationKind value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> orderItemId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.orderItemId,
    value,
  );

  _is.ColumnValue<int, int> orderRef(int? value) => _is.ColumnValue(
    table.orderRef,
    value,
  );

  _is.ColumnValue<String, String> articleName(String? value) => _is.ColumnValue(
    table.articleName,
    value,
  );

  _is.ColumnValue<_iw3cmuga.OrderItemStatus, _iw3cmuga.OrderItemStatus>
  itemStatus(_iw3cmuga.OrderItemStatus? value) => _is.ColumnValue(
    table.itemStatus,
    value,
  );

  _is.ColumnValue<_iij1ihnv.OrderStatus, _iij1ihnv.OrderStatus> orderStatus(
    _iij1ihnv.OrderStatus? value,
  ) => _is.ColumnValue(
    table.orderStatus,
    value,
  );

  _is.ColumnValue<_isnodepe.ReservationStatus, _isnodepe.ReservationStatus>
  reservationStatus(_isnodepe.ReservationStatus? value) => _is.ColumnValue(
    table.reservationStatus,
    value,
  );

  _is.ColumnValue<
    _i9x1n0bn.OrderCancellationReason,
    _i9x1n0bn.OrderCancellationReason
  >
  cancellationReason(_i9x1n0bn.OrderCancellationReason? value) =>
      _is.ColumnValue(
        table.cancellationReason,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> readAt(DateTime? value) =>
      _is.ColumnValue(
        table.readAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class AppNotificationTable extends _is.Table<_is.UuidValue?> {
  AppNotificationTable({super.tableRelation})
    : super(tableName: 'app_notification') {
    updateTable = AppNotificationUpdateTable(this);
    recipientType = _is.ColumnEnum(
      'recipientType',
      this,
      _is.EnumSerialization.byName,
    );
    recipientId = _is.ColumnUuid(
      'recipientId',
      this,
    );
    buildingId = _is.ColumnUuid(
      'buildingId',
      this,
    );
    venueName = _is.ColumnString(
      'venueName',
      this,
    );
    subjectId = _is.ColumnUuid(
      'subjectId',
      this,
    );
    kind = _is.ColumnEnum(
      'kind',
      this,
      _is.EnumSerialization.byName,
    );
    orderItemId = _is.ColumnUuid(
      'orderItemId',
      this,
    );
    orderRef = _is.ColumnInt(
      'orderRef',
      this,
    );
    articleName = _is.ColumnString(
      'articleName',
      this,
    );
    itemStatus = _is.ColumnEnum(
      'itemStatus',
      this,
      _is.EnumSerialization.byName,
    );
    orderStatus = _is.ColumnEnum(
      'orderStatus',
      this,
      _is.EnumSerialization.byName,
    );
    reservationStatus = _is.ColumnEnum(
      'reservationStatus',
      this,
      _is.EnumSerialization.byName,
    );
    cancellationReason = _is.ColumnEnum(
      'cancellationReason',
      this,
      _is.EnumSerialization.byName,
    );
    readAt = _is.ColumnDateTime(
      'readAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final AppNotificationUpdateTable updateTable;

  late final _is.ColumnEnum<_i6ch5qy5.ActorType> recipientType;

  late final _is.ColumnUuid recipientId;

  late final _is.ColumnUuid buildingId;

  late final _is.ColumnString venueName;

  /// Order id, reservation id, or a later management record.
  late final _is.ColumnUuid subjectId;

  late final _is.ColumnEnum<_icpt1wso.AppNotificationKind> kind;

  late final _is.ColumnUuid orderItemId;

  late final _is.ColumnInt orderRef;

  late final _is.ColumnString articleName;

  late final _is.ColumnEnum<_iw3cmuga.OrderItemStatus> itemStatus;

  late final _is.ColumnEnum<_iij1ihnv.OrderStatus> orderStatus;

  late final _is.ColumnEnum<_isnodepe.ReservationStatus> reservationStatus;

  late final _is.ColumnEnum<_i9x1n0bn.OrderCancellationReason>
  cancellationReason;

  /// Null until the recipient opens this alert.
  late final _is.ColumnDateTime readAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    recipientType,
    recipientId,
    buildingId,
    venueName,
    subjectId,
    kind,
    orderItemId,
    orderRef,
    articleName,
    itemStatus,
    orderStatus,
    reservationStatus,
    cancellationReason,
    readAt,
    createdAt,
  ];
}

class AppNotificationInclude extends _is.IncludeObject {
  AppNotificationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => AppNotification.t;
}

class AppNotificationIncludeList extends _is.IncludeList {
  AppNotificationIncludeList._({
    _is.WhereExpressionBuilder<AppNotificationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AppNotification.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => AppNotification.t;
}

class AppNotificationRepository {
  const AppNotificationRepository._();

  /// Returns a list of [AppNotification]s matching the given query parameters.
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
  Future<List<AppNotification>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppNotificationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppNotificationTable>? orderBy,
    _is.OrderByListBuilder<AppNotificationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AppNotification>(
      where: where?.call(AppNotification.t),
      orderBy: orderBy?.call(AppNotification.t),
      orderByList: orderByList?.call(AppNotification.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AppNotification] matching the given query parameters.
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
  Future<AppNotification?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppNotificationTable>? where,
    int? offset,
    _is.OrderByBuilder<AppNotificationTable>? orderBy,
    _is.OrderByListBuilder<AppNotificationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AppNotification>(
      where: where?.call(AppNotification.t),
      orderBy: orderBy?.call(AppNotification.t),
      orderByList: orderByList?.call(AppNotification.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AppNotification] by its [id] or null if no such row exists.
  Future<AppNotification?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AppNotification>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AppNotification]s in the list and returns the inserted rows.
  ///
  /// The returned [AppNotification]s will have their `id` fields set.
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
  Future<List<AppNotification>> insert(
    _is.DatabaseSession session,
    List<AppNotification> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AppNotification>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AppNotification] and returns the inserted row.
  ///
  /// The returned [AppNotification] will have its `id` field set.
  Future<AppNotification> insertRow(
    _is.DatabaseSession session,
    AppNotification row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AppNotification>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AppNotification]s in the list and returns the resulting rows.
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
  /// The returned [AppNotification]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppNotification>> upsert(
    _is.DatabaseSession session,
    List<AppNotification> rows, {
    required _is.ColumnSelections<AppNotificationTable> conflictColumns,
    _is.ColumnSelections<AppNotificationTable>? updateColumns,
    _is.WhereExpressionBuilder<AppNotificationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AppNotification>(
      rows,
      conflictColumns: conflictColumns(AppNotification.t),
      updateColumns: updateColumns?.call(AppNotification.t),
      updateWhere: updateWhere?.call(AppNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AppNotification] and returns the resulting row.
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
  /// The returned [AppNotification] will have its `id` field set.
  Future<AppNotification?> upsertRow(
    _is.DatabaseSession session,
    AppNotification row, {
    required _is.ColumnSelections<AppNotificationTable> conflictColumns,
    _is.ColumnSelections<AppNotificationTable>? updateColumns,
    _is.WhereExpressionBuilder<AppNotificationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AppNotification>(
      row,
      conflictColumns: conflictColumns(AppNotification.t),
      updateColumns: updateColumns?.call(AppNotification.t),
      updateWhere: updateWhere?.call(AppNotification.t),
      transaction: transaction,
    );
  }

  /// Updates all [AppNotification]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppNotification>> update(
    _is.DatabaseSession session,
    List<AppNotification> rows, {
    _is.ColumnSelections<AppNotificationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AppNotification>(
      rows,
      columns: columns?.call(AppNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AppNotification]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AppNotification> updateRow(
    _is.DatabaseSession session,
    AppNotification row, {
    _is.ColumnSelections<AppNotificationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AppNotification>(
      row,
      columns: columns?.call(AppNotification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AppNotification] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AppNotification?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<AppNotificationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AppNotification>(
      id,
      columnValues: columnValues(AppNotification.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AppNotification]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppNotification>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AppNotificationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<AppNotificationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppNotificationTable>? orderBy,
    _is.OrderByListBuilder<AppNotificationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AppNotification>(
      columnValues: columnValues(AppNotification.t.updateTable),
      where: where(AppNotification.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppNotification.t),
      orderByList: orderByList?.call(AppNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AppNotification]s in the list and returns the deleted rows.
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
  Future<List<AppNotification>> delete(
    _is.DatabaseSession session,
    List<AppNotification> rows, {
    _is.OrderByBuilder<AppNotificationTable>? orderBy,
    _is.OrderByListBuilder<AppNotificationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AppNotification>(
      rows,
      orderBy: orderBy?.call(AppNotification.t),
      orderByList: orderByList?.call(AppNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AppNotification].
  Future<AppNotification> deleteRow(
    _is.DatabaseSession session,
    AppNotification row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AppNotification>(
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
  Future<List<AppNotification>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AppNotificationTable> where,
    _is.OrderByBuilder<AppNotificationTable>? orderBy,
    _is.OrderByListBuilder<AppNotificationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AppNotification>(
      where: where(AppNotification.t),
      orderBy: orderBy?.call(AppNotification.t),
      orderByList: orderByList?.call(AppNotification.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppNotificationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AppNotification>(
      where: where?.call(AppNotification.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AppNotification] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AppNotificationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AppNotification>(
      where: where(AppNotification.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
