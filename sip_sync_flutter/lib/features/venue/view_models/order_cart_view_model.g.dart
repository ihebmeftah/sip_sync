// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_cart_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Dishes selected for one venue. Survives the scan screen.

@ProviderFor(OrderCart)
const orderCartProvider = OrderCartFamily._();

/// Dishes selected for one venue. Survives the scan screen.
final class OrderCartProvider
    extends $NotifierProvider<OrderCart, List<CartLine>> {
  /// Dishes selected for one venue. Survives the scan screen.
  const OrderCartProvider._({
    required OrderCartFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'orderCartProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orderCartHash();

  @override
  String toString() {
    return r'orderCartProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  OrderCart create() => OrderCart();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CartLine> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CartLine>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is OrderCartProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orderCartHash() => r'cb36ed3afc1590b1f98357f75bc8ddce7e81c18e';

/// Dishes selected for one venue. Survives the scan screen.

final class OrderCartFamily extends $Family
    with
        $ClassFamilyOverride<
          OrderCart,
          List<CartLine>,
          List<CartLine>,
          List<CartLine>,
          String
        > {
  const OrderCartFamily._()
    : super(
        retry: null,
        name: r'orderCartProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Dishes selected for one venue. Survives the scan screen.

  OrderCartProvider call(String buildingId) =>
      OrderCartProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'orderCartProvider';
}

/// Dishes selected for one venue. Survives the scan screen.

abstract class _$OrderCart extends $Notifier<List<CartLine>> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  List<CartLine> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<List<CartLine>, List<CartLine>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<CartLine>, List<CartLine>>,
              List<CartLine>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
