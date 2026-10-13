import 'package:sip_sync_client/sip_sync_client.dart';

/// Places and reads the signed-in customer's orders.
class CustomerOrderRepository {
  CustomerOrderRepository(this._client);

  final Client _client;

  /// Sends the cart for one scanned table. The server prices each dish.
  Future<CustomerOrderView> place({
    required UuidValue buildingId,
    required UuidValue tableId,
    required List<CustomerOrderItem> items,
  }) {
    return _client.customerOrder.place(
      CustomerOrderPlace(
        buildingId: buildingId,
        tableId: tableId,
        items: items,
      ),
    );
  }

  /// One order this customer placed.
  Future<CustomerOrderView> getOrder(UuidValue orderId) =>
      _client.customerOrder.get(orderId);

  /// The newest order still in progress, or null when none is open.
  Future<CustomerOrderView?> current() => _client.customerOrder.current();

  /// Live visit: the open order, then each staff change on it.
  Stream<CustomerOrderLive> watchCurrent() =>
      _client.customerOrder.watchCurrent();

  /// Adds units to an order this customer already has open.
  Future<CustomerOrderView> append({
    required UuidValue orderId,
    required List<CustomerOrderItem> items,
  }) {
    return _client.customerOrder.append(
      CustomerOrderAppend(orderId: orderId, items: items),
    );
  }

  /// One page of orders this customer placed in `[from, to)`, every venue.
  Future<CustomerOrderPage> list({
    required DateTime from,
    required DateTime to,
    int? limit,
    int? offset,
  }) => _client.customerOrder.list(from, to, limit: limit, offset: offset);
}
