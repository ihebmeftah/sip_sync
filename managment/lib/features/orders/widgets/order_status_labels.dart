import 'package:flutter/material.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../l10n/generated/app_localizations.dart';

String orderStatusLabel(AppLocalizations l10n, OrderStatus status) {
  return switch (status) {
    OrderStatus.progress => l10n.orderStatusProgress,
    OrderStatus.payed => l10n.orderStatusPayed,
    OrderStatus.cancelled => l10n.orderStatusCancelled,
  };
}

String orderItemStatusLabel(AppLocalizations l10n, OrderItemStatus status) {
  return switch (status) {
    OrderItemStatus.progress => l10n.orderItemStatusProgress,
    OrderItemStatus.picked => l10n.orderItemStatusPicked,
    OrderItemStatus.ready => l10n.orderItemStatusReady,
    OrderItemStatus.served => l10n.orderItemStatusServed,
    OrderItemStatus.payed => l10n.orderItemStatusPayed,
    OrderItemStatus.cancelled => l10n.orderItemStatusCancelled,
  };
}

OrderItemStatus? nextOrderItemStatus(OrderItemStatus status) {
  return switch (status) {
    OrderItemStatus.progress => OrderItemStatus.picked,
    OrderItemStatus.picked => OrderItemStatus.ready,
    OrderItemStatus.ready => OrderItemStatus.served,
    OrderItemStatus.served => OrderItemStatus.payed,
    OrderItemStatus.payed || OrderItemStatus.cancelled => null,
  };
}

/// Representative colors for order-level status chips.
({Color background, Color foreground}) orderStatusColors(
  ColorScheme scheme,
  OrderStatus status,
) {
  return switch (status) {
    OrderStatus.progress => (
      background: const Color(0xFFFFF3E0),
      foreground: const Color(0xFFE65100),
    ),
    OrderStatus.payed => (
      background: const Color(0xFFE8F5E9),
      foreground: const Color(0xFF2E7D32),
    ),
    OrderStatus.cancelled => (
      background: scheme.errorContainer,
      foreground: scheme.onErrorContainer,
    ),
  };
}

/// Representative colors for per-item kitchen / payment status.
({Color background, Color foreground}) orderItemStatusColors(
  ColorScheme scheme,
  OrderItemStatus status,
) {
  return switch (status) {
    OrderItemStatus.progress => (
      background: const Color(0xFFE3F2FD),
      foreground: const Color(0xFF1565C0),
    ),
    OrderItemStatus.picked => (
      background: const Color(0xFFE8EAF6),
      foreground: const Color(0xFF3949AB),
    ),
    OrderItemStatus.ready => (
      background: const Color(0xFFE0F2F1),
      foreground: const Color(0xFF00695C),
    ),
    OrderItemStatus.served => (
      background: const Color(0xFFF3E5F5),
      foreground: const Color(0xFF6A1B9A),
    ),
    OrderItemStatus.payed => (
      background: const Color(0xFFE8F5E9),
      foreground: const Color(0xFF2E7D32),
    ),
    OrderItemStatus.cancelled => (
      background: scheme.errorContainer,
      foreground: scheme.onErrorContainer,
    ),
  };
}

/// Compact colored status pill.
class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = orderStatusColors(Theme.of(context).colorScheme, status);
    return _StatusChip(
      label: orderStatusLabel(l10n, status),
      background: colors.background,
      foreground: colors.foreground,
    );
  }
}

/// Compact colored item-status pill.
class OrderItemStatusChip extends StatelessWidget {
  const OrderItemStatusChip({super.key, required this.status});

  final OrderItemStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = orderItemStatusColors(Theme.of(context).colorScheme, status);
    return _StatusChip(
      label: orderItemStatusLabel(l10n, status),
      background: colors.background,
      foreground: colors.foreground,
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
