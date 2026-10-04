import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/di/building_session.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/list_page_bar.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/buildings_view_model.dart';

class BuildingsListView extends ConsumerWidget {
  const BuildingsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final isOwner = ref.watch(appSessionStoreProvider).isOwner;
    final async = ref.watch(buildingsViewModelProvider);
    final selectedId = ref.watch(buildingSelectionProvider)?.id;

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              Text(l10n.navBuildings, style: text.headlineSmall),
              const SizedBox(height: AppSpacing.sm),
              Text(
                isOwner ? l10n.buildingsOwnerHint : l10n.buildingsStaffHint,
                style: text.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              if (isOwner)
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 44),
                    ),
                    onPressed: () => const BuildingCreateRoute().go(context),
                    icon: const Icon(Icons.add),
                    label: Text(l10n.addBuilding),
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),
              async.when(
                loading: () => const AppScreenLoader(),
                error: (error, _) => AppErrorBanner(
                  message: lookupError(l10n, mapError(error).l10nKey),
                ),
                data: (page) {
                  final buildings = page.items;
                  if (buildings.isEmpty) {
                    return AppSurfaceCard(
                      child: Text(
                        isOwner ? l10n.buildingsEmptyOwner : l10n.empty,
                      ),
                    );
                  }
                  return Column(
                    children: [
                      for (final building in buildings)
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: Material(
                            color: scheme.surfaceContainerLowest,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppRadii.lg),
                              side: BorderSide(
                                color: building.id == selectedId
                                    ? scheme.primary
                                    : scheme.outline,
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(
                                AppSpacing.lg,
                              ),
                              title: Text(
                                building.name,
                                style: text.titleLarge,
                              ),
                              subtitle: Text(
                                '${building.type} · ${building.address}',
                              ),
                              trailing: isOwner
                                  ? IconButton(
                                      tooltip: l10n.editBuilding,
                                      onPressed: () => BuildingEditRoute(
                                        buildingId: building.id.uuid,
                                      ).go(context),
                                      icon: const Icon(Icons.edit_outlined),
                                    )
                                  : Icon(
                                      Icons.chevron_right,
                                      color: scheme.primary,
                                    ),
                              onTap: () {
                                getIt<BuildingSession>().upsert(building);
                                getIt<BuildingSession>().select(building.id);
                                DashboardRoute(
                                  buildingId: building.id.uuid,
                                ).go(context);
                              },
                            ),
                          ),
                        ),
                      ListPageBar(
                        total: page.total,
                        limit: page.limit,
                        offset: page.offset,
                        onPrevious: () => ref
                            .read(buildingsViewModelProvider.notifier)
                            .previousPage(),
                        onNext: () => ref
                            .read(buildingsViewModelProvider.notifier)
                            .nextPage(),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
