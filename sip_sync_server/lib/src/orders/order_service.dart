import 'package:serverpod/serverpod.dart';

import '../auth/auth_context.dart';
import '../auth/auth_guard.dart';
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
    return rows.map(_view).toList();
  }

  /// Loads one order with items.
  Future<OrderView> get(Session session, UuidValue orderId) async {
    final row = await _loadOrder(session, orderId);
    await _requireBuildingAccess(session, row.buildingId);
    return _view(row);
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
    final order = await VenueOrder.db.insertRow(
      session,
      VenueOrder(
        buildingId: request.buildingId,
        venueTableId: tableId,
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
    _assertItemTransition(item.status, request.status);

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

  void _assertItemTransition(OrderItemStatus from, OrderItemStatus to) {
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
    const forward = {
      OrderItemStatus.progress: {
        OrderItemStatus.picked,
        OrderItemStatus.cancelled,
      },
      OrderItemStatus.picked: {
        OrderItemStatus.ready,
        OrderItemStatus.cancelled,
      },
      OrderItemStatus.ready: {
        OrderItemStatus.served,
        OrderItemStatus.cancelled,
      },
      OrderItemStatus.served: {
        OrderItemStatus.payed,
        OrderItemStatus.cancelled,
      },
    };
    final allowed = forward[from] ?? const <OrderItemStatus>{};
    if (!allowed.contains(to)) {
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

  OrderView _view(VenueOrder row) {
    final items =
        (row.items ?? const <VenueOrderItem>[]).map(_itemView).toList()
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
      status: row.status,
      launchedByType: row.launchedByType,
      launchedById: row.launchedById,
      lastPaidByType: row.lastPaidByType,
      lastPaidById: row.lastPaidById,
      lastPaidAt: row.lastPaidAt,
      cancelledByType: row.cancelledByType,
      cancelledById: row.cancelledById,
      cancelledAt: row.cancelledAt,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      items: items,
      totalAmount: total,
    );
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
    // Stable tie-break — Dart's sort is not stable for equal keys.
    return a.id.uuid.compareTo(b.id.uuid);
  }

  OrderItemView _itemView(VenueOrderItem row) => OrderItemView(
    id: row.id!,
    orderId: row.orderId,
    articleId: row.articleId,
    articleName: row.articleName,
    unitPrice: row.unitPrice,
    status: row.status,
    passedByType: row.passedByType,
    passedById: row.passedById,
    preparedByType: row.preparedByType,
    preparedById: row.preparedById,
    servedByType: row.servedByType,
    servedById: row.servedById,
    paidToType: row.paidToType,
    paidToId: row.paidToId,
    cancelledByType: row.cancelledByType,
    cancelledById: row.cancelledById,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
    preparedAt: row.preparedAt,
    servedAt: row.servedAt,
    paidAt: row.paidAt,
    cancelledAt: row.cancelledAt,
  );

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
