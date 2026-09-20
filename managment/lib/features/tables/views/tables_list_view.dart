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
import '../view_models/tables_view_model.dart';
import '../widgets/table_floor_preview.dart';
import '../widgets/venue_table_dialog.dart';

/// Floor map for a building: seat-based previews, status filters, add dialog.
///
/// When [OrderDraftViewModel] is in [OrderDraftState.pickingTable] mode, taps
/// select the table and continue to article selection instead of editing.
class TablesListView extends ConsumerStatefulWidget {
  const TablesListView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<TablesListView> createState() => _TablesListViewState();
}

class _TablesListViewState extends ConsumerState<TablesListView> {
  var _filter = TableFloorFilter.all;

  Future<void> _openDialog({
    VenueTableView? existing,
    int? suggestedNumber,
  }) async {
    await showVenueTableDialog(
      context,
      buildingId: widget.buildingId,
      existing: existing,
      suggestedNumber: suggestedNumber,
    );
  }

  void _onTableTap(VenueTableView table, {required bool picking}) {
    if (picking) {
      if (!table.isActive) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.orderTableInactive),
          ),
        );
        return;
      }
      final multiOrder =
          ref.read(buildingSelectionProvider)?.tableMultiOrder ?? false;
      if (!multiOrder && table.status == TableFloorStatus.occupied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.orderTableOccupied),
          ),
        );
        return;
      }
      ref
          .read(orderDraftViewModelProvider(widget.buildingId).notifier)
          .selectTable(id: table.id, number: table.number);
      OrderCreateArticlesRoute(buildingId: widget.buildingId).go(context);
      return;
    }

    final isOwner = ref.read(appSessionStoreProvider).isOwner;
    if (isOwner) {
      _openDialog(existing: table);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final isOwner = ref.watch(appSessionStoreProvider).isOwner;
    final draft = ref.watch(orderDraftViewModelProvider(widget.buildingId));
    final picking = draft.pickingTable;
    final async = ref.watch(tablesViewModelProvider(widget.buildingId));
    final tables = async.asData?.value ?? const <VenueTableView>[];
    final nextNumber = tables.isEmpty
        ? 1
        : tables.map((t) => t.number).reduce(math.max) + 1;
    final visible = filterTables(tables, _filter);

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
                            picking
                                ? l10n.orderSelectTablePrompt
                                : l10n.tablesHint,
                            style: text.bodyMedium,
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
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(0, 44),
                        ),
                        onPressed: () =>
                            _openDialog(suggestedNumber: nextNumber),
                        icon: const Icon(Icons.add),
                        label: Text(l10n.addTable),
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
                      final wide =
                          constraints.maxWidth >= AppBreakpoints.expanded;
                      final tileWidth = wide ? 176.0 : 156.0;
                      return Wrap(
                        spacing: AppSpacing.lg,
                        runSpacing: AppSpacing.lg,
                        children: [
                          for (final table in visible)
                            SizedBox(
                              width: tileWidth,
                              child: TableFloorPreview(
                                table: table,
                                onTap: picking || isOwner
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
