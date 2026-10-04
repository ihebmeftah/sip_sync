import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/list_page_bar.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/access_profiles_view_model.dart';

/// Owner list of named access profiles for a building.
class AccessProfilesListView extends ConsumerWidget {
  const AccessProfilesListView({super.key, required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final isOwner = ref.watch(appSessionStoreProvider).isOwner;
    final async = ref.watch(accessProfilesViewModelProvider(buildingId));

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.navAccessProfiles, style: text.headlineSmall),
                        const SizedBox(height: AppSpacing.xs),
                        Text(l10n.accessProfilesHint, style: text.bodyMedium),
                      ],
                    ),
                  ),
                  if (isOwner)
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 44),
                      ),
                      onPressed: () {
                        final pack = ref.read(buildingSelectionProvider)?.pack;
                        if (pack != null &&
                            !allowPackFeature(
                              context,
                              allowed: pack.customAccessProfiles,
                              message: l10n.errorPackFeatureAccess,
                            )) {
                          return;
                        }
                        AccessProfileCreateRoute(
                          buildingId: buildingId,
                        ).go(context);
                      },
                      icon: const Icon(Icons.add),
                      label: AppButtonLabel(l10n.addAccessProfile),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              if (ref
                      .watch(buildingSelectionProvider)
                      ?.pack
                      .customAccessProfiles ==
                  false)
                AppErrorBanner(message: l10n.errorPackFeatureAccess),
              if (!isOwner)
                AppErrorBanner(message: l10n.employeesOwnerOnly)
              else
                async.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (error, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppErrorBanner(
                        message: lookupError(l10n, mapError(error).l10nKey),
                      ),
                      TextButton(
                        onPressed: () => ref
                            .read(
                              accessProfilesViewModelProvider(
                                buildingId,
                              ).notifier,
                            )
                            .refresh(),
                        child: Text(l10n.retry),
                      ),
                    ],
                  ),
                  data: (page) {
                    final profiles = page.items;
                    if (profiles.isEmpty) {
                      return AppSurfaceCard(
                        child: Text(l10n.accessProfilesEmpty),
                      );
                    }
                    return Column(
                      children: [
                        AppSurfaceCard(
                          child: Column(
                            children: [
                              for (final profile in profiles)
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    backgroundColor: scheme.secondaryContainer,
                                    foregroundColor:
                                        scheme.onSecondaryContainer,
                                    child: const Icon(Icons.lock_outline),
                                  ),
                                  title: Text(profile.name),
                                  subtitle: Text(_summary(l10n, profile)),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () => AccessProfileEditRoute(
                                    buildingId: buildingId,
                                    accessId: profile.id.uuid,
                                  ).go(context),
                                ),
                            ],
                          ),
                        ),
                        ListPageBar(
                          total: page.total,
                          limit: page.limit,
                          offset: page.offset,
                          onPrevious: () => ref
                              .read(
                                accessProfilesViewModelProvider(
                                  buildingId,
                                ).notifier,
                              )
                              .previousPage(),
                          onNext: () => ref
                              .read(
                                accessProfilesViewModelProvider(
                                  buildingId,
                                ).notifier,
                              )
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

  String _summary(AppLocalizations l10n, EmployeeAccessView profile) {
    final flags = <String>[];
    if (profile.orderCreation) flags.add(l10n.accessFlagCreate);
    if (profile.orderPayment) flags.add(l10n.accessFlagPay);
    if (profile.cancelOrder) flags.add(l10n.accessFlagCancel);
    if (profile.preparation) flags.add(l10n.accessFlagPrep);
    if (profile.serving) flags.add(l10n.accessFlagServe);
    if (profile.consultAllOrders) flags.add(l10n.accessFlagConsultAll);
    if (flags.isEmpty) return l10n.accessNoFlags;
    return flags.join(' · ');
  }
}
