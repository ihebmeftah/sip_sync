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
import '../../auth/entity/customer.dart' as _iigcgb04;
import '../../buildings/entity/building.dart' as _iaohraio;
import '../../reservations/entity/table_reservation.dart' as _i6tkokf9;
import '../../reservations/reservation_status.dart' as _isnodepe;

/// A booking for one or more tables in a venue.
abstract class Reservation
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  Reservation._({
    this.id,
    required this.buildingId,
    this.building,
    required this.startsAt,
    required this.endsAt,
    this.customerId,
    this.customer,
    required this.guestName,
    this.guestPhone,
    double? paidAmount,
    required this.status,
    required this.createdByType,
    required this.createdById,
    this.confirmedAt,
    this.confirmedById,
    DateTime? createdAt,
    this.links,
  }) : paidAmount = paidAmount ?? 0.0,
       createdAt = createdAt ?? DateTime.now();

  factory Reservation({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    required DateTime startsAt,
    required DateTime endsAt,
    _is.UuidValue? customerId,
    _iigcgb04.Customer? customer,
    required String guestName,
    String? guestPhone,
    double? paidAmount,
    required _isnodepe.ReservationStatus status,
    required _i6ch5qy5.ActorType createdByType,
    required _is.UuidValue createdById,
    DateTime? confirmedAt,
    _is.UuidValue? confirmedById,
    DateTime? createdAt,
    List<_i6tkokf9.TableReservation>? links,
  }) = _ReservationImpl;

  factory Reservation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Reservation(
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
      startsAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      customerId: jsonSerialization['customerId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['customerId'],
            ),
      customer: jsonSerialization['customer'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_iigcgb04.Customer>(
              jsonSerialization['customer'],
            ),
      guestName: jsonSerialization['guestName'] as String,
      guestPhone: jsonSerialization['guestPhone'] as String?,
      paidAmount: (jsonSerialization['paidAmount'] as num?)?.toDouble(),
      status: _isnodepe.ReservationStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      createdByType: _i6ch5qy5.ActorType.fromJson(
        (jsonSerialization['createdByType'] as String),
      ),
      createdById: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdById'],
      ),
      confirmedAt: jsonSerialization['confirmedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['confirmedAt'],
            ),
      confirmedById: jsonSerialization['confirmedById'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['confirmedById'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      links: jsonSerialization['links'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_i6tkokf9.TableReservation>>(
              jsonSerialization['links'],
            ),
    );
  }

  static final t = ReservationTable();

  static const db = ReservationRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue buildingId;

  _iaohraio.Building? building;

  DateTime startsAt;

  DateTime endsAt;

  _is.UuidValue? customerId;

  _iigcgb04.Customer? customer;

  /// Display name. Copied from the customer account or typed for a guest.
  String guestName;

  String? guestPhone;

  /// Amount recorded as paid, in the venue currency.
  double paidAmount;

  _isnodepe.ReservationStatus status;

  _i6ch5qy5.ActorType createdByType;

  _is.UuidValue createdById;

  DateTime? confirmedAt;

  _is.UuidValue? confirmedById;

  DateTime createdAt;

  List<_i6tkokf9.TableReservation>? links;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Reservation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Reservation copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    _iaohraio.Building? building,
    DateTime? startsAt,
    DateTime? endsAt,
    _is.UuidValue? customerId,
    _iigcgb04.Customer? customer,
    String? guestName,
    String? guestPhone,
    double? paidAmount,
    _isnodepe.ReservationStatus? status,
    _i6ch5qy5.ActorType? createdByType,
    _is.UuidValue? createdById,
    DateTime? confirmedAt,
    _is.UuidValue? confirmedById,
    DateTime? createdAt,
    List<_i6tkokf9.TableReservation>? links,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Reservation',
      if (id != null) 'id': id?.toJson(),
      'buildingId': buildingId.toJson(),
      if (building != null) 'building': building?.toJson(),
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      if (customerId != null) 'customerId': customerId?.toJson(),
      if (customer != null) 'customer': customer?.toJson(),
      'guestName': guestName,
      if (guestPhone != null) 'guestPhone': guestPhone,
      'paidAmount': paidAmount,
      'status': status.toJson(),
      'createdByType': createdByType.toJson(),
      'createdById': createdById.toJson(),
      if (confirmedAt != null) 'confirmedAt': confirmedAt?.toJson(),
      if (confirmedById != null) 'confirmedById': confirmedById?.toJson(),
      'createdAt': createdAt.toJson(),
      if (links != null) 'links': links?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static ReservationInclude include({
    _iaohraio.BuildingInclude? building,
    _iigcgb04.CustomerInclude? customer,
    _i6tkokf9.TableReservationIncludeList? links,
  }) {
    return ReservationInclude._(
      building: building,
      customer: customer,
      links: links,
    );
  }

  static ReservationIncludeList includeList({
    _is.WhereExpressionBuilder<ReservationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReservationTable>? orderBy,
    _is.OrderByListBuilder<ReservationTable>? orderByList,
    ReservationInclude? include,
  }) {
    return ReservationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Reservation.t),
      orderByList: orderByList?.call(Reservation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReservationImpl extends Reservation {
  _ReservationImpl({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    required DateTime startsAt,
    required DateTime endsAt,
    _is.UuidValue? customerId,
    _iigcgb04.Customer? customer,
    required String guestName,
    String? guestPhone,
    double? paidAmount,
    required _isnodepe.ReservationStatus status,
    required _i6ch5qy5.ActorType createdByType,
    required _is.UuidValue createdById,
    DateTime? confirmedAt,
    _is.UuidValue? confirmedById,
    DateTime? createdAt,
    List<_i6tkokf9.TableReservation>? links,
  }) : super._(
         id: id,
         buildingId: buildingId,
         building: building,
         startsAt: startsAt,
         endsAt: endsAt,
         customerId: customerId,
         customer: customer,
         guestName: guestName,
         guestPhone: guestPhone,
         paidAmount: paidAmount,
         status: status,
         createdByType: createdByType,
         createdById: createdById,
         confirmedAt: confirmedAt,
         confirmedById: confirmedById,
         createdAt: createdAt,
         links: links,
       );

  /// Returns a shallow copy of this [Reservation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Reservation copyWith({
    Object? id = _Undefined,
    _is.UuidValue? buildingId,
    Object? building = _Undefined,
    DateTime? startsAt,
    DateTime? endsAt,
    Object? customerId = _Undefined,
    Object? customer = _Undefined,
    String? guestName,
    Object? guestPhone = _Undefined,
    double? paidAmount,
    _isnodepe.ReservationStatus? status,
    _i6ch5qy5.ActorType? createdByType,
    _is.UuidValue? createdById,
    Object? confirmedAt = _Undefined,
    Object? confirmedById = _Undefined,
    DateTime? createdAt,
    Object? links = _Undefined,
  }) {
    return Reservation(
      id: id is _is.UuidValue? ? id : this.id,
      buildingId: buildingId ?? this.buildingId,
      building: building is _iaohraio.Building?
          ? building
          : this.building?.copyWith(),
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      customerId: customerId is _is.UuidValue? ? customerId : this.customerId,
      customer: customer is _iigcgb04.Customer?
          ? customer
          : this.customer?.copyWith(),
      guestName: guestName ?? this.guestName,
      guestPhone: guestPhone is String? ? guestPhone : this.guestPhone,
      paidAmount: paidAmount ?? this.paidAmount,
      status: status ?? this.status,
      createdByType: createdByType ?? this.createdByType,
      createdById: createdById ?? this.createdById,
      confirmedAt: confirmedAt is DateTime? ? confirmedAt : this.confirmedAt,
      confirmedById: confirmedById is _is.UuidValue?
          ? confirmedById
          : this.confirmedById,
      createdAt: createdAt ?? this.createdAt,
      links: links is List<_i6tkokf9.TableReservation>?
          ? links
          : this.links?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class ReservationUpdateTable extends _is.UpdateTable<ReservationTable> {
  ReservationUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> buildingId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.buildingId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startsAt(DateTime value) =>
      _is.ColumnValue(
        table.startsAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> endsAt(DateTime value) => _is.ColumnValue(
    table.endsAt,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> customerId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.customerId,
    value,
  );

  _is.ColumnValue<String, String> guestName(String value) => _is.ColumnValue(
    table.guestName,
    value,
  );

  _is.ColumnValue<String, String> guestPhone(String? value) => _is.ColumnValue(
    table.guestPhone,
    value,
  );

  _is.ColumnValue<double, double> paidAmount(double value) => _is.ColumnValue(
    table.paidAmount,
    value,
  );

  _is.ColumnValue<_isnodepe.ReservationStatus, _isnodepe.ReservationStatus>
  status(_isnodepe.ReservationStatus value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<_i6ch5qy5.ActorType, _i6ch5qy5.ActorType> createdByType(
    _i6ch5qy5.ActorType value,
  ) => _is.ColumnValue(
    table.createdByType,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> createdById(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.createdById,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> confirmedAt(DateTime? value) =>
      _is.ColumnValue(
        table.confirmedAt,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> confirmedById(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.confirmedById,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ReservationTable extends _is.Table<_is.UuidValue?> {
  ReservationTable({super.tableRelation}) : super(tableName: 'reservation') {
    updateTable = ReservationUpdateTable(this);
    buildingId = _is.ColumnUuid(
      'buildingId',
      this,
    );
    startsAt = _is.ColumnDateTime(
      'startsAt',
      this,
    );
    endsAt = _is.ColumnDateTime(
      'endsAt',
      this,
    );
    customerId = _is.ColumnUuid(
      'customerId',
      this,
    );
    guestName = _is.ColumnString(
      'guestName',
      this,
    );
    guestPhone = _is.ColumnString(
      'guestPhone',
      this,
    );
    paidAmount = _is.ColumnDouble(
      'paidAmount',
      this,
      hasDefault: true,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    createdByType = _is.ColumnEnum(
      'createdByType',
      this,
      _is.EnumSerialization.byName,
    );
    createdById = _is.ColumnUuid(
      'createdById',
      this,
    );
    confirmedAt = _is.ColumnDateTime(
      'confirmedAt',
      this,
    );
    confirmedById = _is.ColumnUuid(
      'confirmedById',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ReservationUpdateTable updateTable;

  late final _is.ColumnUuid buildingId;

  _iaohraio.BuildingTable? _building;

  late final _is.ColumnDateTime startsAt;

  late final _is.ColumnDateTime endsAt;

  late final _is.ColumnUuid customerId;

  _iigcgb04.CustomerTable? _customer;

  /// Display name. Copied from the customer account or typed for a guest.
  late final _is.ColumnString guestName;

  late final _is.ColumnString guestPhone;

  /// Amount recorded as paid, in the venue currency.
  late final _is.ColumnDouble paidAmount;

  late final _is.ColumnEnum<_isnodepe.ReservationStatus> status;

  late final _is.ColumnEnum<_i6ch5qy5.ActorType> createdByType;

  late final _is.ColumnUuid createdById;

  late final _is.ColumnDateTime confirmedAt;

  late final _is.ColumnUuid confirmedById;

  late final _is.ColumnDateTime createdAt;

  _i6tkokf9.TableReservationTable? ___links;

  _is.ManyRelation<_i6tkokf9.TableReservationTable>? _links;

  _iaohraio.BuildingTable get building {
    if (_building != null) return _building!;
    _building = _is.createRelationTable(
      relationFieldName: 'building',
      field: Reservation.t.buildingId,
      foreignField: _iaohraio.Building.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iaohraio.BuildingTable(tableRelation: foreignTableRelation),
    );
    return _building!;
  }

  _iigcgb04.CustomerTable get customer {
    if (_customer != null) return _customer!;
    _customer = _is.createRelationTable(
      relationFieldName: 'customer',
      field: Reservation.t.customerId,
      foreignField: _iigcgb04.Customer.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iigcgb04.CustomerTable(tableRelation: foreignTableRelation),
    );
    return _customer!;
  }

  _i6tkokf9.TableReservationTable get __links {
    if (___links != null) return ___links!;
    ___links = _is.createRelationTable(
      relationFieldName: '__links',
      field: Reservation.t.id,
      foreignField: _i6tkokf9.TableReservation.t.reservationId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6tkokf9.TableReservationTable(tableRelation: foreignTableRelation),
    );
    return ___links!;
  }

  _is.ManyRelation<_i6tkokf9.TableReservationTable> get links {
    if (_links != null) return _links!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'links',
      field: Reservation.t.id,
      foreignField: _i6tkokf9.TableReservation.t.reservationId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6tkokf9.TableReservationTable(tableRelation: foreignTableRelation),
    );
    _links = _is.ManyRelation<_i6tkokf9.TableReservationTable>(
      tableWithRelations: relationTable,
      table: _i6tkokf9.TableReservationTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _links!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    buildingId,
    startsAt,
    endsAt,
    customerId,
    guestName,
    guestPhone,
    paidAmount,
    status,
    createdByType,
    createdById,
    confirmedAt,
    confirmedById,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'building') {
      return building;
    }
    if (relationField == 'customer') {
      return customer;
    }
    if (relationField == 'links') {
      return __links;
    }
    return null;
  }
}

class ReservationInclude extends _is.IncludeObject {
  ReservationInclude._({
    _iaohraio.BuildingInclude? building,
    _iigcgb04.CustomerInclude? customer,
    _i6tkokf9.TableReservationIncludeList? links,
  }) {
    _building = building;
    _customer = customer;
    _links = links;
  }

  _iaohraio.BuildingInclude? _building;

  _iigcgb04.CustomerInclude? _customer;

  _i6tkokf9.TableReservationIncludeList? _links;

  @override
  Map<String, _is.Include?> get includes => {
    'building': _building,
    'customer': _customer,
    'links': _links,
  };

  @override
  _is.Table<_is.UuidValue?> get table => Reservation.t;
}

class ReservationIncludeList extends _is.IncludeList {
  ReservationIncludeList._({
    _is.WhereExpressionBuilder<ReservationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Reservation.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => Reservation.t;
}

class ReservationRepository {
  const ReservationRepository._();

  final attach = const ReservationAttachRepository._();

  final attachRow = const ReservationAttachRowRepository._();

  final detachRow = const ReservationDetachRowRepository._();

  /// Returns a list of [Reservation]s matching the given query parameters.
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
  Future<List<Reservation>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReservationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReservationTable>? orderBy,
    _is.OrderByListBuilder<ReservationTable>? orderByList,
    _is.Transaction? transaction,
    ReservationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Reservation>(
      where: where?.call(Reservation.t),
      orderBy: orderBy?.call(Reservation.t),
      orderByList: orderByList?.call(Reservation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Reservation] matching the given query parameters.
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
  Future<Reservation?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReservationTable>? where,
    int? offset,
    _is.OrderByBuilder<ReservationTable>? orderBy,
    _is.OrderByListBuilder<ReservationTable>? orderByList,
    _is.Transaction? transaction,
    ReservationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Reservation>(
      where: where?.call(Reservation.t),
      orderBy: orderBy?.call(Reservation.t),
      orderByList: orderByList?.call(Reservation.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Reservation] by its [id] or null if no such row exists.
  Future<Reservation?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    ReservationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Reservation>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Reservation]s in the list and returns the inserted rows.
  ///
  /// The returned [Reservation]s will have their `id` fields set.
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
  Future<List<Reservation>> insert(
    _is.DatabaseSession session,
    List<Reservation> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Reservation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Reservation] and returns the inserted row.
  ///
  /// The returned [Reservation] will have its `id` field set.
  Future<Reservation> insertRow(
    _is.DatabaseSession session,
    Reservation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Reservation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Reservation]s in the list and returns the resulting rows.
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
  /// The returned [Reservation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Reservation>> upsert(
    _is.DatabaseSession session,
    List<Reservation> rows, {
    required _is.ColumnSelections<ReservationTable> conflictColumns,
    _is.ColumnSelections<ReservationTable>? updateColumns,
    _is.WhereExpressionBuilder<ReservationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Reservation>(
      rows,
      conflictColumns: conflictColumns(Reservation.t),
      updateColumns: updateColumns?.call(Reservation.t),
      updateWhere: updateWhere?.call(Reservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Reservation] and returns the resulting row.
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
  /// The returned [Reservation] will have its `id` field set.
  Future<Reservation?> upsertRow(
    _is.DatabaseSession session,
    Reservation row, {
    required _is.ColumnSelections<ReservationTable> conflictColumns,
    _is.ColumnSelections<ReservationTable>? updateColumns,
    _is.WhereExpressionBuilder<ReservationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Reservation>(
      row,
      conflictColumns: conflictColumns(Reservation.t),
      updateColumns: updateColumns?.call(Reservation.t),
      updateWhere: updateWhere?.call(Reservation.t),
      transaction: transaction,
    );
  }

  /// Updates all [Reservation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Reservation>> update(
    _is.DatabaseSession session,
    List<Reservation> rows, {
    _is.ColumnSelections<ReservationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Reservation>(
      rows,
      columns: columns?.call(Reservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Reservation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Reservation> updateRow(
    _is.DatabaseSession session,
    Reservation row, {
    _is.ColumnSelections<ReservationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Reservation>(
      row,
      columns: columns?.call(Reservation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Reservation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Reservation?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<ReservationUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Reservation>(
      id,
      columnValues: columnValues(Reservation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Reservation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Reservation>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ReservationUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ReservationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReservationTable>? orderBy,
    _is.OrderByListBuilder<ReservationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Reservation>(
      columnValues: columnValues(Reservation.t.updateTable),
      where: where(Reservation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Reservation.t),
      orderByList: orderByList?.call(Reservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Reservation]s in the list and returns the deleted rows.
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
  Future<List<Reservation>> delete(
    _is.DatabaseSession session,
    List<Reservation> rows, {
    _is.OrderByBuilder<ReservationTable>? orderBy,
    _is.OrderByListBuilder<ReservationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Reservation>(
      rows,
      orderBy: orderBy?.call(Reservation.t),
      orderByList: orderByList?.call(Reservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Reservation].
  Future<Reservation> deleteRow(
    _is.DatabaseSession session,
    Reservation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Reservation>(
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
  Future<List<Reservation>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReservationTable> where,
    _is.OrderByBuilder<ReservationTable>? orderBy,
    _is.OrderByListBuilder<ReservationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Reservation>(
      where: where(Reservation.t),
      orderBy: orderBy?.call(Reservation.t),
      orderByList: orderByList?.call(Reservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReservationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Reservation>(
      where: where?.call(Reservation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Reservation] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReservationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Reservation>(
      where: where(Reservation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ReservationAttachRepository {
  const ReservationAttachRepository._();

  /// Creates a relation between this [Reservation] and the given [TableReservation]s
  /// by setting each [TableReservation]'s foreign key `reservationId` to refer to this [Reservation].
  Future<void> links(
    _is.DatabaseSession session,
    Reservation reservation,
    List<_i6tkokf9.TableReservation> tableReservation, {
    _is.Transaction? transaction,
  }) async {
    if (tableReservation.any((e) => e.id == null)) {
      throw ArgumentError.notNull('tableReservation.id');
    }
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }

    var $tableReservation = tableReservation
        .map((e) => e.copyWith(reservationId: reservation.id))
        .toList();
    await session.db.update<_i6tkokf9.TableReservation>(
      $tableReservation,
      columns: [_i6tkokf9.TableReservation.t.reservationId],
      transaction: transaction,
    );
  }
}

class ReservationAttachRowRepository {
  const ReservationAttachRowRepository._();

  /// Creates a relation between the given [Reservation] and [Building]
  /// by setting the [Reservation]'s foreign key `buildingId` to refer to the [Building].
  Future<void> building(
    _is.DatabaseSession session,
    Reservation reservation,
    _iaohraio.Building building, {
    _is.Transaction? transaction,
  }) async {
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $reservation = reservation.copyWith(buildingId: building.id);
    await session.db.updateRow<Reservation>(
      $reservation,
      columns: [Reservation.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Reservation] and [Customer]
  /// by setting the [Reservation]'s foreign key `customerId` to refer to the [Customer].
  Future<void> customer(
    _is.DatabaseSession session,
    Reservation reservation,
    _iigcgb04.Customer customer, {
    _is.Transaction? transaction,
  }) async {
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }
    if (customer.id == null) {
      throw ArgumentError.notNull('customer.id');
    }

    var $reservation = reservation.copyWith(customerId: customer.id);
    await session.db.updateRow<Reservation>(
      $reservation,
      columns: [Reservation.t.customerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Reservation] and the given [TableReservation]
  /// by setting the [TableReservation]'s foreign key `reservationId` to refer to this [Reservation].
  Future<void> links(
    _is.DatabaseSession session,
    Reservation reservation,
    _i6tkokf9.TableReservation tableReservation, {
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
    await session.db.updateRow<_i6tkokf9.TableReservation>(
      $tableReservation,
      columns: [_i6tkokf9.TableReservation.t.reservationId],
      transaction: transaction,
    );
  }
}

class ReservationDetachRowRepository {
  const ReservationDetachRowRepository._();

  /// Detaches the relation between this [Reservation] and the [Customer] set in `customer`
  /// by setting the [Reservation]'s foreign key `customerId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> customer(
    _is.DatabaseSession session,
    Reservation reservation, {
    _is.Transaction? transaction,
  }) async {
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }

    var $reservation = reservation.copyWith(customerId: null);
    await session.db.updateRow<Reservation>(
      $reservation,
      columns: [Reservation.t.customerId],
      transaction: transaction,
    );
  }
}
