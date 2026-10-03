// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_order_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Sends the cart for one venue and clears it when the server accepts.

@ProviderFor(OrderPass)
const orderPassProvider = OrderPassFamily._();

/// Sends the cart for one venue and clears it when the server accepts.
final class OrderPassProvider extends $AsyncNotifierProvider<OrderPass, void> {
  /// Sends the cart for one venue and clears it when the server accepts.
  const OrderPassProvider._({
    required OrderPassFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'orderPassProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orderPassHash();

  @override
  String toString() {
    return r'orderPassProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  OrderPass create() => OrderPass();

  @override
  bool operator ==(Object other) {
    return other is OrderPassProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orderPassHash() => r'db69052512795b6d2da90a599b4f2323eee6ed41';

/// Sends the cart for one venue and clears it when the server accepts.

final class OrderPassFamily extends $Family
    with
        $ClassFamilyOverride<
          OrderPass,
          AsyncValue<void>,
          void,
          FutureOr<void>,
          String
        > {
  const OrderPassFamily._()
    : super(
        retry: null,
        name: r'orderPassProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Sends the cart for one venue and clears it when the server accepts.

  OrderPassProvider call(String buildingId) =>
      OrderPassProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'orderPassProvider';
}

/// Sends the cart for one venue and clears it when the server accepts.

abstract class _$OrderPass extends $AsyncNotifier<void> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<void> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    build(_$args);
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}

/// The customer's open order, if one is still in progress.

@ProviderFor(openCustomerOrder)
const openCustomerOrderProvider = OpenCustomerOrderProvider._();

/// The customer's open order, if one is still in progress.

final class OpenCustomerOrderProvider
    extends
        $FunctionalProvider<
          AsyncValue<CustomerOrderView?>,
          CustomerOrderView?,
          FutureOr<CustomerOrderView?>
        >
    with
        $FutureModifier<CustomerOrderView?>,
        $FutureProvider<CustomerOrderView?> {
  /// The customer's open order, if one is still in progress.
  const OpenCustomerOrderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openCustomerOrderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openCustomerOrderHash();

  @$internal
  @override
  $FutureProviderElement<CustomerOrderView?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CustomerOrderView?> create(Ref ref) {
    return openCustomerOrder(ref);
  }
}

String _$openCustomerOrderHash() => r'1552602e25eb259603f2c95021cb6f981269ea19';

/// The receipt for an order this customer placed.

@ProviderFor(CustomerOrderDetail)
const customerOrderDetailProvider = CustomerOrderDetailFamily._();

/// The receipt for an order this customer placed.
final class CustomerOrderDetailProvider
    extends $AsyncNotifierProvider<CustomerOrderDetail, CustomerOrderView> {
  /// The receipt for an order this customer placed.
  const CustomerOrderDetailProvider._({
    required CustomerOrderDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'customerOrderDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$customerOrderDetailHash();

  @override
  String toString() {
    return r'customerOrderDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CustomerOrderDetail create() => CustomerOrderDetail();

  @override
  bool operator ==(Object other) {
    return other is CustomerOrderDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customerOrderDetailHash() =>
    r'85924683cc5e30e717b4ba750c0830782fd50dc0';

/// The receipt for an order this customer placed.

final class CustomerOrderDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          CustomerOrderDetail,
          AsyncValue<CustomerOrderView>,
          CustomerOrderView,
          FutureOr<CustomerOrderView>,
          String
        > {
  const CustomerOrderDetailFamily._()
    : super(
        retry: null,
        name: r'customerOrderDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The receipt for an order this customer placed.

  CustomerOrderDetailProvider call(String orderId) =>
      CustomerOrderDetailProvider._(argument: orderId, from: this);

  @override
  String toString() => r'customerOrderDetailProvider';
}

/// The receipt for an order this customer placed.

abstract class _$CustomerOrderDetail extends $AsyncNotifier<CustomerOrderView> {
  late final _$args = ref.$arg as String;
  String get orderId => _$args;

  FutureOr<CustomerOrderView> build(String orderId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<CustomerOrderView>, CustomerOrderView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CustomerOrderView>, CustomerOrderView>,
              AsyncValue<CustomerOrderView>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
