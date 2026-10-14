// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OrdersViewModel)
const ordersViewModelProvider = OrdersViewModelFamily._();

final class OrdersViewModelProvider
    extends $AsyncNotifierProvider<OrdersViewModel, OrderBoardState> {
  const OrdersViewModelProvider._({
    required OrdersViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'ordersViewModelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ordersViewModelHash();

  @override
  String toString() {
    return r'ordersViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  OrdersViewModel create() => OrdersViewModel();

  @override
  bool operator ==(Object other) {
    return other is OrdersViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ordersViewModelHash() => r'763f441fad0b4c57520593f79c0ae38be9970a7d';

final class OrdersViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          OrdersViewModel,
          AsyncValue<OrderBoardState>,
          OrderBoardState,
          FutureOr<OrderBoardState>,
          String
        > {
  const OrdersViewModelFamily._()
    : super(
        retry: null,
        name: r'ordersViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  OrdersViewModelProvider call(String buildingId) =>
      OrdersViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'ordersViewModelProvider';
}

abstract class _$OrdersViewModel extends $AsyncNotifier<OrderBoardState> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<OrderBoardState> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<OrderBoardState>, OrderBoardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<OrderBoardState>, OrderBoardState>,
              AsyncValue<OrderBoardState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
