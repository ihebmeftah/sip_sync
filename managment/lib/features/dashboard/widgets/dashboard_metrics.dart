import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/pack_catalog_sheet.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/dashboard_view_model.dart';

/// Today's orders, reservations, and low stock for the open building.
class DashboardMetrics extends ConsumerWidget {
  const DashboardMetrics({super.key, required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final summary = ref.watch(dashboardViewModelProvider(buildingId));
    return summary.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: AppScreenLoader(compact: true),
      ),
      error: (error, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LoadFailureNotice(error: error),
          AppErrorBanner(message: lookupError(l10n, mapError(error).l10nKey)),
          TextButton(
            onPressed: () => ref
                .read(dashboardViewModelProvider(buildingId).notifier)
                .refresh(),
            child: Text(l10n.retry),
          ),
        ],
      ),
      data: (data) {
        final pack = ref.watch(buildingSelectionProvider)?.pack;
        return _MetricsBody(
          summary: data,
          onReservations: () {
            if (pack?.reservations == false) {
              showPackCatalog(context);
              return;
            }
            ReservationsRoute(buildingId: buildingId).go(context);
          },
          onOutOfStock: () {
            if (pack?.inventory == false) {
              showPackCatalog(context);
              return;
            }
            IngredientsRoute(
              buildingId: buildingId,
              outOfStock: true,
            ).go(context);
          },
        );
      },
    );
  }
}

class _MetricsBody extends StatelessWidget {
  const _MetricsBody({
    required this.summary,
    required this.onReservations,
    required this.onOutOfStock,
  });

  final DashboardSummary summary;
  final VoidCallback onReservations;
  final VoidCallback onOutOfStock;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.dashboardHouse, style: text.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        _SpotlightRow(
          children: [
            _SpotlightCard(
              icon: Icons.event_available_outlined,
              label: l10n.dashboardReservationsToday,
              value: summary.reservationsToday,
              hint: l10n.dashboardPendingCount(summary.pendingReservations),
              onTap: onReservations,
            ),
            _SpotlightCard(
              icon: Icons.science_outlined,
              label: l10n.dashboardRestock,
              hint: l10n.dashboardRestockHint,
              value: summary.ingredientsToRestock,
              alert: summary.ingredientsToRestock > 0,
              onTap: onOutOfStock,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.dashboardOrdersByStatus, style: text.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        _CountWrap(
          children: [
            _CountCard(
              label: l10n.dashboardOrderTotal,
              value: summary.orderTotal,
            ),
            _CountCard(
              label: l10n.orderStatusProgress,
              value: summary.ordersProgress,
            ),
            _CountCard(
              label: l10n.orderStatusPayed,
              value: summary.ordersPayed,
            ),
            _CountCard(
              label: l10n.orderStatusCancelled,
              value: summary.ordersCancelled,
              alert: summary.ordersCancelled > 0,
            ),
            _CountCard(
              label: l10n.dashboardCustomerOrders,
              value: summary.customerOrders,
              accent: scheme.primary,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.dashboardItemsByStatus, style: text.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        _CountWrap(
          children: [
            _CountCard(
              label: l10n.orderItemStatusProgress,
              value: summary.itemsProgress,
            ),
            _CountCard(
              label: l10n.orderItemStatusPicked,
              value: summary.itemsPicked,
            ),
            _CountCard(
              label: l10n.orderItemStatusReady,
              value: summary.itemsReady,
            ),
            _CountCard(
              label: l10n.orderItemStatusServed,
              value: summary.itemsServed,
            ),
            _CountCard(
              label: l10n.orderItemStatusPayed,
              value: summary.itemsPayed,
            ),
            _CountCard(
              label: l10n.orderItemStatusCancelled,
              value: summary.itemsCancelled,
              alert: summary.itemsCancelled > 0,
            ),
          ],
        ),
      ],
    );
  }
}

class _SpotlightRow extends StatelessWidget {
  const _SpotlightRow({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 520) {
          return Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const SizedBox(height: AppSpacing.sm),
                children[i],
              ],
            ],
          );
        }
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const SizedBox(width: AppSpacing.sm),
                Expanded(child: children[i]),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _SpotlightCard extends StatelessWidget {
  const _SpotlightCard({
    required this.icon,
    required this.label,
    required this.value,
    this.hint,
    this.alert = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final int value;
  final String? hint;
  final bool alert;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final ink = alert ? scheme.error : scheme.primary;
    return Material(
      color: scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.md),
        side: BorderSide(
          color: alert
              ? scheme.error.withValues(alpha: 0.45)
              : scheme.outline.withValues(alpha: 0.7),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: alert
                      ? scheme.errorContainer
                      : scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Icon(icon, color: ink, size: 22),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$value',
                      style: text.headlineSmall?.copyWith(color: ink),
                    ),
                    Text(label, style: text.titleSmall),
                    if (hint != null)
                      Text(
                        hint!,
                        style: text.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountWrap extends StatelessWidget {
  const _CountWrap({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1100
            ? 5
            : constraints.maxWidth >= 720
            ? 4
            : constraints.maxWidth >= 460
            ? 3
            : 2;
        const gap = AppSpacing.md;
        final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final child in children) SizedBox(width: width, child: child),
          ],
        );
      },
    );
  }
}

class _CountCard extends StatelessWidget {
  const _CountCard({
    required this.label,
    required this.value,
    this.accent,
    this.alert = false,
  });

  final String label;
  final int value;
  final Color? accent;
  final bool alert;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final numberColor = alert ? scheme.error : (accent ?? scheme.onSurface);
    return Material(
      color: scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.md),
        side: BorderSide(
          color: alert
              ? scheme.error.withValues(alpha: 0.45)
              : scheme.outline.withValues(alpha: 0.7),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$value',
              style: text.titleLarge?.copyWith(color: numberColor),
            ),
            Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: text.labelMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
