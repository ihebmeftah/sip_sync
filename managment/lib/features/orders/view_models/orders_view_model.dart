import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/paging/list_paging.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../tables/view_models/tables_view_model.dart';

part 'orders_view_model.g.dart';

/// Floor orders loaded so far, newest first.
class OrderBoardState {
  const OrderBoardState({
    required this.orders,
    required this.total,
    this.loadingMore = false,
    this.moreErrorKey,
  });

  final List<OrderView> orders;
  final int total;
  final bool loadingMore;
  final String? moreErrorKey;

  bool get hasMore => orders.length < total;

  OrderBoardState copyWith({
    List<OrderView>? orders,
    int? total,
    bool? loadingMore,
    String? moreErrorKey,
    bool clearMoreError = false,
  }) {
    return OrderBoardState(
      orders: orders ?? this.orders,
      total: total ?? this.total,
      loadingMore: loadingMore ?? this.loadingMore,
      moreErrorKey: clearMoreError ? null : (moreErrorKey ?? this.moreErrorKey),
    );
  }
}

@Riverpod(keepAlive: true)
class OrdersViewModel extends _$OrdersViewModel {
  late String _buildingId;
  OrderStatus? _statusFilter;

  /// Current list chip filter (`null` = all).
  OrderStatus? get statusFilter => _statusFilter;

  @override
  Future<OrderBoardState> build(String buildingId) async {
    _buildingId = buildingId;
    ref.watch(signedInActorIdProvider);
    if (buildingId.isEmpty) {
      return const OrderBoardState(orders: [], total: 0);
    }
    final page = await _fetch(0);
    return OrderBoardState(orders: page.items, total: page.total);
  }

  /// Changes the status chip and reloads from the first page.
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
        return const OrderBoardState(orders: [], total: 0);
      }
      final page = await _fetch(0);
      return OrderBoardState(orders: page.items, total: page.total);
    });
  }

  /// Appends the next page when the list is near the end.
  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || current.loadingMore || !current.hasMore) {
      return;
    }
    state = AsyncData(
      current.copyWith(loadingMore: true, clearMoreError: true),
    );
    try {
      final page = await _fetch(current.orders.length);
      final seen = {for (final order in current.orders) order.id};
      state = AsyncData(
        current.copyWith(
          orders: [
            ...current.orders,
            for (final order in page.items)
              if (!seen.contains(order.id)) order,
          ],
          total: page.total,
          loadingMore: false,
        ),
      );
    } catch (error) {
      state = AsyncData(
        current.copyWith(
          loadingMore: false,
          moreErrorKey: mapError(error).l10nKey,
        ),
      );
    }
  }

  Future<OrderPage> _fetch(int offset) {
    return ref
        .read(orderRepositoryProvider)
        .list(
          UuidValue.fromString(_buildingId),
          status: _statusFilter,
          limit: listPageSize,
          offset: offset,
        );
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

  /// Open ([OrderStatus.progress]) orders seated on [tableId].
  Future<List<OrderView>> openOrdersForTable(UuidValue tableId) async {
    if (_buildingId.isEmpty) {
      return const [];
    }
    return ref
        .read(orderRepositoryProvider)
        .openForTable(UuidValue.fromString(_buildingId), tableId);
  }

  void _patchOrder(OrderView saved) {
    final current = state.asData?.value;
    if (current == null) {
      return;
    }
    if (_statusFilter != null && saved.status != _statusFilter) {
      state = AsyncData(
        current.copyWith(
          orders: [
            for (final order in current.orders)
              if (order.id != saved.id) order,
          ],
          total: current.total > 0 ? current.total - 1 : 0,
        ),
      );
      return;
    }
    state = AsyncData(
      current.copyWith(
        orders: [
          for (final order in current.orders)
            if (order.id == saved.id) saved else order,
        ],
      ),
    );
  }
}
