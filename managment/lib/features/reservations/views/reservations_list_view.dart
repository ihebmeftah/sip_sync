import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/access/floor_access.dart';
import '../../../core/di/app_providers.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/pack_locked_action.dart';
import '../../../core/widgets/refresh_on_appear.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../tables/view_models/tables_view_model.dart';
import '../view_models/reservations_view_model.dart';

/// Bookings for one UTC day, with a way to add one when the pack allows it.
class ReservationsListView extends ConsumerStatefulWidget {
  const ReservationsListView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<ReservationsListView> createState() =>
      _ReservationsListViewState();
}

class _ReservationsListViewState extends ConsumerState<ReservationsListView> {
  UuidValue? _busyId;

  @override
  void initState() {
    super.initState();
    refreshCachedListOnAppear(
      this,
      providerAlreadyAlive: ref.exists(
        reservationsViewModelProvider(widget.buildingId),
      ),
      refresh: () => ref
          .read(reservationsViewModelProvider(widget.buildingId).notifier)
          .refresh(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final day = ref.watch(reservationsViewModelProvider(widget.buildingId));
    final building = ref.watch(buildingSelectionProvider);
    final pending =
        ref
            .watch(pendingReservationCountProvider(widget.buildingId))
            .asData
            ?.value ??
        0;
    final scheme = Theme.of(context).colorScheme;
    final access = FloorAccess.fromSession(ref.watch(appSessionStoreProvider));
    final packOn = building?.pack.reservations == true;
    final venueReservations = building?.reservationsEnabled ?? true;
    final cap = building?.pack.maxReservationsPerDay;
    final tables = ref.watch(tablesViewModelProvider(widget.buildingId));
    final activeTables =
        tables.asData?.value.where((row) => row.isActive).toList() ??
        const <VenueTableView>[];
    final items = day.asData?.value.items ?? const <ReservationView>[];
    final showingToday = _isToday(day.asData?.value.day);
    final usedToday = items
        .where((row) => row.status != ReservationStatus.cancelled)
        .length;
    final capped =
        packOn && showingToday && packCapReached(max: cap, current: usedToday);

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: day.when(
        loading: () => const AppScreenLoader(),
        error: (error, _) => ListView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          children: [
            LoadFailureNotice(error: error),
            AppErrorBanner(message: lookupError(l10n, mapError(error).l10nKey)),
          ],
        ),
        data: (value) => Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        l10n.reservationsTitle,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    if (pending > 0) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Tooltip(
                        message: l10n.reservationPendingCount(pending),
                        child: Badge(
                          backgroundColor: scheme.primary,
                          textColor: scheme.onPrimary,
                          label: Text(pending > 99 ? '99+' : '$pending'),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                if (access.canManageReservations)
                  PackLockedAction(
                    locked: !packOn || capped,
                    child: AppFilledButton(
                      label: l10n.reservationNew,
                      onPressed: packOn && venueReservations && !capped
                          ? () => ReservationCreateRoute(
                              buildingId: widget.buildingId,
                            ).go(context)
                          : null,
                    ),
                  ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    IconButton(
                      tooltip: l10n.reservationPreviousDay,
                      onPressed: () => ref
                          .read(
                            reservationsViewModelProvider(
                              widget.buildingId,
                            ).notifier,
                          )
                          .shiftDay(-1),
                      icon: const Icon(Icons.chevron_left),
                    ),
                    Expanded(
                      child: Text(
                        MaterialLocalizations.of(context).formatMediumDate(
                          DateTime(
                            value.day.year,
                            value.day.month,
                            value.day.day,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.reservationNextDay,
                      onPressed: () => ref
                          .read(
                            reservationsViewModelProvider(
                              widget.buildingId,
                            ).notifier,
                          )
                          .shiftDay(1),
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                if (value.items.isEmpty)
                  Text(l10n.reservationEmpty)
                else
                  for (final row in value.items)
                    _ReservationCard(
                      key: ValueKey(row.id.uuid),
                      row: row,
                      currency: building?.currencyCode ?? '',
                      busy: _busyId == row.id,
                      onConfirm:
                          row.status == ReservationStatus.requested &&
                              access.canManageReservations &&
                              _busyId == null
                          ? () => _confirm(row)
                          : null,
                      onAssign:
                          row.status == ReservationStatus.confirmed &&
                              access.canManageReservations &&
                              _busyId == null
                          ? () => _assign(row, activeTables)
                          : null,
                      onCancel:
                          (row.status == ReservationStatus.requested ||
                                  row.status == ReservationStatus.confirmed) &&
                              access.canManageReservations &&
                              _busyId == null
                          ? () => _cancel(row)
                          : null,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isToday(DateTime? day) {
    if (day == null) {
      return false;
    }
    final now = DateTime.now();
    return day.year == now.year && day.month == now.month && day.day == now.day;
  }

  Future<void> _confirm(ReservationView row) async {
    await _run(
      row.id,
      () => ref
          .read(reservationsViewModelProvider(widget.buildingId).notifier)
          .confirm(row.id),
    );
  }

  Future<void> _run(UuidValue id, Future<void> Function() action) async {
    setState(() => _busyId = id);
    try {
      await action();
      if (mounted) {
        showSavedSnackBar(context);
      }
    } catch (error) {
      if (mounted) {
        captureError(context, error);
      }
    } finally {
      if (mounted) {
        setState(() => _busyId = null);
      }
    }
  }

  Future<void> _assign(ReservationView row, List<VenueTableView> tables) async {
    final selected = await showDialog<List<UuidValue>>(
      context: context,
      builder: (context) =>
          _AssignTablesDialog(tables: tables, initial: row.tableIds.toSet()),
    );
    if (selected == null || !mounted) {
      return;
    }
    await _run(
      row.id,
      () => ref
          .read(reservationsViewModelProvider(widget.buildingId).notifier)
          .assignTables(row.id, selected),
    );
  }

  Future<void> _cancel(ReservationView row) async {
    final l10n = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.reservationCancel),
        content: Text(l10n.reservationCancelConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.close),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.reservationCancel),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) {
      return;
    }
    await _run(
      row.id,
      () => ref
          .read(reservationsViewModelProvider(widget.buildingId).notifier)
          .cancel(row.id),
    );
  }
}

class _ReservationCard extends StatelessWidget {
  const _ReservationCard({
    super.key,
    required this.row,
    required this.currency,
    required this.busy,
    required this.onConfirm,
    required this.onAssign,
    required this.onCancel,
  });

  final ReservationView row;
  final String currency;
  final bool busy;
  final VoidCallback? onConfirm;
  final VoidCallback? onAssign;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final pending = row.status == ReservationStatus.requested;
    final tables = row.tableNumbers.isEmpty
        ? l10n.reservationNoTable
        : '${l10n.reservationTables} ${row.tableNumbers.join(', ')}';
    final amount = currency.isEmpty
        ? '${row.paidAmount}'
        : '${row.paidAmount} $currency';
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      color: scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        side: BorderSide(
          color: pending
              ? scheme.primary
              : scheme.outline.withValues(alpha: 0.6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _StatusChip(status: row.status),
                const Spacer(),
                Text(_range(context, row), style: text.titleMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(row.guestName, style: text.titleLarge),
            const SizedBox(height: AppSpacing.xs),
            Text(tables, style: text.bodyMedium),
            if (row.guestPhone != null)
              Text(row.guestPhone!, style: text.bodyMedium),
            Text(
              '${l10n.reservationPaidAmount} · $amount',
              style: text.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            if (busy)
              const SizedBox(width: 18, height: 18, child: AppBusyIndicator())
            else
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  if (onConfirm != null)
                    FilledButton(
                      onPressed: onConfirm,
                      child: Text(l10n.reservationConfirm),
                    ),
                  if (onAssign != null)
                    FilledButton.tonal(
                      onPressed: onAssign,
                      child: Text(l10n.reservationAssignTable),
                    ),
                  if (onCancel != null)
                    TextButton(
                      onPressed: onCancel,
                      child: Text(l10n.reservationCancel),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  String _range(BuildContext context, ReservationView row) {
    final localizations = MaterialLocalizations.of(context);
    String clock(DateTime value) {
      return localizations.formatTimeOfDay(
        TimeOfDay.fromDateTime(value.toLocal()),
      );
    }

    return '${clock(row.startsAt)} – ${clock(row.endsAt)}';
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final ReservationStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final (label, background, foreground) = switch (status) {
      ReservationStatus.requested => (
        l10n.reservationStatusRequested,
        scheme.primaryContainer,
        scheme.onPrimaryContainer,
      ),
      ReservationStatus.confirmed => (
        l10n.reservationStatusConfirmed,
        scheme.secondaryContainer,
        scheme.onSecondaryContainer,
      ),
      ReservationStatus.arrived => (
        l10n.reservationStatusArrived,
        scheme.tertiaryContainer,
        scheme.onTertiaryContainer,
      ),
      ReservationStatus.cancelled => (
        l10n.reservationStatusCancelled,
        scheme.errorContainer,
        scheme.onErrorContainer,
      ),
      ReservationStatus.noShow => (
        l10n.reservationStatusNoShow,
        scheme.surfaceContainerHighest,
        scheme.onSurface,
      ),
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: foreground),
        ),
      ),
    );
  }
}

/// Picks the tables for a confirmed reservation. Empty selection stays on screen.
class _AssignTablesDialog extends StatefulWidget {
  const _AssignTablesDialog({required this.tables, required this.initial});

  final List<VenueTableView> tables;
  final Set<UuidValue> initial;

  @override
  State<_AssignTablesDialog> createState() => _AssignTablesDialogState();
}

class _AssignTablesDialogState extends State<_AssignTablesDialog> {
  late final Set<UuidValue> _selected = {...widget.initial};
  var _showError = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.reservationAssignTable),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final table in widget.tables)
                FilterChip(
                  label: Text('${table.number}'),
                  selected: _selected.contains(table.id),
                  onSelected: (selected) {
                    setState(() {
                      _showError = false;
                      if (selected) {
                        _selected.add(table.id);
                      } else {
                        _selected.remove(table.id);
                      }
                    });
                  },
                ),
            ],
          ),
          if (_showError)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: AppErrorBanner(message: l10n.reservationSelectTables),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.close),
        ),
        FilledButton(
          onPressed: () {
            if (_selected.isEmpty) {
              setState(() => _showError = true);
              return;
            }
            Navigator.of(context).pop(_selected.toList());
          },
          child: Text(l10n.reservationAssignTable),
        ),
      ],
    );
  }
}
