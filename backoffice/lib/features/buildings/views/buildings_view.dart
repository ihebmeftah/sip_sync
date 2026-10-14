import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/list_page_bar.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../console/views/console_shell.dart';
import '../view_models/buildings_view_model.dart';

/// Platform building list. A card opens the venue detail screen.
class BuildingsView extends ConsumerStatefulWidget {
  const BuildingsView({super.key});

  @override
  ConsumerState<BuildingsView> createState() => _BuildingsViewState();
}

class _BuildingsViewState extends ConsumerState<BuildingsView> {
  late final TextEditingController _search;
  late final Future<List<PackView>> _packs;
  String _packValue = '';

  @override
  void initState() {
    super.initState();
    final model = ref.read(buildingsViewModelProvider.notifier);
    _search = TextEditingController(text: model.query ?? '');
    _packValue = model.packId?.uuid ?? '';
    _packs = ref.read(packRepositoryProvider).listAll();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final buildings = ref.watch(buildingsViewModelProvider);
    final theme = ShadTheme.of(context);
    final filtered = ref.read(buildingsViewModelProvider.notifier).hasFilter;
    return ConsolePage(
      title: l10n.buildingsTitle,
      subtitle: l10n.buildingsSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _filters(context, l10n, theme),
          buildings.when(
            loading: () => const AppScreenLoader(),
            error: (error, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadFailureNotice(error: error),
                AppErrorBanner(
                  message: lookupError(l10n, mapError(error).l10nKey),
                ),
                ShadButton.outline(
                  onPressed: () =>
                      ref.read(buildingsViewModelProvider.notifier).refresh(),
                  child: Text(l10n.retry),
                ),
              ],
            ),
            data: (page) {
              final rows = page.items;
              if (rows.isEmpty) {
                return Text(
                  filtered ? l10n.buildingsFilterEmpty : l10n.empty,
                  style: theme.textTheme.muted,
                );
              }
              return Column(
                children: [
                  for (final building in rows) ...[
                    _BuildingCard(building: building),
                    const SizedBox(height: AppSpacing.md),
                  ],
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
    );
  }

  Widget _filters(
    BuildContext context,
    AppLocalizations l10n,
    ShadThemeData theme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.buildingSearchLabel, style: theme.textTheme.small),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ShadInput(
                  controller: _search,
                  placeholder: Text(l10n.buildingSearchHint),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => _apply(),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              ShadButton(
                onPressed: _apply,
                child: Text(l10n.buildingSearchAction),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.buildingPackFilter, style: theme.textTheme.small),
          const SizedBox(height: AppSpacing.sm),
          FutureBuilder<List<PackView>>(
            future: _packs,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(
                  lookupError(l10n, mapError(snapshot.error!).l10nKey),
                  style: theme.textTheme.small.copyWith(
                    color: theme.colorScheme.destructive,
                  ),
                );
              }
              final packs = snapshot.data;
              if (packs == null) {
                return const AppScreenLoader();
              }
              final ordered = [...packs]
                ..sort((a, b) => a.name.compareTo(b.name));
              return ShadSelect<String>(
                initialValue: _packValue.isEmpty ? null : _packValue,
                placeholder: Text(l10n.buildingPackAll),
                minWidth: 240,
                selectedOptionBuilder: (context, value) {
                  return Text(_packLabel(l10n, ordered, value));
                },
                onChanged: (value) {
                  setState(() => _packValue = value ?? '');
                  _apply();
                },
                options: [
                  ShadOption(value: '', child: Text(l10n.buildingPackAll)),
                  for (final pack in ordered)
                    ShadOption(value: pack.id.uuid, child: Text(pack.name)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  String _packLabel(AppLocalizations l10n, List<PackView> packs, String value) {
    if (value.isEmpty) {
      return l10n.buildingPackAll;
    }
    for (final pack in packs) {
      if (pack.id.uuid == value) {
        return pack.name;
      }
    }
    return l10n.buildingPackAll;
  }

  void _apply() {
    ref
        .read(buildingsViewModelProvider.notifier)
        .search(
          query: _search.text,
          packId: _packValue.isEmpty ? null : UuidValue.fromString(_packValue),
        );
  }
}

class _BuildingCard extends StatelessWidget {
  const _BuildingCard({required this.building});

  final AdminBuildingView building;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);
    final owner = '${building.ownerFirstName} ${building.ownerLastName}'.trim();
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () =>
            BuildingDetailRoute(buildingId: building.id.uuid).go(context),
        child: ShadCard(
          width: double.infinity,
          rowMainAxisSize: MainAxisSize.max,
          columnCrossAxisAlignment: CrossAxisAlignment.stretch,
          title: Row(
            children: [
              Expanded(child: Text(building.name)),
              const SizedBox(width: AppSpacing.sm),
              ShadBadge.outline(child: Text(building.packName)),
              const SizedBox(width: AppSpacing.sm),
              ShadBadge.outline(child: Text(building.type)),
            ],
          ),
          description: Text(
            '$owner · ${building.ownerEmail} · ${building.ownerPhoneNumber}',
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.contact, style: theme.textTheme.muted),
                const SizedBox(height: AppSpacing.xs),
                Text(_contact(building), style: theme.textTheme.small),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _contact(AdminBuildingView building) {
    return [
      building.phoneNumber,
      if ((building.whatsapp ?? '').isNotEmpty) building.whatsapp!,
      if ((building.instagram ?? '').isNotEmpty) building.instagram!,
      if ((building.facebook ?? '').isNotEmpty) building.facebook!,
    ].join(' · ');
  }
}
