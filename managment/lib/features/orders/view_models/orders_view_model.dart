import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../tables/view_models/tables_view_model.dart';

part 'orders_view_model.g.dart';

@Riverpod(keepAlive: true)
class OrdersViewModel extends _$OrdersViewModel {
  late String _buildingId;
  OrderStatus? _statusFilter;

  /// Current list chip filter (`null` = all).
  OrderStatus? get statusFilter => _statusFilter;

  @override
  Future<List<OrderView>> build(String buildingId) async {
    _buildingId = buildingId;
    ref.watch(signedInActorIdProvider);
    if (buildingId.isEmpty) {
      return const [];
    }
    return ref
        .read(orderRepositoryProvider)
        .list(UuidValue.fromString(buildingId), status: _statusFilter);
  }

  /// Changes the status chip and reloads from the server.
  Future<void> setStatusFilter(OrderStatus? status) async {
    if (_statusFilter == status) return;
    _statusFilter = status;
    await refresh();
  }

  /// Remount: reset chip to All and refetch (keepAlive otherwise keeps the filter).
  Future<void> onScreenAppeared() async {
    _statusFilter = null;
    await refresh();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      if (_buildingId.isEmpty) {
        return const <OrderView>[];
      }
      return ref
          .read(orderRepositoryProvider)
          .list(UuidValue.fromString(_buildingId), status: _statusFilter);
    });
  }

  Future<OrderView> createOrder({
    UuidValue? venueTableId,
    required List<OrderItemCreateLine> items,
  }) async {
    final saved = await ref
        .read(orderRepositoryProvider)
        .create(
          buildingId: UuidValue.fromString(_buildingId),
          venueTableId: venueTableId,
          items: items,
        );
    await refresh();
    await _refreshTables();
    return saved;
  }

  Future<OrderView> addItems({
    required UuidValue orderId,
    required List<OrderItemCreateLine> items,
  }) async {
    final saved = await ref
        .read(orderRepositoryProvider)
        .addItems(orderId: orderId, items: items);
    _patchOrder(saved);
    return saved;
  }

  Future<OrderView> updateItemStatus({
    required UuidValue id,
    required OrderItemStatus status,
  }) async {
    final saved = await ref
        .read(orderRepositoryProvider)
        .updateItemStatus(id: id, status: status);
    if (saved.status == OrderStatus.payed ||
        saved.status == OrderStatus.cancelled) {
      await refresh();
      await _refreshTables();
    } else {
      _patchOrder(saved);
    }
    return saved;
  }

  Future<OrderView> cancelOrder(UuidValue orderId) async {
    final saved = await ref.read(orderRepositoryProvider).cancel(orderId);
    await refresh();
    await _refreshTables();
    return saved;
  }

  Future<void> _refreshTables() async {
    if (_buildingId.isEmpty) return;
    await ref.read(tablesViewModelProvider(_buildingId).notifier).refresh();
  }

  /// Open ([OrderStatus.progress]) orders seated on [tableId] (does not change list filter).
  Future<List<OrderView>> openOrdersForTable(UuidValue tableId) async {
    if (_buildingId.isEmpty) {
      return const [];
    }
    final list = await ref
        .read(orderRepositoryProvider)
        .list(UuidValue.fromString(_buildingId), status: OrderStatus.progress);
    return [
      for (final order in list)
        if (order.venueTableId == tableId) order,
    ];
  }

  void _patchOrder(OrderView saved) {
    final current = state.asData?.value;
    if (current == null) {
      return;
    }
    // Drop from list if it no longer matches the active status chip.
    if (_statusFilter != null && saved.status != _statusFilter) {
      state = AsyncData([
        for (final order in current)
          if (order.id != saved.id) order,
      ]);
      return;
    }
    state = AsyncData([
      for (final order in current)
        if (order.id == saved.id) saved else order,
    ]);
  }
}
