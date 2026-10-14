import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/building_session.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/app_phone_field.dart';
import '../../../core/phone/phone_numbers.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../orders/widgets/order_item_workflow.dart';
import '../venue_location.dart';
import '../view_models/buildings_view_model.dart';

const _predefinedTypes = ['restaurant', 'lounge', 'bar', 'cafe'];

class BuildingFormView extends ConsumerStatefulWidget {
  const BuildingFormView({super.key, this.buildingId});

  final String? buildingId;

  @override
  ConsumerState<BuildingFormView> createState() => _BuildingFormViewState();
}

class _BuildingFormViewState extends ConsumerState<BuildingFormView> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _customType = TextEditingController();
  final _address = TextEditingController();
  final _latitude = TextEditingController();
  final _longitude = TextEditingController();
  final _opensText = TextEditingController();
  final _closesText = TextEditingController();
  final _instagram = TextEditingController();
  final _facebook = TextEditingController();
  final _otherLinks = TextEditingController();
  TimeOfDay _opens = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _closes = const TimeOfDay(hour: 23, minute: 0);
  String _type = 'cafe';
  String _currency = 'TND';
  String _phoneNumber = '';
  String _whatsapp = '';
  var _otherType = false;
  var _filled = false;
  var _saving = false;
  var _locating = false;
  var _tableMultiOrder = false;
  var _allowAppendingItemsToOrder = true;
  var _strictMode = false;
  List<StrictModeStep> _strictModeSteps = defaultStrictModeSteps();
  var _reservationFee = 0.0;
  var _customerOrderingEnabled = true;
  var _reservationsEnabled = true;
  var _allowOutOfStockOrders = false;
  var _cashRegisterEnabled = false;
  String? _locationErrorKey;
  final _locationPicker = VenueLocationPicker();

  String get _id => widget.buildingId ?? '';

  bool get _isEdit => _id.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _syncTimeFields();
  }

  @override
  void dispose() {
    _name.dispose();
    _customType.dispose();
    _address.dispose();
    _latitude.dispose();
    _longitude.dispose();
    _opensText.dispose();
    _closesText.dispose();
    _instagram.dispose();
    _facebook.dispose();
    _otherLinks.dispose();
    super.dispose();
  }

  void _fill(BuildingView building) {
    if (_filled) {
      return;
    }
    _name.text = building.name;
    _address.text = building.address;
    _latitude.text = building.latitude.toString();
    _longitude.text = building.longitude.toString();
    _currency = Currencies.isValidCode(building.currencyCode)
        ? building.currencyCode.toUpperCase()
        : 'TND';
    _phoneNumber = building.phoneNumber;
    _whatsapp = building.whatsapp ?? '';
    _instagram.text = building.instagram ?? '';
    _facebook.text = building.facebook ?? '';
    _otherLinks.text = building.otherLinks.join('\n');
    _opens = TimeOfDay(
      hour: building.openingMinutes ~/ 60,
      minute: building.openingMinutes % 60,
    );
    _closes = TimeOfDay(
      hour: building.closingMinutes ~/ 60,
      minute: building.closingMinutes % 60,
    );
    _tableMultiOrder = building.tableMultiOrder;
    _allowAppendingItemsToOrder = building.allowAppendingItemsToOrder;
    _reservationFee = building.reservationFee;
    _strictMode = building.strictMode;
    _strictModeSteps = normalizeStrictModeSteps(building.strictModeSteps);
    _customerOrderingEnabled = building.customerOrderingEnabled;
    _reservationsEnabled = building.reservationsEnabled;
    _allowOutOfStockOrders = building.allowOutOfStockOrders;
    _cashRegisterEnabled = building.cashRegisterEnabled;
    _syncTimeFields();
    if (_predefinedTypes.contains(building.type)) {
      _type = building.type;
      _otherType = false;
    } else {
      _type = building.type;
      _otherType = true;
      _customType.text = building.type;
    }
    _filled = true;
  }

  List<String> _parsedOtherLinks() {
    return [
      for (final line in _otherLinks.text.split(RegExp(r'[\n,]')))
        if (line.trim().isNotEmpty) line.trim(),
    ];
  }

  String _resolvedType() => _otherType ? _customType.text : _type;

  void _syncTimeFields() {
    _opensText.text = formatMinutes(minutesFromTimeOfDay(_opens));
    _closesText.text = formatMinutes(minutesFromTimeOfDay(_closes));
  }

  Future<void> _pickTime({required bool opening}) async {
    final initial = opening ? _opens : _closes;
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked == null) {
      return;
    }
    setState(() {
      if (opening) {
        _opens = picked;
      } else {
        _closes = picked;
      }
      _syncTimeFields();
    });
  }

  Future<void> _pickCurrentPosition() async {
    setState(() {
      _locating = true;
      _locationErrorKey = null;
    });
    try {
      final location = await _locationPicker.pickCurrent();
      if (!mounted) {
        return;
      }
      setState(() {
        _latitude.text = location.latitude.toString();
        _longitude.text = location.longitude.toString();
        if (location.address != null && location.address!.isNotEmpty) {
          _address.text = location.address!;
        }
        _locating = false;
      });
    } on VenueLocationException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _locationErrorKey = error.l10nKey;
        _locating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final async = ref.watch(buildingFormViewModelProvider(_id));
    async.whenData((building) {
      if (building != null) {
        _fill(building);
      }
    });

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [
                Text(
                  _isEdit ? l10n.editBuilding : l10n.addBuilding,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.lg),
                if (async.isLoading) const AppScreenLoader(),
                AppSurfaceCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppTextField(
                        controller: _name,
                        label: l10n.buildingName,
                        prefixIcon: Icons.storefront_outlined,
                        validator: (value) =>
                            FormValidators.venueName(l10n, value),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              l10n.buildingType,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Wrap(
                              spacing: AppSpacing.sm,
                              runSpacing: AppSpacing.sm,
                              children: [
                                for (final type in _predefinedTypes)
                                  ChoiceChip(
                                    label: Text(_typeLabel(l10n, type)),
                                    selected: !_otherType && _type == type,
                                    onSelected: (_) => setState(() {
                                      _otherType = false;
                                      _type = type;
                                    }),
                                  ),
                                ChoiceChip(
                                  label: Text(l10n.buildingTypeOther),
                                  selected: _otherType,
                                  onSelected: (_) =>
                                      setState(() => _otherType = true),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (_otherType)
                        AppTextField(
                          controller: _customType,
                          label: l10n.buildingTypeCustom,
                          validator: (value) =>
                              FormValidators.venueType(l10n, value),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                        child: Column(
                          children: [
                            AppTextField(
                              controller: _address,
                              label: l10n.buildingAddress,
                              prefixIcon: Icons.place_outlined,
                              compact: true,
                              validator: (value) =>
                                  FormValidators.address(l10n, value),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.lg,
                              ),
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: OutlinedButton.icon(
                                  onPressed: _locating
                                      ? null
                                      : _pickCurrentPosition,
                                  icon: _locating
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: AppBusyIndicator(),
                                        )
                                      : const Icon(Icons.my_location_outlined),
                                  label: Text(l10n.pickCurrentPosition),
                                ),
                              ),
                            ),
                            if (_locationErrorKey != null)
                              AppErrorBanner(
                                message: lookupError(l10n, _locationErrorKey!),
                              ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: AppTextField(
                                    controller: _longitude,
                                    label: l10n.longitude,
                                    compact: true,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                          decimal: true,
                                          signed: true,
                                        ),
                                    validator: (value) =>
                                        FormValidators.longitude(l10n, value),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: AppTextField(
                                    controller: _latitude,
                                    label: l10n.latitude,
                                    compact: true,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                          decimal: true,
                                          signed: true,
                                        ),
                                    validator: (value) =>
                                        FormValidators.latitude(l10n, value),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      AppTextField(
                        controller: _opensText,
                        label: l10n.openingTime,
                        readOnly: true,
                        prefixIcon: Icons.schedule_outlined,
                        suffixIcon: const Icon(Icons.keyboard_arrow_down),
                        onTap: () => _pickTime(opening: true),
                      ),
                      AppTextField(
                        controller: _closesText,
                        label: l10n.closingTime,
                        readOnly: true,
                        prefixIcon: Icons.schedule_outlined,
                        suffixIcon: const Icon(Icons.keyboard_arrow_down),
                        onTap: () => _pickTime(opening: false),
                      ),
                      AppDropdownField<String>(
                        label: l10n.currencyCode,
                        value: _currency,
                        prefixIcon: Icons.payments_outlined,
                        items: [
                          for (final currency in Currencies.list)
                            DropdownMenuItem(
                              value: currency.code,
                              child: Text(
                                '${currency.code} — ${currency.name}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _currency = value);
                          }
                        },
                      ),
                      AppPhoneField(
                        label: l10n.buildingPhone,
                        value: _phoneNumber,
                        onChanged: (value) =>
                            setState(() => _phoneNumber = value),
                      ),
                      AppPhoneField(
                        label: l10n.buildingWhatsapp,
                        value: _whatsapp,
                        optional: true,
                        prefixIcon: Icons.chat_outlined,
                        onChanged: (value) => setState(() => _whatsapp = value),
                      ),
                      AppTextField(
                        controller: _instagram,
                        label: l10n.buildingInstagram,
                        prefixIcon: Icons.camera_alt_outlined,
                        helperText: l10n.buildingSocialHint,
                        validator: (value) =>
                            FormValidators.optionalSocial(l10n, value),
                      ),
                      AppTextField(
                        controller: _facebook,
                        label: l10n.buildingFacebook,
                        prefixIcon: Icons.public_outlined,
                        helperText: l10n.buildingSocialHint,
                        validator: (value) =>
                            FormValidators.optionalSocial(l10n, value),
                      ),
                      AppTextField(
                        controller: _otherLinks,
                        label: l10n.buildingOtherLinks,
                        prefixIcon: Icons.link_outlined,
                        helperText: l10n.buildingOtherLinksHint,
                        validator: (value) {
                          for (final link in _parsedOtherLinks()) {
                            final err = FormValidators.otherLinkUrl(l10n, link);
                            if (err != null) {
                              return err;
                            }
                          }
                          return null;
                        },
                      ),
                      if (async.hasError)
                        AppErrorBanner(
                          message: lookupError(
                            l10n,
                            mapError(async.error!).l10nKey,
                          ),
                        ),
                      AppFilledButton(
                        label: _isEdit ? l10n.saveBuilding : l10n.addBuilding,
                        busy: _saving,
                        onPressed: () async {
                          if (!(_formKey.currentState?.validate() ?? false)) {
                            return;
                          }
                          if (FormValidators.venueType(l10n, _resolvedType()) !=
                              null) {
                            return;
                          }
                          setState(() => _saving = true);
                          final saved = await ref
                              .read(buildingFormViewModelProvider(_id).notifier)
                              .save(
                                name: _name.text,
                                type: _resolvedType(),
                                address: _address.text,
                                latitude: double.parse(_latitude.text.trim()),
                                longitude: double.parse(_longitude.text.trim()),
                                openingMinutes: minutesFromTimeOfDay(_opens),
                                closingMinutes: minutesFromTimeOfDay(_closes),
                                currencyCode: _currency,
                                phoneNumber: _phoneNumber,
                                whatsapp: _whatsapp.isEmpty ? null : _whatsapp,
                                instagram: _instagram.text.trim().isEmpty
                                    ? null
                                    : _instagram.text.trim(),
                                facebook: _facebook.text.trim().isEmpty
                                    ? null
                                    : _facebook.text.trim(),
                                otherLinks: _parsedOtherLinks(),
                                tableMultiOrder: _tableMultiOrder,
                                allowAppendingItemsToOrder:
                                    _allowAppendingItemsToOrder,
                                strictMode: _strictMode,
                                strictModeSteps: _strictModeSteps,
                                reservationFee: _reservationFee,
                                customerOrderingEnabled:
                                    _customerOrderingEnabled,
                                reservationsEnabled: _reservationsEnabled,
                                allowOutOfStockOrders: _allowOutOfStockOrders,
                                cashRegisterEnabled: _cashRegisterEnabled,
                              );
                          if (!context.mounted) {
                            return;
                          }
                          setState(() => _saving = false);
                          if (saved == null) {
                            final error = ref
                                .read(buildingFormViewModelProvider(_id))
                                .error;
                            if (error != null) {
                              captureError(context, error);
                            }
                            return;
                          }
                          getIt<BuildingSession>().upsert(saved);
                          getIt<BuildingSession>().select(saved.id);
                          DashboardRoute(buildingId: saved.id.uuid).go(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _typeLabel(AppLocalizations l10n, String type) {
    return switch (type) {
      'restaurant' => l10n.buildingTypeRestaurant,
      'lounge' => l10n.buildingTypeLounge,
      'bar' => l10n.buildingTypeBar,
      'cafe' => l10n.buildingTypeCafe,
      _ => type,
    };
  }
}
