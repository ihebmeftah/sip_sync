import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../auth/auth_context.dart';
import '../auth/auth_guard.dart';
import '../buildings/strict_mode.dart';
import '../core/page_window.dart';
import '../generated/protocol.dart';
import '../notifications/notification_service.dart';
import '../packs/pack_gate.dart';

/// Create / list / status updates for building orders.
class OrderService {
  final _notifications = NotificationService();

  /// Channel for one building's floor board. Not derived from the client.
  static String boardChannel(UuidValue buildingId) =>
      'order-board:${buildingId.uuid}';

  /// Channel for one customer's open visit. Keyed by the customer actor id.
  static String customerOrderChannel(UuidValue customerId) =>
      'customer-order:${customerId.uuid}';

  /// Lists orders for a building sorted by [VenueOrder.createdAt] newest first.
  ///
  /// Optional [status] and [venueTableId] filter in the database, including
  /// the employee visibility rule, so a page is not shortened after the read.
  Future<OrderPage> listForBuilding(
    Session session,
    UuidValue buildingId, {
    OrderStatus? status,
    UuidValue? venueTableId,
    int? limit,
    int? offset,
  }) async {
    await _requireBuildingAccess(session, buildingId);
    final ctx = AuthGuard.requireAny(session);
    final access = await _requireEmployeeAccessIfNeeded(session, ctx);
    final window = PageWindow.from(limit: limit, offset: offset);
    final restricted = access != null && !access.consultAllOrders;

    var total = 0;
    final rows = await VenueOrder.db.find(
      session,
      where: (t) {
        var filter = t.buildingId.equals(buildingId);
        if (status != null) {
          filter = filter & t.status.equals(status);
        }
        if (venueTableId != null) {
          filter = filter & t.venueTableId.equals(venueTableId);
        }
        if (restricted) {
          filter = filter & _employeeParticipated(t, ctx);
        }
        return filter;
      },
      orderBy: (t) => t.createdAt.desc(),
      limit: window.limit,
      offset: window.offset,
      include: VenueOrder.include(
        venueTable: VenueTable.include(),
        items: VenueOrderItem.includeList(
          orderBy: (t) => t.createdAt,
        ),
      ),
    );
    total = await VenueOrder.db.count(
      session,
      where: (t) {
        var filter = t.buildingId.equals(buildingId);
        if (status != null) {
          filter = filter & t.status.equals(status);
        }
        if (venueTableId != null) {
          filter = filter & t.venueTableId.equals(venueTableId);
        }
        if (restricted) {
          filter = filter & _employeeParticipated(t, ctx);
        }
        return filter;
      },
    );
    final names = await _actorNameCache(session, rows);
    return OrderPage(
      items: [for (final row in rows) _view(row, names)],
      total: total,
      limit: window.limit,
      offset: window.offset,
    );
  }

  /// Loads one order with items.
  Future<OrderView> get(Session session, UuidValue orderId) async {
    final row = await _loadOrder(session, orderId);
    await _requireBuildingAccess(session, row.buildingId);
    final ctx = AuthGuard.requireAny(session);
    final access = await _requireEmployeeAccessIfNeeded(session, ctx);
    if (!await _canReadOrder(session, row, ctx, access)) {
      throw OrderException(
        message: 'Not allowed to view this order.',
        code: OrderErrorCode.permissionDenied,
      );
    }
    final names = await _actorNameCache(session, [row]);
    return _view(row, names);
  }

  /// Owner or employee creates an order with at least one line.
  Future<OrderView> create(Session session, OrderCreate request) async {
    final ctx = AuthGuard.requireAny(session);
    _requireFloorActor(ctx);
    await _requireBuildingAccess(session, request.buildingId);
    await _requireFlag(session, ctx, (a) => a.orderCreation);
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
    final itemIds = await _insertResolvedLines(
      session,
      order,
      articles,
      now,
      ctx,
    );
    final view = await get(session, order.id!);
    await _publishBoard(
      session,
      kind: OrderBoardEventKind.orderOpened,
      order: view,
      itemIds: itemIds,
    );
    return view;
  }

  /// Customer places an order at an active table they scanned.
  ///
  /// Reuses stock, ticket numbers, and the one-open-order table rule.
  /// The receipt hides staff attribution.
  Future<CustomerOrderView> placeForCustomer(
    Session session,
    CustomerOrderPlace request,
  ) async {
    final ctx = _requireCustomer(session);
    final pack = await PackGate.ofBuilding(session, request.buildingId);
    PackGate.requireFeature(
      pack.customerOrdering,
      PackFeature.customerOrdering,
    );
    await _assertCustomerOrderingEnabled(session, request.buildingId);
    final lines = _customerLines(request.items);
    final table = await _requireActiveTable(
      session,
      request.buildingId,
      request.tableId,
    );
    await _assertTableAcceptsNewOrder(
      session,
      buildingId: request.buildingId,
      tableId: table.id,
    );
    final articles = await _resolveArticles(
      session,
      request.buildingId,
      lines,
    );
    await _syncIngredientStock(
      session,
      buildingId: request.buildingId,
      articleIds: articles.map((article) => article.id!).toList(),
      deduct: true,
    );
    final now = DateTime.now().toUtc();
    final orderRef = await _nextOrderRef(session, request.buildingId);
    final order = await VenueOrder.db.insertRow(
      session,
      VenueOrder(
        buildingId: request.buildingId,
        venueTableId: table.id,
        ref: orderRef,
        status: OrderStatus.progress,
        launchedByType: ctx.actorType,
        launchedById: ctx.actorId,
        createdAt: now,
        updatedAt: now,
      ),
    );
    final itemIds = await _insertResolvedLines(
      session,
      order,
      articles,
      now,
      ctx,
    );
    await _publishBoard(
      session,
      kind: OrderBoardEventKind.orderOpened,
      order: await _boardView(session, order.id!),
      itemIds: itemIds,
    );
    await _publishCustomerOrder(session, order.id!);
    return getForCustomer(session, order.id!);
  }

  /// This customer's orders in `[from, to)`, newest first, across venues.
  ///
  /// The window is capped at 62 days so the history tabs stay day, week,
  /// and month.
  Future<CustomerOrderPage> listForCustomer(
    Session session,
    DateTime from,
    DateTime to, {
    int? limit,
    int? offset,
  }) async {
    final ctx = _requireCustomer(session);
    if (!to.isAfter(from) || to.difference(from) > const Duration(days: 62)) {
      throw OrderException(
        message: 'Order history window is not valid.',
        code: OrderErrorCode.invalidInput,
      );
    }
    final window = PageWindow.from(limit: limit, offset: offset);
    Expression where(VenueOrderTable t) =>
        t.launchedByType.equals(ActorType.customer) &
        t.launchedById.equals(ctx.actorId) &
        (t.createdAt >= from) &
        (t.createdAt < to);
    final total = await VenueOrder.db.count(session, where: where);
    final rows = await VenueOrder.db.find(
      session,
      where: where,
      orderBy: (t) => t.createdAt.desc(),
      limit: window.limit,
      offset: window.offset,
      include: VenueOrder.include(
        building: Building.include(),
        venueTable: VenueTable.include(),
        items: VenueOrderItem.includeList(),
      ),
    );
    return CustomerOrderPage(
      items: [
        for (final row in rows)
          if (row.id != null)
            CustomerOrderSummary(
              id: row.id!,
              buildingId: row.buildingId,
              venueName: row.building?.name ?? '',
              ref: row.ref,
              tableNumber: row.venueTable?.number ?? 0,
              currencyCode: row.building?.currencyCode ?? '',
              status: row.status,
              cancellationReason: row.cancellationReason,
              itemCount: row.items?.length ?? 0,
              totalAmount: (row.items ?? const <VenueOrderItem>[]).fold<double>(
                0,
                (sum, item) => sum + item.unitPrice,
              ),
              createdAt: row.createdAt,
            ),
      ],
      total: total,
      limit: window.limit,
      offset: window.offset,
    );
  }

  /// One order this customer launched. Other orders look missing.
  Future<CustomerOrderView> getForCustomer(
    Session session,
    UuidValue orderId,
  ) async {
    final ctx = _requireCustomer(session);
    final order = await _loadOrder(session, orderId);
    final owns =
        order.launchedByType == ActorType.customer &&
        order.launchedById == ctx.actorId;
    if (!owns) {
      throw OrderException(
        message: 'Order not found.',
        code: OrderErrorCode.notFound,
      );
    }
    final building = await Building.db.findById(session, order.buildingId);
    if (building == null) {
      throw OrderException(
        message: 'Building not found.',
        code: OrderErrorCode.notFound,
      );
    }
    return _customerView(order, building.currencyCode);
  }

  /// Newest in-progress order for this customer, across venues.
  Future<CustomerOrderView?> currentForCustomer(Session session) async {
    final ctx = _requireCustomer(session);
    final row = await VenueOrder.db.findFirstRow(
      session,
      where: (t) =>
          t.launchedByType.equals(ActorType.customer) &
          t.launchedById.equals(ctx.actorId) &
          t.status.equals(OrderStatus.progress),
      orderBy: (t) => t.createdAt.desc(),
      include: VenueOrder.include(
        building: Building.include(),
        venueTable: VenueTable.include(),
        items: VenueOrderItem.includeList(
          orderBy: (t) => t.createdAt,
        ),
      ),
    );
    if (row == null || row.id == null) {
      return null;
    }
    return _customerView(row, row.building?.currencyCode ?? '');
  }

  /// Live visit for the signed-in customer.
  ///
  /// The first event is [currentForCustomer]. Later events are staff
  /// changes on an order this customer launched, including the paid or
  /// cancelled receipt so the visit can unlock.
  Stream<CustomerOrderLive> watchCurrentForCustomer(Session session) async* {
    final ctx = _requireCustomer(session);
    final live = session.messages.createStream<CustomerOrderLive>(
      customerOrderChannel(ctx.actorId),
    );
    final queue = StreamController<CustomerOrderLive>();
    final subscription = live.listen(
      queue.add,
      onError: queue.addError,
      onDone: queue.close,
    );
    try {
      final open = await currentForCustomer(session);
      yield CustomerOrderLive(open: open, changed: open);
      yield* queue.stream;
    } finally {
      await subscription.cancel();
      await queue.close();
    }
  }

  /// Adds units to an order this customer still has open.
  Future<CustomerOrderView> appendForCustomer(
    Session session,
    CustomerOrderAppend request,
  ) async {
    final ctx = _requireCustomer(session);
    final order = await _loadOrder(session, request.orderId);
    final owns =
        order.launchedByType == ActorType.customer &&
        order.launchedById == ctx.actorId;
    if (!owns) {
      throw OrderException(
        message: 'Order not found.',
        code: OrderErrorCode.notFound,
      );
    }
    if (order.status != OrderStatus.progress) {
      throw OrderException(
        message: 'Only an open order can take more dishes.',
        code: OrderErrorCode.invalidStatus,
      );
    }
    final pack = await PackGate.ofBuilding(session, order.buildingId);
    PackGate.requireFeature(
      pack.customerOrdering,
      PackFeature.customerOrdering,
    );
    PackGate.requireFeature(
      pack.allowAppendingItems,
      PackFeature.appendingItems,
    );
    final building = await Building.db.findById(session, order.buildingId);
    if (building == null) {
      throw OrderException(
        message: 'Building not found.',
        code: OrderErrorCode.notFound,
      );
    }
    if (!building.customerOrderingEnabled) {
      throw OrderException(
        message: 'This venue has turned off customer ordering.',
        code: OrderErrorCode.customerOrderingDisabled,
      );
    }
    if (!building.allowAppendingItemsToOrder) {
      throw OrderException(
        message: 'Appending articles to this order is not allowed.',
        code: OrderErrorCode.appendNotAllowed,
      );
    }
    final lines = _customerLines(request.items);
    final articles = await _resolveArticles(session, order.buildingId, lines);
    await _syncIngredientStock(
      session,
      buildingId: order.buildingId,
      articleIds: articles.map((article) => article.id!).toList(),
      deduct: true,
    );
    final now = DateTime.now().toUtc();
    final itemIds = await _insertResolvedLines(
      session,
      order,
      articles,
      now,
      ctx,
    );
    await VenueOrder.db.updateRow(
      session,
      order.copyWith(updatedAt: now),
    );
    await _publishBoard(
      session,
      kind: OrderBoardEventKind.itemsAdded,
      order: await _boardView(session, order.id!),
      itemIds: itemIds,
    );
    await _publishCustomerOrder(session, order.id!);
    return getForCustomer(session, order.id!);
  }

  /// Adds lines to an open order.
  Future<OrderView> addItems(Session session, OrderAddItems request) async {
    final ctx = AuthGuard.requireAny(session);
    _requireFloorActor(ctx);
    final order = await _loadOrder(session, request.orderId);
    await _requireBuildingAccess(session, order.buildingId);
    await _requireFlag(session, ctx, (a) => a.orderCreation);
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
    final pack = await PackGate.ofBuilding(session, order.buildingId);
    PackGate.requireFeature(
      pack.allowAppendingItems,
      PackFeature.appendingItems,
    );
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
    final itemIds = await _insertResolvedLines(
      session,
      order,
      articles,
      DateTime.now().toUtc(),
      ctx,
    );
    await VenueOrder.db.updateRow(
      session,
      order.copyWith(updatedAt: DateTime.now().toUtc()),
    );
    final view = await get(session, order.id!);
    await _publishBoard(
      session,
      kind: OrderBoardEventKind.itemsAdded,
      order: view,
      itemIds: itemIds,
    );
    await _publishCustomerOrder(session, order.id!);
    return view;
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
    await _requireStatusFlag(session, ctx, request.status);
    await _assertServiceAttribution(session, ctx, order, item, request.status);
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
    // Stamp the person who made this step, and drop any later stamps so the
    // chain matches the steps that actually happened.
    var next = item.copyWith(
      status: request.status,
      updatedAt: now,
    );
    switch (request.status) {
      case OrderItemStatus.picked:
      case OrderItemStatus.ready:
        // One kitchen actor: the employee with preparation access.
        // Picked records them; ready records them again and sets the time.
        next = next.copyWith(
          preparedByType: ctx.actorType,
          preparedById: ctx.actorId,
          preparedAt: request.status == OrderItemStatus.ready ? now : null,
          servedByType: null,
          servedById: null,
          servedAt: null,
          paidToType: null,
          paidToId: null,
          paidAt: null,
        );
      case OrderItemStatus.served:
        next = next.copyWith(
          servedByType: ctx.actorType,
          servedById: ctx.actorId,
          servedAt: now,
          paidToType: null,
          paidToId: null,
          paidAt: null,
        );
      case OrderItemStatus.payed:
        next = next.copyWith(
          paidToType: ctx.actorType,
          paidToId: ctx.actorId,
          paidAt: now,
        );
      case OrderItemStatus.cancelled:
        final reason = request.cancellationReason;
        if (reason == null) {
          throw OrderException(
            message: 'Choose a cancellation reason.',
            code: OrderErrorCode.invalidInput,
          );
        }
        next = next.copyWith(
          cancelledByType: ctx.actorType,
          cancelledById: ctx.actorId,
          cancelledAt: now,
          cancellationReason: reason,
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
    final nextOrderStatus = _deriveOrderStatus(order.status, refreshedItems);
    orderUpdate = orderUpdate.copyWith(status: nextOrderStatus);
    await VenueOrder.db.updateRow(session, orderUpdate);
    await _notifications.recordItemChange(
      session,
      order: order,
      item: next,
      venueName: building.name,
      previousOrderStatus: order.status,
      nextOrderStatus: nextOrderStatus,
    );
    // Do not use [get]: kitchen and service staff may update a line they
    // cannot consult. The write already passed the status flag.
    final view = await _boardView(session, order.id!);
    await _publishBoard(
      session,
      kind: OrderBoardEventKind.changed,
      order: view,
      itemIds: [request.id],
    );
    await _publishCustomerOrder(session, order.id!);
    return view;
  }

  /// Cancels an open order and all non-payed lines.
  ///
  /// [reason] is kept on the order and copied onto each line cancelled here.
  /// A line that was already cancelled keeps its own reason.
  Future<OrderView> cancel(
    Session session,
    UuidValue orderId,
    OrderCancellationReason reason,
  ) async {
    final ctx = AuthGuard.requireAny(session);
    _requireFloorActor(ctx);
    final order = await _loadOrder(session, orderId);
    await _requireBuildingAccess(session, order.buildingId);
    await _requireFlag(session, ctx, (a) => a.cancelOrder);
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
          cancellationReason: reason,
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
        cancellationReason: reason,
        updatedAt: now,
      ),
    );
    final building = await Building.db.findById(session, order.buildingId);
    if (building != null) {
      await _notifications.recordOrderCancelled(
        session,
        order: order,
        venueName: building.name,
        reason: reason,
      );
    }
    // The person who cancelled may not be allowed to consult the ticket.
    final view = await _boardView(session, order.id!);
    await _publishBoard(
      session,
      kind: OrderBoardEventKind.changed,
      order: view,
    );
    await _publishCustomerOrder(session, order.id!);
    return view;
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

  Future<List<UuidValue>> _insertResolvedLines(
    Session session,
    VenueOrder order,
    List<MenuArticle> articles,
    DateTime now,
    AuthContext ctx,
  ) async {
    final ids = <UuidValue>[];
    for (final article in articles) {
      final row = await VenueOrderItem.db.insertRow(
        session,
        VenueOrderItem(
          orderId: order.id!,
          articleId: article.id!,
          articleName: article.name,
          unitPrice: article.price,
          status: OrderItemStatus.progress,
          addedByType: ctx.actorType,
          addedById: ctx.actorId,
          createdAt: now,
          updatedAt: now,
        ),
      );
      final id = row.id;
      if (id != null) {
        ids.add(id);
      }
    }
    return ids;
  }

  /// Open tickets for the floor board, then each create, append, and move.
  ///
  /// Preparation sees lines waiting to be picked or readied. Serving and
  /// payment see the step they can record. History is not replayed after [synced].
  Stream<OrderBoardEvent> watchBoard(
    Session session,
    UuidValue buildingId,
  ) async* {
    await _requireBuildingAccess(session, buildingId);
    final ctx = AuthGuard.requireAny(session);
    final access = await _requireEmployeeAccessIfNeeded(session, ctx);
    final building = await Building.db.findById(session, buildingId);
    final steps = normalizeStrictModeSteps(building?.strictModeSteps);
    final live = session.messages.createStream<OrderBoardEvent>(
      boardChannel(buildingId),
    );
    final queue = StreamController<OrderBoardEvent>();
    final subscription = live.listen(
      queue.add,
      onError: queue.addError,
      onDone: queue.close,
    );
    try {
      final open = await _openBoardOrders(session, buildingId);
      for (final order in open) {
        if (!_canSeeBoard(order, ctx, access, steps)) {
          continue;
        }
        yield OrderBoardEvent(
          kind: OrderBoardEventKind.snapshot,
          order: order,
          itemIds: const [],
        );
      }
      yield OrderBoardEvent(
        kind: OrderBoardEventKind.synced,
        itemIds: const [],
      );
      await for (final event in queue.stream) {
        final order = event.order;
        if (order != null &&
            !_shouldDeliverBoardEvent(event.kind, order, ctx, access, steps)) {
          continue;
        }
        yield event;
      }
    } finally {
      await subscription.cancel();
      if (!queue.isClosed) {
        await queue.close();
      }
    }
  }

  /// Open tickets for the board, without the consult-all list filter.
  ///
  /// Kitchen staff must see progress lines they did not launch. [_canSeeBoard]
  /// keeps each role to the step they can act on.
  Future<List<OrderView>> _openBoardOrders(
    Session session,
    UuidValue buildingId,
  ) async {
    final rows = await VenueOrder.db.find(
      session,
      where: (t) =>
          t.buildingId.equals(buildingId) &
          t.status.equals(OrderStatus.progress),
      orderBy: (t) => t.createdAt.desc(),
      limit: 300,
      include: VenueOrder.include(
        venueTable: VenueTable.include(),
        items: VenueOrderItem.includeList(orderBy: (t) => t.createdAt),
      ),
    );
    final names = await _actorNameCache(session, rows);
    return [for (final row in rows) _view(row, names)];
  }

  Future<OrderView> _boardView(Session session, UuidValue orderId) async {
    final row = await _loadOrder(session, orderId);
    final names = await _actorNameCache(session, [row]);
    return _view(row, names);
  }

  Future<void> _publishBoard(
    Session session, {
    required OrderBoardEventKind kind,
    required OrderView order,
    List<UuidValue> itemIds = const [],
  }) {
    return session.messages.postMessage(
      boardChannel(order.buildingId),
      OrderBoardEvent(kind: kind, order: order, itemIds: itemIds),
    );
  }

  /// Tells the customer who launched [orderId] that the receipt changed.
  ///
  /// Staff-opened tickets are ignored. A paid or cancelled order is sent
  /// as [CustomerOrderLive.changed] with an empty [CustomerOrderLive.open]
  /// so the visit unlocks while the receipt still shows the final status.
  Future<void> _publishCustomerOrder(Session session, UuidValue orderId) async {
    final order = await _loadOrder(session, orderId);
    if (order.launchedByType != ActorType.customer) {
      return;
    }
    final customerId = order.launchedById;
    final building = await Building.db.findById(session, order.buildingId);
    final receipt = _customerView(order, building?.currencyCode ?? '');
    final open = order.status == OrderStatus.progress ? receipt : null;
    await session.messages.postMessage(
      customerOrderChannel(customerId),
      CustomerOrderLive(open: open, changed: receipt),
    );
  }

  /// Kitchen and service staff may open a ticket that is on their board.
  Future<bool> _canReadOrder(
    Session session,
    VenueOrder row,
    AuthContext ctx,
    EmployeeAccess? access,
  ) async {
    if (_canConsultOrder(row, ctx, access)) {
      return true;
    }
    final building = await Building.db.findById(session, row.buildingId);
    final steps = normalizeStrictModeSteps(building?.strictModeSteps);
    final names = await _actorNameCache(session, [row]);
    return _canSeeBoard(_view(row, names), ctx, access, steps);
  }

  /// Live moves are delivered to preparation and serving even after the line
  /// leaves their column, so the other screen drops or shows it without a refresh.
  bool _shouldDeliverBoardEvent(
    OrderBoardEventKind kind,
    OrderView order,
    AuthContext ctx,
    EmployeeAccess? access,
    List<StrictModeStep> steps,
  ) {
    if (_canSeeBoard(order, ctx, access, steps)) {
      return true;
    }
    if (kind != OrderBoardEventKind.changed || access == null) {
      return false;
    }
    return access.preparation || access.serving;
  }

  /// Preparation sees lines waiting to be picked or readied. Serving sees
  /// lines waiting to be served. Payment sees the pay step on tickets they
  /// placed, unless a customer opened the line.
  bool _canSeeBoard(
    OrderView order,
    AuthContext ctx,
    EmployeeAccess? access,
    List<StrictModeStep> steps,
  ) {
    if (access == null || access.consultAllOrders) {
      return true;
    }
    for (final item in order.items) {
      if (item.status == OrderItemStatus.payed ||
          item.status == OrderItemStatus.cancelled) {
        continue;
      }
      final next = nextEnabledStrictStatus(item.status, steps);
      if (access.preparation &&
          (next == OrderItemStatus.picked || next == OrderItemStatus.ready)) {
        return true;
      }
      if (access.serving && next == OrderItemStatus.served) {
        return true;
      }
      if (access.orderPayment &&
          next == OrderItemStatus.payed &&
          _canRecordServiceView(order, item, ctx, access)) {
        return true;
      }
    }
    return false;
  }

  bool _canRecordServiceView(
    OrderView order,
    OrderItemView item,
    AuthContext ctx,
    EmployeeAccess? access,
  ) {
    if (ctx.actorType != ActorType.employee) {
      return true;
    }
    if (access == null || access.consultAllOrders) {
      return true;
    }
    if (order.launchedBy.type == ctx.actorType &&
        order.launchedBy.id == ctx.actorId) {
      return true;
    }
    final addedBy = item.addedBy;
    if (addedBy != null &&
        addedBy.type == ctx.actorType &&
        addedBy.id == ctx.actorId) {
      return true;
    }
    final staffPlaced =
        order.launchedBy.type == ActorType.owner ||
        order.launchedBy.type == ActorType.employee ||
        (addedBy != null &&
            (addedBy.type == ActorType.owner ||
                addedBy.type == ActorType.employee));
    return !staffPlaced;
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

    final building = await Building.db.findById(session, buildingId);
    final allowOutOfStock = building?.allowOutOfStockOrders == true;

    for (final entry in totals.entries) {
      final ingredient = await Ingredient.db.findById(session, entry.key);
      if (ingredient == null || ingredient.buildingId != buildingId) {
        throw OrderException(
          message: 'Ingredient not found for article composition.',
          code: OrderErrorCode.notFound,
        );
      }
      final delta = deduct ? -entry.value : entry.value;
      var next = ingredient.currentStock + delta;
      if (deduct && next < 0) {
        if (!allowOutOfStock) {
          throw OrderException(
            message: 'Insufficient stock for ${ingredient.name}.',
            code: OrderErrorCode.insufficientStock,
          );
        }
        // The venue allows the order. Stock stays at zero instead of going negative.
        next = 0;
      }
      await Ingredient.db.updateRow(
        session,
        ingredient.copyWith(currentStock: next),
      );
    }
  }

  /// The pack can include customer ordering while the venue has it turned off.
  Future<void> _assertCustomerOrderingEnabled(
    Session session,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null || !building.customerOrderingEnabled) {
      throw OrderException(
        message: 'This venue has turned off customer ordering.',
        code: OrderErrorCode.customerOrderingDisabled,
      );
    }
  }

  AuthContext _requireCustomer(Session session) {
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType != ActorType.customer) {
      throw AccountException(
        message: 'Only customers can perform this action.',
        code: AccountErrorCode.notAuthorized,
      );
    }
    return ctx;
  }

  /// Each request item is already one unit, same as [OrderItemCreateLine].
  List<OrderItemCreateLine> _customerLines(List<CustomerOrderItem> items) {
    return _validateLines([
      for (final item in items) OrderItemCreateLine(articleId: item.articleId),
    ]);
  }

  Future<VenueTable> _requireActiveTable(
    Session session,
    UuidValue buildingId,
    UuidValue tableId,
  ) async {
    final table = await VenueTable.db.findById(session, tableId);
    if (table == null ||
        table.id == null ||
        table.buildingId != buildingId ||
        !table.isActive) {
      throw OrderException(
        message: 'Table not found in this building.',
        code: OrderErrorCode.notFound,
      );
    }
    return table;
  }

  CustomerOrderView _customerView(VenueOrder order, String currencyCode) {
    final lines = [
      for (final item in order.items ?? const <VenueOrderItem>[])
        CustomerOrderLine(
          id: item.id!,
          articleId: item.articleId,
          name: item.articleName,
          unitPrice: item.unitPrice,
          status: item.status,
          cancellationReason: item.cancellationReason,
        ),
    ];
    final total = lines.fold<double>(0, (sum, line) => sum + line.unitPrice);
    return CustomerOrderView(
      id: order.id!,
      buildingId: order.buildingId,
      ref: order.ref,
      tableNumber: order.venueTable?.number ?? 0,
      currencyCode: currencyCode,
      status: order.status,
      cancellationReason: order.cancellationReason,
      lines: lines,
      totalAmount: total,
    );
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
      final next = nextEnabledStrictStatus(from, steps);
      final payedEnabled = steps.any(
        (step) => step.enabled && step.status == OrderItemStatus.payed,
      );
      // Open workflow: the next enabled venue step, or a jump to payed.
      if (to == next || (to == OrderItemStatus.payed && payedEnabled)) {
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

  OrderView _view(
    VenueOrder row,
    Map<String, ({String first, String last})> names,
  ) {
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
      cancellationReason: row.cancellationReason,
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
    addedBy: _actorView(
      type: row.addedByType,
      id: row.addedById,
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
    cancellationReason: row.cancellationReason,
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
        collect(item.addedByType, item.addedById);
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

  /// Owners need no profile; employees must have an assigned access row.
  Future<EmployeeAccess?> _requireEmployeeAccessIfNeeded(
    Session session,
    AuthContext ctx,
  ) async {
    if (ctx.actorType != ActorType.employee) {
      return null;
    }
    final employee = await Employee.db.findById(
      session,
      ctx.actorId,
      include: Employee.include(access: EmployeeAccess.include()),
    );
    final access = employee?.access;
    if (access == null) {
      throw OrderException(
        message: 'No access profile assigned.',
        code: OrderErrorCode.permissionDenied,
      );
    }
    return access;
  }

  Future<void> _requireFlag(
    Session session,
    AuthContext ctx,
    bool Function(EmployeeAccess access) flag,
  ) async {
    final access = await _requireEmployeeAccessIfNeeded(session, ctx);
    if (access == null) {
      return;
    }
    if (!flag(access)) {
      throw OrderException(
        message: 'Access profile does not allow this action.',
        code: OrderErrorCode.permissionDenied,
      );
    }
  }

  /// Payed on a staff ticket belongs to whoever placed that line.
  ///
  /// Served is any employee with serving access. A customer-opened line has
  /// no staff owner, so any employee with payment access may record payed.
  Future<void> _assertServiceAttribution(
    Session session,
    AuthContext ctx,
    VenueOrder order,
    VenueOrderItem item,
    OrderItemStatus status,
  ) async {
    if (status != OrderItemStatus.payed) {
      return;
    }
    if (ctx.actorType != ActorType.employee) {
      return;
    }
    final access = await _requireEmployeeAccessIfNeeded(session, ctx);
    if (access == null || access.consultAllOrders) {
      return;
    }
    if (order.launchedByType == ctx.actorType &&
        order.launchedById == ctx.actorId) {
      return;
    }
    if (item.addedByType == ctx.actorType && item.addedById == ctx.actorId) {
      return;
    }
    final staffPlaced =
        order.launchedByType == ActorType.owner ||
        order.launchedByType == ActorType.employee ||
        item.addedByType == ActorType.owner ||
        item.addedByType == ActorType.employee;
    if (!staffPlaced) {
      return;
    }
    throw OrderException(
      message: 'Only the staff member who placed this line can record it.',
      code: OrderErrorCode.permissionDenied,
    );
  }

  Future<void> _requireStatusFlag(
    Session session,
    AuthContext ctx,
    OrderItemStatus status,
  ) async {
    switch (status) {
      case OrderItemStatus.picked:
      case OrderItemStatus.ready:
        // Only preparation access (or the owner) may pick or mark ready.
        await _requireFlag(session, ctx, (a) => a.preparation);
      case OrderItemStatus.served:
        await _requireFlag(session, ctx, (a) => a.serving);
      case OrderItemStatus.payed:
        await _requireFlag(session, ctx, (a) => a.orderPayment);
      case OrderItemStatus.cancelled:
        await _requireFlag(session, ctx, (a) => a.cancelOrder);
      case OrderItemStatus.progress:
        break;
    }
  }

  /// Orders an employee may open when they cannot consult every ticket.
  ///
  /// Includes tickets they launched and lines they added, prepared, served,
  /// recorded payment for, or cancelled.
  Expression _employeeParticipated(VenueOrderTable t, AuthContext ctx) {
    final type = ctx.actorType;
    final id = ctx.actorId;
    return (t.launchedByType.equals(type) & t.launchedById.equals(id)) |
        (t.cancelledByType.equals(type) & t.cancelledById.equals(id)) |
        t.items.any(
          (item) => item.addedByType.equals(type) & item.addedById.equals(id),
        ) |
        t.items.any(
          (item) =>
              item.preparedByType.equals(type) & item.preparedById.equals(id),
        ) |
        t.items.any(
          (item) => item.servedByType.equals(type) & item.servedById.equals(id),
        ) |
        t.items.any(
          (item) => item.paidToType.equals(type) & item.paidToId.equals(id),
        ) |
        t.items.any(
          (item) =>
              item.cancelledByType.equals(type) & item.cancelledById.equals(id),
        );
  }

  /// Employee without [EmployeeAccess.consultAllOrders] sees orders they
  /// launched or lines they added, prepared, served, were paid on, or cancelled.
  bool _canConsultOrder(
    VenueOrder row,
    AuthContext ctx,
    EmployeeAccess? access,
  ) {
    if (access == null || access.consultAllOrders) {
      return true;
    }
    bool matches(ActorType? actorType, UuidValue? actorId) =>
        actorType == ctx.actorType && actorId == ctx.actorId;
    if (matches(row.launchedByType, row.launchedById) ||
        matches(row.cancelledByType, row.cancelledById)) {
      return true;
    }
    for (final item in row.items ?? const <VenueOrderItem>[]) {
      if (matches(item.addedByType, item.addedById) ||
          matches(item.preparedByType, item.preparedById) ||
          matches(item.servedByType, item.servedById) ||
          matches(item.paidToType, item.paidToId) ||
          matches(item.cancelledByType, item.cancelledById)) {
        return true;
      }
    }
    return false;
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
