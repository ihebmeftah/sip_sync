import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'order_service.dart';

/// Floor / POS order RPC for a building.
class OrderEndpoint extends Endpoint {
  final _orders = OrderService();

  @override
  bool get requireLogin => true;

  /// Lists orders for [buildingId] (owner or assigned employee).
  Future<List<OrderView>> list(Session session, UuidValue buildingId) {
    return _orders.listForBuilding(session, buildingId);
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

  /// Cancels an open order.
  Future<OrderView> cancel(Session session, UuidValue orderId) {
    return _orders.cancel(session, orderId);
  }
}
