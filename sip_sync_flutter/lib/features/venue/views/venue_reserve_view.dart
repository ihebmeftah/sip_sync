import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/customer_reservations_view_model.dart';
import '../view_models/venue_detail_view_model.dart';
import '../widgets/venue_chrome.dart';

/// Customer request for one venue, plus their upcoming rows.
class VenueReserveView extends ConsumerStatefulWidget {
  const VenueReserveView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<VenueReserveView> createState() => _VenueReserveViewState();
}

class _VenueReserveViewState extends ConsumerState<VenueReserveView> {
  UuidValue? _busyId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final signedIn = ref.watch(appSessionStoreProvider).isSignedIn;
    final detail = ref.watch(venueDetailViewModelProvider(widget.buildingId));
    final mine = ref.watch(myReservationsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const VenueBackButton(),
        title: Text(l10n.reserveTable),
        actions: const [LocaleMenuButton()],
      ),
      body: SafeArea(
        top: false,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                if (!signedIn)
                  AppFilledButton(
                    label: l10n.signInToReserve,
                    onPressed: () => const SignInRoute().go(context),
                  )
                else
                  detail.when(
                    loading: () => const AppScreenLoader(compact: true),
                    error: (error, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LoadFailureNotice(error: error),
                        AppErrorBanner(
                          message: lookupError(l10n, mapError(error).l10nKey),
                        ),
                      ],
                    ),
                    data: (page) {
                      if (page.reservationsClosedByVenue) {
                        return AppFilledButton(
                          label: l10n.reservationBook,
                          onPressed: null,
                        );
                      }
                      if (!page.reservationsEnabled) {
                        return Text(l10n.errorPackFeatureReservations);
                      }
                      return AppFilledButton(
                        label: l10n.reservationBook,
                        onPressed: () => showReserveRequestDialog(
                          context,
                          buildingId: page.venue.id,
                        ),
                      );
                    },
                  ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  l10n.reservationMine,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                mine.when(
                  loading: () => const AppScreenLoader(compact: true),
                  error: (error, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LoadFailureNotice(error: error),
                      AppErrorBanner(
                        message: lookupError(l10n, mapError(error).l10nKey),
                      ),
                    ],
                  ),
                  data: (rows) {
                    final here = [
                      for (final row in rows)
                        if (row.buildingId.uuid == widget.buildingId) row,
                    ];
                    if (here.isEmpty) {
                      return Text(l10n.reservationEmpty);
                    }
                    return Column(
                      children: [
                        for (final row in here)
                          _ReservationCard(
                            key: ValueKey(row.id.uuid),
                            row: row,
                            busy: _busyId == row.id,
                            onCancel:
                                _busyId == null &&
                                    (row.status ==
                                            ReservationStatus.requested ||
                                        row.status ==
                                            ReservationStatus.confirmed)
                                ? () => _cancel(row.id)
                                : null,
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

  Future<void> _cancel(UuidValue id) async {
    setState(() => _busyId = id);
    try {
      await ref.read(myReservationsProvider.notifier).cancel(id);
    } catch (error) {
      if (mounted) {
        showMappedError(context, error);
      }
    } finally {
      if (mounted) {
        setState(() => _busyId = null);
      }
    }
  }
}

class _ReservationCard extends StatelessWidget {
  const _ReservationCard({
    super.key,
    required this.row,
    required this.busy,
    required this.onCancel,
  });

  final ReservationView row;
  final bool busy;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final localizations = MaterialLocalizations.of(context);
    final start = row.startsAt.toLocal();
    final pending = row.status == ReservationStatus.requested;
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
                Text(
                  localizations.formatMediumDate(start),
                  style: text.titleSmall,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(start))} – ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(row.endsAt.toLocal()))}',
              style: text.titleMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(_summary(l10n, row), style: text.bodyMedium),
            if (busy) ...[
              const SizedBox(height: AppSpacing.sm),
              const SizedBox(
                width: 18,
                height: 18,
                child: AppBusyIndicator(),
              ),
            ] else if (onCancel != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: onCancel,
                  child: Text(l10n.reservationCancel),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _summary(AppLocalizations l10n, ReservationView row) {
    return switch (row.status) {
      ReservationStatus.requested => l10n.reservationAwaitingConfirmation,
      ReservationStatus.confirmed when row.tableNumbers.isEmpty =>
        l10n.reservationAwaitingTable,
      ReservationStatus.confirmed =>
        '${l10n.reservationStatusConfirmed} · ${row.tableNumbers.join(', ')}',
      ReservationStatus.arrived =>
        '${l10n.reservationStatusArrived} · ${row.tableNumbers.join(', ')}',
      ReservationStatus.cancelled => l10n.reservationStatusCancelled,
      ReservationStatus.noShow => l10n.reservationStatusNoShow,
    };
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

/// Asks for a date and a start, then sends the reservation request.
///
/// The server sets the end two hours after the start. Nothing is sent until
/// the customer confirms.
Future<void> showReserveRequestDialog(
  BuildContext context, {
  required UuidValue buildingId,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _ReserveRequestDialog(buildingId: buildingId),
  );
}

class _ReserveRequestDialog extends ConsumerStatefulWidget {
  const _ReserveRequestDialog({required this.buildingId});

  final UuidValue buildingId;

  @override
  ConsumerState<_ReserveRequestDialog> createState() =>
      _ReserveRequestDialogState();
}

class _ReserveRequestDialogState extends ConsumerState<_ReserveRequestDialog> {
  late DateTime _date;
  late TimeOfDay _start;
  var _saving = false;
  String? _errorKey;

  @override
  void initState() {
    super.initState();
    final start = DateTime.now().add(const Duration(hours: 2));
    _date = DateTime(start.year, start.month, start.day);
    _start = TimeOfDay(hour: start.hour, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PopScope(
      canPop: !_saving,
      child: Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.formMax),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.reserveTable,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.reservationDate),
                  subtitle: Text(
                    MaterialLocalizations.of(context).formatMediumDate(_date),
                  ),
                  onTap: _saving ? null : _pickDate,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.reservationStart),
                  subtitle: Text(_start.format(context)),
                  onTap: _saving ? null : _pickTime,
                ),
                if (_errorKey != null)
                  AppErrorBanner(message: lookupError(l10n, _errorKey!)),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    TextButton(
                      onPressed: _saving
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: Text(l10n.close),
                    ),
                    const Spacer(),
                    AppFilledButton(
                      label: l10n.reservationBook,
                      expand: false,
                      busy: _saving,
                      onPressed: _saving ? null : _submit,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime _combine(TimeOfDay time) {
    return DateTime(
      _date.year,
      _date.month,
      _date.day,
      time.hour,
      time.minute,
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _start);
    if (picked == null) {
      return;
    }
    setState(() => _start = picked);
  }

  Future<void> _submit() async {
    final start = _combine(_start);
    if (!start.isAfter(DateTime.now())) {
      setState(() => _errorKey = 'reservationWindow');
      return;
    }
    setState(() {
      _saving = true;
      _errorKey = null;
    });
    try {
      final created = await ref
          .read(customerReservationRepositoryProvider)
          .create(
            CustomerReservationCreate(
              buildingId: widget.buildingId,
              startsAt: start.toUtc(),
            ),
          );
      ref.read(myReservationsProvider.notifier).remember(created);
      if (mounted) {
        popWithSnackBar(context, AppLocalizations.of(context)!.noticeSaved);
      }
    } catch (error) {
      if (mounted) {
        setState(() => _errorKey = mapError(error).l10nKey);
        showMappedError(context, error);
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }
}
