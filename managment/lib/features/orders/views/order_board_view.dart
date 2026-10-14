import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/access/floor_access.dart';
import '../../../core/di/app_providers.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/order_kitchen_board_view_model.dart';
import '../widgets/cancellation_reason_dialog.dart';
import '../widgets/order_item_workflow.dart';
import '../widgets/order_status_labels.dart';
import '../widgets/order_view_switch.dart';

/// Floor board: one column per enabled venue step, grouped by table and ref.
class OrderBoardView extends ConsumerStatefulWidget {
  const OrderBoardView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<OrderBoardView> createState() => _OrderBoardViewState();
}

class _OrderBoardViewState extends ConsumerState<OrderBoardView> {
  var _selecting = false;
  var _busy = false;
  final _selected = <String>{};

  @override
  Widget build(BuildContext context) {
    final buildingId = widget.buildingId;
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final board = ref.watch(orderKitchenBoardProvider(buildingId));
    final building = ref.watch(buildingSelectionProvider);
    final session = ref.watch(appSessionStoreProvider);
    final access = FloorAccess.fromSession(session);
    final seesAll = session.isOwner || access.canConsultAll;
    final currency = building?.currencyCode ?? '';
    final strictMode = building?.strictMode ?? false;
    final steps = effectiveStrictModeSteps(
      strictMode: strictMode,
      steps: building?.strictModeSteps,
    );
    final columns = visibleWorkflowColumns(
      strictMode: strictMode,
      steps: steps,
      access: access,
      seesAll: seesAll,
    );

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: board.when(
        loading: () => const AppScreenLoader(),
        error: (error, _) => Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              AppErrorBanner(
                message: lookupError(l10n, mapError(error).l10nKey),
              ),
              AppFilledButton(
                label: l10n.retry,
                onPressed: () =>
                    ref.invalidate(orderKitchenBoardProvider(buildingId)),
              ),
            ],
          ),
        ),
        data: (page) {
          final shown = boardColumnsIncludingOpenLines(
            strictMode: strictMode,
            columns: columns,
            orders: page.orders,
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.navOrders,
                            style: text.headlineSmall,
                          ),
                        ),
                        const OrderViewSwitch(),
                      ],
                    ),
                    if (access.canCancel) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          _BoardAction(
                            label: l10n.orderBoardCancel,
                            filled: _selecting,
                            onPressed: _busy ? null : _toggleSelecting,
                          ),
                          if (_selecting) ...[
                            const SizedBox(width: AppSpacing.sm),
                            _BoardAction(
                              label: l10n.orderBoardCancelConfirm,
                              filled: true,
                              onPressed: _selected.isEmpty || _busy
                                  ? null
                                  : () => _confirm(page.orders),
                            ),
                          ],
                        ],
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      page.registerClosed
                          ? l10n.cashRegisterBoardClosed
                          : _selecting
                          ? l10n.orderBoardCancelHint
                          : l10n.orderBoardHint,
                      style: text.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.ordersFilterToday,
                      style: text.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.xl,
                  ),
                  itemCount: shown.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final status = shown[index];
                    return _StatusColumn(
                      buildingId: buildingId,
                      status: status,
                      orders: page.orders,
                      newOrderIds: page.newOrderIds,
                      addedItemIds: page.addedItemIds,
                      currency: currency,
                      showPrice: access.canPay,
                      strictMode: strictMode,
                      steps: steps,
                      access: access,
                      seesAll: seesAll,
                      isOwner: session.isOwner,
                      actorType: session.actorType,
                      actorId: session.actorId,
                      selecting: _selecting,
                      selectedIds: _selected,
                      onToggleItem: _toggleItem,
                      onToggleOrder: (order) => _toggleOrder(
                        order,
                        shown,
                        steps,
                        access,
                        seesAll,
                        session.isOwner,
                        session.actorType,
                        session.actorId,
                      ),
                      orderSelection: (order) => _orderSelection(
                        order,
                        shown,
                        steps,
                        access,
                        seesAll,
                        session.isOwner,
                        session.actorType,
                        session.actorId,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _toggleSelecting() {
    setState(() {
      _selecting = !_selecting;
      if (!_selecting) {
        _selected.clear();
      }
    });
  }

  void _toggleItem(String itemId) {
    setState(() {
      if (!_selected.add(itemId)) {
        _selected.remove(itemId);
      }
    });
  }

  void _toggleOrder(
    OrderView order,
    List<OrderItemStatus> columns,
    List<StrictModeStep> steps,
    FloorAccess access,
    bool seesAll,
    bool isOwner,
    ActorType? actorType,
    UuidValue? actorId,
  ) {
    final ids = _visibleIds(
      order,
      columns,
      steps,
      access,
      seesAll,
      isOwner,
      actorType,
      actorId,
    );
    final all = ids.isNotEmpty && ids.every(_selected.contains);
    setState(() {
      if (all) {
        _selected.removeAll(ids);
      } else {
        _selected.addAll(ids);
      }
    });
  }

  Future<void> _confirm(List<OrderView> orders) async {
    final reason = await showCancellationReasonDialog(context);
    if (reason == null || !mounted) {
      return;
    }
    setState(() => _busy = true);
    final board = ref.read(
      orderKitchenBoardProvider(widget.buildingId).notifier,
    );
    try {
      for (final order in orders) {
        final chosen = [
          for (final item in order.items)
            if (_selected.contains(item.id.uuid)) item,
        ];
        if (chosen.isEmpty) {
          continue;
        }
        final open = [
          for (final item in order.items)
            if (item.status != OrderItemStatus.payed &&
                item.status != OrderItemStatus.cancelled)
              item,
        ];
        if (!orderCancelLocked(order) && chosen.length == open.length) {
          await board.cancelOrder(order.id, reason);
        } else {
          for (final item in chosen) {
            if (lineCancelLocked(item)) {
              continue;
            }
            await board.cancelItem(item.id, reason);
          }
        }
      }
      if (mounted) {
        setState(() {
          _selecting = false;
          _selected.clear();
        });
      }
    } catch (error) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        showAppSnackBar(context, lookupError(l10n, mapError(error).l10nKey));
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  bool? _orderSelection(
    OrderView order,
    List<OrderItemStatus> columns,
    List<StrictModeStep> steps,
    FloorAccess access,
    bool seesAll,
    bool isOwner,
    ActorType? actorType,
    UuidValue? actorId,
  ) {
    final ids = _visibleIds(
      order,
      columns,
      steps,
      access,
      seesAll,
      isOwner,
      actorType,
      actorId,
    );
    if (ids.isEmpty) {
      return false;
    }
    final picked = ids.where(_selected.contains).length;
    if (picked == 0) {
      return false;
    }
    if (picked == ids.length) {
      return true;
    }
    return null;
  }

  Set<String> _visibleIds(
    OrderView order,
    List<OrderItemStatus> columns,
    List<StrictModeStep> steps,
    FloorAccess access,
    bool seesAll,
    bool isOwner,
    ActorType? actorType,
    UuidValue? actorId,
  ) {
    return {
      for (final item in order.items)
        if (item.status != OrderItemStatus.payed &&
            item.status != OrderItemStatus.cancelled &&
            !lineCancelLocked(item) &&
            columns.contains(item.status) &&
            (seesAll ||
                canAdvanceWorkflowItem(
                  order: order,
                  item: item,
                  next: nextEnabledStrictStatus(item.status, steps),
                  access: access,
                  isOwner: isOwner,
                  seesAll: seesAll,
                  actorType: actorType,
                  actorId: actorId,
                )))
          item.id.uuid,
    };
  }
}

class _StatusColumn extends ConsumerWidget {
  const _StatusColumn({
    required this.buildingId,
    required this.status,
    required this.orders,
    required this.newOrderIds,
    required this.addedItemIds,
    required this.currency,
    required this.showPrice,
    required this.strictMode,
    required this.steps,
    required this.access,
    required this.seesAll,
    required this.isOwner,
    required this.actorType,
    required this.actorId,
    required this.selecting,
    required this.selectedIds,
    required this.onToggleItem,
    required this.onToggleOrder,
    required this.orderSelection,
  });

  final String buildingId;
  final OrderItemStatus status;
  final List<OrderView> orders;
  final Set<String> newOrderIds;
  final Set<String> addedItemIds;
  final String currency;
  final bool showPrice;
  final bool strictMode;
  final List<StrictModeStep> steps;
  final FloorAccess access;
  final bool seesAll;
  final bool isOwner;
  final ActorType? actorType;
  final UuidValue? actorId;
  final bool selecting;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggleItem;
  final ValueChanged<OrderView> onToggleOrder;
  final bool? Function(OrderView order) orderSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final colors = orderItemStatusColors(scheme, status);
    final groups = _groups();
    final count = groups.fold<int>(0, (sum, group) => sum + group.items.length);

    return DragTarget<_TableDrag>(
      onWillAcceptWithDetails: (details) =>
          !selecting && details.data.next == status,
      onAcceptWithDetails: (details) {
        _drop(context, ref, details.data);
      },
      builder: (context, candidate, _) {
        final hot = candidate.isNotEmpty;
        return SizedBox(
          width: 300,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            decoration: BoxDecoration(
              color: hot ? colors.background : scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadii.lg),
              border: Border.all(
                color: hot
                    ? colors.foreground
                    : colors.foreground.withValues(alpha: 0.35),
                width: hot ? 2 : 1,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ColoredBox(
                  color: colors.background,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.md,
                      AppSpacing.md,
                      AppSpacing.sm,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            orderItemStatusLabel(l10n, status),
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: colors.foreground,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: colors.foreground,
                            borderRadius: BorderRadius.circular(AppRadii.lg),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 2,
                            ),
                            child: Text(
                              '$count',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: colors.background,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.sm,
                      AppSpacing.sm,
                      AppSpacing.sm,
                      AppSpacing.md,
                    ),
                    itemCount: groups.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, index) {
                      final group = groups[index];
                      return _TicketGroupCard(
                        buildingId: buildingId,
                        order: group.order,
                        items: group.items,
                        isNewOrder: newOrderIds.contains(group.order.id.uuid),
                        addedItemIds: addedItemIds,
                        currency: currency,
                        showPrice: showPrice,
                        accent: colors.foreground,
                        strictMode: strictMode,
                        steps: steps,
                        access: access,
                        seesAll: seesAll,
                        isOwner: isOwner,
                        actorType: actorType,
                        actorId: actorId,
                        selecting: selecting,
                        selectedIds: selectedIds,
                        onToggleItem: onToggleItem,
                        onToggleOrder: () => onToggleOrder(group.order),
                        orderSelected: orderSelection(group.order),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _drop(
    BuildContext context,
    WidgetRef ref,
    _TableDrag drag,
  ) async {
    for (final id in drag.itemIds) {
      try {
        await ref
            .read(orderKitchenBoardProvider(buildingId).notifier)
            .advance(id, drag.next);
      } catch (error) {
        if (context.mounted) {
          final l10n = AppLocalizations.of(context)!;
          showAppSnackBar(context, lookupError(l10n, mapError(error).l10nKey));
        }
        return;
      }
    }
  }

  List<({OrderView order, List<OrderItemView> items})> _groups() {
    final groups = <({OrderView order, List<OrderItemView> items})>[];
    final sorted = [...orders]
      ..sort((a, b) {
        final table = (a.tableNumber ?? 1 << 20).compareTo(
          b.tableNumber ?? 1 << 20,
        );
        if (table != 0) {
          return table;
        }
        return a.ref.compareTo(b.ref);
      });
    for (final order in sorted) {
      final items = [
        for (final item in order.items)
          if (item.status == status &&
              item.status != OrderItemStatus.cancelled &&
              (seesAll ||
                  (status == OrderItemStatus.payed &&
                      !strictMode &&
                      access.canPay &&
                      actorMayRecordService(
                        order: order,
                        item: item,
                        seesAll: seesAll,
                        actorType: actorType,
                        actorId: actorId,
                      )) ||
                  canAdvanceWorkflowItem(
                    order: order,
                    item: item,
                    next: nextEnabledStrictStatus(item.status, steps),
                    access: access,
                    isOwner: isOwner,
                    seesAll: seesAll,
                    actorType: actorType,
                    actorId: actorId,
                  )))
            item,
      ]..sort((a, b) => a.createdAt.compareTo(b.createdAt));
      if (items.isEmpty) {
        continue;
      }
      groups.add((order: order, items: items));
    }
    return groups;
  }
}

class _TicketGroupCard extends ConsumerWidget {
  const _TicketGroupCard({
    required this.buildingId,
    required this.order,
    required this.items,
    required this.isNewOrder,
    required this.addedItemIds,
    required this.currency,
    required this.showPrice,
    required this.accent,
    required this.strictMode,
    required this.steps,
    required this.access,
    required this.seesAll,
    required this.isOwner,
    required this.actorType,
    required this.actorId,
    required this.selecting,
    required this.selectedIds,
    required this.onToggleItem,
    required this.onToggleOrder,
    required this.orderSelected,
  });

  final String buildingId;
  final OrderView order;
  final List<OrderItemView> items;
  final bool isNewOrder;
  final Set<String> addedItemIds;
  final String currency;
  final bool showPrice;
  final Color accent;
  final bool strictMode;
  final List<StrictModeStep> steps;
  final FloorAccess access;
  final bool seesAll;
  final bool isOwner;
  final ActorType? actorType;
  final UuidValue? actorId;
  final bool selecting;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggleItem;
  final VoidCallback onToggleOrder;
  final bool? orderSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final table = order.tableNumber == null
        ? l10n.orderBoardNoTable
        : l10n.orderTableNumber(order.tableNumber!);
    final label = '$table · ${l10n.orderRefLabel(order.ref)}';
    final drag = selecting ? null : _dragData(label);
    final card = Material(
      color: scheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.md),
        side: BorderSide(color: accent.withValues(alpha: 0.45)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: selecting
                ? onToggleOrder
                : () => OrderDetailRoute(
                    buildingId: buildingId,
                    orderId: order.id.uuid,
                  ).go(context),
            child: ColoredBox(
              color: accent.withValues(alpha: 0.08),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.sm,
                  AppSpacing.sm,
                  AppSpacing.md,
                  AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    if (selecting)
                      IgnorePointer(
                        child: Checkbox(
                          tristate: true,
                          value: orderSelected,
                          activeColor: accent,
                          onChanged: (_) {},
                        ),
                      )
                    else
                      Icon(Icons.drag_indicator, size: 18, color: accent),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(child: Text(label, style: text.titleSmall)),
                    if (isNewOrder)
                      _Flag(
                        label: l10n.orderBoardNewOrder,
                        background: scheme.primaryContainer,
                        foreground: scheme.onPrimaryContainer,
                      ),
                  ],
                ),
              ),
            ),
          ),
          for (final item in items)
            _Line(
              item: item,
              added: addedItemIds.contains(item.id.uuid),
              currency: currency,
              showPrice: showPrice,
              selected: selecting ? selectedIds.contains(item.id.uuid) : null,
              onToggle: selecting && !lineCancelLocked(item)
                  ? () => onToggleItem(item.id.uuid)
                  : null,
              next: nextOrderItemStatusForBuilding(
                item.status,
                strictMode: strictMode,
                steps: steps,
              ),
              canAdvance: canAdvanceWorkflowItem(
                order: order,
                item: item,
                next: nextOrderItemStatusForBuilding(
                  item.status,
                  strictMode: strictMode,
                  steps: steps,
                ),
                access: access,
                isOwner: isOwner,
                seesAll: seesAll,
                actorType: actorType,
                actorId: actorId,
              ),
              onAdvance: (next) => _advance(context, ref, item, next),
            ),
        ],
      ),
    );
    if (drag == null) {
      return card;
    }
    final nextColors = orderItemStatusColors(scheme, drag.next);
    return LongPressDraggable<_TableDrag>(
      data: drag,
      feedback: Material(
        color: nextColors.foreground,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Text(
            label,
            style: text.titleSmall?.copyWith(color: nextColors.background),
          ),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.35, child: card),
      child: card,
    );
  }

  _TableDrag? _dragData(String label) {
    final ids = <UuidValue>[];
    OrderItemStatus? next;
    for (final item in items) {
      final step = nextOrderItemStatusForBuilding(
        item.status,
        strictMode: strictMode,
        steps: steps,
      );
      if (step == null) {
        continue;
      }
      final allowed = canAdvanceWorkflowItem(
        order: order,
        item: item,
        next: step,
        access: access,
        isOwner: isOwner,
        seesAll: seesAll,
        actorType: actorType,
        actorId: actorId,
      );
      if (!allowed) {
        continue;
      }
      next ??= step;
      if (step == next) {
        ids.add(item.id);
      }
    }
    if (ids.isEmpty || next == null) {
      return null;
    }
    return _TableDrag(label: label, next: next, itemIds: ids);
  }

  Future<bool> _advance(
    BuildContext context,
    WidgetRef ref,
    OrderItemView item,
    OrderItemStatus next,
  ) async {
    try {
      await ref
          .read(orderKitchenBoardProvider(buildingId).notifier)
          .advance(item.id, next);
      return true;
    } catch (error) {
      if (context.mounted) {
        final l10n = AppLocalizations.of(context)!;
        showAppSnackBar(context, lookupError(l10n, mapError(error).l10nKey));
      }
      return false;
    }
  }
}

class _Line extends StatelessWidget {
  const _Line({
    required this.item,
    required this.added,
    required this.currency,
    required this.showPrice,
    this.selected,
    this.onToggle,
    required this.next,
    required this.canAdvance,
    required this.onAdvance,
  });

  final OrderItemView item;
  final bool added;
  final String currency;
  final bool showPrice;
  final bool? selected;
  final VoidCallback? onToggle;
  final OrderItemStatus? next;
  final bool canAdvance;
  final Future<bool> Function(OrderItemStatus next) onAdvance;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final price = currency.isEmpty
        ? item.unitPrice.toStringAsFixed(2)
        : '${item.unitPrice.toStringAsFixed(2)} $currency';
    final row = Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          if (onToggle != null)
            IgnorePointer(
              child: Checkbox(value: selected ?? false, onChanged: (_) {}),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.articleName, style: text.bodyLarge),
                if (showPrice) Text(price, style: text.bodySmall),
              ],
            ),
          ),
          if (added)
            _Flag(
              label: l10n.orderBoardItemAdded,
              background: scheme.secondaryContainer,
              foreground: scheme.onSecondaryContainer,
            ),
        ],
      ),
    );
    if (onToggle != null) {
      return InkWell(onTap: onToggle, child: row);
    }
    if (next == null || !canAdvance) {
      return row;
    }
    final nextColors = orderItemStatusColors(scheme, next!);
    return Dismissible(
      key: ValueKey('${item.id.uuid}-${item.status.name}'),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        await onAdvance(next!);
        return false;
      },
      background: const SizedBox.shrink(),
      secondaryBackground: ColoredBox(
        color: nextColors.foreground,
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: AppSpacing.md),
            child: Text(
              orderItemStatusLabel(l10n, next!),
              style: text.labelLarge?.copyWith(
                color: nextColors.background,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      child: row,
    );
  }
}

/// A table card dragged onto the column for [next].
class _TableDrag {
  const _TableDrag({
    required this.label,
    required this.next,
    required this.itemIds,
  });

  final String label;
  final OrderItemStatus next;
  final List<UuidValue> itemIds;
}

/// Cancel and confirm share one width and height on the item board.
class _BoardAction extends StatelessWidget {
  const _BoardAction({
    required this.label,
    required this.filled,
    required this.onPressed,
  });

  final String label;
  final bool filled;
  final VoidCallback? onPressed;

  static const _size = Size(168, 44);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return FilledButton(
      style: FilledButton.styleFrom(
        fixedSize: _size,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        backgroundColor: filled ? scheme.error : scheme.errorContainer,
        foregroundColor: filled ? scheme.onError : scheme.onErrorContainer,
        disabledBackgroundColor: scheme.error.withValues(alpha: 0.38),
        disabledForegroundColor: scheme.onError.withValues(alpha: 0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
        ),
        textStyle: text.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
      onPressed: onPressed,
      child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}

class _Flag extends StatelessWidget {
  const _Flag({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: foreground,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
