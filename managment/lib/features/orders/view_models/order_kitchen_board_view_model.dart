import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../products/view_models/ingredients_view_model.dart';
import '../../tables/view_models/tables_view_model.dart';
import '../../cash_register/view_models/cash_register_view_model.dart';
import '../order_list_day.dart';

part 'order_kitchen_board_view_model.g.dart';

/// Open tickets on the floor board, plus which ones just arrived.
class KitchenBoardState {
  const KitchenBoardState({
    required this.orders,
    required this.newOrderIds,
    required this.addedItemIds,
    this.live = false,
    this.registerClosed = false,
  });

  final List<OrderView> orders;

  /// Tickets created after the board opened.
  final Set<String> newOrderIds;

  /// Lines appended to a ticket that was already open.
  final Set<String> addedItemIds;
  final bool live;

  /// The venue requires a register and none is open.
  final bool registerClosed;

  KitchenBoardState copyWith({
    List<OrderView>? orders,
    Set<String>? newOrderIds,
    Set<String>? addedItemIds,
    bool? live,
    bool? registerClosed,
  }) {
    return KitchenBoardState(
      orders: orders ?? this.orders,
      newOrderIds: newOrderIds ?? this.newOrderIds,
      addedItemIds: addedItemIds ?? this.addedItemIds,
      live: live ?? this.live,
      registerClosed: registerClosed ?? this.registerClosed,
    );
  }
}

/// Floor board for one building. History is the stream, not a poll.
@Riverpod(keepAlive: true)
class OrderKitchenBoard extends _$OrderKitchenBoard {
  StreamSubscription<OrderBoardEvent>? _live;

  @override
  Future<KitchenBoardState> build(String buildingId) async {
    ref.listen(buildingSelectionProvider, (previous, next) {
      if (previous?.strictMode != next?.strictMode ||
          previous?.cashRegisterEnabled != next?.cashRegisterEnabled) {
        ref.invalidateSelf();
      }
    });
    ref.onDispose(() {
      _live?.cancel();
      _live = null;
    });
    if (buildingId.isEmpty) {
      return const KitchenBoardState(
        orders: [],
        newOrderIds: {},
        addedItemIds: {},
      );
    }
    final building = ref.read(buildingSelectionProvider);
    final registerRequired =
        building?.cashRegisterEnabled == true &&
        building?.id.uuid == buildingId;
    UuidValue? sessionId;
    if (registerRequired) {
      final session = await ref.watch(
        openCashRegisterProvider(buildingId).future,
      );
      if (session == null) {
        return const KitchenBoardState(
          orders: [],
          newOrderIds: {},
          addedItemIds: {},
          registerClosed: true,
        );
      }
      sessionId = session.id;
    }
    final day = orderListDayWindow(
      const OrderListDaySelection.today(),
      DateTime.now(),
    );
    if (!registerRequired) {
      var untilMidnight = day.to.difference(DateTime.now());
      if (untilMidnight <= Duration.zero) {
        untilMidnight = const Duration(seconds: 1);
      }
      final rollDay = Timer(untilMidnight, ref.invalidateSelf);
      ref.onDispose(rollDay.cancel);
    }
    final ready = Completer<KitchenBoardState>();
    var current = const KitchenBoardState(
      orders: [],
      newOrderIds: {},
      addedItemIds: {},
    );
    _live = ref
        .read(orderRepositoryProvider)
        .watchBoard(
          UuidValue.fromString(buildingId),
          createdFrom: sessionId == null ? day.from : null,
          createdTo: sessionId == null ? day.to : null,
          cashRegisterSessionId: sessionId,
        )
        .listen(
          (event) {
            current = _reduce(current, event);
            if (event.kind != OrderBoardEventKind.synced) {
              unawaited(_refreshOutOfStock());
            }
            if (!ready.isCompleted) {
              if (event.kind == OrderBoardEventKind.synced) {
                ready.complete(current);
              }
            } else {
              state = AsyncData(current);
            }
          },
          onError: (Object error, StackTrace stack) {
            if (!ready.isCompleted) {
              ready.completeError(error, stack);
            } else {
              state = AsyncError(error, stack);
            }
          },
        );
    return ready.future;
  }

  /// Moves one line to [status]. The server still checks the step is allowed.
  Future<void> advance(UuidValue itemId, OrderItemStatus status) async {
    final saved = await ref
        .read(orderRepositoryProvider)
        .updateItemStatus(id: itemId, status: status);
    _apply(saved, clearItemId: itemId.uuid);
  }

  /// Cancels one open line. The server still requires cancel access and a reason.
  Future<void> cancelItem(
    UuidValue itemId,
    OrderCancellationReason reason,
  ) async {
    final saved = await ref
        .read(orderRepositoryProvider)
        .updateItemStatus(
          id: itemId,
          status: OrderItemStatus.cancelled,
          cancellationReason: reason,
        );
    _apply(saved, clearItemId: itemId.uuid);
    unawaited(_refreshOutOfStock());
  }

  /// Cancels every open line on the ticket and frees the table.
  Future<void> cancelOrder(
    UuidValue orderId,
    OrderCancellationReason reason,
  ) async {
    final saved = await ref
        .read(orderRepositoryProvider)
        .cancel(orderId, reason);
    _apply(saved);
    unawaited(_refreshOutOfStock());
  }

  Future<void> _refreshOutOfStock() {
    if (buildingId.isEmpty) return Future.value();
    return ref
        .read(outOfStockIngredientCountProvider(buildingId).notifier)
        .refresh();
  }

  void _apply(OrderView saved, {String? clearItemId}) {
    _reinitTable(saved);
    final current = state.asData?.value;
    if (current == null) {
      return;
    }
    state = AsyncData(
      _place(current, saved, acknowledgeOrder: true, clearItemId: clearItemId),
    );
  }

  KitchenBoardState _reduce(KitchenBoardState current, OrderBoardEvent event) {
    if (event.kind == OrderBoardEventKind.synced) {
      return current.copyWith(live: true);
    }
    final order = event.order;
    if (order == null) {
      return current;
    }
    _reinitTable(order);
    final next = _place(current, order);
    if (event.kind == OrderBoardEventKind.orderOpened) {
      return next.copyWith(newOrderIds: {...next.newOrderIds, order.id.uuid});
    }
    if (event.kind == OrderBoardEventKind.itemsAdded) {
      return next.copyWith(
        addedItemIds: {
          ...next.addedItemIds,
          for (final id in event.itemIds) id.uuid,
        },
      );
    }
    return next;
  }

  /// A paid or cancelled ticket frees its table on the floor map.
  void _reinitTable(OrderView order) {
    if (order.status != OrderStatus.payed &&
        order.status != OrderStatus.cancelled) {
      return;
    }
    if (buildingId.isEmpty) {
      return;
    }
    unawaited(ref.read(tablesViewModelProvider(buildingId).notifier).refresh());
  }

  KitchenBoardState _place(
    KitchenBoardState current,
    OrderView order, {
    bool acknowledgeOrder = false,
    String? clearItemId,
  }) {
    final orders = [...current.orders];
    final index = orders.indexWhere((row) => row.id == order.id);
    final keepPayed = ref.read(buildingSelectionProvider)?.strictMode == false;
    final drop =
        order.status == OrderStatus.cancelled ||
        (order.status == OrderStatus.payed && !keepPayed) ||
        (order.status != OrderStatus.progress &&
            order.status != OrderStatus.payed);
    if (drop) {
      if (index >= 0) {
        orders.removeAt(index);
      }
    } else if (index >= 0) {
      orders[index] = order;
    } else {
      orders.insert(0, order);
    }
    final newOrderIds = {...current.newOrderIds};
    final addedItemIds = {...current.addedItemIds};
    if (drop || acknowledgeOrder) {
      newOrderIds.remove(order.id.uuid);
    }
    if (clearItemId != null) {
      addedItemIds.remove(clearItemId);
    }
    if (drop) {
      for (final item in order.items) {
        addedItemIds.remove(item.id.uuid);
      }
    }
    return current.copyWith(
      orders: orders,
      newOrderIds: newOrderIds,
      addedItemIds: addedItemIds,
    );
  }
}
