import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'order_service.dart';

/// Customer orders. Staff status changes stay on [OrderEndpoint].
class CustomerOrderEndpoint extends Endpoint {
  final _orders = OrderService();

  @override
  bool get requireLogin => true;

  /// Places an order for the signed-in customer at a scanned table.
  ///
  /// Prices and stock come from the venue menu. The caller must be a
  /// customer. A missing table, unknown dish, occupied table, or short
  /// stock throws [OrderException].
  Future<CustomerOrderView> place(
    Session session,
    CustomerOrderPlace request,
  ) {
    return _orders.placeForCustomer(session, request);
  }

  /// Orders this customer placed between [from] and [to], newest first.
  ///
  /// Every venue is included. [from] is inclusive and [to] is exclusive.
  /// Another customer's orders are never returned. A reversed or oversized
  /// window throws [OrderException] / [OrderErrorCode.invalidInput].
  /// [limit] defaults to 20 and is capped at 100.
  Future<CustomerOrderPage> list(
    Session session,
    DateTime from,
    DateTime to, {
    int? limit,
    int? offset,
  }) {
    return _orders.listForCustomer(
      session,
      from,
      to,
      limit: limit,
      offset: offset,
    );
  }

  /// Loads one order the signed-in customer placed.
  ///
  /// Another customer's order is [OrderErrorCode.notFound].
  Future<CustomerOrderView> get(Session session, UuidValue orderId) {
    return _orders.getForCustomer(session, orderId);
  }

  /// The newest order this customer still has in progress, or null.
  ///
  /// Paid and cancelled orders are ignored. Another customer's order is
  /// never returned.
  Future<CustomerOrderView?> current(Session session) {
    return _orders.currentForCustomer(session);
  }

  /// Live visit for the signed-in customer.
  ///
  /// The first event is the current in-progress order (or empty). Later
  /// events follow staff status changes, payment, and cancellation on an
  /// order this customer launched. Another customer's ticket is never sent.
  Stream<CustomerOrderLive> watchCurrent(Session session) {
    return _orders.watchCurrentForCustomer(session);
  }

  /// Adds dishes to this customer's open order.
  ///
  /// The order must still be in progress, and the venue must allow
  /// appending. Stock is deducted the same way as a new order. A missing
  /// or foreign order is [OrderErrorCode.notFound].
  Future<CustomerOrderView> append(
    Session session,
    CustomerOrderAppend request,
  ) {
    return _orders.appendForCustomer(session, request);
  }
}
