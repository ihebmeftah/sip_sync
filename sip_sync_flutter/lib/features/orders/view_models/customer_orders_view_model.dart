import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
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

/// Orders the signed-in customer placed in the selected window, all venues.
@riverpod
Future<List<CustomerOrderSummary>> customerOrders(Ref ref) {
  final filter = ref.watch(orderHistoryFilterControllerProvider);
  final window = orderHistoryWindow(filter, DateTime.now());
  return ref
      .read(customerOrderRepositoryProvider)
      .list(from: window.from, to: window.to);
}
