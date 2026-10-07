import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/phone/phone_numbers.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/app_phone_field.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../tables/view_models/tables_view_model.dart';
import '../view_models/reservations_view_model.dart';

/// Staff booking: tables, a window, a guest or a customer, and the amount paid.
class ReservationCreateView extends ConsumerStatefulWidget {
  const ReservationCreateView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<ReservationCreateView> createState() =>
      _ReservationCreateViewState();
}

class _ReservationCreateViewState extends ConsumerState<ReservationCreateView> {
  final _formKey = GlobalKey<FormState>();
  final _guestName = TextEditingController();
  final _paid = TextEditingController();
  final _selected = <UuidValue>{};
  DateTime _date = DateTime.now();
  TimeOfDay _start = TimeOfDay.now();
  TimeOfDay _end = TimeOfDay.now();
  var _guest = true;
  var _phone = '';
  var _saving = false;
  var _lookingUp = false;
  String? _errorKey;
  ReservationCustomerMatch? _customer;
  var _seededFee = false;

  @override
  void initState() {
    super.initState();
    final start = DateTime.now().add(const Duration(hours: 1));
    _date = DateTime(start.year, start.month, start.day);
    _start = TimeOfDay(hour: start.hour, minute: 0);
    final end = start.add(const Duration(hours: 1));
    _end = TimeOfDay(hour: end.hour, minute: 0);
  }

  @override
  void dispose() {
    _guestName.dispose();
    _paid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final building = ref.watch(buildingSelectionProvider);
    if (!_seededFee && building != null) {
      _seededFee = true;
      _paid.text = _money(building.reservationFee);
    }
    final tables = ref.watch(tablesViewModelProvider(widget.buildingId));

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.formMax),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [
                Text(
                  l10n.reservationNew,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.lg),
                tables.when(
                  loading: () => const AppScreenLoader(compact: true),
                  error: (error, _) => AppErrorBanner(
                    message: lookupError(l10n, mapError(error).l10nKey),
                  ),
                  data: (rows) => Wrap(
                    spacing: AppSpacing.sm,
                    children: [
                      for (final table in rows.where((row) => row.isActive))
                        FilterChip(
                          label: Text('${table.number}'),
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
                ),
                const SizedBox(height: AppSpacing.md),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.reservationDate),
                  subtitle: Text(
                    MaterialLocalizations.of(context).formatMediumDate(_date),
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
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.reservationGuestInstead),
                  value: _guest,
                  onChanged: (value) => setState(() {
                    _guest = value;
                    _errorKey = null;
                  }),
                ),
                if (_guest) ...[
                  AppTextField(
                    controller: _guestName,
                    label: l10n.reservationGuestName,
                    validator: (value) =>
                        FormValidators.requiredName(l10n, value),
                  ),
                  AppPhoneField(
                    value: _phone,
                    label: l10n.reservationGuestPhone,
                    optional: true,
                    onChanged: (value) => setState(() => _phone = value),
                  ),
                ] else ...[
                  AppPhoneField(
                    value: _phone,
                    label: l10n.reservationGuestPhone,
                    onChanged: (value) => setState(() => _phone = value),
                  ),
                  AppFilledButton(
                    label: l10n.reservationFindCustomer,
                    busy: _lookingUp,
                    onPressed: _lookingUp ? null : _findCustomer,
                  ),
                  if (_customer != null)
                    Text('${_customer!.firstName} ${_customer!.lastName}'),
                ],
                AppTextField(
                  controller: _paid,
                  label: l10n.reservationPaidAmount,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) => _paidError(l10n, value),
                ),
                if (_errorKey != null)
                  AppErrorBanner(message: lookupError(l10n, _errorKey!)),
                const SizedBox(height: AppSpacing.md),
                AppFilledButton(
                  label: l10n.reservationNew,
                  busy: _saving,
                  onPressed: _saving ? null : _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _paidError(AppLocalizations l10n, String? value) {
    final parsed = double.tryParse((value ?? '').trim().replaceAll(',', '.'));
    if (parsed == null || parsed < 0 || parsed > 1000000) {
      return l10n.reservationPaidInvalid;
    }
    return null;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
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

  DateTime _combine(TimeOfDay time) {
    return DateTime(_date.year, _date.month, _date.day, time.hour, time.minute);
  }

  Future<void> _findCustomer() async {
    if (!PhoneNumbers.isValid(_phone)) {
      setState(() => _errorKey = 'errorInvalidInput');
      return;
    }
    setState(() {
      _lookingUp = true;
      _errorKey = null;
    });
    try {
      final match = await ref
          .read(reservationRepositoryProvider)
          .findCustomer(UuidValue.fromString(widget.buildingId), _phone);
      if (!mounted) {
        return;
      }
      setState(() => _customer = match);
    } catch (error) {
      if (mounted) {
        setState(() => _errorKey = captureError(context, error));
      }
    } finally {
      if (mounted) {
        setState(() => _lookingUp = false);
      }
    }
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    if (_selected.isEmpty) {
      setState(() => _errorKey = 'reservationSelectTables');
      return;
    }
    final start = _combine(_start);
    final end = _combine(_end);
    final length = end.difference(start);
    if (!end.isAfter(start) ||
        length < const Duration(minutes: 30) ||
        length > const Duration(hours: 8) ||
        !end.isAfter(DateTime.now())) {
      setState(() => _errorKey = 'reservationWindow');
      return;
    }
    if (!_guest && _customer == null) {
      setState(() => _errorKey = 'errorReservationNotFound');
      return;
    }
    if (_guest &&
        _phone.trim().isNotEmpty &&
        FormValidators.optionalPhone(l10n, _phone) != null) {
      setState(() => _errorKey = 'errorInvalidInput');
      return;
    }
    setState(() {
      _saving = true;
      _errorKey = null;
    });
    try {
      await ref
          .read(reservationRepositoryProvider)
          .create(
            ReservationCreate(
              buildingId: UuidValue.fromString(widget.buildingId),
              tableIds: _selected.toList(),
              startsAt: start.toUtc(),
              endsAt: end.toUtc(),
              customerId: _guest ? null : _customer!.id,
              guestName: _guest ? _guestName.text.trim() : null,
              guestPhone: _guest && _phone.trim().isNotEmpty ? _phone : null,
              paidAmount: double.parse(_paid.text.trim().replaceAll(',', '.')),
            ),
          );
      await ref
          .read(reservationsViewModelProvider(widget.buildingId).notifier)
          .refresh();
      if (!mounted) {
        return;
      }
      ReservationsRoute(buildingId: widget.buildingId).go(context);
    } catch (error) {
      if (mounted) {
        setState(() => _errorKey = captureError(context, error));
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  String _money(double value) {
    if (value == value.roundToDouble()) {
      return value.round().toString();
    }
    return value.toString();
  }
}
