import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_phone_field.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/reservations_view_model.dart';

/// Staff booking. It is confirmed on save and still needs a table.
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
  final _search = TextEditingController();
  final _customerFocus = FocusNode();
  final _customerLink = LayerLink();
  final _customerMenu = OverlayPortalController();
  DateTime _date = DateTime.now();
  TimeOfDay _start = TimeOfDay.now();
  var _guest = true;
  var _phone = '';
  var _saving = false;
  var _lookingUp = false;
  var _searched = false;
  var _applyingCustomer = false;
  String? _errorKey;
  ReservationCustomerMatch? _customer;
  List<ReservationCustomerMatch> _matches = [];
  Timer? _searchTimer;
  var _seededFee = false;
  var _customerFieldWidth = 360.0;

  @override
  void initState() {
    super.initState();
    final start = DateTime.now().add(const Duration(hours: 1));
    _date = DateTime(start.year, start.month, start.day);
    _start = TimeOfDay(hour: start.hour, minute: 0);
    _customerFocus.addListener(_onCustomerFocus);
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    _customerFocus.removeListener(_onCustomerFocus);
    _customerFocus.dispose();
    _guestName.dispose();
    _paid.dispose();
    _search.dispose();
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
                const SizedBox(height: AppSpacing.sm),
                Text(l10n.reservationCreateHint),
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
                  onTap: _pickTime,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.reservationGuestInstead),
                  value: _guest,
                  onChanged: (value) {
                    _searchTimer?.cancel();
                    _customerMenu.hide();
                    setState(() {
                      _guest = value;
                      _errorKey = null;
                      _lookingUp = false;
                    });
                  },
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
                  _customerDropdown(l10n),
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

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _start);
    if (picked == null) {
      return;
    }
    setState(() => _start = picked);
  }

  Widget _customerDropdown(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: OverlayPortal(
        controller: _customerMenu,
        overlayChildBuilder: (context) => _customerMenuPanel(l10n),
        child: CompositedTransformTarget(
          link: _customerLink,
          child: LayoutBuilder(
            builder: (context, constraints) {
              _customerFieldWidth = constraints.maxWidth;
              return TextFormField(
                controller: _search,
                focusNode: _customerFocus,
                textInputAction: TextInputAction.search,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  labelText: l10n.reservationSearchHint,
                  helperText: _customer?.phoneNumber,
                  suffixIcon: _customer == null
                      ? const Icon(Icons.arrow_drop_down)
                      : IconButton(
                          onPressed: _clearCustomer,
                          icon: const Icon(Icons.close),
                        ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _customerMenuPanel(AppLocalizations l10n) {
    return CompositedTransformFollower(
      link: _customerLink,
      targetAnchor: Alignment.bottomLeft,
      followerAnchor: Alignment.topLeft,
      showWhenUnlinked: false,
      offset: const Offset(0, 4),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: SizedBox(
          width: _customerFieldWidth,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 280),
              child: _lookingUp
                  ? const SizedBox(
                      height: 72,
                      child: Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    )
                  : _matches.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Text(l10n.reservationSearchEmpty),
                    )
                  : ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        for (final match in _matches)
                          GestureDetector(
                            onTapDown: (_) => _selectCustomer(match),
                            child: ListTile(
                              title: Text(
                                '${match.firstName} ${match.lastName}',
                              ),
                              subtitle: Text(match.phoneNumber),
                            ),
                          ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void _onCustomerFocus() {
    if (_customerFocus.hasFocus) {
      _showCustomerMenu();
      return;
    }
    Future<void>.delayed(const Duration(milliseconds: 200), () {
      if (mounted && !_customerFocus.hasFocus) {
        _customerMenu.hide();
      }
    });
  }

  void _showCustomerMenu() {
    if (_guest || !_customerFocus.hasFocus) {
      return;
    }
    if (_lookingUp || _searched) {
      _customerMenu.show();
    }
  }

  void _clearCustomer() {
    _searchTimer?.cancel();
    _search.clear();
    setState(() {
      _customer = null;
      _matches = [];
      _searched = false;
      _lookingUp = false;
    });
    _customerMenu.hide();
    _customerFocus.requestFocus();
  }

  void _selectCustomer(ReservationCustomerMatch match) {
    _applyingCustomer = true;
    _search.text = '${match.firstName} ${match.lastName}';
    _search.selection = TextSelection.collapsed(offset: _search.text.length);
    _applyingCustomer = false;
    _searchTimer?.cancel();
    setState(() {
      _customer = match;
      _matches = [];
      _searched = false;
      _lookingUp = false;
      _errorKey = null;
    });
    _customerMenu.hide();
    _customerFocus.unfocus();
  }

  void _onSearchChanged(String value) {
    if (_applyingCustomer) {
      return;
    }
    _searchTimer?.cancel();
    setState(() {
      _customer = null;
      _matches = [];
      _searched = false;
      _lookingUp = false;
      _errorKey = null;
    });
    _customerMenu.hide();
    final query = value.trim();
    if (query.length < 2) {
      return;
    }
    _searchTimer = Timer(
      const Duration(seconds: 1),
      () => _searchCustomers(query),
    );
  }

  Future<void> _searchCustomers(String query) async {
    setState(() {
      _lookingUp = true;
      _searched = false;
      _errorKey = null;
    });
    _showCustomerMenu();
    try {
      final rows = await ref
          .read(reservationRepositoryProvider)
          .searchCustomers(UuidValue.fromString(widget.buildingId), query);
      if (!mounted || _search.text.trim() != query) {
        return;
      }
      setState(() {
        _matches = rows;
        _searched = true;
        _lookingUp = false;
      });
      _showCustomerMenu();
    } catch (error) {
      if (mounted && _search.text.trim() == query) {
        setState(() {
          _errorKey = captureError(context, error);
          _lookingUp = false;
        });
        _customerMenu.hide();
      }
    }
  }

  DateTime _combine(TimeOfDay time) {
    return DateTime(_date.year, _date.month, _date.day, time.hour, time.minute);
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final start = _combine(_start);
    if (!start.add(const Duration(hours: 2)).isAfter(DateTime.now())) {
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
              startsAt: start.toUtc(),
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
