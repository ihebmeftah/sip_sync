import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'order_service.dart';

/// Floor / POS order RPC for a building.
class OrderEndpoint extends Endpoint {
  final _orders = OrderService();

  @override
  bool get requireLogin => true;

  /// Lists orders for [buildingId] (owner or assigned employee).
  ///
  /// When [status] is set, only orders with that status are returned.
  /// [createdFrom] and [createdTo] are an inclusive-exclusive window on
  /// [VenueOrder.createdAt] for every caller. Omit both to list every day.
  /// A partial, reversed, or window longer than 8 days throws
  /// [OrderException] / [OrderErrorCode.invalidInput]. [venueTableId]
  /// limits the page to one
  /// table, so a seat lookup does not depend on the floor page. [limit]
  /// defaults to 20 and is capped at 100.
  Future<OrderPage> list(
    Session session,
    UuidValue buildingId,
    OrderStatus? status, {
    DateTime? createdFrom,
    DateTime? createdTo,
    UuidValue? venueTableId,
    int? limit,
    int? offset,
  }) {
    return _orders.listForBuilding(
      session,
      buildingId,
      status: status,
      createdFrom: createdFrom,
      createdTo: createdTo,
      venueTableId: venueTableId,
      limit: limit,
      offset: offset,
    );
  }

  /// Loads one order with items.
  Future<OrderView> get(Session session, UuidValue orderId) {
    return _orders.get(session, orderId);
  }

  /// Owner or employee creates an order with lines.
  Future<OrderView> create(Session session, OrderCreate request) {
    return _orders.create(session, request);
  }

  /// Adds lines to an open order.
  Future<OrderView> addItems(Session session, OrderAddItems request) {
    return _orders.addItems(session, request);
  }

  /// Advances or cancels one order line (sets attribution).
  Future<OrderView> updateItemStatus(
    Session session,
    OrderItemStatusUpdate request,
  ) {
    return _orders.updateItemStatus(session, request);
  }

  /// Live floor board for [buildingId] on one local day.
  ///
  /// [createdFrom] is inclusive and [createdTo] is exclusive on
  /// [VenueOrder.createdAt]. The management app sends the current local day.
  /// A partial, reversed, or window longer than 8 days throws
  /// [OrderException] / [OrderErrorCode.invalidInput]. Sends one snapshot per
  /// ticket in that day, then [OrderBoardEventKind.synced], then each new
  /// ticket, appended line, and status change whose ticket was created in
  /// the same window. An employee who cannot consult every order only
  /// receives tickets they launched or lines they added.
  Stream<OrderBoardEvent> watchBoard(
    Session session,
    UuidValue buildingId, {
    required DateTime createdFrom,
    required DateTime createdTo,
  }) {
    return _orders.watchBoard(
      session,
      buildingId,
      createdFrom: createdFrom,
      createdTo: createdTo,
    );
  }

  /// Cancels an open order. [reason] is stored on the order and on each
  /// line that was still open.
  Future<OrderView> cancel(
    Session session,
    UuidValue orderId,
    OrderCancellationReason reason,
  ) {
    return _orders.cancel(session, orderId, reason);
  }
}
