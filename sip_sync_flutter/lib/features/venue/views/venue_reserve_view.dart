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

/// Customer request for one venue, plus their upcoming rows.
class VenueReserveView extends ConsumerStatefulWidget {
  const VenueReserveView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<VenueReserveView> createState() => _VenueReserveViewState();
}

class _VenueReserveViewState extends ConsumerState<VenueReserveView> {
  var _composerShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      ref
          .read(venueDetailViewModelProvider(widget.buildingId))
          .whenData(_presentComposer);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final signedIn = ref.watch(appSessionStoreProvider).isSignedIn;
    final detail = ref.watch(venueDetailViewModelProvider(widget.buildingId));
    final mine = ref.watch(myReservationsProvider);
    ref.listen(venueDetailViewModelProvider(widget.buildingId), (_, next) {
      next.whenData(_presentComposer);
    });

    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                Text(
                  l10n.reserveTable,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.lg),
                if (!signedIn)
                  AppFilledButton(
                    label: l10n.signInToReserve,
                    onPressed: () => const SignInRoute().go(context),
                  )
                else
                  detail.when(
                    loading: () => const AppScreenLoader(compact: true),
                    error: (error, _) => AppErrorBanner(
                      message: lookupError(l10n, mapError(error).l10nKey),
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
                  error: (error, _) => AppErrorBanner(
                    message: lookupError(l10n, mapError(error).l10nKey),
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
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              '${_clock(row.startsAt)} – ${_clock(row.endsAt)}',
                            ),
                            subtitle: Text(_summary(l10n, row)),
                            trailing:
                                row.status == ReservationStatus.requested ||
                                    row.status == ReservationStatus.confirmed
                                ? TextButton(
                                    onPressed: () => _cancel(row.id),
                                    child: Text(l10n.reservationCancel),
                                  )
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

  void _presentComposer(CustomerVenueDetail page) {
    if (_composerShown || !mounted) {
      return;
    }
    if (!ref.read(appSessionStoreProvider).isSignedIn) {
      return;
    }
    if (!page.reservationsEnabled || page.reservationsClosedByVenue) {
      return;
    }
    _composerShown = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      showReserveRequestDialog(context, buildingId: page.venue.id);
    });
  }

  Future<void> _cancel(UuidValue id) async {
    try {
      await ref.read(myReservationsProvider.notifier).cancel(id);
    } catch (error) {
      if (mounted) {
        showMappedError(context, error);
      }
    }
  }

  String _summary(AppLocalizations l10n, ReservationView row) {
    final status = switch (row.status) {
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
    return status;
  }

  String _clock(DateTime value) {
    final local = value.toLocal();
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
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
      await ref
          .read(customerReservationRepositoryProvider)
          .create(
            CustomerReservationCreate(
              buildingId: widget.buildingId,
              startsAt: start.toUtc(),
            ),
          );
      ref.invalidate(myReservationsProvider);
      if (mounted) {
        Navigator.of(context).pop();
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
