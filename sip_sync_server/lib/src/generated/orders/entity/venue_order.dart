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
import '../../orders/dtos/order_cancellation_reason.dart' as _i9x1n0bn;
import '../../orders/dtos/order_status.dart' as _iij1ihnv;
import '../../orders/entity/venue_order_item.dart' as _io4d4iis;
import '../../tables/entity/venue_table.dart' as _ilcfc7kr;

/// A guest order for one building (optional table). Customer launch later.
abstract class VenueOrder
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  VenueOrder._({
    this.id,
    required this.buildingId,
    this.building,
    this.venueTableId,
    this.venueTable,
    required this.ref,
    required this.status,
    required this.launchedByType,
    required this.launchedById,
    this.lastPaidByType,
    this.lastPaidById,
    this.lastPaidAt,
    this.cancelledByType,
    this.cancelledById,
    this.cancelledAt,
    this.cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.items,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory VenueOrder({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    _is.UuidValue? venueTableId,
    _ilcfc7kr.VenueTable? venueTable,
    required int ref,
    required _iij1ihnv.OrderStatus status,
    required _i6ch5qy5.ActorType launchedByType,
    required _is.UuidValue launchedById,
    _i6ch5qy5.ActorType? lastPaidByType,
    _is.UuidValue? lastPaidById,
    DateTime? lastPaidAt,
    _i6ch5qy5.ActorType? cancelledByType,
    _is.UuidValue? cancelledById,
    DateTime? cancelledAt,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_io4d4iis.VenueOrderItem>? items,
  }) = _VenueOrderImpl;

  factory VenueOrder.fromJson(Map<String, dynamic> jsonSerialization) {
    return VenueOrder(
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
      venueTableId: jsonSerialization['venueTableId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['venueTableId'],
            ),
      venueTable: jsonSerialization['venueTable'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_ilcfc7kr.VenueTable>(
              jsonSerialization['venueTable'],
            ),
      ref: jsonSerialization['ref'] as int,
      status: _iij1ihnv.OrderStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      launchedByType: _i6ch5qy5.ActorType.fromJson(
        (jsonSerialization['launchedByType'] as String),
      ),
      launchedById: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['launchedById'],
      ),
      lastPaidByType: jsonSerialization['lastPaidByType'] == null
          ? null
          : _i6ch5qy5.ActorType.fromJson(
              (jsonSerialization['lastPaidByType'] as String),
            ),
      lastPaidById: jsonSerialization['lastPaidById'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['lastPaidById'],
            ),
      lastPaidAt: jsonSerialization['lastPaidAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['lastPaidAt']),
      cancelledByType: jsonSerialization['cancelledByType'] == null
          ? null
          : _i6ch5qy5.ActorType.fromJson(
              (jsonSerialization['cancelledByType'] as String),
            ),
      cancelledById: jsonSerialization['cancelledById'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['cancelledById'],
            ),
      cancelledAt: jsonSerialization['cancelledAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['cancelledAt'],
            ),
      cancellationReason: jsonSerialization['cancellationReason'] == null
          ? null
          : _i9x1n0bn.OrderCancellationReason.fromJson(
              (jsonSerialization['cancellationReason'] as String),
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      items: jsonSerialization['items'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_io4d4iis.VenueOrderItem>>(
              jsonSerialization['items'],
            ),
    );
  }

  static final t = VenueOrderTable();

  static const db = VenueOrderRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue buildingId;

  _iaohraio.Building? building;

  _is.UuidValue? venueTableId;

  _ilcfc7kr.VenueTable? venueTable;

  int ref;

  _iij1ihnv.OrderStatus status;

  _i6ch5qy5.ActorType launchedByType;

  _is.UuidValue launchedById;

  _i6ch5qy5.ActorType? lastPaidByType;

  _is.UuidValue? lastPaidById;

  DateTime? lastPaidAt;

  _i6ch5qy5.ActorType? cancelledByType;

  _is.UuidValue? cancelledById;

  DateTime? cancelledAt;

  /// Why the whole order was cancelled. Null until it is cancelled.
  _i9x1n0bn.OrderCancellationReason? cancellationReason;

  DateTime createdAt;

  DateTime updatedAt;

  List<_io4d4iis.VenueOrderItem>? items;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [VenueOrder]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VenueOrder copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    _iaohraio.Building? building,
    _is.UuidValue? venueTableId,
    _ilcfc7kr.VenueTable? venueTable,
    int? ref,
    _iij1ihnv.OrderStatus? status,
    _i6ch5qy5.ActorType? launchedByType,
    _is.UuidValue? launchedById,
    _i6ch5qy5.ActorType? lastPaidByType,
    _is.UuidValue? lastPaidById,
    DateTime? lastPaidAt,
    _i6ch5qy5.ActorType? cancelledByType,
    _is.UuidValue? cancelledById,
    DateTime? cancelledAt,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_io4d4iis.VenueOrderItem>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VenueOrder',
      if (id != null) 'id': id?.toJson(),
      'buildingId': buildingId.toJson(),
      if (building != null) 'building': building?.toJson(),
      if (venueTableId != null) 'venueTableId': venueTableId?.toJson(),
      if (venueTable != null) 'venueTable': venueTable?.toJson(),
      'ref': ref,
      'status': status.toJson(),
      'launchedByType': launchedByType.toJson(),
      'launchedById': launchedById.toJson(),
      if (lastPaidByType != null) 'lastPaidByType': lastPaidByType?.toJson(),
      if (lastPaidById != null) 'lastPaidById': lastPaidById?.toJson(),
      if (lastPaidAt != null) 'lastPaidAt': lastPaidAt?.toJson(),
      if (cancelledByType != null) 'cancelledByType': cancelledByType?.toJson(),
      if (cancelledById != null) 'cancelledById': cancelledById?.toJson(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      if (cancellationReason != null)
        'cancellationReason': cancellationReason?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (items != null) 'items': items?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static VenueOrderInclude include({
    _iaohraio.BuildingInclude? building,
    _ilcfc7kr.VenueTableInclude? venueTable,
    _io4d4iis.VenueOrderItemIncludeList? items,
  }) {
    return VenueOrderInclude._(
      building: building,
      venueTable: venueTable,
      items: items,
    );
  }

  static VenueOrderIncludeList includeList({
    _is.WhereExpressionBuilder<VenueOrderTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VenueOrderTable>? orderBy,
    _is.OrderByListBuilder<VenueOrderTable>? orderByList,
    VenueOrderInclude? include,
  }) {
    return VenueOrderIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VenueOrder.t),
      orderByList: orderByList?.call(VenueOrder.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VenueOrderImpl extends VenueOrder {
  _VenueOrderImpl({
    _is.UuidValue? id,
    required _is.UuidValue buildingId,
    _iaohraio.Building? building,
    _is.UuidValue? venueTableId,
    _ilcfc7kr.VenueTable? venueTable,
    required int ref,
    required _iij1ihnv.OrderStatus status,
    required _i6ch5qy5.ActorType launchedByType,
    required _is.UuidValue launchedById,
    _i6ch5qy5.ActorType? lastPaidByType,
    _is.UuidValue? lastPaidById,
    DateTime? lastPaidAt,
    _i6ch5qy5.ActorType? cancelledByType,
    _is.UuidValue? cancelledById,
    DateTime? cancelledAt,
    _i9x1n0bn.OrderCancellationReason? cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_io4d4iis.VenueOrderItem>? items,
  }) : super._(
         id: id,
         buildingId: buildingId,
         building: building,
         venueTableId: venueTableId,
         venueTable: venueTable,
         ref: ref,
         status: status,
         launchedByType: launchedByType,
         launchedById: launchedById,
         lastPaidByType: lastPaidByType,
         lastPaidById: lastPaidById,
         lastPaidAt: lastPaidAt,
         cancelledByType: cancelledByType,
         cancelledById: cancelledById,
         cancelledAt: cancelledAt,
         cancellationReason: cancellationReason,
         createdAt: createdAt,
         updatedAt: updatedAt,
         items: items,
       );

  /// Returns a shallow copy of this [VenueOrder]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VenueOrder copyWith({
    Object? id = _Undefined,
    _is.UuidValue? buildingId,
    Object? building = _Undefined,
    Object? venueTableId = _Undefined,
    Object? venueTable = _Undefined,
    int? ref,
    _iij1ihnv.OrderStatus? status,
    _i6ch5qy5.ActorType? launchedByType,
    _is.UuidValue? launchedById,
    Object? lastPaidByType = _Undefined,
    Object? lastPaidById = _Undefined,
    Object? lastPaidAt = _Undefined,
    Object? cancelledByType = _Undefined,
    Object? cancelledById = _Undefined,
    Object? cancelledAt = _Undefined,
    Object? cancellationReason = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? items = _Undefined,
  }) {
    return VenueOrder(
      id: id is _is.UuidValue? ? id : this.id,
      buildingId: buildingId ?? this.buildingId,
      building: building is _iaohraio.Building?
          ? building
          : this.building?.copyWith(),
      venueTableId: venueTableId is _is.UuidValue?
          ? venueTableId
          : this.venueTableId,
      venueTable: venueTable is _ilcfc7kr.VenueTable?
          ? venueTable
          : this.venueTable?.copyWith(),
      ref: ref ?? this.ref,
      status: status ?? this.status,
      launchedByType: launchedByType ?? this.launchedByType,
      launchedById: launchedById ?? this.launchedById,
      lastPaidByType: lastPaidByType is _i6ch5qy5.ActorType?
          ? lastPaidByType
          : this.lastPaidByType,
      lastPaidById: lastPaidById is _is.UuidValue?
          ? lastPaidById
          : this.lastPaidById,
      lastPaidAt: lastPaidAt is DateTime? ? lastPaidAt : this.lastPaidAt,
      cancelledByType: cancelledByType is _i6ch5qy5.ActorType?
          ? cancelledByType
          : this.cancelledByType,
      cancelledById: cancelledById is _is.UuidValue?
          ? cancelledById
          : this.cancelledById,
      cancelledAt: cancelledAt is DateTime? ? cancelledAt : this.cancelledAt,
      cancellationReason:
          cancellationReason is _i9x1n0bn.OrderCancellationReason?
          ? cancellationReason
          : this.cancellationReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items is List<_io4d4iis.VenueOrderItem>?
          ? items
          : this.items?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class VenueOrderUpdateTable extends _is.UpdateTable<VenueOrderTable> {
  VenueOrderUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> buildingId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.buildingId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> venueTableId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.venueTableId,
    value,
  );

  _is.ColumnValue<int, int> ref(int value) => _is.ColumnValue(
    table.ref,
    value,
  );

  _is.ColumnValue<_iij1ihnv.OrderStatus, _iij1ihnv.OrderStatus> status(
    _iij1ihnv.OrderStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<_i6ch5qy5.ActorType, _i6ch5qy5.ActorType> launchedByType(
    _i6ch5qy5.ActorType value,
  ) => _is.ColumnValue(
    table.launchedByType,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> launchedById(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.launchedById,
    value,
  );

  _is.ColumnValue<_i6ch5qy5.ActorType, _i6ch5qy5.ActorType> lastPaidByType(
    _i6ch5qy5.ActorType? value,
  ) => _is.ColumnValue(
    table.lastPaidByType,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> lastPaidById(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.lastPaidById,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> lastPaidAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastPaidAt,
        value,
      );

  _is.ColumnValue<_i6ch5qy5.ActorType, _i6ch5qy5.ActorType> cancelledByType(
    _i6ch5qy5.ActorType? value,
  ) => _is.ColumnValue(
    table.cancelledByType,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> cancelledById(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.cancelledById,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> cancelledAt(DateTime? value) =>
      _is.ColumnValue(
        table.cancelledAt,
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

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class VenueOrderTable extends _is.Table<_is.UuidValue?> {
  VenueOrderTable({super.tableRelation}) : super(tableName: 'venue_order') {
    updateTable = VenueOrderUpdateTable(this);
    buildingId = _is.ColumnUuid(
      'buildingId',
      this,
    );
    venueTableId = _is.ColumnUuid(
      'venueTableId',
      this,
    );
    ref = _is.ColumnInt(
      'ref',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    launchedByType = _is.ColumnEnum(
      'launchedByType',
      this,
      _is.EnumSerialization.byName,
    );
    launchedById = _is.ColumnUuid(
      'launchedById',
      this,
    );
    lastPaidByType = _is.ColumnEnum(
      'lastPaidByType',
      this,
      _is.EnumSerialization.byName,
    );
    lastPaidById = _is.ColumnUuid(
      'lastPaidById',
      this,
    );
    lastPaidAt = _is.ColumnDateTime(
      'lastPaidAt',
      this,
    );
    cancelledByType = _is.ColumnEnum(
      'cancelledByType',
      this,
      _is.EnumSerialization.byName,
    );
    cancelledById = _is.ColumnUuid(
      'cancelledById',
      this,
    );
    cancelledAt = _is.ColumnDateTime(
      'cancelledAt',
      this,
    );
    cancellationReason = _is.ColumnEnum(
      'cancellationReason',
      this,
      _is.EnumSerialization.byName,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final VenueOrderUpdateTable updateTable;

  late final _is.ColumnUuid buildingId;

  _iaohraio.BuildingTable? _building;

  late final _is.ColumnUuid venueTableId;

  _ilcfc7kr.VenueTableTable? _venueTable;

  late final _is.ColumnInt ref;

  late final _is.ColumnEnum<_iij1ihnv.OrderStatus> status;

  late final _is.ColumnEnum<_i6ch5qy5.ActorType> launchedByType;

  late final _is.ColumnUuid launchedById;

  late final _is.ColumnEnum<_i6ch5qy5.ActorType> lastPaidByType;

  late final _is.ColumnUuid lastPaidById;

  late final _is.ColumnDateTime lastPaidAt;

  late final _is.ColumnEnum<_i6ch5qy5.ActorType> cancelledByType;

  late final _is.ColumnUuid cancelledById;

  late final _is.ColumnDateTime cancelledAt;

  /// Why the whole order was cancelled. Null until it is cancelled.
  late final _is.ColumnEnum<_i9x1n0bn.OrderCancellationReason>
  cancellationReason;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  _io4d4iis.VenueOrderItemTable? ___items;

  _is.ManyRelation<_io4d4iis.VenueOrderItemTable>? _items;

  _iaohraio.BuildingTable get building {
    if (_building != null) return _building!;
    _building = _is.createRelationTable(
      relationFieldName: 'building',
      field: VenueOrder.t.buildingId,
      foreignField: _iaohraio.Building.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iaohraio.BuildingTable(tableRelation: foreignTableRelation),
    );
    return _building!;
  }

  _ilcfc7kr.VenueTableTable get venueTable {
    if (_venueTable != null) return _venueTable!;
    _venueTable = _is.createRelationTable(
      relationFieldName: 'venueTable',
      field: VenueOrder.t.venueTableId,
      foreignField: _ilcfc7kr.VenueTable.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ilcfc7kr.VenueTableTable(tableRelation: foreignTableRelation),
    );
    return _venueTable!;
  }

  _io4d4iis.VenueOrderItemTable get __items {
    if (___items != null) return ___items!;
    ___items = _is.createRelationTable(
      relationFieldName: '__items',
      field: VenueOrder.t.id,
      foreignField: _io4d4iis.VenueOrderItem.t.orderId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _io4d4iis.VenueOrderItemTable(tableRelation: foreignTableRelation),
    );
    return ___items!;
  }

  _is.ManyRelation<_io4d4iis.VenueOrderItemTable> get items {
    if (_items != null) return _items!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'items',
      field: VenueOrder.t.id,
      foreignField: _io4d4iis.VenueOrderItem.t.orderId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _io4d4iis.VenueOrderItemTable(tableRelation: foreignTableRelation),
    );
    _items = _is.ManyRelation<_io4d4iis.VenueOrderItemTable>(
      tableWithRelations: relationTable,
      table: _io4d4iis.VenueOrderItemTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _items!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    buildingId,
    venueTableId,
    ref,
    status,
    launchedByType,
    launchedById,
    lastPaidByType,
    lastPaidById,
    lastPaidAt,
    cancelledByType,
    cancelledById,
    cancelledAt,
    cancellationReason,
    createdAt,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'building') {
      return building;
    }
    if (relationField == 'venueTable') {
      return venueTable;
    }
    if (relationField == 'items') {
      return __items;
    }
    return null;
  }
}

class VenueOrderInclude extends _is.IncludeObject {
  VenueOrderInclude._({
    _iaohraio.BuildingInclude? building,
    _ilcfc7kr.VenueTableInclude? venueTable,
    _io4d4iis.VenueOrderItemIncludeList? items,
  }) {
    _building = building;
    _venueTable = venueTable;
    _items = items;
  }

  _iaohraio.BuildingInclude? _building;

  _ilcfc7kr.VenueTableInclude? _venueTable;

  _io4d4iis.VenueOrderItemIncludeList? _items;

  @override
  Map<String, _is.Include?> get includes => {
    'building': _building,
    'venueTable': _venueTable,
    'items': _items,
  };

  @override
  _is.Table<_is.UuidValue?> get table => VenueOrder.t;
}

class VenueOrderIncludeList extends _is.IncludeList {
  VenueOrderIncludeList._({
    _is.WhereExpressionBuilder<VenueOrderTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VenueOrder.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => VenueOrder.t;
}

class VenueOrderRepository {
  const VenueOrderRepository._();

  final attach = const VenueOrderAttachRepository._();

  final attachRow = const VenueOrderAttachRowRepository._();

  final detachRow = const VenueOrderDetachRowRepository._();

  /// Returns a list of [VenueOrder]s matching the given query parameters.
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
  Future<List<VenueOrder>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VenueOrderTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VenueOrderTable>? orderBy,
    _is.OrderByListBuilder<VenueOrderTable>? orderByList,
    _is.Transaction? transaction,
    VenueOrderInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VenueOrder>(
      where: where?.call(VenueOrder.t),
      orderBy: orderBy?.call(VenueOrder.t),
      orderByList: orderByList?.call(VenueOrder.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VenueOrder] matching the given query parameters.
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
  Future<VenueOrder?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VenueOrderTable>? where,
    int? offset,
    _is.OrderByBuilder<VenueOrderTable>? orderBy,
    _is.OrderByListBuilder<VenueOrderTable>? orderByList,
    _is.Transaction? transaction,
    VenueOrderInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VenueOrder>(
      where: where?.call(VenueOrder.t),
      orderBy: orderBy?.call(VenueOrder.t),
      orderByList: orderByList?.call(VenueOrder.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VenueOrder] by its [id] or null if no such row exists.
  Future<VenueOrder?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    VenueOrderInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VenueOrder>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VenueOrder]s in the list and returns the inserted rows.
  ///
  /// The returned [VenueOrder]s will have their `id` fields set.
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
  Future<List<VenueOrder>> insert(
    _is.DatabaseSession session,
    List<VenueOrder> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<VenueOrder>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [VenueOrder] and returns the inserted row.
  ///
  /// The returned [VenueOrder] will have its `id` field set.
  Future<VenueOrder> insertRow(
    _is.DatabaseSession session,
    VenueOrder row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<VenueOrder>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [VenueOrder]s in the list and returns the resulting rows.
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
  /// The returned [VenueOrder]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VenueOrder>> upsert(
    _is.DatabaseSession session,
    List<VenueOrder> rows, {
    required _is.ColumnSelections<VenueOrderTable> conflictColumns,
    _is.ColumnSelections<VenueOrderTable>? updateColumns,
    _is.WhereExpressionBuilder<VenueOrderTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<VenueOrder>(
      rows,
      conflictColumns: conflictColumns(VenueOrder.t),
      updateColumns: updateColumns?.call(VenueOrder.t),
      updateWhere: updateWhere?.call(VenueOrder.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [VenueOrder] and returns the resulting row.
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
  /// The returned [VenueOrder] will have its `id` field set.
  Future<VenueOrder?> upsertRow(
    _is.DatabaseSession session,
    VenueOrder row, {
    required _is.ColumnSelections<VenueOrderTable> conflictColumns,
    _is.ColumnSelections<VenueOrderTable>? updateColumns,
    _is.WhereExpressionBuilder<VenueOrderTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<VenueOrder>(
      row,
      conflictColumns: conflictColumns(VenueOrder.t),
      updateColumns: updateColumns?.call(VenueOrder.t),
      updateWhere: updateWhere?.call(VenueOrder.t),
      transaction: transaction,
    );
  }

  /// Updates all [VenueOrder]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VenueOrder>> update(
    _is.DatabaseSession session,
    List<VenueOrder> rows, {
    _is.ColumnSelections<VenueOrderTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<VenueOrder>(
      rows,
      columns: columns?.call(VenueOrder.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [VenueOrder]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VenueOrder> updateRow(
    _is.DatabaseSession session,
    VenueOrder row, {
    _is.ColumnSelections<VenueOrderTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<VenueOrder>(
      row,
      columns: columns?.call(VenueOrder.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VenueOrder] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VenueOrder?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<VenueOrderUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<VenueOrder>(
      id,
      columnValues: columnValues(VenueOrder.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VenueOrder]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VenueOrder>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<VenueOrderUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<VenueOrderTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VenueOrderTable>? orderBy,
    _is.OrderByListBuilder<VenueOrderTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<VenueOrder>(
      columnValues: columnValues(VenueOrder.t.updateTable),
      where: where(VenueOrder.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VenueOrder.t),
      orderByList: orderByList?.call(VenueOrder.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [VenueOrder]s in the list and returns the deleted rows.
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
  Future<List<VenueOrder>> delete(
    _is.DatabaseSession session,
    List<VenueOrder> rows, {
    _is.OrderByBuilder<VenueOrderTable>? orderBy,
    _is.OrderByListBuilder<VenueOrderTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<VenueOrder>(
      rows,
      orderBy: orderBy?.call(VenueOrder.t),
      orderByList: orderByList?.call(VenueOrder.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [VenueOrder].
  Future<VenueOrder> deleteRow(
    _is.DatabaseSession session,
    VenueOrder row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VenueOrder>(
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
  Future<List<VenueOrder>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VenueOrderTable> where,
    _is.OrderByBuilder<VenueOrderTable>? orderBy,
    _is.OrderByListBuilder<VenueOrderTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<VenueOrder>(
      where: where(VenueOrder.t),
      orderBy: orderBy?.call(VenueOrder.t),
      orderByList: orderByList?.call(VenueOrder.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VenueOrderTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<VenueOrder>(
      where: where?.call(VenueOrder.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VenueOrder] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VenueOrderTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VenueOrder>(
      where: where(VenueOrder.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class VenueOrderAttachRepository {
  const VenueOrderAttachRepository._();

  /// Creates a relation between this [VenueOrder] and the given [VenueOrderItem]s
  /// by setting each [VenueOrderItem]'s foreign key `orderId` to refer to this [VenueOrder].
  Future<void> items(
    _is.DatabaseSession session,
    VenueOrder venueOrder,
    List<_io4d4iis.VenueOrderItem> venueOrderItem, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrderItem.any((e) => e.id == null)) {
      throw ArgumentError.notNull('venueOrderItem.id');
    }
    if (venueOrder.id == null) {
      throw ArgumentError.notNull('venueOrder.id');
    }

    var $venueOrderItem = venueOrderItem
        .map((e) => e.copyWith(orderId: venueOrder.id))
        .toList();
    await session.db.update<_io4d4iis.VenueOrderItem>(
      $venueOrderItem,
      columns: [_io4d4iis.VenueOrderItem.t.orderId],
      transaction: transaction,
    );
  }
}

class VenueOrderAttachRowRepository {
  const VenueOrderAttachRowRepository._();

  /// Creates a relation between the given [VenueOrder] and [Building]
  /// by setting the [VenueOrder]'s foreign key `buildingId` to refer to the [Building].
  Future<void> building(
    _is.DatabaseSession session,
    VenueOrder venueOrder,
    _iaohraio.Building building, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrder.id == null) {
      throw ArgumentError.notNull('venueOrder.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $venueOrder = venueOrder.copyWith(buildingId: building.id);
    await session.db.updateRow<VenueOrder>(
      $venueOrder,
      columns: [VenueOrder.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [VenueOrder] and [VenueTable]
  /// by setting the [VenueOrder]'s foreign key `venueTableId` to refer to the [VenueTable].
  Future<void> venueTable(
    _is.DatabaseSession session,
    VenueOrder venueOrder,
    _ilcfc7kr.VenueTable venueTable, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrder.id == null) {
      throw ArgumentError.notNull('venueOrder.id');
    }
    if (venueTable.id == null) {
      throw ArgumentError.notNull('venueTable.id');
    }

    var $venueOrder = venueOrder.copyWith(venueTableId: venueTable.id);
    await session.db.updateRow<VenueOrder>(
      $venueOrder,
      columns: [VenueOrder.t.venueTableId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [VenueOrder] and the given [VenueOrderItem]
  /// by setting the [VenueOrderItem]'s foreign key `orderId` to refer to this [VenueOrder].
  Future<void> items(
    _is.DatabaseSession session,
    VenueOrder venueOrder,
    _io4d4iis.VenueOrderItem venueOrderItem, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrderItem.id == null) {
      throw ArgumentError.notNull('venueOrderItem.id');
    }
    if (venueOrder.id == null) {
      throw ArgumentError.notNull('venueOrder.id');
    }

    var $venueOrderItem = venueOrderItem.copyWith(orderId: venueOrder.id);
    await session.db.updateRow<_io4d4iis.VenueOrderItem>(
      $venueOrderItem,
      columns: [_io4d4iis.VenueOrderItem.t.orderId],
      transaction: transaction,
    );
  }
}

class VenueOrderDetachRowRepository {
  const VenueOrderDetachRowRepository._();

  /// Detaches the relation between this [VenueOrder] and the [VenueTable] set in `venueTable`
  /// by setting the [VenueOrder]'s foreign key `venueTableId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> venueTable(
    _is.DatabaseSession session,
    VenueOrder venueOrder, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrder.id == null) {
      throw ArgumentError.notNull('venueOrder.id');
    }

    var $venueOrder = venueOrder.copyWith(venueTableId: null);
    await session.db.updateRow<VenueOrder>(
      $venueOrder,
      columns: [VenueOrder.t.venueTableId],
      transaction: transaction,
    );
  }
}
