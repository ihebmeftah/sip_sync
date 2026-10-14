import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/pack_catalog_sheet.dart';
import '../../../core/widgets/pack_locked_action.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/refresh_on_appear.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../orders/view_models/order_draft_view_model.dart';
import '../table_qr_pdf_service.dart';
import '../view_models/tables_view_model.dart';
import '../widgets/table_actions_sheet.dart';
import '../widgets/table_floor_preview.dart';
import '../widgets/venue_table_dialog.dart';

/// Floor map for a building: seat-based previews, status filters, add/edit form.
///
/// Owner create/edit uses a full screen on mobile and a dialog on wide layouts.
/// Non-pick taps open a sheet/dialog (edit, open orders, create). Pick mode
/// still selects the table and continues to article selection.
class TablesListView extends ConsumerStatefulWidget {
  const TablesListView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<TablesListView> createState() => _TablesListViewState();
}

class _TablesListViewState extends ConsumerState<TablesListView> {
  var _exportingQr = false;

  @override
  void initState() {
    super.initState();
    refreshCachedListOnAppear(
      this,
      providerAlreadyAlive: ref.exists(
        tablesViewModelProvider(widget.buildingId),
      ),
      refresh: () => ref
          .read(tablesViewModelProvider(widget.buildingId).notifier)
          .onScreenAppeared(),
    );
  }

  Future<void> _exportQrPdf() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _exportingQr = true);
    try {
      final tables = await ref
          .read(tablesViewModelProvider(widget.buildingId).notifier)
          .listAllForExport();
      if (tables.isEmpty) {
        if (!mounted) return;
        showAppSnackBar(context, l10n.tableQrExportEmpty);
        return;
      }
      final building = ref.read(buildingSelectionProvider);
      final name = building?.name ?? l10n.navTables;
      await TableQrPdfService().exportStickers(
        buildingName: name,
        buildingId: UuidValue.fromString(widget.buildingId),
        tables: tables,
      );
    } catch (_) {
      if (!mounted) {
        return;
      }
      showAppSnackBar(
        context,
        l10n.tableQrExportFailed,
        kind: AppNoticeKind.error,
      );
    } finally {
      if (mounted) {
        setState(() => _exportingQr = false);
      }
    }
  }

  Future<void> _openForm({
    VenueTableView? existing,
    int? suggestedNumber,
  }) async {
    await openVenueTableForm(
      context,
      buildingId: widget.buildingId,
      existing: existing,
      suggestedNumber: suggestedNumber,
    );
  }

  bool _canStartOrderOn(VenueTableView table) {
    final l10n = AppLocalizations.of(context)!;
    if (!table.isActive) {
      showAppSnackBar(
        context,
        l10n.orderTableInactive,
        kind: AppNoticeKind.error,
      );
      return false;
    }
    final multiOrder =
        ref.read(buildingSelectionProvider)?.tableMultiOrder ?? false;
    if (!multiOrder && table.status == TableFloorStatus.occupied) {
      showAppSnackBar(
        context,
        l10n.orderTableOccupied,
        kind: AppNoticeKind.error,
      );
      return false;
    }
    return true;
  }

  void _startOrderOnTable(VenueTableView table, {required bool fromPick}) {
    if (!_canStartOrderOn(table)) {
      return;
    }
    final draft = ref.read(
      orderDraftViewModelProvider(widget.buildingId).notifier,
    );
    if (fromPick) {
      draft.selectTable(id: table.id, number: table.number);
    } else {
      draft.startOnTable(id: table.id, number: table.number);
    }
    OrderCreateArticlesRoute(buildingId: widget.buildingId).go(context);
  }

  void _onTableTap(VenueTableView table, {required bool picking}) {
    if (picking) {
      _startOrderOnTable(table, fromPick: true);
      return;
    }
    showTableActionsSheet(context, buildingId: widget.buildingId, table: table);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final store = ref.watch(appSessionStoreProvider);
    final isOwner = store.isOwner;
    final isEmployee = store.isEmployee;
    final draft = ref.watch(orderDraftViewModelProvider(widget.buildingId));
    final picking = draft.pickingTable;
    final async = ref.watch(tablesViewModelProvider(widget.buildingId));
    final filter = ref
        .watch(tablesViewModelProvider(widget.buildingId).notifier)
        .filter;
    final tables = async.asData?.value ?? const <VenueTableView>[];
    final pack = ref.watch(buildingSelectionProvider)?.pack;
    final qrLocked = pack != null && !pack.tableQr;
    final addLocked =
        filter == TableListFilter.all &&
        packCapReached(max: pack?.maxTables, current: tables.length);
    final hint = picking
        ? l10n.orderSelectTablePrompt
        : isEmployee
        ? l10n.tablesEmployeeOrderHint
        : l10n.tablesHint;

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox.expand(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.xl,
                AppSpacing.xl,
                96,
              ),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.navTables, style: text.headlineSmall),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            hint,
                            style: text.bodyMedium,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (picking)
                      TextButton(
                        onPressed: () {
                          ref
                              .read(
                                orderDraftViewModelProvider(
                                  widget.buildingId,
                                ).notifier,
                              )
                              .cancelPicking();
                        },
                        child: Text(l10n.cancel),
                      )
                    else if (isOwner)
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        alignment: WrapAlignment.end,
                        children: [
                          PackLockedAction(
                            locked: qrLocked,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(0, 44),
                              ),
                              onPressed: qrLocked || _exportingQr
                                  ? null
                                  : _exportQrPdf,
                              icon: _exportingQr
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: AppBusyIndicator(),
                                    )
                                  : const Icon(Icons.qr_code_2_outlined),
                              label: AppButtonLabel(l10n.tableQrExportPdf),
                            ),
                          ),
                          PackLockedAction(
                            locked: addLocked,
                            child: FilledButton.icon(
                              style: FilledButton.styleFrom(
                                minimumSize: const Size(0, 44),
                              ),
                              onPressed: addLocked
                                  ? null
                                  : () async {
                                      final all = await ref
                                          .read(
                                            tablesViewModelProvider(
                                              widget.buildingId,
                                            ).notifier,
                                          )
                                          .listAllForExport();
                                      if (!context.mounted) return;
                                      final cap = ref
                                          .read(buildingSelectionProvider)
                                          ?.pack
                                          .maxTables;
                                      if (packCapReached(
                                        max: cap,
                                        current: all.length,
                                      )) {
                                        showPackCatalog(context);
                                        return;
                                      }
                                      final nextNumber = all.isEmpty
                                          ? 1
                                          : all
                                                    .map((t) => t.number)
                                                    .reduce(math.max) +
                                                1;
                                      await _openForm(
                                        suggestedNumber: nextNumber,
                                      );
                                    },
                              icon: const Icon(Icons.add),
                              label: AppButtonLabel(l10n.addTable),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                if (picking) ...[
                  const SizedBox(height: AppSpacing.lg),
                  AppSurfaceCard(
                    child: Row(
                      children: [
                        Icon(Icons.touch_app_outlined, color: scheme.primary),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            l10n.orderSelectTableFloorHint,
                            style: text.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final chip in TableListFilter.values)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: AppSpacing.sm,
                          ),
                          child: AppFilterChip(
                            selected: filter == chip,
                            label: _filterLabel(l10n, chip),
                            onSelected: (_) => ref
                                .read(
                                  tablesViewModelProvider(
                                    widget.buildingId,
                                  ).notifier,
                                )
                                .setFilter(chip),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (async.isLoading && async.asData == null)
                  const AppScreenLoader()
                else if (async.hasError && async.asData == null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LoadFailureNotice(error: async.error),
                      AppErrorBanner(
                        message: lookupError(
                          l10n,
                          mapError(async.error!).l10nKey,
                        ),
                      ),
                      TextButton(
                        onPressed: () => ref
                            .read(
                              tablesViewModelProvider(
                                widget.buildingId,
                              ).notifier,
                            )
                            .refresh(),
                        child: Text(l10n.retry),
                      ),
                    ],
                  )
                else if (tables.isEmpty)
                  AppSurfaceCard(
                    child: Text(
                      filter == TableListFilter.all
                          ? (isOwner ? l10n.tablesEmptyOwner : l10n.tablesEmpty)
                          : l10n.tablesFilterEmpty,
                    ),
                  )
                else
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      // Two columns on phones, three on mid, four on wide.
                      final columns = width >= AppBreakpoints.expanded
                          ? 4
                          : width >= 520
                          ? 3
                          : 2;
                      final gap = AppSpacing.lg;
                      final tileWidth = (width - gap * (columns - 1)) / columns;
                      return Wrap(
                        spacing: gap,
                        runSpacing: gap,
                        children: [
                          for (final table in tables)
                            SizedBox(
                              width: tileWidth,
                              child: TableFloorPreview(
                                table: table,
                                onTap: picking || isOwner || isEmployee
                                    ? () => _onTableTap(table, picking: picking)
                                    : null,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _filterLabel(AppLocalizations l10n, TableListFilter filter) {
    return switch (filter) {
      TableListFilter.all => l10n.tableFilterAll,
      TableListFilter.available => l10n.tableStatusAvailable,
      TableListFilter.occupied => l10n.tableStatusOccupied,
      TableListFilter.reserved => l10n.tableStatusReserved,
      TableListFilter.inactive => l10n.tableFilterInactive,
    };
  }
}
