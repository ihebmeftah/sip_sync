import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../orders/view_models/order_draft_view_model.dart';
import '../table_qr_pdf_service.dart';
import '../view_models/tables_view_model.dart';
import '../widgets/table_floor_preview.dart';
import '../widgets/venue_table_dialog.dart';

/// Floor map for a building: seat-based previews, status filters, add/edit form.
///
/// Owner create/edit uses a full screen on mobile and a dialog on wide layouts.
/// Owner FAB pick mode and employee taps both select a table and continue to
/// article selection. Owners edit tables when not picking.
class TablesListView extends ConsumerStatefulWidget {
  const TablesListView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<TablesListView> createState() => _TablesListViewState();
}

class _TablesListViewState extends ConsumerState<TablesListView> {
  var _filter = TableFloorFilter.all;
  var _exportingQr = false;

  Future<void> _exportQrPdf(List<VenueTableView> tables) async {
    final l10n = AppLocalizations.of(context)!;
    if (tables.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.tableQrExportEmpty)));
      return;
    }
    setState(() => _exportingQr = true);
    try {
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.tableQrExportFailed)));
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.orderTableInactive)));
      return false;
    }
    final multiOrder =
        ref.read(buildingSelectionProvider)?.tableMultiOrder ?? false;
    if (!multiOrder && table.status == TableFloorStatus.occupied) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.orderTableOccupied)));
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

    final store = ref.read(appSessionStoreProvider);
    if (store.isOwner) {
      _openForm(existing: table);
      return;
    }
    if (store.isEmployee) {
      _startOrderOnTable(table, fromPick: false);
    }
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
    final tables = async.asData?.value ?? const <VenueTableView>[];
    final nextNumber = tables.isEmpty
        ? 1
        : tables.map((t) => t.number).reduce(math.max) + 1;
    final visible = filterTables(tables, _filter);
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
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 44),
                            ),
                            onPressed: _exportingQr || tables.isEmpty
                                ? null
                                : () => _exportQrPdf(tables),
                            icon: _exportingQr
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.qr_code_2_outlined),
                            label: AppButtonLabel(l10n.tableQrExportPdf),
                          ),
                          FilledButton.icon(
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(0, 44),
                            ),
                            onPressed: () =>
                                _openForm(suggestedNumber: nextNumber),
                            icon: const Icon(Icons.add),
                            label: AppButtonLabel(l10n.addTable),
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
                      for (final filter in TableFloorFilter.values)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: AppSpacing.sm,
                          ),
                          child: FilterChip(
                            selected: _filter == filter,
                            showCheckmark: false,
                            label: Text(_filterLabel(l10n, filter)),
                            selectedColor: scheme.secondaryContainer,
                            onSelected: (_) => setState(() => _filter = filter),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (async.isLoading && async.asData == null)
                  const LinearProgressIndicator()
                else if (async.hasError && async.asData == null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                      isOwner ? l10n.tablesEmptyOwner : l10n.tablesEmpty,
                    ),
                  )
                else if (visible.isEmpty)
                  AppSurfaceCard(child: Text(l10n.tablesFilterEmpty))
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
                          for (final table in visible)
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

  String _filterLabel(AppLocalizations l10n, TableFloorFilter filter) {
    return switch (filter) {
      TableFloorFilter.all => l10n.tableFilterAll,
      TableFloorFilter.available => l10n.tableStatusAvailable,
      TableFloorFilter.occupied => l10n.tableStatusOccupied,
      TableFloorFilter.reserved => l10n.tableStatusReserved,
      TableFloorFilter.inactive => l10n.tableFilterInactive,
    };
  }
}
