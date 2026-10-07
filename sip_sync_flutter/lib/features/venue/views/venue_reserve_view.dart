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

/// Customer booking for one venue, plus their upcoming rows.
class VenueReserveView extends ConsumerStatefulWidget {
  const VenueReserveView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<VenueReserveView> createState() => _VenueReserveViewState();
}

class _VenueReserveViewState extends ConsumerState<VenueReserveView> {
  final _selected = <UuidValue>{};
  DateTime _date = DateTime.now();
  TimeOfDay _start = TimeOfDay.now();
  TimeOfDay _end = TimeOfDay.now();
  var _saving = false;
  String? _errorKey;

  @override
  void initState() {
    super.initState();
    final start = DateTime.now().add(const Duration(hours: 2));
    _date = DateTime(start.year, start.month, start.day);
    _start = TimeOfDay(hour: start.hour, minute: 0);
    final end = start.add(const Duration(hours: 1));
    _end = TimeOfDay(hour: end.hour, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final signedIn = ref.watch(appSessionStoreProvider).isSignedIn;
    final detail = ref.watch(venueDetailViewModelProvider(widget.buildingId));
    final mine = ref.watch(myReservationsProvider);

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
                      if (!page.reservationsEnabled) {
                        return Text(l10n.errorPackFeatureReservations);
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Wrap(
                            spacing: AppSpacing.sm,
                            children: [
                              for (final table in page.bookableTables)
                                FilterChip(
                                  label: Text(l10n.tableNumber(table.number)),
                                  selected: _selected.contains(table.id),
                                  onSelected: (selected) {
                                    setState(() {
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
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(l10n.reservationDate),
                            subtitle: Text(
                              MaterialLocalizations.of(
                                context,
                              ).formatMediumDate(_date),
                            ),
                            onTap: _pickDate,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(l10n.reservationStart),
                            subtitle: Text(_start.format(context)),
                            onTap: () => _pickTime(start: true),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(l10n.reservationEnd),
                            subtitle: Text(_end.format(context)),
                            onTap: () => _pickTime(start: false),
                          ),
                          if (_errorKey != null)
                            AppErrorBanner(
                              message: lookupError(l10n, _errorKey!),
                            ),
                          AppFilledButton(
                            label: l10n.reservationBook,
                            busy: _saving,
                            onPressed: _saving ? null : () => _submit(page),
                          ),
                        ],
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
                            subtitle: Text(
                              row.tableNumbers.join(', '),
                            ),
                            trailing: row.status == ReservationStatus.booked
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

  Future<void> _pickTime({required bool start}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: start ? _start : _end,
    );
    if (picked == null) {
      return;
    }
    setState(() {
      if (start) {
        _start = picked;
      } else {
        _end = picked;
      }
    });
  }

  Future<void> _submit(CustomerVenueDetail page) async {
    if (_selected.isEmpty) {
      setState(() => _errorKey = 'reservationSelectTables');
      return;
    }
    final start = _combine(_start);
    final end = _combine(_end);
    final length = end.difference(start);
    if (!start.isAfter(DateTime.now()) ||
        !end.isAfter(start) ||
        length < const Duration(minutes: 30) ||
        length > const Duration(hours: 8)) {
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
              buildingId: page.venue.id,
              tableIds: _selected.toList(),
              startsAt: start.toUtc(),
              endsAt: end.toUtc(),
            ),
          );
      ref.invalidate(myReservationsProvider);
      if (mounted) {
        setState(() => _selected.clear());
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

  Future<void> _cancel(UuidValue id) async {
    try {
      await ref.read(myReservationsProvider.notifier).cancel(id);
    } catch (error) {
      if (mounted) {
        showMappedError(context, error);
      }
    }
  }

  String _clock(DateTime value) {
    final local = value.toLocal();
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
