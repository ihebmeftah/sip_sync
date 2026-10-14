// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_kitchen_board_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Floor board for one building. History is the stream, not a poll.

@ProviderFor(OrderKitchenBoard)
const orderKitchenBoardProvider = OrderKitchenBoardFamily._();

/// Floor board for one building. History is the stream, not a poll.
final class OrderKitchenBoardProvider
    extends $AsyncNotifierProvider<OrderKitchenBoard, KitchenBoardState> {
  /// Floor board for one building. History is the stream, not a poll.
  const OrderKitchenBoardProvider._({
    required OrderKitchenBoardFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'orderKitchenBoardProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orderKitchenBoardHash();

  @override
  String toString() {
    return r'orderKitchenBoardProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  OrderKitchenBoard create() => OrderKitchenBoard();

  @override
  bool operator ==(Object other) {
    return other is OrderKitchenBoardProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orderKitchenBoardHash() => r'f9888bcb54dc3fdb40b3fb83baecba334bcf5d9c';

/// Floor board for one building. History is the stream, not a poll.

final class OrderKitchenBoardFamily extends $Family
    with
        $ClassFamilyOverride<
          OrderKitchenBoard,
          AsyncValue<KitchenBoardState>,
          KitchenBoardState,
          FutureOr<KitchenBoardState>,
          String
        > {
  const OrderKitchenBoardFamily._()
    : super(
        retry: null,
        name: r'orderKitchenBoardProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Floor board for one building. History is the stream, not a poll.

  OrderKitchenBoardProvider call(String buildingId) =>
      OrderKitchenBoardProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'orderKitchenBoardProvider';
}

/// Floor board for one building. History is the stream, not a poll.

abstract class _$OrderKitchenBoard extends $AsyncNotifier<KitchenBoardState> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<KitchenBoardState> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<KitchenBoardState>, KitchenBoardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<KitchenBoardState>, KitchenBoardState>,
              AsyncValue<KitchenBoardState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
