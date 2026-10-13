import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';
import 'order_item_workflow.dart';
import 'order_status_labels.dart';

String formatOrderMoney(double amount, String currency) {
  final value = amount == amount.roundToDouble()
      ? '${amount.round()}'
      : amount.toStringAsFixed(2);
  if (currency.isEmpty) return value;
  return '$value $currency';
}

String formatOrderDateTime(BuildContext context, DateTime value) {
  final local = value.toLocal();
  final locale = Localizations.localeOf(context).toString();
  return DateFormat.yMMMd(locale).add_Hm().format(local);
}

DateTime? _timeForStatus(OrderItemView item, OrderItemStatus status) {
  return switch (status) {
    OrderItemStatus.progress => item.createdAt,
    OrderItemStatus.picked => null,
    OrderItemStatus.ready => item.preparedAt,
    OrderItemStatus.served => item.servedAt,
    OrderItemStatus.payed => item.paidAt,
    OrderItemStatus.cancelled => item.cancelledAt,
  };
}

/// Bottom sheet / dialog with full attribution and timestamps for one line.
Future<void> showOrderItemInfoDialog(
  BuildContext context, {
  required OrderItemView item,
  required String currency,
  required List<StrictModeStep> steps,
}) {
  final l10n = AppLocalizations.of(context)!;
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      final text = Theme.of(context).textTheme;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.sm,
            AppSpacing.xl,
            AppSpacing.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(item.articleName, style: text.titleLarge),
                  ),
                  OrderItemStatusChip(status: item.status),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                formatOrderMoney(item.unitPrice, currency),
                style: text.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _InfoRow(
                label: l10n.orderFieldUpdatedAt,
                value: formatOrderDateTime(context, item.updatedAt),
              ),
              for (final status in [
                OrderItemStatus.progress,
                for (final step in normalizeStrictModeSteps(steps))
                  if (step.enabled) step.status,
              ])
                if (actorForItemStatus(item, status) case final actor?)
                  _InfoRow(
                    label: orderItemStatusLabel(l10n, status),
                    value: [
                      formatOrderActor(l10n, actor),
                      if (_timeForStatus(item, status) case final at?)
                        formatOrderDateTime(context, at),
                    ].join(' · '),
                  ),
              if (item.cancelledBy != null || item.cancelledAt != null)
                _InfoRow(
                  label: orderItemStatusLabel(l10n, OrderItemStatus.cancelled),
                  value: [
                    if (item.cancelledBy != null)
                      formatOrderActor(l10n, item.cancelledBy!),
                    if (item.cancelledAt != null)
                      formatOrderDateTime(context, item.cancelledAt!),
                  ].join(' · '),
                ),
              if (item.cancellationReason != null)
                _InfoRow(
                  label: l10n.cancelReasonTitle,
                  value: orderCancellationReasonLabel(
                    l10n,
                    item.cancellationReason!,
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.close),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// Bottom sheet with order-level timestamps (created / updated / cancelled…).
Future<void> showOrderInfoDialog(
  BuildContext context, {
  required OrderView order,
  required String currency,
}) {
  final l10n = AppLocalizations.of(context)!;
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      final text = Theme.of(context).textTheme;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.sm,
            AppSpacing.xl,
            AppSpacing.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      order.tableNumber == null
                          ? l10n.orderNoTable
                          : l10n.orderTableNumber(order.tableNumber!),
                      style: text.titleLarge,
                    ),
                  ),
                  OrderStatusChip(status: order.status),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                formatOrderMoney(order.totalAmount, currency),
                style: text.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _InfoRow(
                label: l10n.orderFieldCreatedAt,
                value: formatOrderDateTime(context, order.createdAt),
              ),
              _InfoRow(
                label: l10n.orderFieldUpdatedAt,
                value: formatOrderDateTime(context, order.updatedAt),
              ),
              if (order.cancelledAt != null)
                _InfoRow(
                  label: l10n.orderFieldCancelledAt,
                  value: formatOrderDateTime(context, order.cancelledAt!),
                ),
              if (order.lastPaidAt != null)
                _InfoRow(
                  label: l10n.orderFieldPaidAt,
                  value: formatOrderDateTime(context, order.lastPaidAt!),
                ),
              _InfoRow(
                label: l10n.orderFieldLaunchedBy,
                value: formatOrderActor(l10n, order.launchedBy),
              ),
              if (order.lastPaidBy != null)
                _InfoRow(
                  label: l10n.orderFieldPaidTo,
                  value: formatOrderActor(l10n, order.lastPaidBy!),
                ),
              if (order.cancelledBy != null)
                _InfoRow(
                  label: l10n.orderFieldCancelledBy,
                  value: formatOrderActor(l10n, order.cancelledBy!),
                ),
              if (order.cancellationReason != null)
                _InfoRow(
                  label: l10n.cancelReasonTitle,
                  value: orderCancellationReasonLabel(
                    l10n,
                    order.cancellationReason!,
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.close),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: text.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Text(value, style: text.bodyMedium)),
        ],
      ),
    );
  }
}
