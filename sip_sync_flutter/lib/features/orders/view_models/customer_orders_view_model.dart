import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/paging/list_paging.dart';
import '../order_history_range.dart';

part 'customer_orders_view_model.g.dart';

/// Which history window the orders tab is showing. Last month is the start.
@Riverpod(keepAlive: true)
class OrderHistoryFilterController extends _$OrderHistoryFilterController {
  @override
  OrderHistoryFilter build() => OrderHistoryFilter.month;

  /// Switches the window. The list provider reloads from this.
  void select(OrderHistoryFilter filter) => state = filter;
}

/// Orders loaded so far for the selected history window.
class CustomerOrderBoard {
  const CustomerOrderBoard({
    required this.orders,
    required this.total,
    required this.from,
    required this.to,
    this.loadingMore = false,
    this.moreErrorKey,
  });

  final List<CustomerOrderSummary> orders;
  final int total;
  final DateTime from;
  final DateTime to;
  final bool loadingMore;
  final String? moreErrorKey;

  bool get hasMore => orders.length < total;

  CustomerOrderBoard copyWith({
    List<CustomerOrderSummary>? orders,
    int? total,
    bool? loadingMore,
    String? moreErrorKey,
    bool clearMoreError = false,
  }) {
    return CustomerOrderBoard(
      orders: orders ?? this.orders,
      total: total ?? this.total,
      from: from,
      to: to,
      loadingMore: loadingMore ?? this.loadingMore,
      moreErrorKey: clearMoreError ? null : (moreErrorKey ?? this.moreErrorKey),
    );
  }
}

/// Orders the signed-in customer placed in the selected window, all venues.
@riverpod
class CustomerOrders extends _$CustomerOrders {
  @override
  Future<CustomerOrderBoard> build() async {
    final filter = ref.watch(orderHistoryFilterControllerProvider);
    final window = orderHistoryWindow(filter, DateTime.now());
    final page = await ref
        .read(customerOrderRepositoryProvider)
        .list(
          from: window.from,
          to: window.to,
          limit: listPageSize,
          offset: 0,
        );
    return CustomerOrderBoard(
      orders: page.items,
      total: page.total,
      from: window.from,
      to: window.to,
    );
  }

  /// Appends the next page of this same history window.
  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || current.loadingMore || !current.hasMore) {
      return;
    }
    state = AsyncData(
      current.copyWith(loadingMore: true, clearMoreError: true),
    );
    try {
      final page = await ref
          .read(customerOrderRepositoryProvider)
          .list(
            from: current.from,
            to: current.to,
            limit: listPageSize,
            offset: current.orders.length,
          );
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
}
