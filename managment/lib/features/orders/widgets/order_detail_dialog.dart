import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/orders_view_model.dart';
import 'order_status_labels.dart';

/// View / advance a single order’s lines.
Future<void> showOrderDetailDialog(
  BuildContext context, {
  required String buildingId,
  required OrderView order,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) =>
        _OrderDetailDialog(buildingId: buildingId, orderId: order.id),
  );
}

class _OrderDetailDialog extends ConsumerStatefulWidget {
  const _OrderDetailDialog({required this.buildingId, required this.orderId});

  final String buildingId;
  final UuidValue orderId;

  @override
  ConsumerState<_OrderDetailDialog> createState() => _OrderDetailDialogState();
}

class _OrderDetailDialogState extends ConsumerState<_OrderDetailDialog> {
  String? _errorKey;
  var _busy = false;

  OrderView? _current(List<OrderView> orders) {
    for (final order in orders) {
      if (order.id == widget.orderId) {
        return order;
      }
    }
    return null;
  }

  Future<void> _advance(OrderItemView item) async {
    final next = nextOrderItemStatus(item.status);
    if (next == null) {
      return;
    }
    setState(() {
      _busy = true;
      _errorKey = null;
    });
    try {
      await ref
          .read(ordersViewModelProvider(widget.buildingId).notifier)
          .updateItemStatus(id: item.id, status: next);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _errorKey = mapError(error).l10nKey);
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _cancelLine(OrderItemView item) async {
    setState(() {
      _busy = true;
      _errorKey = null;
    });
    try {
      await ref
          .read(ordersViewModelProvider(widget.buildingId).notifier)
          .updateItemStatus(id: item.id, status: OrderItemStatus.cancelled);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _errorKey = mapError(error).l10nKey);
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
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
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.cancelOrder),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) {
      return;
    }
    setState(() {
      _busy = true;
      _errorKey = null;
    });
    try {
      await ref
          .read(ordersViewModelProvider(widget.buildingId).notifier)
          .cancelOrder(order.id);
      if (!mounted) return;
      setState(() => _busy = false);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _busy = false;
        _errorKey = mapError(error).l10nKey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final async = ref.watch(ordersViewModelProvider(widget.buildingId));
    final order = _current(async.asData?.value ?? const []);

    return AlertDialog(
      title: Text(
        order == null
            ? l10n.navPos
            : l10n.orderDetailTitle(
                order.tableNumber == null
                    ? l10n.orderNoTable
                    : l10n.orderTableNumber(order.tableNumber!),
              ),
      ),
      content: SizedBox(
        width: 440,
        child: order == null
            ? Text(l10n.errorNotFound)
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${orderStatusLabel(l10n, order.status)} · ${order.totalAmount == order.totalAmount.roundToDouble() ? order.totalAmount.round() : order.totalAmount.toStringAsFixed(2)}',
                    style: text.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.orderLaunchedBy(order.launchedByType.name),
                    style: text.bodySmall,
                  ),
                  if (order.lastPaidByType != null)
                    Text(
                      l10n.orderLastPaidBy(order.lastPaidByType!.name),
                      style: text.bodySmall,
                    ),
                  const SizedBox(height: AppSpacing.lg),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 320),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (final item in order.items)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(item.articleName),
                            subtitle: Text(
                              orderItemStatusLabel(l10n, item.status),
                            ),
                            trailing:
                                order.status == OrderStatus.progress &&
                                    item.status != OrderItemStatus.payed &&
                                    item.status != OrderItemStatus.cancelled
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (nextOrderItemStatus(item.status) !=
                                          null)
                                        TextButton(
                                          onPressed: _busy
                                              ? null
                                              : () => _advance(item),
                                          child: Text(
                                            orderItemStatusLabel(
                                              l10n,
                                              nextOrderItemStatus(item.status)!,
                                            ),
                                          ),
                                        ),
                                      IconButton(
                                        tooltip: l10n.cancelOrderItem,
                                        onPressed: _busy
                                            ? null
                                            : () => _cancelLine(item),
                                        icon: const Icon(Icons.close),
                                      ),
                                    ],
                                  )
                                : null,
                          ),
                      ],
                    ),
                  ),
                  if (_errorKey != null)
                    AppErrorBanner(message: lookupError(l10n, _errorKey!)),
                ],
              ),
      ),
      actions: [
        if (order != null && order.status == OrderStatus.progress)
          TextButton(
            onPressed: _busy ? null : () => _cancelOrder(order),
            child: Text(l10n.cancelOrder),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.close),
        ),
      ],
    );
  }
}
