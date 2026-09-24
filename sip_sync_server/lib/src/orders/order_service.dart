import 'package:serverpod/serverpod.dart';

import '../auth/auth_context.dart';
import '../auth/auth_guard.dart';
import '../buildings/strict_mode.dart';
import '../generated/protocol.dart';

/// Create / list / status updates for building orders.
class OrderService {
  /// Lists orders for a building sorted by [VenueOrder.createdAt] newest first.
  Future<List<OrderView>> listForBuilding(
    Session session,
    UuidValue buildingId,
  ) async {
    await _requireBuildingAccess(session, buildingId);
    final rows = await VenueOrder.db.find(
      session,
      where: (t) => t.buildingId.equals(buildingId),
      orderBy: (t) => t.createdAt.desc(),
      include: VenueOrder.include(
        venueTable: VenueTable.include(),
        items: VenueOrderItem.includeList(
          orderBy: (t) => t.createdAt,
        ),
      ),
    );
    final names = await _actorNameCache(session, rows);
    return [
      for (final row in rows) _view(row, names),
    ];
  }

  /// Loads one order with items.
  Future<OrderView> get(Session session, UuidValue orderId) async {
    final row = await _loadOrder(session, orderId);
    await _requireBuildingAccess(session, row.buildingId);
    final names = await _actorNameCache(session, [row]);
    return _view(row, names);
  }

  /// Owner or employee creates an order with at least one line.
  Future<OrderView> create(Session session, OrderCreate request) async {
    final ctx = AuthGuard.requireAny(session);
    _requireFloorActor(ctx);
    await _requireBuildingAccess(session, request.buildingId);
    final lines = _validateLines(request.items);
    final tableId = await _resolveTableId(
      session,
      request.buildingId,
      request.venueTableId,
    );
    await _assertTableAcceptsNewOrder(
      session,
      buildingId: request.buildingId,
      tableId: tableId,
    );
    final articles = await _resolveArticles(
      session,
      request.buildingId,
      lines,
    );
    // Stock first so a shortfall never leaves an empty order row.
    await _syncIngredientStock(
      session,
      buildingId: request.buildingId,
      articleIds: articles.map((a) => a.id!).toList(),
      deduct: true,
    );
    final now = DateTime.now().toUtc();
    final orderRef = await _nextOrderRef(session, request.buildingId);
    final order = await VenueOrder.db.insertRow(
      session,
      VenueOrder(
        buildingId: request.buildingId,
        venueTableId: tableId,
        ref: orderRef,
        status: OrderStatus.progress,
        launchedByType: ctx.actorType,
        launchedById: ctx.actorId,
        createdAt: now,
        updatedAt: now,
      ),
    );
    await _insertResolvedLines(session, order, articles, now);
    return get(session, order.id!);
  }

  /// Adds lines to an open order.
  Future<OrderView> addItems(Session session, OrderAddItems request) async {
    final ctx = AuthGuard.requireAny(session);
    _requireFloorActor(ctx);
    final order = await _loadOrder(session, request.orderId);
    await _requireBuildingAccess(session, order.buildingId);
    if (order.status != OrderStatus.progress) {
      throw OrderException(
        message: 'Only open orders can accept new items.',
        code: OrderErrorCode.invalidStatus,
      );
    }
    final building = await Building.db.findById(session, order.buildingId);
    if (building == null) {
      throw OrderException(
        message: 'Building not found.',
        code: OrderErrorCode.notFound,
      );
    }
    if (!building.allowAppendingItemsToOrder) {
      throw OrderException(
        message: 'Appending articles to this order is not allowed.',
        code: OrderErrorCode.appendNotAllowed,
      );
    }
    final lines = _validateLines(request.items);
    final articles = await _resolveArticles(
      session,
      order.buildingId,
      lines,
    );
    await _syncIngredientStock(
      session,
      buildingId: order.buildingId,
      articleIds: articles.map((a) => a.id!).toList(),
      deduct: true,
    );
    await _insertResolvedLines(
      session,
      order,
      articles,
      DateTime.now().toUtc(),
    );
    await VenueOrder.db.updateRow(
      session,
      order.copyWith(updatedAt: DateTime.now().toUtc()),
    );
    return get(session, order.id!);
  }

  /// Advances or cancels one line; sets attribution timestamps.
  Future<OrderView> updateItemStatus(
    Session session,
    OrderItemStatusUpdate request,
  ) async {
    final ctx = AuthGuard.requireAny(session);
    _requireFloorActor(ctx);
    final item = await VenueOrderItem.db.findById(session, request.id);
    if (item == null) {
      throw OrderException(
        message: 'Order item not found.',
        code: OrderErrorCode.notFound,
      );
    }
    final order = await _loadOrder(session, item.orderId);
    await _requireBuildingAccess(session, order.buildingId);
    if (order.status == OrderStatus.cancelled) {
      throw OrderException(
        message: 'Order is cancelled.',
        code: OrderErrorCode.invalidStatus,
      );
    }
    final building = await Building.db.findById(session, order.buildingId);
    if (building == null) {
      throw OrderException(
        message: 'Building not found.',
        code: OrderErrorCode.notFound,
      );
    }
    _assertItemTransition(
      item.status,
      request.status,
      strictMode: building.strictMode,
      steps: normalizeStrictModeSteps(building.strictModeSteps),
    );

    final now = DateTime.now().toUtc();
    var next = item.copyWith(
      status: request.status,
      updatedAt: now,
    );
    switch (request.status) {
      case OrderItemStatus.picked:
        next = next.copyWith(
          passedByType: ctx.actorType,
          passedById: ctx.actorId,
        );
      case OrderItemStatus.ready:
        next = next.copyWith(
          preparedByType: ctx.actorType,
          preparedById: ctx.actorId,
          preparedAt: now,
        );
      case OrderItemStatus.served:
        next = next.copyWith(
          servedByType: ctx.actorType,
          servedById: ctx.actorId,
          servedAt: now,
        );
      case OrderItemStatus.payed:
        next = next.copyWith(
          paidToType: ctx.actorType,
          paidToId: ctx.actorId,
          paidAt: now,
        );
      case OrderItemStatus.cancelled:
        next = next.copyWith(
          cancelledByType: ctx.actorType,
          cancelledById: ctx.actorId,
          cancelledAt: now,
        );
      case OrderItemStatus.progress:
        break;
    }
    await VenueOrderItem.db.updateRow(session, next);

    if (request.status == OrderItemStatus.cancelled) {
      await _syncIngredientStock(
        session,
        buildingId: order.buildingId,
        articleIds: [item.articleId],
        deduct: false,
      );
    }

    var orderUpdate = order.copyWith(updatedAt: now);
    if (request.status == OrderItemStatus.payed) {
      orderUpdate = orderUpdate.copyWith(
        lastPaidByType: ctx.actorType,
        lastPaidById: ctx.actorId,
        lastPaidAt: now,
      );
    }
    final refreshedItems = await VenueOrderItem.db.find(
      session,
      where: (t) => t.orderId.equals(order.id!),
    );
    orderUpdate = orderUpdate.copyWith(
      status: _deriveOrderStatus(order.status, refreshedItems),
    );
    await VenueOrder.db.updateRow(session, orderUpdate);
    return get(session, order.id!);
  }

  /// Cancels an open order and all non-payed lines.
  Future<OrderView> cancel(Session session, UuidValue orderId) async {
    final ctx = AuthGuard.requireAny(session);
    _requireFloorActor(ctx);
    final order = await _loadOrder(session, orderId);
    await _requireBuildingAccess(session, order.buildingId);
    if (order.status == OrderStatus.payed) {
      throw OrderException(
        message: 'Paid orders cannot be cancelled.',
        code: OrderErrorCode.invalidStatus,
      );
    }
    final now = DateTime.now().toUtc();
    final restoreArticleIds = <UuidValue>[];
    for (final item in order.items ?? const <VenueOrderItem>[]) {
      if (item.status == OrderItemStatus.payed ||
          item.status == OrderItemStatus.cancelled) {
        continue;
      }
      restoreArticleIds.add(item.articleId);
      await VenueOrderItem.db.updateRow(
        session,
        item.copyWith(
          status: OrderItemStatus.cancelled,
          cancelledByType: ctx.actorType,
          cancelledById: ctx.actorId,
          cancelledAt: now,
          updatedAt: now,
        ),
      );
    }
    await _syncIngredientStock(
      session,
      buildingId: order.buildingId,
      articleIds: restoreArticleIds,
      deduct: false,
    );
    await VenueOrder.db.updateRow(
      session,
      order.copyWith(
        status: OrderStatus.cancelled,
        cancelledByType: ctx.actorType,
        cancelledById: ctx.actorId,
        cancelledAt: now,
        updatedAt: now,
      ),
    );
    return get(session, order.id!);
  }

  Future<List<MenuArticle>> _resolveArticles(
    Session session,
    UuidValue buildingId,
    List<OrderItemCreateLine> lines,
  ) async {
    final articles = <MenuArticle>[];
    for (final line in lines) {
      final article = await MenuArticle.db.findById(session, line.articleId);
      if (article == null || article.buildingId != buildingId) {
        throw OrderException(
          message: 'Article not found in this building.',
          code: OrderErrorCode.notFound,
        );
      }
      articles.add(article);
    }
    return articles;
  }

  Future<void> _insertResolvedLines(
    Session session,
    VenueOrder order,
    List<MenuArticle> articles,
    DateTime now,
  ) async {
    for (final article in articles) {
      await VenueOrderItem.db.insertRow(
        session,
        VenueOrderItem(
          orderId: order.id!,
          articleId: article.id!,
          articleName: article.name,
          unitPrice: article.price,
          status: OrderItemStatus.progress,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }
  }

  /// Applies composition quantities to [Ingredient.currentStock] for each article unit.
  ///
  /// Articles with no composition are skipped. [deduct] true on create/append;
  /// false restores stock when a line or order is cancelled.
  Future<void> _syncIngredientStock(
    Session session, {
    required UuidValue buildingId,
    required List<UuidValue> articleIds,
    required bool deduct,
  }) async {
    if (articleIds.isEmpty) return;

    final totals = <UuidValue, double>{};
    for (final articleId in articleIds) {
      final compositions = await ArticleComposition.db.find(
        session,
        where: (t) => t.articleId.equals(articleId),
      );
      for (final line in compositions) {
        totals.update(
          line.ingredientId,
          (v) => v + line.quantity,
          ifAbsent: () => line.quantity,
        );
      }
    }
    if (totals.isEmpty) return;

    for (final entry in totals.entries) {
      final ingredient = await Ingredient.db.findById(session, entry.key);
      if (ingredient == null || ingredient.buildingId != buildingId) {
        throw OrderException(
          message: 'Ingredient not found for article composition.',
          code: OrderErrorCode.notFound,
        );
      }
      final delta = deduct ? -entry.value : entry.value;
      final next = ingredient.currentStock + delta;
      if (deduct && next < 0) {
        throw OrderException(
          message: 'Insufficient stock for ${ingredient.name}.',
          code: OrderErrorCode.insufficientStock,
        );
      }
      await Ingredient.db.updateRow(
        session,
        ingredient.copyWith(currentStock: next),
      );
    }
  }

  List<OrderItemCreateLine> _validateLines(List<OrderItemCreateLine> items) {
    if (items.isEmpty) {
      throw OrderException(
        message: 'Add at least one article.',
        code: OrderErrorCode.invalidInput,
      );
    }
    if (items.length > 200) {
      throw OrderException(
        message: 'Too many items on one order.',
        code: OrderErrorCode.invalidInput,
      );
    }
    return items;
  }

  Future<UuidValue?> _resolveTableId(
    Session session,
    UuidValue buildingId,
    UuidValue? tableId,
  ) async {
    if (tableId == null) {
      return null;
    }
    final table = await VenueTable.db.findById(session, tableId);
    if (table == null || table.buildingId != buildingId || !table.isActive) {
      throw OrderException(
        message: 'Table not found in this building.',
        code: OrderErrorCode.notFound,
      );
    }
    return table.id;
  }

  /// Blocks a second open order on the same table when [Building.tableMultiOrder] is false.
  Future<void> _assertTableAcceptsNewOrder(
    Session session, {
    required UuidValue buildingId,
    required UuidValue? tableId,
  }) async {
    if (tableId == null) return;
    final building = await Building.db.findById(session, buildingId);
    if (building == null) {
      throw OrderException(
        message: 'Building not found.',
        code: OrderErrorCode.notFound,
      );
    }
    if (building.tableMultiOrder) return;
    final openCount = await VenueOrder.db.count(
      session,
      where: (t) =>
          t.venueTableId.equals(tableId) &
          t.status.equals(OrderStatus.progress),
    );
    if (openCount > 0) {
      throw OrderException(
        message: 'This table already has an open order.',
        code: OrderErrorCode.tableOccupied,
      );
    }
  }

  void _assertItemTransition(
    OrderItemStatus from,
    OrderItemStatus to, {
    required bool strictMode,
    required List<StrictModeStep> steps,
  }) {
    if (from == to) {
      return;
    }
    if (from == OrderItemStatus.cancelled || from == OrderItemStatus.payed) {
      throw OrderException(
        message: 'This line can no longer change status.',
        code: OrderErrorCode.invalidStatus,
      );
    }
    if (to == OrderItemStatus.cancelled) {
      return;
    }

    if (!strictMode) {
      final linear = switch (from) {
        OrderItemStatus.progress => OrderItemStatus.picked,
        OrderItemStatus.picked => OrderItemStatus.ready,
        OrderItemStatus.ready => OrderItemStatus.served,
        OrderItemStatus.served => OrderItemStatus.payed,
        OrderItemStatus.payed || OrderItemStatus.cancelled => null,
      };
      // Non-strict: one step forward, or jump straight to payed.
      if (to == linear || to == OrderItemStatus.payed) {
        return;
      }
      throw OrderException(
        message: 'Invalid status change for this line.',
        code: OrderErrorCode.invalidStatus,
      );
    }

    final expected = nextEnabledStrictStatus(from, steps);
    if (expected == null || to != expected) {
      throw OrderException(
        message: 'Invalid status change for this line.',
        code: OrderErrorCode.invalidStatus,
      );
    }
  }

  OrderStatus _deriveOrderStatus(
    OrderStatus current,
    List<VenueOrderItem> items,
  ) {
    if (current == OrderStatus.cancelled) {
      return OrderStatus.cancelled;
    }
    if (items.isEmpty) {
      return OrderStatus.progress;
    }
    final active = items
        .where((i) => i.status != OrderItemStatus.cancelled)
        .toList();
    if (active.isEmpty) {
      return OrderStatus.cancelled;
    }
    if (active.every((i) => i.status == OrderItemStatus.payed)) {
      return OrderStatus.payed;
    }
    return OrderStatus.progress;
  }

  Future<VenueOrder> _loadOrder(Session session, UuidValue orderId) async {
    final row = await VenueOrder.db.findById(
      session,
      orderId,
      include: VenueOrder.include(
        venueTable: VenueTable.include(),
        items: VenueOrderItem.includeList(
          orderBy: (t) => t.createdAt,
        ),
      ),
    );
    if (row == null) {
      throw OrderException(
        message: 'Order not found.',
        code: OrderErrorCode.notFound,
      );
    }
    return row;
  }

  OrderView _view(VenueOrder row, Map<String, ({String first, String last})> names) {
    final items =
        (row.items ?? const <VenueOrderItem>[])
            .map((item) => _itemView(item, names))
            .toList()
          ..sort(_compareOrderItems);
    final total = items.fold<double>(
      0,
      (sum, item) =>
          sum + (item.status == OrderItemStatus.cancelled ? 0 : item.unitPrice),
    );
    return OrderView(
      id: row.id!,
      buildingId: row.buildingId,
      venueTableId: row.venueTableId,
      tableNumber: row.venueTable?.number,
      ref: row.ref,
      status: row.status,
      launchedBy: _actorView(
        type: row.launchedByType,
        id: row.launchedById,
        names: names,
      )!,
      lastPaidBy: _actorView(
        type: row.lastPaidByType,
        id: row.lastPaidById,
        names: names,
      ),
      lastPaidAt: row.lastPaidAt,
      cancelledBy: _actorView(
        type: row.cancelledByType,
        id: row.cancelledById,
        names: names,
      ),
      cancelledAt: row.cancelledAt,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      items: items,
      totalAmount: total,
    );
  }

  OrderItemView _itemView(
    VenueOrderItem row,
    Map<String, ({String first, String last})> names,
  ) => OrderItemView(
    id: row.id!,
    orderId: row.orderId,
    articleId: row.articleId,
    articleName: row.articleName,
    unitPrice: row.unitPrice,
    status: row.status,
    passedBy: _actorView(
      type: row.passedByType,
      id: row.passedById,
      names: names,
    ),
    preparedBy: _actorView(
      type: row.preparedByType,
      id: row.preparedById,
      names: names,
    ),
    servedBy: _actorView(
      type: row.servedByType,
      id: row.servedById,
      names: names,
    ),
    paidTo: _actorView(
      type: row.paidToType,
      id: row.paidToId,
      names: names,
    ),
    cancelledBy: _actorView(
      type: row.cancelledByType,
      id: row.cancelledById,
      names: names,
    ),
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
    preparedAt: row.preparedAt,
    servedAt: row.servedAt,
    paidAt: row.paidAt,
    cancelledAt: row.cancelledAt,
  );

  OrderActorView? _actorView({
    required ActorType? type,
    required UuidValue? id,
    required Map<String, ({String first, String last})> names,
  }) {
    if (type == null || id == null) {
      return null;
    }
    final key = _actorKey(type, id);
    final name = names[key];
    return OrderActorView(
      type: type,
      id: id,
      firstName: name?.first ?? '',
      lastName: name?.last ?? '',
    );
  }

  String _actorKey(ActorType type, UuidValue id) => '${type.name}:${id.uuid}';

  /// Batch-loads first/last names for every attribution id on [rows].
  Future<Map<String, ({String first, String last})>> _actorNameCache(
    Session session,
    List<VenueOrder> rows,
  ) async {
    final ownerIds = <UuidValue>{};
    final employeeIds = <UuidValue>{};
    final customerIds = <UuidValue>{};
    final adminIds = <UuidValue>{};

    void collect(ActorType? type, UuidValue? id) {
      if (type == null || id == null) {
        return;
      }
      switch (type) {
        case ActorType.owner:
          ownerIds.add(id);
        case ActorType.employee:
          employeeIds.add(id);
        case ActorType.customer:
          customerIds.add(id);
        case ActorType.superAdmin:
          adminIds.add(id);
      }
    }

    for (final row in rows) {
      collect(row.launchedByType, row.launchedById);
      collect(row.lastPaidByType, row.lastPaidById);
      collect(row.cancelledByType, row.cancelledById);
      for (final item in row.items ?? const <VenueOrderItem>[]) {
        collect(item.passedByType, item.passedById);
        collect(item.preparedByType, item.preparedById);
        collect(item.servedByType, item.servedById);
        collect(item.paidToType, item.paidToId);
        collect(item.cancelledByType, item.cancelledById);
      }
    }

    final out = <String, ({String first, String last})>{};
    if (ownerIds.isNotEmpty) {
      final owners = await Owner.db.find(
        session,
        where: (t) => t.id.inSet(ownerIds),
      );
      for (final owner in owners) {
        out[_actorKey(ActorType.owner, owner.id!)] = (
          first: owner.firstName,
          last: owner.lastName,
        );
      }
    }
    if (employeeIds.isNotEmpty) {
      final employees = await Employee.db.find(
        session,
        where: (t) => t.id.inSet(employeeIds),
      );
      for (final employee in employees) {
        out[_actorKey(ActorType.employee, employee.id!)] = (
          first: employee.firstName,
          last: employee.lastName,
        );
      }
    }
    if (customerIds.isNotEmpty) {
      final customers = await Customer.db.find(
        session,
        where: (t) => t.id.inSet(customerIds),
      );
      for (final customer in customers) {
        out[_actorKey(ActorType.customer, customer.id!)] = (
          first: customer.firstName,
          last: customer.lastName,
        );
      }
    }
    if (adminIds.isNotEmpty) {
      final admins = await SuperAdmin.db.find(
        session,
        where: (t) => t.id.inSet(adminIds),
      );
      for (final admin in admins) {
        out[_actorKey(ActorType.superAdmin, admin.id!)] = (
          first: admin.firstName,
          last: admin.lastName,
        );
      }
    }
    return out;
  }

  /// Next display ticket number for [buildingId] (1, 2, 3…).
  Future<int> _nextOrderRef(Session session, UuidValue buildingId) async {
    final last = await VenueOrder.db.findFirstRow(
      session,
      where: (t) => t.buildingId.equals(buildingId),
      orderBy: (t) => t.ref.desc(),
    );
    return (last?.ref ?? 0) + 1;
  }

  /// Active lines stay in [createdAt] order (stable by id); payed sinks to the bottom.
  int _compareOrderItems(OrderItemView a, OrderItemView b) {
    final aPaid = a.status == OrderItemStatus.payed;
    final bPaid = b.status == OrderItemStatus.payed;
    if (aPaid != bPaid) {
      return aPaid ? 1 : -1;
    }
    if (aPaid && bPaid) {
      final pa = a.paidAt;
      final pb = b.paidAt;
      if (pa != null && pb != null) {
        final byPaid = pb.compareTo(pa);
        if (byPaid != 0) return byPaid;
      } else if (pa != null) {
        return -1;
      } else if (pb != null) {
        return 1;
      }
    }
    final byCreated = a.createdAt.compareTo(b.createdAt);
    if (byCreated != 0) return byCreated;
    return a.id.uuid.compareTo(b.id.uuid);
  }

  void _requireFloorActor(AuthContext ctx) {
    if (ctx.actorType != ActorType.owner &&
        ctx.actorType != ActorType.employee) {
      throw OrderException(
        message: 'Only owners and employees can manage orders.',
        code: OrderErrorCode.notAuthorized,
      );
    }
  }

  Future<void> _requireBuildingAccess(
    Session session,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null) {
      throw OrderException(
        message: 'Building not found.',
        code: OrderErrorCode.notFound,
      );
    }
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType == ActorType.owner && building.ownerId == ctx.actorId) {
      return;
    }
    if (ctx.actorType == ActorType.employee) {
      final employee = await Employee.db.findById(session, ctx.actorId);
      if (employee != null && employee.buildingId == buildingId) {
        return;
      }
    }
    throw OrderException(
      message: 'Not allowed for this building.',
      code: OrderErrorCode.notAuthorized,
    );
  }
}
