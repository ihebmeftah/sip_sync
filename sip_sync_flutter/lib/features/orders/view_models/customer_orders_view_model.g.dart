// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_orders_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Which history window the orders tab is showing. Last month is the start.

@ProviderFor(OrderHistoryFilterController)
const orderHistoryFilterControllerProvider =
    OrderHistoryFilterControllerProvider._();

/// Which history window the orders tab is showing. Last month is the start.
final class OrderHistoryFilterControllerProvider
    extends
        $NotifierProvider<OrderHistoryFilterController, OrderHistoryFilter> {
  /// Which history window the orders tab is showing. Last month is the start.
  const OrderHistoryFilterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderHistoryFilterControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderHistoryFilterControllerHash();

  @$internal
  @override
  OrderHistoryFilterController create() => OrderHistoryFilterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderHistoryFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderHistoryFilter>(value),
    );
  }
}

String _$orderHistoryFilterControllerHash() =>
    r'94d11d369e83e55e4f8af126aa52a606e6e308ff';

/// Which history window the orders tab is showing. Last month is the start.

abstract class _$OrderHistoryFilterController
    extends $Notifier<OrderHistoryFilter> {
  OrderHistoryFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<OrderHistoryFilter, OrderHistoryFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OrderHistoryFilter, OrderHistoryFilter>,
              OrderHistoryFilter,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Orders the signed-in customer placed in the selected window, all venues.

@ProviderFor(CustomerOrders)
const customerOrdersProvider = CustomerOrdersProvider._();

/// Orders the signed-in customer placed in the selected window, all venues.
final class CustomerOrdersProvider
    extends $AsyncNotifierProvider<CustomerOrders, CustomerOrderBoard> {
  /// Orders the signed-in customer placed in the selected window, all venues.
  const CustomerOrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customerOrdersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customerOrdersHash();

  @$internal
  @override
  CustomerOrders create() => CustomerOrders();
}

String _$customerOrdersHash() => r'2f12be41d41ffbe437b46b8cca44693f8f45dfea';

/// Orders the signed-in customer placed in the selected window, all venues.

abstract class _$CustomerOrders extends $AsyncNotifier<CustomerOrderBoard> {
  FutureOr<CustomerOrderBoard> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<CustomerOrderBoard>, CustomerOrderBoard>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CustomerOrderBoard>, CustomerOrderBoard>,
              AsyncValue<CustomerOrderBoard>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
