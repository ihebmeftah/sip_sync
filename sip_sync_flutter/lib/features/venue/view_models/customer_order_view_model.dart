import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import 'order_cart_view_model.dart';

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

/// The customer's open order, if one is still in progress.
@riverpod
Future<CustomerOrderView?> openCustomerOrder(Ref ref) {
  return ref.watch(customerOrderRepositoryProvider).current();
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
}
