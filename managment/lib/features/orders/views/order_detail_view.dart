import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/order_draft_view_model.dart';
import '../view_models/orders_view_model.dart';
import '../widgets/order_item_info_sheet.dart';
import '../widgets/order_item_workflow.dart';
import '../widgets/order_status_labels.dart';

/// Full-screen order detail: compact item actions, table summary, add lines.
class OrderDetailView extends ConsumerStatefulWidget {
  const OrderDetailView({
    super.key,
    required this.buildingId,
    required this.orderId,
  });

  final String buildingId;
  final String orderId;

  @override
  ConsumerState<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends ConsumerState<OrderDetailView> {
  String? _errorKey;
  UuidValue? _busyItemId;
  var _cancellingOrder = false;

  OrderView? _current(List<OrderView> orders) {
    for (final order in orders) {
      if (order.id.uuid == widget.orderId) {
        return order;
      }
    }
    return null;
  }

  Future<void> _advance(OrderItemView item) async {
    final building = ref.read(buildingSelectionProvider);
    final next = nextOrderItemStatusForBuilding(
      item.status,
      strictMode: building?.strictMode ?? false,
      steps: normalizeStrictModeSteps(building?.strictModeSteps),
    );
    if (next == null || _busyItemId != null) return;
    await _setItemStatus(item, next);
  }

  Future<void> _pay(OrderItemView item) async {
    if (_busyItemId != null) return;
    await _setItemStatus(item, OrderItemStatus.payed);
  }

  Future<void> _setItemStatus(
    OrderItemView item,
    OrderItemStatus status,
  ) async {
    setState(() {
      _busyItemId = item.id;
      _errorKey = null;
    });
    try {
      await ref
          .read(ordersViewModelProvider(widget.buildingId).notifier)
          .updateItemStatus(id: item.id, status: status);
    } catch (error) {
      if (!mounted) return;
      setState(() => _errorKey = mapError(error).l10nKey);
    } finally {
      if (mounted) setState(() => _busyItemId = null);
    }
  }

  Future<void> _cancelLine(OrderItemView item) async {
    if (_busyItemId != null) return;
    await _setItemStatus(item, OrderItemStatus.cancelled);
  }

  void _addArticles(OrderView order) {
    if (order.venueTableId == null || order.tableNumber == null) return;
    ref
        .read(orderDraftViewModelProvider(widget.buildingId).notifier)
        .beginAppend(
          orderId: order.id,
          tableId: order.venueTableId!,
          tableNumber: order.tableNumber!,
        );
    OrderCreateArticlesRoute(buildingId: widget.buildingId).go(context);
  }

  Future<void> _cancelOrder(OrderView order) async {
    final l10n = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.cancelOrder),
        content: Text(l10n.cancelOrderConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.close),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.cancelOrder),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    setState(() {
      _cancellingOrder = true;
      _errorKey = null;
    });
    try {
      await ref
          .read(ordersViewModelProvider(widget.buildingId).notifier)
          .cancelOrder(order.id);
      if (!mounted) return;
      setState(() => _cancellingOrder = false);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _cancellingOrder = false;
        _errorKey = mapError(error).l10nKey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final currency = ref.watch(buildingSelectionProvider)?.currencyCode ?? '';
    final async = ref.watch(ordersViewModelProvider(widget.buildingId));
    final order = _current(async.asData?.value ?? const []);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(l10n.navOrders),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              OrdersRoute(buildingId: widget.buildingId).go(context),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
          child: async.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: AppErrorBanner(
                message: lookupError(l10n, mapError(error).l10nKey),
              ),
            ),
            data: (_) {
              if (order == null) {
                return Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Text(l10n.errorNotFound),
                );
              }
              return ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  96,
                ),
                children: [
                  _OrderHeaderCard(
                    order: order,
                    currency: currency,
                    cancelling: _cancellingOrder,
                    busyItem: _busyItemId != null,
                    onOpenTables: () =>
                        TablesRoute(buildingId: widget.buildingId).go(context),
                    onAddArticles:
                        order.status == OrderStatus.progress &&
                            order.venueTableId != null
                        ? () => _addArticles(order)
                        : null,
                    addArticlesEnabled:
                        ref
                            .watch(buildingSelectionProvider)
                            ?.allowAppendingItemsToOrder ??
                        true,
                    onCancelOrder: order.status == OrderStatus.progress
                        ? () => _cancelOrder(order)
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.orderItemsHeading,
                    style: text.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  for (final item in order.items)
                    _OrderItemCard(
                      key: ValueKey(item.id.uuid),
                      item: item,
                      currency: currency,
                      orderOpen: order.status == OrderStatus.progress,
                      busy: _busyItemId == item.id,
                      actionsLocked: _cancellingOrder,
                      strictMode:
                          ref.watch(buildingSelectionProvider)?.strictMode ??
                          false,
                      strictModeSteps: normalizeStrictModeSteps(
                        ref.watch(buildingSelectionProvider)?.strictModeSteps,
                      ),
                      onAdvance: () => _advance(item),
                      onPay: () => _pay(item),
                      onCancel: () => _cancelLine(item),
                      onInfo: () => showOrderItemInfoDialog(
                        context,
                        item: item,
                        currency: currency,
                      ),
                    ),
                  if (_errorKey != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    AppErrorBanner(message: lookupError(l10n, _errorKey!)),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _OrderHeaderCard extends StatelessWidget {
  const _OrderHeaderCard({
    required this.order,
    required this.currency,
    required this.onOpenTables,
    required this.cancelling,
    required this.busyItem,
    this.onAddArticles,
    this.addArticlesEnabled = true,
    this.onCancelOrder,
  });

  final OrderView order;
  final String currency;
  final VoidCallback onOpenTables;
  final bool cancelling;
  final bool busyItem;
  final VoidCallback? onAddArticles;
  final bool addArticlesEnabled;
  final VoidCallback? onCancelOrder;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final muted = text.bodySmall?.copyWith(color: scheme.onSurfaceVariant);

    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Material(
                color: scheme.secondaryContainer,
                borderRadius: BorderRadius.circular(AppRadii.md),
                child: InkWell(
                  onTap: onOpenTables,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.table_restaurant_outlined,
                          size: 20,
                          color: scheme.onSecondaryContainer,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          order.tableNumber == null
                              ? l10n.orderNoTable
                              : l10n.orderTableNumber(order.tableNumber!),
                          style: text.titleSmall?.copyWith(
                            color: scheme.onSecondaryContainer,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              OrderStatusChip(status: order.status),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            formatOrderMoney(order.totalAmount, currency),
            style: text.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  l10n.orderLaunchedBy(order.launchedByType.name),
                  style: text.bodySmall,
                ),
              ),
              if (order.lastPaidByType != null)
                Expanded(
                  child: Text(
                    l10n.orderLastPaidBy(order.lastPaidByType!.name),
                    style: text.bodySmall,
                    textAlign: TextAlign.end,
                  ),
                ),
            ],
          ),
          if (order.cancelledByType != null) ...[
            const SizedBox(height: 4),
            Text(
              l10n.orderCancelledBy(order.cancelledByType!.name),
              style: text.bodySmall,
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.orderFieldCreatedAtLabel(
                    formatOrderDateTime(context, order.createdAt),
                  ),
                  style: muted,
                ),
              ),
              Expanded(
                child: Text(
                  l10n.orderFieldUpdatedAtLabel(
                    formatOrderDateTime(context, order.updatedAt),
                  ),
                  style: muted,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          if (order.cancelledAt != null) ...[
            const SizedBox(height: 4),
            Text(
              l10n.orderFieldCancelledAtLabel(
                formatOrderDateTime(context, order.cancelledAt!),
              ),
              style: muted,
            ),
          ],
          if (order.lastPaidAt != null) ...[
            const SizedBox(height: 4),
            Text(
              l10n.orderFieldPaidAtLabel(
                formatOrderDateTime(context, order.lastPaidAt!),
              ),
              style: muted,
            ),
          ],
          if (onAddArticles != null || onCancelOrder != null) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                if (onAddArticles != null)
                  Tooltip(
                    message: addArticlesEnabled
                        ? l10n.orderAppendArticles
                        : l10n.orderAppendArticlesDisabled,
                    child: FilledButton.tonalIcon(
                      style: FilledButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: const Size(0, 36),
                      ),
                      onPressed: cancelling || busyItem || !addArticlesEnabled
                          ? null
                          : onAddArticles,
                      icon: const Icon(Icons.add, size: 18),
                      label: Text(l10n.orderAppendArticles),
                    ),
                  ),
                const Spacer(),
                if (onCancelOrder != null)
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: scheme.error,
                      side: BorderSide(
                        color: scheme.error.withValues(alpha: 0.5),
                      ),
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: const Size(0, 36),
                    ),
                    onPressed: cancelling || busyItem ? null : onCancelOrder,
                    icon: cancelling
                        ? SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: scheme.error,
                            ),
                          )
                        : const Icon(Icons.cancel_outlined, size: 18),
                    label: Text(l10n.cancelOrder),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _OrderItemCard extends StatelessWidget {
  const _OrderItemCard({
    super.key,
    required this.item,
    required this.currency,
    required this.orderOpen,
    required this.busy,
    required this.actionsLocked,
    required this.strictMode,
    required this.strictModeSteps,
    required this.onAdvance,
    required this.onPay,
    required this.onCancel,
    required this.onInfo,
  });

  final OrderItemView item;
  final String currency;
  final bool orderOpen;
  final bool busy;
  final bool actionsLocked;
  final bool strictMode;
  final List<StrictModeStep> strictModeSteps;
  final VoidCallback onAdvance;
  final VoidCallback onPay;
  final VoidCallback onCancel;
  final VoidCallback onInfo;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final next = nextOrderItemStatusForBuilding(
      item.status,
      strictMode: strictMode,
      steps: strictModeSteps,
    );
    final showPay =
        canJumpToPayed(item.status, strictMode: strictMode) &&
        next != OrderItemStatus.payed;
    final canAct =
        orderOpen &&
        item.status != OrderItemStatus.payed &&
        item.status != OrderItemStatus.cancelled;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AppSurfaceCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.articleName, style: text.titleSmall),
                      const SizedBox(height: 2),
                      Text(
                        formatOrderMoney(item.unitPrice, currency),
                        style: text.labelLarge?.copyWith(
                          color: scheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: l10n.orderItemInfo,
                  visualDensity: VisualDensity.compact,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: onInfo,
                  icon: const Icon(Icons.info_outline, size: 20),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                OrderItemStatusChip(status: item.status),
                const SizedBox(width: AppSpacing.sm),
                if (canAct && next != null)
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: FilledButton(
                        onPressed: busy || actionsLocked ? null : onAdvance,
                        style: FilledButton.styleFrom(
                          backgroundColor: scheme.secondaryContainer,
                          foregroundColor: scheme.onSecondaryContainer,
                          disabledBackgroundColor:
                              scheme.surfaceContainerHighest,
                          disabledForegroundColor: scheme.onSurface.withValues(
                            alpha: 0.38,
                          ),
                          visualDensity: VisualDensity.compact,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          minimumSize: const Size(0, 34),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (busy)
                              SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: scheme.onSecondaryContainer,
                                ),
                              )
                            else ...[
                              Text(
                                orderItemStatusLabel(l10n, next),
                                style: text.labelMedium?.copyWith(
                                  color: scheme.onSecondaryContainer,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.arrow_forward,
                                size: 16,
                                color: scheme.onSecondaryContainer,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  const Spacer(),
                if (canAct && showPay) ...[
                  const SizedBox(width: AppSpacing.sm),
                  FilledButton(
                    onPressed: busy || actionsLocked ? null : onPay,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFE8F5E9),
                      foregroundColor: const Color(0xFF2E7D32),
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      minimumSize: const Size(0, 34),
                    ),
                    child: Text(l10n.orderItemPayNow),
                  ),
                ],
                if (canAct) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Tooltip(
                    message: l10n.cancelOrderItem,
                    child: Material(
                      color: scheme.errorContainer,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: busy || actionsLocked ? null : onCancel,
                        child: SizedBox(
                          width: 34,
                          height: 34,
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: scheme.onErrorContainer,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
