import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/paging/list_paging.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../products/view_models/ingredients_view_model.dart';
import '../../tables/view_models/tables_view_model.dart';
import '../../cash_register/view_models/cash_register_view_model.dart';
import '../order_list_day.dart';

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
  OrderListDaySelection _dayFilter = const OrderListDaySelection.today();
  var _followRegister = true;

  /// Current list chip filter (`null` = all).
  OrderStatus? get statusFilter => _statusFilter;

  /// Day chip. Defaults to today and is sent for every caller.
  OrderListDaySelection get dayFilter => _dayFilter;

  /// True while the list follows the open cash register instead of a day chip.
  bool get followingRegister => _followRegister;

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

  /// Changes the day chip and reloads from the first page.
  Future<void> setDayFilter(OrderListDaySelection selection) async {
    if (!_followRegister && _dayFilter == selection) return;
    _followRegister = false;
    _dayFilter = selection;
    await refresh();
  }

  /// Follows the open register again. The day chips stay for another lookup.
  Future<void> followRegister() async {
    if (_followRegister) return;
    _followRegister = true;
    await refresh();
  }

  /// Remount: reset chips to All and the open register, or today.
  Future<void> onScreenAppeared() async {
    _statusFilter = null;
    _dayFilter = const OrderListDaySelection.today();
    _followRegister = true;
    await refresh();
  }

  Future<void> refresh() async {
    ref.invalidate(openCashRegisterProvider(_buildingId));
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

  Future<OrderPage> _fetch(int offset) async {
    final building = ref.read(buildingSelectionProvider);
    if (_followRegister && building?.cashRegisterEnabled == true) {
      final session = await ref.read(
        openCashRegisterProvider(_buildingId).future,
      );
      if (session == null) {
        return OrderPage(
          items: const [],
          total: 0,
          limit: listPageSize,
          offset: offset,
        );
      }
      return ref
          .read(orderRepositoryProvider)
          .list(
            UuidValue.fromString(_buildingId),
            status: _statusFilter,
            cashRegisterSessionId: session.id,
            limit: listPageSize,
            offset: offset,
          );
    }
    final window = orderListDayWindow(_dayFilter, DateTime.now());
    return ref
        .read(orderRepositoryProvider)
        .list(
          UuidValue.fromString(_buildingId),
          status: _statusFilter,
          createdFrom: window.from,
          createdTo: window.to,
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
    await _refreshOutOfStock();
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
    await _refreshOutOfStock();
    return saved;
  }

  Future<OrderView> updateItemStatus({
    required UuidValue id,
    required OrderItemStatus status,
    OrderCancellationReason? cancellationReason,
  }) async {
    final saved = await ref
        .read(orderRepositoryProvider)
        .updateItemStatus(
          id: id,
          status: status,
          cancellationReason: cancellationReason,
        );
    if (saved.status == OrderStatus.payed ||
        saved.status == OrderStatus.cancelled) {
      await refresh();
      await _refreshTables();
    } else {
      _patchOrder(saved);
    }
    if (status == OrderItemStatus.cancelled) {
      await _refreshOutOfStock();
    }
    return saved;
  }

  Future<OrderView> cancelOrder(
    UuidValue orderId,
    OrderCancellationReason reason,
  ) async {
    final saved = await ref
        .read(orderRepositoryProvider)
        .cancel(orderId, reason);
    await refresh();
    await _refreshTables();
    await _refreshOutOfStock();
    return saved;
  }

  Future<void> _refreshTables() async {
    if (_buildingId.isEmpty) return;
    await ref.read(tablesViewModelProvider(_buildingId).notifier).refresh();
  }

  Future<void> _refreshOutOfStock() {
    if (_buildingId.isEmpty) return Future.value();
    return ref
        .read(outOfStockIngredientCountProvider(_buildingId).notifier)
        .refresh();
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
