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
import '../../menu/entity/menu_article.dart' as _is7gdyz6;
import '../../orders/dtos/order_item_status.dart' as _iw3cmuga;
import '../../orders/entity/venue_order.dart' as _iwamn8sj;

/// One article unit on an order (repeat the article for multiple units).
abstract class VenueOrderItem
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  VenueOrderItem._({
    this.id,
    required this.orderId,
    this.order,
    required this.articleId,
    this.article,
    required this.articleName,
    required this.unitPrice,
    required this.status,
    this.passedByType,
    this.passedById,
    this.preparedByType,
    this.preparedById,
    this.servedByType,
    this.servedById,
    this.paidToType,
    this.paidToId,
    this.cancelledByType,
    this.cancelledById,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.preparedAt,
    this.servedAt,
    this.paidAt,
    this.cancelledAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory VenueOrderItem({
    _is.UuidValue? id,
    required _is.UuidValue orderId,
    _iwamn8sj.VenueOrder? order,
    required _is.UuidValue articleId,
    _is7gdyz6.MenuArticle? article,
    required String articleName,
    required double unitPrice,
    required _iw3cmuga.OrderItemStatus status,
    _i6ch5qy5.ActorType? passedByType,
    _is.UuidValue? passedById,
    _i6ch5qy5.ActorType? preparedByType,
    _is.UuidValue? preparedById,
    _i6ch5qy5.ActorType? servedByType,
    _is.UuidValue? servedById,
    _i6ch5qy5.ActorType? paidToType,
    _is.UuidValue? paidToId,
    _i6ch5qy5.ActorType? cancelledByType,
    _is.UuidValue? cancelledById,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? preparedAt,
    DateTime? servedAt,
    DateTime? paidAt,
    DateTime? cancelledAt,
  }) = _VenueOrderItemImpl;

  factory VenueOrderItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return VenueOrderItem(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      orderId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['orderId'],
      ),
      order: jsonSerialization['order'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_iwamn8sj.VenueOrder>(
              jsonSerialization['order'],
            ),
      articleId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['articleId'],
      ),
      article: jsonSerialization['article'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_is7gdyz6.MenuArticle>(
              jsonSerialization['article'],
            ),
      articleName: jsonSerialization['articleName'] as String,
      unitPrice: (jsonSerialization['unitPrice'] as num).toDouble(),
      status: _iw3cmuga.OrderItemStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      passedByType: jsonSerialization['passedByType'] == null
          ? null
          : _i6ch5qy5.ActorType.fromJson(
              (jsonSerialization['passedByType'] as String),
            ),
      passedById: jsonSerialization['passedById'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['passedById'],
            ),
      preparedByType: jsonSerialization['preparedByType'] == null
          ? null
          : _i6ch5qy5.ActorType.fromJson(
              (jsonSerialization['preparedByType'] as String),
            ),
      preparedById: jsonSerialization['preparedById'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['preparedById'],
            ),
      servedByType: jsonSerialization['servedByType'] == null
          ? null
          : _i6ch5qy5.ActorType.fromJson(
              (jsonSerialization['servedByType'] as String),
            ),
      servedById: jsonSerialization['servedById'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['servedById'],
            ),
      paidToType: jsonSerialization['paidToType'] == null
          ? null
          : _i6ch5qy5.ActorType.fromJson(
              (jsonSerialization['paidToType'] as String),
            ),
      paidToId: jsonSerialization['paidToId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['paidToId']),
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
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      preparedAt: jsonSerialization['preparedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['preparedAt']),
      servedAt: jsonSerialization['servedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['servedAt']),
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      cancelledAt: jsonSerialization['cancelledAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['cancelledAt'],
            ),
    );
  }

  static final t = VenueOrderItemTable();

  static const db = VenueOrderItemRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue orderId;

  _iwamn8sj.VenueOrder? order;

  _is.UuidValue articleId;

  _is7gdyz6.MenuArticle? article;

  String articleName;

  double unitPrice;

  _iw3cmuga.OrderItemStatus status;

  _i6ch5qy5.ActorType? passedByType;

  _is.UuidValue? passedById;

  _i6ch5qy5.ActorType? preparedByType;

  _is.UuidValue? preparedById;

  _i6ch5qy5.ActorType? servedByType;

  _is.UuidValue? servedById;

  _i6ch5qy5.ActorType? paidToType;

  _is.UuidValue? paidToId;

  _i6ch5qy5.ActorType? cancelledByType;

  _is.UuidValue? cancelledById;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? preparedAt;

  DateTime? servedAt;

  DateTime? paidAt;

  DateTime? cancelledAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [VenueOrderItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VenueOrderItem copyWith({
    _is.UuidValue? id,
    _is.UuidValue? orderId,
    _iwamn8sj.VenueOrder? order,
    _is.UuidValue? articleId,
    _is7gdyz6.MenuArticle? article,
    String? articleName,
    double? unitPrice,
    _iw3cmuga.OrderItemStatus? status,
    _i6ch5qy5.ActorType? passedByType,
    _is.UuidValue? passedById,
    _i6ch5qy5.ActorType? preparedByType,
    _is.UuidValue? preparedById,
    _i6ch5qy5.ActorType? servedByType,
    _is.UuidValue? servedById,
    _i6ch5qy5.ActorType? paidToType,
    _is.UuidValue? paidToId,
    _i6ch5qy5.ActorType? cancelledByType,
    _is.UuidValue? cancelledById,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? preparedAt,
    DateTime? servedAt,
    DateTime? paidAt,
    DateTime? cancelledAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VenueOrderItem',
      if (id != null) 'id': id?.toJson(),
      'orderId': orderId.toJson(),
      if (order != null) 'order': order?.toJson(),
      'articleId': articleId.toJson(),
      if (article != null) 'article': article?.toJson(),
      'articleName': articleName,
      'unitPrice': unitPrice,
      'status': status.toJson(),
      if (passedByType != null) 'passedByType': passedByType?.toJson(),
      if (passedById != null) 'passedById': passedById?.toJson(),
      if (preparedByType != null) 'preparedByType': preparedByType?.toJson(),
      if (preparedById != null) 'preparedById': preparedById?.toJson(),
      if (servedByType != null) 'servedByType': servedByType?.toJson(),
      if (servedById != null) 'servedById': servedById?.toJson(),
      if (paidToType != null) 'paidToType': paidToType?.toJson(),
      if (paidToId != null) 'paidToId': paidToId?.toJson(),
      if (cancelledByType != null) 'cancelledByType': cancelledByType?.toJson(),
      if (cancelledById != null) 'cancelledById': cancelledById?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (preparedAt != null) 'preparedAt': preparedAt?.toJson(),
      if (servedAt != null) 'servedAt': servedAt?.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static VenueOrderItemInclude include({
    _iwamn8sj.VenueOrderInclude? order,
    _is7gdyz6.MenuArticleInclude? article,
  }) {
    return VenueOrderItemInclude._(
      order: order,
      article: article,
    );
  }

  static VenueOrderItemIncludeList includeList({
    _is.WhereExpressionBuilder<VenueOrderItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VenueOrderItemTable>? orderBy,
    _is.OrderByListBuilder<VenueOrderItemTable>? orderByList,
    VenueOrderItemInclude? include,
  }) {
    return VenueOrderItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VenueOrderItem.t),
      orderByList: orderByList?.call(VenueOrderItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VenueOrderItemImpl extends VenueOrderItem {
  _VenueOrderItemImpl({
    _is.UuidValue? id,
    required _is.UuidValue orderId,
    _iwamn8sj.VenueOrder? order,
    required _is.UuidValue articleId,
    _is7gdyz6.MenuArticle? article,
    required String articleName,
    required double unitPrice,
    required _iw3cmuga.OrderItemStatus status,
    _i6ch5qy5.ActorType? passedByType,
    _is.UuidValue? passedById,
    _i6ch5qy5.ActorType? preparedByType,
    _is.UuidValue? preparedById,
    _i6ch5qy5.ActorType? servedByType,
    _is.UuidValue? servedById,
    _i6ch5qy5.ActorType? paidToType,
    _is.UuidValue? paidToId,
    _i6ch5qy5.ActorType? cancelledByType,
    _is.UuidValue? cancelledById,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? preparedAt,
    DateTime? servedAt,
    DateTime? paidAt,
    DateTime? cancelledAt,
  }) : super._(
         id: id,
         orderId: orderId,
         order: order,
         articleId: articleId,
         article: article,
         articleName: articleName,
         unitPrice: unitPrice,
         status: status,
         passedByType: passedByType,
         passedById: passedById,
         preparedByType: preparedByType,
         preparedById: preparedById,
         servedByType: servedByType,
         servedById: servedById,
         paidToType: paidToType,
         paidToId: paidToId,
         cancelledByType: cancelledByType,
         cancelledById: cancelledById,
         createdAt: createdAt,
         updatedAt: updatedAt,
         preparedAt: preparedAt,
         servedAt: servedAt,
         paidAt: paidAt,
         cancelledAt: cancelledAt,
       );

  /// Returns a shallow copy of this [VenueOrderItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VenueOrderItem copyWith({
    Object? id = _Undefined,
    _is.UuidValue? orderId,
    Object? order = _Undefined,
    _is.UuidValue? articleId,
    Object? article = _Undefined,
    String? articleName,
    double? unitPrice,
    _iw3cmuga.OrderItemStatus? status,
    Object? passedByType = _Undefined,
    Object? passedById = _Undefined,
    Object? preparedByType = _Undefined,
    Object? preparedById = _Undefined,
    Object? servedByType = _Undefined,
    Object? servedById = _Undefined,
    Object? paidToType = _Undefined,
    Object? paidToId = _Undefined,
    Object? cancelledByType = _Undefined,
    Object? cancelledById = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? preparedAt = _Undefined,
    Object? servedAt = _Undefined,
    Object? paidAt = _Undefined,
    Object? cancelledAt = _Undefined,
  }) {
    return VenueOrderItem(
      id: id is _is.UuidValue? ? id : this.id,
      orderId: orderId ?? this.orderId,
      order: order is _iwamn8sj.VenueOrder? ? order : this.order?.copyWith(),
      articleId: articleId ?? this.articleId,
      article: article is _is7gdyz6.MenuArticle?
          ? article
          : this.article?.copyWith(),
      articleName: articleName ?? this.articleName,
      unitPrice: unitPrice ?? this.unitPrice,
      status: status ?? this.status,
      passedByType: passedByType is _i6ch5qy5.ActorType?
          ? passedByType
          : this.passedByType,
      passedById: passedById is _is.UuidValue? ? passedById : this.passedById,
      preparedByType: preparedByType is _i6ch5qy5.ActorType?
          ? preparedByType
          : this.preparedByType,
      preparedById: preparedById is _is.UuidValue?
          ? preparedById
          : this.preparedById,
      servedByType: servedByType is _i6ch5qy5.ActorType?
          ? servedByType
          : this.servedByType,
      servedById: servedById is _is.UuidValue? ? servedById : this.servedById,
      paidToType: paidToType is _i6ch5qy5.ActorType?
          ? paidToType
          : this.paidToType,
      paidToId: paidToId is _is.UuidValue? ? paidToId : this.paidToId,
      cancelledByType: cancelledByType is _i6ch5qy5.ActorType?
          ? cancelledByType
          : this.cancelledByType,
      cancelledById: cancelledById is _is.UuidValue?
          ? cancelledById
          : this.cancelledById,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      preparedAt: preparedAt is DateTime? ? preparedAt : this.preparedAt,
      servedAt: servedAt is DateTime? ? servedAt : this.servedAt,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
      cancelledAt: cancelledAt is DateTime? ? cancelledAt : this.cancelledAt,
    );
  }
}

class VenueOrderItemUpdateTable extends _is.UpdateTable<VenueOrderItemTable> {
  VenueOrderItemUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> orderId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.orderId,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> articleId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.articleId,
    value,
  );

  _is.ColumnValue<String, String> articleName(String value) => _is.ColumnValue(
    table.articleName,
    value,
  );

  _is.ColumnValue<double, double> unitPrice(double value) => _is.ColumnValue(
    table.unitPrice,
    value,
  );

  _is.ColumnValue<_iw3cmuga.OrderItemStatus, _iw3cmuga.OrderItemStatus> status(
    _iw3cmuga.OrderItemStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<_i6ch5qy5.ActorType, _i6ch5qy5.ActorType> passedByType(
    _i6ch5qy5.ActorType? value,
  ) => _is.ColumnValue(
    table.passedByType,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> passedById(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.passedById,
    value,
  );

  _is.ColumnValue<_i6ch5qy5.ActorType, _i6ch5qy5.ActorType> preparedByType(
    _i6ch5qy5.ActorType? value,
  ) => _is.ColumnValue(
    table.preparedByType,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> preparedById(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.preparedById,
    value,
  );

  _is.ColumnValue<_i6ch5qy5.ActorType, _i6ch5qy5.ActorType> servedByType(
    _i6ch5qy5.ActorType? value,
  ) => _is.ColumnValue(
    table.servedByType,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> servedById(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.servedById,
    value,
  );

  _is.ColumnValue<_i6ch5qy5.ActorType, _i6ch5qy5.ActorType> paidToType(
    _i6ch5qy5.ActorType? value,
  ) => _is.ColumnValue(
    table.paidToType,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> paidToId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.paidToId,
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

  _is.ColumnValue<DateTime, DateTime> preparedAt(DateTime? value) =>
      _is.ColumnValue(
        table.preparedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> servedAt(DateTime? value) =>
      _is.ColumnValue(
        table.servedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> paidAt(DateTime? value) =>
      _is.ColumnValue(
        table.paidAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> cancelledAt(DateTime? value) =>
      _is.ColumnValue(
        table.cancelledAt,
        value,
      );
}

class VenueOrderItemTable extends _is.Table<_is.UuidValue?> {
  VenueOrderItemTable({super.tableRelation})
    : super(tableName: 'venue_order_item') {
    updateTable = VenueOrderItemUpdateTable(this);
    orderId = _is.ColumnUuid(
      'orderId',
      this,
    );
    articleId = _is.ColumnUuid(
      'articleId',
      this,
    );
    articleName = _is.ColumnString(
      'articleName',
      this,
    );
    unitPrice = _is.ColumnDouble(
      'unitPrice',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    passedByType = _is.ColumnEnum(
      'passedByType',
      this,
      _is.EnumSerialization.byName,
    );
    passedById = _is.ColumnUuid(
      'passedById',
      this,
    );
    preparedByType = _is.ColumnEnum(
      'preparedByType',
      this,
      _is.EnumSerialization.byName,
    );
    preparedById = _is.ColumnUuid(
      'preparedById',
      this,
    );
    servedByType = _is.ColumnEnum(
      'servedByType',
      this,
      _is.EnumSerialization.byName,
    );
    servedById = _is.ColumnUuid(
      'servedById',
      this,
    );
    paidToType = _is.ColumnEnum(
      'paidToType',
      this,
      _is.EnumSerialization.byName,
    );
    paidToId = _is.ColumnUuid(
      'paidToId',
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
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
    preparedAt = _is.ColumnDateTime(
      'preparedAt',
      this,
    );
    servedAt = _is.ColumnDateTime(
      'servedAt',
      this,
    );
    paidAt = _is.ColumnDateTime(
      'paidAt',
      this,
    );
    cancelledAt = _is.ColumnDateTime(
      'cancelledAt',
      this,
    );
  }

  late final VenueOrderItemUpdateTable updateTable;

  late final _is.ColumnUuid orderId;

  _iwamn8sj.VenueOrderTable? _order;

  late final _is.ColumnUuid articleId;

  _is7gdyz6.MenuArticleTable? _article;

  late final _is.ColumnString articleName;

  late final _is.ColumnDouble unitPrice;

  late final _is.ColumnEnum<_iw3cmuga.OrderItemStatus> status;

  late final _is.ColumnEnum<_i6ch5qy5.ActorType> passedByType;

  late final _is.ColumnUuid passedById;

  late final _is.ColumnEnum<_i6ch5qy5.ActorType> preparedByType;

  late final _is.ColumnUuid preparedById;

  late final _is.ColumnEnum<_i6ch5qy5.ActorType> servedByType;

  late final _is.ColumnUuid servedById;

  late final _is.ColumnEnum<_i6ch5qy5.ActorType> paidToType;

  late final _is.ColumnUuid paidToId;

  late final _is.ColumnEnum<_i6ch5qy5.ActorType> cancelledByType;

  late final _is.ColumnUuid cancelledById;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnDateTime preparedAt;

  late final _is.ColumnDateTime servedAt;

  late final _is.ColumnDateTime paidAt;

  late final _is.ColumnDateTime cancelledAt;

  _iwamn8sj.VenueOrderTable get order {
    if (_order != null) return _order!;
    _order = _is.createRelationTable(
      relationFieldName: 'order',
      field: VenueOrderItem.t.orderId,
      foreignField: _iwamn8sj.VenueOrder.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iwamn8sj.VenueOrderTable(tableRelation: foreignTableRelation),
    );
    return _order!;
  }

  _is7gdyz6.MenuArticleTable get article {
    if (_article != null) return _article!;
    _article = _is.createRelationTable(
      relationFieldName: 'article',
      field: VenueOrderItem.t.articleId,
      foreignField: _is7gdyz6.MenuArticle.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _is7gdyz6.MenuArticleTable(tableRelation: foreignTableRelation),
    );
    return _article!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    orderId,
    articleId,
    articleName,
    unitPrice,
    status,
    passedByType,
    passedById,
    preparedByType,
    preparedById,
    servedByType,
    servedById,
    paidToType,
    paidToId,
    cancelledByType,
    cancelledById,
    createdAt,
    updatedAt,
    preparedAt,
    servedAt,
    paidAt,
    cancelledAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'order') {
      return order;
    }
    if (relationField == 'article') {
      return article;
    }
    return null;
  }
}

class VenueOrderItemInclude extends _is.IncludeObject {
  VenueOrderItemInclude._({
    _iwamn8sj.VenueOrderInclude? order,
    _is7gdyz6.MenuArticleInclude? article,
  }) {
    _order = order;
    _article = article;
  }

  _iwamn8sj.VenueOrderInclude? _order;

  _is7gdyz6.MenuArticleInclude? _article;

  @override
  Map<String, _is.Include?> get includes => {
    'order': _order,
    'article': _article,
  };

  @override
  _is.Table<_is.UuidValue?> get table => VenueOrderItem.t;
}

class VenueOrderItemIncludeList extends _is.IncludeList {
  VenueOrderItemIncludeList._({
    _is.WhereExpressionBuilder<VenueOrderItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VenueOrderItem.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => VenueOrderItem.t;
}

class VenueOrderItemRepository {
  const VenueOrderItemRepository._();

  final attachRow = const VenueOrderItemAttachRowRepository._();

  /// Returns a list of [VenueOrderItem]s matching the given query parameters.
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
  Future<List<VenueOrderItem>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VenueOrderItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VenueOrderItemTable>? orderBy,
    _is.OrderByListBuilder<VenueOrderItemTable>? orderByList,
    _is.Transaction? transaction,
    VenueOrderItemInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VenueOrderItem>(
      where: where?.call(VenueOrderItem.t),
      orderBy: orderBy?.call(VenueOrderItem.t),
      orderByList: orderByList?.call(VenueOrderItem.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VenueOrderItem] matching the given query parameters.
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
  Future<VenueOrderItem?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VenueOrderItemTable>? where,
    int? offset,
    _is.OrderByBuilder<VenueOrderItemTable>? orderBy,
    _is.OrderByListBuilder<VenueOrderItemTable>? orderByList,
    _is.Transaction? transaction,
    VenueOrderItemInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VenueOrderItem>(
      where: where?.call(VenueOrderItem.t),
      orderBy: orderBy?.call(VenueOrderItem.t),
      orderByList: orderByList?.call(VenueOrderItem.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VenueOrderItem] by its [id] or null if no such row exists.
  Future<VenueOrderItem?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    VenueOrderItemInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VenueOrderItem>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VenueOrderItem]s in the list and returns the inserted rows.
  ///
  /// The returned [VenueOrderItem]s will have their `id` fields set.
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
  Future<List<VenueOrderItem>> insert(
    _is.DatabaseSession session,
    List<VenueOrderItem> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<VenueOrderItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [VenueOrderItem] and returns the inserted row.
  ///
  /// The returned [VenueOrderItem] will have its `id` field set.
  Future<VenueOrderItem> insertRow(
    _is.DatabaseSession session,
    VenueOrderItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<VenueOrderItem>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [VenueOrderItem]s in the list and returns the resulting rows.
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
  /// The returned [VenueOrderItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VenueOrderItem>> upsert(
    _is.DatabaseSession session,
    List<VenueOrderItem> rows, {
    required _is.ColumnSelections<VenueOrderItemTable> conflictColumns,
    _is.ColumnSelections<VenueOrderItemTable>? updateColumns,
    _is.WhereExpressionBuilder<VenueOrderItemTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<VenueOrderItem>(
      rows,
      conflictColumns: conflictColumns(VenueOrderItem.t),
      updateColumns: updateColumns?.call(VenueOrderItem.t),
      updateWhere: updateWhere?.call(VenueOrderItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [VenueOrderItem] and returns the resulting row.
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
  /// The returned [VenueOrderItem] will have its `id` field set.
  Future<VenueOrderItem?> upsertRow(
    _is.DatabaseSession session,
    VenueOrderItem row, {
    required _is.ColumnSelections<VenueOrderItemTable> conflictColumns,
    _is.ColumnSelections<VenueOrderItemTable>? updateColumns,
    _is.WhereExpressionBuilder<VenueOrderItemTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<VenueOrderItem>(
      row,
      conflictColumns: conflictColumns(VenueOrderItem.t),
      updateColumns: updateColumns?.call(VenueOrderItem.t),
      updateWhere: updateWhere?.call(VenueOrderItem.t),
      transaction: transaction,
    );
  }

  /// Updates all [VenueOrderItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VenueOrderItem>> update(
    _is.DatabaseSession session,
    List<VenueOrderItem> rows, {
    _is.ColumnSelections<VenueOrderItemTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<VenueOrderItem>(
      rows,
      columns: columns?.call(VenueOrderItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [VenueOrderItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VenueOrderItem> updateRow(
    _is.DatabaseSession session,
    VenueOrderItem row, {
    _is.ColumnSelections<VenueOrderItemTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<VenueOrderItem>(
      row,
      columns: columns?.call(VenueOrderItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VenueOrderItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VenueOrderItem?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<VenueOrderItemUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<VenueOrderItem>(
      id,
      columnValues: columnValues(VenueOrderItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VenueOrderItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VenueOrderItem>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<VenueOrderItemUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<VenueOrderItemTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VenueOrderItemTable>? orderBy,
    _is.OrderByListBuilder<VenueOrderItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<VenueOrderItem>(
      columnValues: columnValues(VenueOrderItem.t.updateTable),
      where: where(VenueOrderItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VenueOrderItem.t),
      orderByList: orderByList?.call(VenueOrderItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [VenueOrderItem]s in the list and returns the deleted rows.
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
  Future<List<VenueOrderItem>> delete(
    _is.DatabaseSession session,
    List<VenueOrderItem> rows, {
    _is.OrderByBuilder<VenueOrderItemTable>? orderBy,
    _is.OrderByListBuilder<VenueOrderItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<VenueOrderItem>(
      rows,
      orderBy: orderBy?.call(VenueOrderItem.t),
      orderByList: orderByList?.call(VenueOrderItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [VenueOrderItem].
  Future<VenueOrderItem> deleteRow(
    _is.DatabaseSession session,
    VenueOrderItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VenueOrderItem>(
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
  Future<List<VenueOrderItem>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VenueOrderItemTable> where,
    _is.OrderByBuilder<VenueOrderItemTable>? orderBy,
    _is.OrderByListBuilder<VenueOrderItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<VenueOrderItem>(
      where: where(VenueOrderItem.t),
      orderBy: orderBy?.call(VenueOrderItem.t),
      orderByList: orderByList?.call(VenueOrderItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VenueOrderItemTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<VenueOrderItem>(
      where: where?.call(VenueOrderItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VenueOrderItem] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VenueOrderItemTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VenueOrderItem>(
      where: where(VenueOrderItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class VenueOrderItemAttachRowRepository {
  const VenueOrderItemAttachRowRepository._();

  /// Creates a relation between the given [VenueOrderItem] and [VenueOrder]
  /// by setting the [VenueOrderItem]'s foreign key `orderId` to refer to the [VenueOrder].
  Future<void> order(
    _is.DatabaseSession session,
    VenueOrderItem venueOrderItem,
    _iwamn8sj.VenueOrder order, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrderItem.id == null) {
      throw ArgumentError.notNull('venueOrderItem.id');
    }
    if (order.id == null) {
      throw ArgumentError.notNull('order.id');
    }

    var $venueOrderItem = venueOrderItem.copyWith(orderId: order.id);
    await session.db.updateRow<VenueOrderItem>(
      $venueOrderItem,
      columns: [VenueOrderItem.t.orderId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [VenueOrderItem] and [MenuArticle]
  /// by setting the [VenueOrderItem]'s foreign key `articleId` to refer to the [MenuArticle].
  Future<void> article(
    _is.DatabaseSession session,
    VenueOrderItem venueOrderItem,
    _is7gdyz6.MenuArticle article, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrderItem.id == null) {
      throw ArgumentError.notNull('venueOrderItem.id');
    }
    if (article.id == null) {
      throw ArgumentError.notNull('article.id');
    }

    var $venueOrderItem = venueOrderItem.copyWith(articleId: article.id);
    await session.db.updateRow<VenueOrderItem>(
      $venueOrderItem,
      columns: [VenueOrderItem.t.articleId],
      transaction: transaction,
    );
  }
}
