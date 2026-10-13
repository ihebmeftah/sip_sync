import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/order_screen_mode.dart';
import 'order_board_view.dart';
import 'orders_list_view.dart';

/// Orders for one venue: item board or the ticket list.
class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key, required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(orderScreenModeControllerProvider);
    return switch (mode) {
      OrderScreenMode.items => OrderBoardView(buildingId: buildingId),
      OrderScreenMode.list => OrdersListView(buildingId: buildingId),
    };
  }
}
