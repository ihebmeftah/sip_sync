// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_draft_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OrderDraftViewModel)
const orderDraftViewModelProvider = OrderDraftViewModelFamily._();

final class OrderDraftViewModelProvider
    extends $NotifierProvider<OrderDraftViewModel, OrderDraftState> {
  const OrderDraftViewModelProvider._({
    required OrderDraftViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'orderDraftViewModelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orderDraftViewModelHash();

  @override
  String toString() {
    return r'orderDraftViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  OrderDraftViewModel create() => OrderDraftViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderDraftState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderDraftState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is OrderDraftViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orderDraftViewModelHash() =>
    r'43c36fbb09315fe4395d98ff73c51b6887589f5f';

final class OrderDraftViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          OrderDraftViewModel,
          OrderDraftState,
          OrderDraftState,
          OrderDraftState,
          String
        > {
  const OrderDraftViewModelFamily._()
    : super(
        retry: null,
        name: r'orderDraftViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  OrderDraftViewModelProvider call(String buildingId) =>
      OrderDraftViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'orderDraftViewModelProvider';
}

abstract class _$OrderDraftViewModel extends $Notifier<OrderDraftState> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  OrderDraftState build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<OrderDraftState, OrderDraftState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OrderDraftState, OrderDraftState>,
              OrderDraftState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
