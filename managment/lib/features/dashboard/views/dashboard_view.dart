import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';

/// House overview for owners and staff. Destinations are wired; metrics later.
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
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.xxl,
                AppSpacing.xl,
                AppSpacing.lg,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppBreakpoints.pageMax,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadii.xl),
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
                        padding: const EdgeInsets.all(AppSpacing.xxl),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.dashboardEyebrow,
                              style: text.labelLarge?.copyWith(
                                color: scheme.primary,
                                letterSpacing: 1.4,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              l10n.welcome(name),
                              style: text.displaySmall?.copyWith(
                                color: scheme.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              l10n.dashboardSubtitle,
                              style: text.titleMedium?.copyWith(
                                color: scheme.onPrimaryContainer.withValues(
                                  alpha: 0.82,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            Wrap(
                              spacing: AppSpacing.sm,
                              runSpacing: AppSpacing.sm,
                              children: [
                                Chip(
                                  label: Text(roleLabel),
                                  backgroundColor: scheme.surface.withValues(
                                    alpha: 0.55,
                                  ),
                                  labelStyle: text.labelLarge?.copyWith(
                                    color: scheme.onPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                            if (building != null) ...[
                              const SizedBox(height: AppSpacing.lg),
                              Text(
                                building.name,
                                style: text.headlineSmall?.copyWith(
                                  color: scheme.onPrimaryContainer,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                l10n.dashboardBuildingMeta(
                                  building.type,
                                  building.address,
                                  formatMinutes(building.openingMinutes),
                                  formatMinutes(building.closingMinutes),
                                  building.currencyCode,
                                ),
                                style: text.bodyMedium?.copyWith(
                                  color: scheme.onPrimaryContainer.withValues(
                                    alpha: 0.82,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final wide =
                            constraints.maxWidth >= AppBreakpoints.expanded;
                        final cards = [
                          _DashTile(
                            title: l10n.navPos,
                            body: l10n.dashboardPosCue,
                            icon: Icons.point_of_sale_outlined,
                            onTap: () =>
                                PosRoute(buildingId: buildingId).go(context),
                          ),
                          _DashTile(
                            title: l10n.navTables,
                            body: l10n.dashboardTablesCue,
                            icon: Icons.table_restaurant_outlined,
                            onTap: () =>
                                TablesRoute(buildingId: buildingId).go(context),
                          ),
                          _DashTile(
                            title: l10n.navProducts,
                            body: l10n.dashboardCatalogCue,
                            icon: Icons.inventory_2_outlined,
                            onTap: () => ArticlesRoute(
                              buildingId: buildingId,
                            ).go(context),
                          ),
                          _DashTile(
                            title: l10n.navEmployees,
                            body: l10n.dashboardEmployeesCue,
                            icon: Icons.groups_outlined,
                            onTap: () => EmployeesRoute(
                              buildingId: buildingId,
                            ).go(context),
                          ),
                          _DashTile(
                            title: l10n.navProfile,
                            body: l10n.dashboardProfileCue,
                            icon: Icons.person_outline,
                            onTap: () => ProfileRoute(
                              buildingId: buildingId,
                            ).go(context),
                          ),
                        ];
                        if (wide) {
                          return GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: AppSpacing.lg,
                            crossAxisSpacing: AppSpacing.lg,
                            childAspectRatio: 2.2,
                            children: cards,
                          );
                        }
                        return Column(
                          children: [
                            for (final card in cards) ...[
                              card,
                              const SizedBox(height: AppSpacing.lg),
                            ],
                          ],
                        );
                      },
                    ),
                    AppSurfaceCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.dashboardShift, style: text.titleLarge),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            l10n.placeholderBody,
                            style: text.bodyMedium?.copyWith(
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
          ),
        ],
      ),
    );
  }
}

class _DashTile extends StatelessWidget {
  const _DashTile({
    required this.title,
    required this.body,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String body;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        side: BorderSide(color: scheme.outline),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Icon(icon, color: scheme.onSecondaryContainer),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      body,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_outward, color: scheme.secondary),
            ],
          ),
        ),
      ),
    );
  }
}
