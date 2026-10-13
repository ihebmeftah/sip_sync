// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_screen_mode.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Remembers the orders screen choice for this session.

@ProviderFor(OrderScreenModeController)
const orderScreenModeControllerProvider = OrderScreenModeControllerProvider._();

/// Remembers the orders screen choice for this session.
final class OrderScreenModeControllerProvider
    extends $NotifierProvider<OrderScreenModeController, OrderScreenMode> {
  /// Remembers the orders screen choice for this session.
  const OrderScreenModeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderScreenModeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderScreenModeControllerHash();

  @$internal
  @override
  OrderScreenModeController create() => OrderScreenModeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderScreenMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderScreenMode>(value),
    );
  }
}

String _$orderScreenModeControllerHash() =>
    r'ba94bd80d7961100f7935ff92b3f95854b658427';

/// Remembers the orders screen choice for this session.

abstract class _$OrderScreenModeController extends $Notifier<OrderScreenMode> {
  OrderScreenMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<OrderScreenMode, OrderScreenMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OrderScreenMode, OrderScreenMode>,
              OrderScreenMode,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
