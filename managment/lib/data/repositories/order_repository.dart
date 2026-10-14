import 'package:sip_sync_client/sip_sync_client.dart';

import '../../core/paging/list_paging.dart';

/// Floor / POS orders for a building.
class OrderRepository {
  OrderRepository(this._client);

  final Client _client;

  /// One page of orders. [status] null is every status.
  ///
  /// [createdFrom] and [createdTo] are the day window. The server applies
  /// them for every caller.
  Future<OrderPage> list(
    UuidValue buildingId, {
    OrderStatus? status,
    DateTime? createdFrom,
    DateTime? createdTo,
    UuidValue? cashRegisterSessionId,
    UuidValue? venueTableId,
    int? limit,
    int? offset,
  }) => _client.order.list(
    buildingId,
    status,
    createdFrom: createdFrom,
    createdTo: createdTo,
    cashRegisterSessionId: cashRegisterSessionId,
    venueTableId: venueTableId,
    limit: limit,
    offset: offset,
  );

  /// Every open order seated on [venueTableId].
  Future<List<OrderView>> openForTable(
    UuidValue buildingId,
    UuidValue venueTableId,
  ) {
    return collectPages(
      load: (offset) async {
        final page = await list(
          buildingId,
          status: OrderStatus.progress,
          venueTableId: venueTableId,
          limit: 100,
          offset: offset,
        );
        return (items: page.items, total: page.total);
      },
    );
  }

  Future<OrderView> get(UuidValue orderId) => _client.order.get(orderId);

  /// Tickets created in [createdFrom] inclusive, [createdTo] exclusive, then
  /// each new ticket, appended line, and status change in that day.
  Stream<OrderBoardEvent> watchBoard(
    UuidValue buildingId, {
    DateTime? createdFrom,
    DateTime? createdTo,
    UuidValue? cashRegisterSessionId,
  }) {
    return _client.order.watchBoard(
      buildingId,
      createdFrom: createdFrom,
      createdTo: createdTo,
      cashRegisterSessionId: cashRegisterSessionId,
    );
  }

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
    OrderCancellationReason? cancellationReason,
  }) {
    return _client.order.updateItemStatus(
      OrderItemStatusUpdate(
        id: id,
        status: status,
        cancellationReason: cancellationReason,
      ),
    );
  }

  Future<OrderView> cancel(UuidValue orderId, OrderCancellationReason reason) =>
      _client.order.cancel(orderId, reason);
}
