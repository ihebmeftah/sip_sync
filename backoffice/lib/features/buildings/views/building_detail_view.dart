import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../console/views/console_shell.dart';
import '../../packs/pack_money.dart';
import '../../packs/view_models/packs_view_model.dart';
import '../../packs/views/pack_form_dialog.dart';
import '../view_models/building_detail_view_model.dart';

/// Venue contact, pack, platform gain, and counts.
class BuildingDetailView extends ConsumerStatefulWidget {
  const BuildingDetailView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<BuildingDetailView> createState() => _BuildingDetailViewState();
}

enum _BuildingTab { details, pack, gain, stats }

class _BuildingDetailViewState extends ConsumerState<BuildingDetailView> {
  _BuildingTab _tab = _BuildingTab.details;
  String? _errorKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final detail = ref.watch(
      buildingDetailViewModelProvider(widget.buildingId),
    );
    final theme = ShadTheme.of(context);
    return ConsolePage(
      title: l10n.buildingDetailTitle,
      subtitle: l10n.buildingDetailSubtitle,
      action: ShadButton.outline(
        onPressed: () => const BuildingsRoute().go(context),
        child: Text(l10n.buildingsTitle),
      ),
      child: detail.when(
        loading: () => const LinearProgressIndicator(),
        error: (error, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppErrorBanner(message: lookupError(l10n, mapError(error).l10nKey)),
            ShadButton.outline(
              onPressed: () => ref.invalidate(
                buildingDetailViewModelProvider(widget.buildingId),
              ),
              child: Text(l10n.retry),
            ),
          ],
        ),
        data: (row) {
          final building = row.building;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(building.name, style: theme.textTheme.h3),
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: ShadBadge.outline(child: Text(building.type)),
              ),
              if (_errorKey != null) ...[
                const SizedBox(height: AppSpacing.md),
                AppErrorBanner(message: lookupError(l10n, _errorKey!)),
              ],
              const SizedBox(height: AppSpacing.lg),
              ShadTabs<_BuildingTab>(
                value: _tab,
                onChanged: (value) => setState(() => _tab = value),
                tabs: [
                  ShadTab(
                    value: _BuildingTab.details,
                    content: _DetailsTab(building: building),
                    child: Text(l10n.buildingTabDetails),
                  ),
                  ShadTab(
                    value: _BuildingTab.pack,
                    content: _PackTab(
                      detail: row,
                      onAssign: _assign,
                      onCreate: _createPrivate,
                    ),
                    child: Text(l10n.buildingTabPack),
                  ),
                  ShadTab(
                    value: _BuildingTab.gain,
                    content: _GainTab(detail: row),
                    child: Text(l10n.buildingTabGain),
                  ),
                  ShadTab(
                    value: _BuildingTab.stats,
                    content: _StatsTab(detail: row),
                    child: Text(l10n.buildingTabStats),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _assign() async {
    final packId = await showShadDialog<UuidValue>(
      context: context,
      builder: (_) => const _AssignPackDialog(),
    );
    if (packId == null || !mounted) {
      return;
    }
    final error = await ref
        .read(buildingDetailViewModelProvider(widget.buildingId).notifier)
        .assignPack(packId);
    if (!mounted) {
      return;
    }
    setState(() => _errorKey = error);
  }

  Future<void> _createPrivate() async {
    final created = await showShadDialog<PackView>(
      context: context,
      builder: (_) => const PackFormDialog(),
    );
    if (created == null || !mounted) {
      return;
    }
    final error = await ref
        .read(buildingDetailViewModelProvider(widget.buildingId).notifier)
        .assignPack(created.id);
    if (!mounted) {
      return;
    }
    setState(() => _errorKey = error);
  }
}

class _DetailsTab extends StatelessWidget {
  const _DetailsTab({required this.building});

  final AdminBuildingView building;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final owner = '${building.ownerFirstName} ${building.ownerLastName}'.trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Line(label: l10n.owner, value: owner),
        _Line(label: l10n.email, value: building.ownerEmail),
        _Line(label: l10n.phone, value: building.ownerPhoneNumber),
        _Line(label: l10n.address, value: building.address),
        _Line(
          label: l10n.location,
          value: l10n.coordinates(
            building.latitude.toStringAsFixed(5),
            building.longitude.toStringAsFixed(5),
          ),
        ),
        _Line(label: l10n.currency, value: building.currencyCode),
        _Line(label: l10n.contact, value: building.phoneNumber),
      ],
    );
  }
}

class _PackTab extends StatelessWidget {
  const _PackTab({
    required this.detail,
    required this.onAssign,
    required this.onCreate,
  });

  final AdminBuildingDetail detail;
  final VoidCallback onAssign;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);
    final pack = detail.pack;
    final caps = pack.capabilities;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(pack.name, style: theme.textTheme.h4),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            ShadBadge.outline(
              child: Text(pack.isPublic ? l10n.packPublic : l10n.packPrivate),
            ),
            ShadBadge.outline(
              child: Text(pack.isEnabled ? l10n.packEnabled : l10n.disabled),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.packPriceMonth(formatMillimes(pack.monthlyMillimes)),
          style: theme.textTheme.p,
        ),
        Text(
          l10n.packFeeLabel(formatBps(pack.customerOrderFeeBps)),
          style: theme.textTheme.muted,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(_limits(l10n, caps), style: theme.textTheme.small),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            ShadButton(onPressed: onAssign, child: Text(l10n.assignPack)),
            ShadButton.outline(
              onPressed: onCreate,
              child: Text(l10n.quickCreatePack),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.quickCreatePackHint, style: theme.textTheme.muted),
      ],
    );
  }

  String _limits(AppLocalizations l10n, PackCapabilities caps) {
    String cap(int? value) => value == null ? l10n.packNoLimit : '$value';
    return [
      '${l10n.capMaxEmployees}: ${cap(caps.maxEmployees)}',
      '${l10n.capMaxTables}: ${cap(caps.maxTables)}',
      '${l10n.capMaxCategories}: ${cap(caps.maxCategories)}',
      '${l10n.capMaxArticles}: ${cap(caps.maxArticles)}',
      '${l10n.capMaxIngredients}: ${cap(caps.maxIngredients)}',
    ].join(' · ');
  }
}

class _GainTab extends StatelessWidget {
  const _GainTab({required this.detail});

  final AdminBuildingDetail detail;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);
    final currency = detail.building.currencyCode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.gainHint, style: theme.textTheme.muted),
        const SizedBox(height: AppSpacing.md),
        _Line(
          label: l10n.gainMonthly,
          value: l10n.packPriceMonth(
            formatMillimes(detail.pack.monthlyMillimes),
          ),
        ),
        _Line(
          label: l10n.gainFeeRate,
          value: '${formatBps(detail.pack.customerOrderFeeBps)}%',
        ),
        _Line(
          label: l10n.gainCustomerOrders,
          value: '${detail.customerOrderCount}',
        ),
        _Line(
          label: l10n.gainCustomerSales,
          value: '${detail.customerSales.toStringAsFixed(3)} $currency',
        ),
        _Line(
          label: l10n.gainFeeEarned,
          value: '${detail.feeEarned.toStringAsFixed(3)} $currency',
        ),
      ],
    );
  }
}

class _StatsTab extends StatelessWidget {
  const _StatsTab({required this.detail});

  final AdminBuildingDetail detail;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Line(label: l10n.statCategories, value: '${detail.categoryCount}'),
        _Line(label: l10n.statArticles, value: '${detail.articleCount}'),
        _Line(label: l10n.statTables, value: '${detail.tableCount}'),
        _Line(label: l10n.statOrders, value: '${detail.orderCount}'),
      ],
    );
  }
}

class _AssignPackDialog extends ConsumerWidget {
  const _AssignPackDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final packs = ref.watch(packsViewModelProvider);
    return ShadDialog(
      title: Text(l10n.assignPack),
      constraints: const BoxConstraints(maxWidth: AppBreakpoints.formMax),
      child: packs.when(
        loading: () => const LinearProgressIndicator(),
        error: (error, _) => Text(lookupError(l10n, mapError(error).l10nKey)),
        data: (rows) {
          final enabled = rows.where((pack) => pack.isEnabled).toList();
          if (enabled.isEmpty) {
            return Text(l10n.empty);
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final pack in enabled)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: ShadButton.outline(
                    onPressed: () => Navigator.of(context).pop(pack.id),
                    child: Text(
                      '${pack.name} · ${l10n.packPriceMonth(formatMillimes(pack.monthlyMillimes))}',
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.muted),
          const SizedBox(height: AppSpacing.xs),
          Text(value, style: theme.textTheme.p),
        ],
      ),
    );
  }
}
