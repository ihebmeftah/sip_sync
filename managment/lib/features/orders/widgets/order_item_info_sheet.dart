import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';
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

/// Bottom sheet / dialog with full attribution and timestamps for one line.
Future<void> showOrderItemInfoDialog(
  BuildContext context, {
  required OrderItemView item,
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
                label: l10n.orderFieldCreatedAt,
                value: formatOrderDateTime(context, item.createdAt),
              ),
              _InfoRow(
                label: l10n.orderFieldUpdatedAt,
                value: formatOrderDateTime(context, item.updatedAt),
              ),
              if (item.preparedAt != null)
                _InfoRow(
                  label: l10n.orderFieldPreparedAt,
                  value: formatOrderDateTime(context, item.preparedAt!),
                ),
              if (item.servedAt != null)
                _InfoRow(
                  label: l10n.orderFieldServedAt,
                  value: formatOrderDateTime(context, item.servedAt!),
                ),
              if (item.paidAt != null)
                _InfoRow(
                  label: l10n.orderFieldPaidAt,
                  value: formatOrderDateTime(context, item.paidAt!),
                ),
              if (item.cancelledAt != null)
                _InfoRow(
                  label: l10n.orderFieldCancelledAt,
                  value: formatOrderDateTime(context, item.cancelledAt!),
                ),
              if (item.passedByType != null)
                _InfoRow(
                  label: l10n.orderFieldPassedBy,
                  value: item.passedByType!.name,
                ),
              if (item.preparedByType != null)
                _InfoRow(
                  label: l10n.orderFieldPreparedBy,
                  value: item.preparedByType!.name,
                ),
              if (item.servedByType != null)
                _InfoRow(
                  label: l10n.orderFieldServedBy,
                  value: item.servedByType!.name,
                ),
              if (item.paidToType != null)
                _InfoRow(
                  label: l10n.orderFieldPaidTo,
                  value: item.paidToType!.name,
                ),
              if (item.cancelledByType != null)
                _InfoRow(
                  label: l10n.orderFieldCancelledBy,
                  value: item.cancelledByType!.name,
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
