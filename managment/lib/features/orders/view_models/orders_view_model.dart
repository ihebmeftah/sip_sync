import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../tables/view_models/tables_view_model.dart';

part 'orders_view_model.g.dart';

@Riverpod(keepAlive: true)
class OrdersViewModel extends _$OrdersViewModel {
  late String _buildingId;

  @override
  Future<List<OrderView>> build(String buildingId) async {
    _buildingId = buildingId;
    ref.watch(signedInActorIdProvider);
    if (buildingId.isEmpty) {
      return const [];
    }
    return ref
        .read(orderRepositoryProvider)
        .list(UuidValue.fromString(buildingId));
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      if (_buildingId.isEmpty) {
        return const <OrderView>[];
      }
      return ref
          .read(orderRepositoryProvider)
          .list(UuidValue.fromString(_buildingId));
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

  void _patchOrder(OrderView saved) {
    final current = state.asData?.value;
    if (current == null) {
      return;
    }
    state = AsyncData([
      for (final order in current)
        if (order.id == saved.id) saved else order,
    ]);
  }
}
