import 'package:sip_sync_client/sip_sync_client.dart';

/// Floor / POS orders for a building.
class OrderRepository {
  OrderRepository(this._client);

  final Client _client;

  /// When [status] is null, returns all orders for the building.
  Future<List<OrderView>> list(UuidValue buildingId, {OrderStatus? status}) =>
      _client.order.list(buildingId, status);

  Future<OrderView> get(UuidValue orderId) => _client.order.get(orderId);

  Future<OrderView> create({
    required UuidValue buildingId,
    UuidValue? venueTableId,
    required List<OrderItemCreateLine> items,
  }) {
    return _client.order.create(
      OrderCreate(
        buildingId: buildingId,
        venueTableId: venueTableId,
        items: items,
      ),
    );
  }

  Future<OrderView> addItems({
    required UuidValue orderId,
    required List<OrderItemCreateLine> items,
  }) {
    return _client.order.addItems(
      OrderAddItems(orderId: orderId, items: items),
    );
  }

  Future<OrderView> updateItemStatus({
    required UuidValue id,
    required OrderItemStatus status,
  }) {
    return _client.order.updateItemStatus(
      OrderItemStatusUpdate(id: id, status: status),
    );
  }

  Future<OrderView> cancel(UuidValue orderId) => _client.order.cancel(orderId);
}
