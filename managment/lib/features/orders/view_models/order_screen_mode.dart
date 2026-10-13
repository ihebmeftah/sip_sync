import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_screen_mode.g.dart';

/// Which orders screen is showing.
enum OrderScreenMode {
  /// Lines grouped by status.
  items,

  /// Tickets in the original list.
  list,
}

/// Remembers the orders screen choice for this session.
@Riverpod(keepAlive: true)
class OrderScreenModeController extends _$OrderScreenModeController {
  @override
  OrderScreenMode build() => OrderScreenMode.items;

  void show(OrderScreenMode mode) => state = mode;
}
