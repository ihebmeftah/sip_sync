import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../auth/view_models/auth_view_model.dart';
import 'order_cart_view_model.dart';
import 'seated_table_view_model.dart';

part 'customer_order_view_model.g.dart';

/// Sends the cart for one venue and clears it when the server accepts.
@riverpod
class OrderPass extends _$OrderPass {
  @override
  FutureOr<void> build(String buildingId) {}

  /// Places [tableId] with the current cart. Returns the receipt.
  Future<CustomerOrderView> submit(UuidValue tableId) async {
    final lines = ref.read(orderCartProvider(buildingId));
    state = const AsyncLoading();
    try {
      final order = await ref
          .read(customerOrderRepositoryProvider)
          .place(
            buildingId: UuidValue.fromString(buildingId),
            tableId: tableId,
            items: [
              for (final line in lines)
                for (var unit = 0; unit < line.quantity; unit++)
                  CustomerOrderItem(
                    articleId: UuidValue.fromString(line.articleId),
                  ),
            ],
          );
      ref.read(orderCartProvider(buildingId).notifier).clear();
      ref.invalidate(openCustomerOrderProvider);
      state = const AsyncData(null);
      return order;
    } catch (error, stack) {
      state = AsyncError(error, stack);
      rethrow;
    }
  }

  /// Adds the cart onto [orderId], which must still be in progress.
  Future<CustomerOrderView> append(UuidValue orderId) async {
    final lines = ref.read(orderCartProvider(buildingId));
    state = const AsyncLoading();
    try {
      final order = await ref
          .read(customerOrderRepositoryProvider)
          .append(
            orderId: orderId,
            items: [
              for (final line in lines)
                for (var unit = 0; unit < line.quantity; unit++)
                  CustomerOrderItem(
                    articleId: UuidValue.fromString(line.articleId),
                  ),
            ],
          );
      ref.read(orderCartProvider(buildingId).notifier).clear();
      ref.invalidate(openCustomerOrderProvider);
      ref.invalidate(customerOrderDetailProvider(order.id.uuid));
      state = const AsyncData(null);
      return order;
    } catch (error, stack) {
      state = AsyncError(error, stack);
      rethrow;
    }
  }
}

/// The customer's open order, kept live while they are signed in.
///
/// Staff status changes, payment, and cancellation arrive on the same
/// stream, so the visit unlocks without a refresh.
@Riverpod(keepAlive: true)
class OpenCustomerOrder extends _$OpenCustomerOrder {
  StreamSubscription<CustomerOrderLive>? _live;

  @override
  Future<CustomerOrderView?> build() async {
    ref.onDispose(() {
      _live?.cancel();
      _live = null;
    });
    final signedIn = ref.watch(authViewModelProvider).session != null;
    if (!signedIn) {
      return null;
    }
    final ready = Completer<CustomerOrderView?>();
    _live = ref
        .read(customerOrderRepositoryProvider)
        .watchCurrent()
        .listen(
          (event) {
            final changed = event.changed;
            if (changed != null) {
              _applyDetail(changed);
              _releaseSeat(changed);
            }
            if (!ready.isCompleted) {
              ready.complete(event.open);
            } else {
              state = AsyncData(event.open);
            }
          },
          onError: (Object error, StackTrace stack) {
            if (!ready.isCompleted) {
              ready.completeError(error, stack);
            }
          },
        );
    return ready.future;
  }

  void _applyDetail(CustomerOrderView order) {
    final detail = customerOrderDetailProvider(order.id.uuid);
    if (ref.exists(detail)) {
      ref.read(detail.notifier).apply(order);
    }
  }

  /// A paid or cancelled visit ends the scan. The next order starts at the sticker.
  void _releaseSeat(CustomerOrderView order) {
    if (order.status != OrderStatus.payed &&
        order.status != OrderStatus.cancelled) {
      return;
    }
    ref.read(seatedTableProvider.notifier).leave();
  }
}

/// The receipt for an order this customer placed.
@riverpod
class CustomerOrderDetail extends _$CustomerOrderDetail {
  @override
  Future<CustomerOrderView> build(String orderId) {
    return ref
        .read(customerOrderRepositoryProvider)
        .getOrder(UuidValue.fromString(orderId));
  }

  /// Replaces the receipt when the live visit already has the new lines.
  void apply(CustomerOrderView order) {
    state = AsyncData(order);
  }
}
