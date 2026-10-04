import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../console/views/console_shell.dart';
import '../../packs/pack_money.dart';
import '../../packs/views/pack_form_dialog.dart';
import '../pack_assignment.dart';
import '../pack_term_preview.dart';
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
    final assignment = await showShadDialog<PackAssignment>(
      context: context,
      builder: (_) => const _AssignPackDialog(),
    );
    if (assignment == null || !mounted) {
      return;
    }
    await _saveAssignment(assignment);
  }

  Future<void> _createPrivate() async {
    final created = await showShadDialog<PackView>(
      context: context,
      builder: (_) => const PackFormDialog(),
    );
    if (created == null || !mounted) {
      return;
    }
    final assignment = await showShadDialog<PackAssignment>(
      context: context,
      builder: (_) => _AssignPackDialog(pack: created),
    );
    if (assignment == null || !mounted) {
      return;
    }
    await _saveAssignment(assignment);
  }

  Future<void> _saveAssignment(PackAssignment assignment) async {
    final error = await ref
        .read(buildingDetailViewModelProvider(widget.buildingId).notifier)
        .assignPack(assignment);
    if (!mounted) {
      return;
    }
    setState(() => _errorKey = error);
  }
}

String _formatExpiry(BuildContext context, DateTime value) {
  final locale = Localizations.localeOf(context).toString();
  return DateFormat.yMMMMd(locale).format(value.toLocal());
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
        const SizedBox(height: AppSpacing.sm),
        if (detail.packBillingPeriod != null)
          Text(
            _billingPeriodLabel(l10n, detail.packBillingPeriod!),
            style: theme.textTheme.p,
          ),
        Text(
          detail.packExpiresAt == null
              ? l10n.packExpiresNever
              : l10n.packExpiresOn(
                  _formatExpiry(context, detail.packExpiresAt!),
                ),
          style: theme.textTheme.p,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(_limits(l10n, caps), style: theme.textTheme.small),
        const SizedBox(height: AppSpacing.lg),
        if (pack.code == 'free') ...[
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
        ] else
          AppErrorBanner(message: l10n.packPaidLocked),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.packHistoryTitle, style: theme.textTheme.h4),
        const SizedBox(height: AppSpacing.sm),
        if (detail.packHistory.isEmpty)
          Text(l10n.empty, style: theme.textTheme.muted)
        else
          for (final row in detail.packHistory) _HistoryLine(row: row),
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

class _AssignPackDialog extends ConsumerStatefulWidget {
  const _AssignPackDialog({this.pack});

  /// Skips the catalog list when a private pack was just created.
  final PackView? pack;

  @override
  ConsumerState<_AssignPackDialog> createState() => _AssignPackDialogState();
}

class _AssignPackDialogState extends ConsumerState<_AssignPackDialog> {
  PackView? _selected;
  PackBillingPeriod _period = PackBillingPeriod.monthly;
  late DateTime _expires = previewPackExpiry(_period);
  String? _dateError;
  String? _dateNote;
  late final Future<List<PackView>> _catalog;

  @override
  void initState() {
    super.initState();
    _catalog = ref.read(packRepositoryProvider).listAll();
    final pack = widget.pack;
    if (pack != null && pack.code != 'free') {
      _selected = pack;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final selected = _selected;
    return ShadDialog(
      title: Text(l10n.assignPack),
      constraints: const BoxConstraints(maxWidth: AppBreakpoints.formMax),
      child: selected == null
          ? FutureBuilder<List<PackView>>(
              future: _catalog,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    lookupError(l10n, mapError(snapshot.error!).l10nKey),
                  );
                }
                final rows = snapshot.data;
                if (rows == null) {
                  return const LinearProgressIndicator();
                }
                return _packList(context, l10n, rows);
              },
            )
          : _termStep(context, l10n, selected),
    );
  }

  Widget _packList(
    BuildContext context,
    AppLocalizations l10n,
    List<PackView> rows,
  ) {
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
              onPressed: () => _choose(pack),
              child: Text(
                '${pack.name} · ${l10n.packPriceMonth(formatMillimes(pack.monthlyMillimes))}',
              ),
            ),
          ),
      ],
    );
  }

  void _choose(PackView pack) {
    if (pack.code == 'free') {
      Navigator.of(context).pop(PackAssignment(packId: pack.id));
      return;
    }
    setState(() {
      _selected = pack;
      _period = PackBillingPeriod.monthly;
      _expires = previewPackExpiry(PackBillingPeriod.monthly);
      _dateError = null;
      _dateNote = null;
    });
  }

  Widget _termStep(BuildContext context, AppLocalizations l10n, PackView pack) {
    final theme = ShadTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(pack.name, style: theme.textTheme.h4),
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.packTermHint, style: theme.textTheme.muted),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          children: [
            _periodButton(
              label: l10n.packBillingDaily,
              period: PackBillingPeriod.daily,
            ),
            _periodButton(
              label: l10n.packBillingMonthly,
              period: PackBillingPeriod.monthly,
            ),
            _periodButton(
              label: l10n.packBillingYearly,
              period: PackBillingPeriod.yearly,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.packExpiresOn(_formatExpiry(context, _expires)),
          style: theme.textTheme.p,
        ),
        if (_dateNote != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(_dateNote!, style: theme.textTheme.small),
        ],
        if (_dateError != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            _dateError!,
            style: theme.textTheme.small.copyWith(
              color: theme.colorScheme.destructive,
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            if (widget.pack == null)
              ShadButton.outline(
                onPressed: () => setState(() {
                  _selected = null;
                  _dateError = null;
                  _dateNote = null;
                }),
                child: Text(l10n.packsTitle),
              ),
            ShadButton.outline(
              onPressed: _changeDate,
              child: Text(l10n.packChangeDate),
            ),
            ShadButton(
              onPressed: () => _confirm(l10n, pack),
              child: Text(l10n.packAssignConfirm),
            ),
          ],
        ),
      ],
    );
  }

  Widget _periodButton({
    required String label,
    required PackBillingPeriod period,
  }) {
    void select() => setState(() {
      _period = period;
      _expires = previewPackExpiry(period);
      _dateError = null;
      _dateNote = null;
    });
    if (_period == period) {
      return ShadButton(onPressed: select, child: Text(label));
    }
    return ShadButton.outline(onPressed: select, child: Text(label));
  }

  Future<void> _changeDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final horizon = today.add(const Duration(days: 365 * 5));
    final first = switch (_period) {
      PackBillingPeriod.daily => tomorrow,
      PackBillingPeriod.monthly => packLocalDate(
        previewPackExpiry(PackBillingPeriod.monthly),
      ),
      PackBillingPeriod.yearly => packLocalDate(
        previewPackExpiry(PackBillingPeriod.yearly),
      ),
    };
    var initial = packLocalDate(_expires);
    if (initial.isBefore(first)) {
      initial = first;
    }
    if (initial.isAfter(horizon)) {
      initial = horizon;
    }
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: horizon,
    );
    if (!mounted || picked == null) {
      return;
    }
    final l10n = AppLocalizations.of(context)!;
    final chosen = endOfLocalDay(picked);
    if (_period == PackBillingPeriod.daily) {
      final normalized = normalizePackTerm(period: _period, expiresAt: chosen);
      setState(() {
        _period = normalized.period;
        _expires = normalized.expiresAt;
        _dateError = null;
        _dateNote = normalized.startedMonthly
            ? l10n.packDailyStartsMonthly
            : null;
      });
      return;
    }
    setState(() {
      _expires = chosen;
      _dateNote = null;
      _dateError = FormValidators.packExpiry(l10n, chosen, _period);
    });
  }

  void _confirm(AppLocalizations l10n, PackView pack) {
    final normalized = normalizePackTerm(period: _period, expiresAt: _expires);
    final error = FormValidators.packExpiry(
      l10n,
      normalized.expiresAt,
      normalized.period,
    );
    if (error != null) {
      setState(() => _dateError = error);
      return;
    }
    Navigator.of(context).pop(
      PackAssignment(
        packId: pack.id,
        billingPeriod: normalized.period,
        expiresAt: normalized.expiresAt.toUtc(),
      ),
    );
  }
}

class _HistoryLine extends StatelessWidget {
  const _HistoryLine({required this.row});

  final BuildingPackAssignmentView row;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);
    final status = row.endedAt == null
        ? l10n.packHistoryCurrent
        : switch (row.endReason) {
            BuildingPackEndReason.replaced => l10n.packEndReplaced,
            BuildingPackEndReason.expired => l10n.packEndExpired,
            null => l10n.packHistoryCurrent,
          };
    final period = switch (row.billingPeriod) {
      PackBillingPeriod.daily => l10n.packBillingDaily,
      PackBillingPeriod.monthly => l10n.packBillingMonthly,
      PackBillingPeriod.yearly => l10n.packBillingYearly,
      null => null,
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(row.packName, style: theme.textTheme.p),
          Text(
            [
              status,
              ?period,
              _formatExpiry(context, row.startedAt),
              if (row.endedAt != null) _formatExpiry(context, row.endedAt!),
            ].join(' · '),
            style: theme.textTheme.muted,
          ),
        ],
      ),
    );
  }
}

String _billingPeriodLabel(AppLocalizations l10n, PackBillingPeriod period) {
  return switch (period) {
    PackBillingPeriod.daily => l10n.packBillingDaily,
    PackBillingPeriod.monthly => l10n.packBillingMonthly,
    PackBillingPeriod.yearly => l10n.packBillingYearly,
  };
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
