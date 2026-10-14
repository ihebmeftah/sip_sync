import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/dashboard_view_model.dart';
import '../widgets/dashboard_metrics.dart';

/// House overview for owners and staff: welcome, quick actions, then counts.
class DashboardView extends ConsumerWidget {
  const DashboardView({super.key, required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final store = ref.watch(appSessionStoreProvider);
    final building = ref.watch(buildingSelectionProvider);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final name = store.owner?.firstName ?? store.employee?.firstName ?? '';
    final roleLabel = store.isOwner ? l10n.loginAsOwner : l10n.loginAsEmployee;

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: RefreshIndicator(
        onRefresh: () =>
            ref.read(dashboardViewModelProvider(buildingId).notifier).refresh(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          scheme.primaryContainer,
                          scheme.secondaryContainer,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        AppSpacing.lg,
                        AppSpacing.lg,
                        AppSpacing.lg,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.xs,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                l10n.dashboardEyebrow,
                                style: text.labelMedium?.copyWith(
                                  color: scheme.primary,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              Chip(
                                visualDensity: VisualDensity.compact,
                                label: Text(roleLabel),
                                backgroundColor: scheme.surface.withValues(
                                  alpha: 0.72,
                                ),
                                labelStyle: text.labelMedium?.copyWith(
                                  color: scheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            l10n.welcome(name),
                            style: text.headlineSmall?.copyWith(
                              color: scheme.onPrimaryContainer,
                            ),
                          ),
                          if (building != null) ...[
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              building.name,
                              style: text.titleMedium?.copyWith(
                                color: scheme.onPrimaryContainer,
                              ),
                            ),
                            Text(
                              l10n.dashboardBuildingMeta(
                                building.type,
                                building.address,
                                formatMinutes(building.openingMinutes),
                                formatMinutes(building.closingMinutes),
                                building.currencyCode,
                              ),
                              style: text.bodySmall?.copyWith(
                                color: scheme.onPrimaryContainer.withValues(
                                  alpha: 0.82,
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: AppSpacing.md),
                          const _DayRange(),
                          const SizedBox(height: AppSpacing.md),
                          _QuickActions(buildingId: buildingId),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.xl,
                    ),
                    child: DashboardMetrics(buildingId: buildingId),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Local start and end of the day the counts cover.
class _DayRange extends StatelessWidget {
  const _DayRange();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final material = MaterialLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day, 23, 59);
    final use24 = MediaQuery.alwaysUse24HourFormatOf(context);
    String stamp(DateTime value) {
      final date = material.formatMediumDate(value);
      final time = material.formatTimeOfDay(
        TimeOfDay.fromDateTime(value),
        alwaysUse24HourFormat: use24,
      );
      return '$date, $time';
    }

    return Material(
      color: scheme.surface.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.dashboardCurrentDay,
              style: text.labelLarge?.copyWith(color: scheme.primary),
            ),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.lg,
              runSpacing: AppSpacing.xs,
              children: [
                _RangeStamp(
                  label: l10n.dashboardRangeStart,
                  value: stamp(start),
                ),
                _RangeStamp(label: l10n.dashboardRangeEnd, value: stamp(end)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RangeStamp extends StatelessWidget {
  const _RangeStamp({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label  ',
            style: text.labelMedium?.copyWith(color: scheme.primary),
          ),
          TextSpan(
            text: value,
            style: text.bodyMedium?.copyWith(color: scheme.onSurface),
          ),
        ],
      ),
    );
  }
}

/// Equal actions across the welcome band. Narrow windows scroll them in one row.
class _QuickActions extends ConsumerWidget {
  const _QuickActions({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final pending = ref
        .watch(dashboardViewModelProvider(buildingId))
        .asData
        ?.value
        .pendingReservations;
    final actions = [
      _QuickAction(
        title: l10n.navReservations,
        icon: Icons.event_available_outlined,
        badge: pending,
        onTap: () => ReservationsRoute(buildingId: buildingId).go(context),
      ),
      _QuickAction(
        title: l10n.navOrders,
        icon: Icons.receipt_long_outlined,
        onTap: () => OrdersRoute(buildingId: buildingId).go(context),
      ),
      _QuickAction(
        title: l10n.navTables,
        icon: Icons.table_restaurant_outlined,
        onTap: () => TablesRoute(buildingId: buildingId).go(context),
      ),
      _QuickAction(
        title: l10n.navProducts,
        icon: Icons.inventory_2_outlined,
        onTap: () => CategoriesRoute(buildingId: buildingId).go(context),
      ),
      _QuickAction(
        title: l10n.navEmployees,
        icon: Icons.groups_outlined,
        onTap: () => EmployeesRoute(buildingId: buildingId).go(context),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 720) {
          return SizedBox(
            height: 56,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: actions.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (_, index) => SizedBox(
                width: index == 0 ? 210 : 148,
                child: actions[index],
              ),
            ),
          );
        }
        return Row(
          children: [
            for (var i = 0; i < actions.length; i++) ...[
              if (i > 0) const SizedBox(width: AppSpacing.sm),
              Expanded(child: actions[i]),
            ],
          ],
        );
      },
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.title,
    required this.icon,
    required this.onTap,
    this.badge,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  /// Pending count drawn on the action. Null hides the pill.
  final int? badge;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Material(
      color: scheme.surface.withValues(alpha: 0.94),
      elevation: 1,
      shadowColor: scheme.shadow.withValues(alpha: 0.18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Icon(icon, size: 18, color: scheme.onPrimary),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.labelLarge?.copyWith(color: scheme.onSurface),
                ),
              ),
              if (badge != null) ...[
                const SizedBox(width: AppSpacing.xs),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: badge! > 0
                        ? scheme.error
                        : scheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(AppRadii.lg),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 2,
                    ),
                    child: Text(
                      '$badge',
                      style: text.labelMedium?.copyWith(
                        color: badge! > 0 ? scheme.onError : scheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
