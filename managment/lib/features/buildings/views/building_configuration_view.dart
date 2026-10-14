import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/building_session.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/pack_locked_action.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../orders/widgets/order_item_workflow.dart';
import '../../orders/widgets/order_status_labels.dart';
import '../view_models/buildings_view_model.dart';

/// Owner-only switches for one venue. Profile fields stay on the building form.
class BuildingConfigurationView extends ConsumerStatefulWidget {
  const BuildingConfigurationView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<BuildingConfigurationView> createState() =>
      _BuildingConfigurationViewState();
}

class _BuildingConfigurationViewState
    extends ConsumerState<BuildingConfigurationView> {
  final _formKey = GlobalKey<FormState>();
  final _reservationFee = TextEditingController(text: '0');
  var _filled = false;
  var _saving = false;
  var _saved = false;
  String? _errorKey;
  var _tableMultiOrder = false;
  var _allowAppendingItemsToOrder = true;
  var _strictMode = false;
  List<StrictModeStep> _strictModeSteps = defaultStrictModeSteps();
  List<StrictModeStep>? _stepsWhileStrict;
  var _customerOrderingEnabled = true;
  var _reservationsEnabled = true;
  var _allowOutOfStockOrders = false;
  var _cashRegisterEnabled = false;

  @override
  void dispose() {
    _reservationFee.dispose();
    super.dispose();
  }

  void _fill(BuildingView building) {
    if (_filled) {
      return;
    }
    _tableMultiOrder = building.tableMultiOrder;
    _allowAppendingItemsToOrder = building.allowAppendingItemsToOrder;
    _strictMode = building.strictMode;
    final stored = normalizeStrictModeSteps(building.strictModeSteps);
    if (_strictMode) {
      _strictModeSteps = stored;
      _stepsWhileStrict = null;
    } else {
      final hasKitchen = stored.any(
        (step) => step.status != OrderItemStatus.payed && step.enabled,
      );
      _stepsWhileStrict = hasKitchen ? stored : null;
      _strictModeSteps = effectiveStrictModeSteps(
        strictMode: false,
        steps: stored,
      );
    }
    _customerOrderingEnabled = building.customerOrderingEnabled;
    _reservationsEnabled = building.reservationsEnabled;
    _allowOutOfStockOrders = building.allowOutOfStockOrders;
    _cashRegisterEnabled = building.cashRegisterEnabled;
    _reservationFee.text = _money(building.reservationFee);
    _filled = true;
  }

  String _money(double value) {
    if (value == value.roundToDouble()) {
      return value.round().toString();
    }
    return value.toString();
  }

  double? _parsedFee() {
    return double.tryParse(_reservationFee.text.trim().replaceAll(',', '.'));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final async = ref.watch(buildingFormViewModelProvider(widget.buildingId));
    async.whenData((building) {
      if (building != null) {
        _fill(building);
      }
    });
    if (!_filled) {
      return async.when(
        loading: () => const AppScreenLoader(),
        error: (error, _) => Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoadFailureNotice(error: error),
              AppErrorBanner(
                message: lookupError(l10n, mapError(error).l10nKey),
              ),
            ],
          ),
        ),
        data: (_) => const AppScreenLoader(),
      );
    }

    final pack = async.asData?.value?.pack;
    final text = Theme.of(context).textTheme;

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
                Text(l10n.configurationTitle, style: text.headlineSmall),
                const SizedBox(height: AppSpacing.sm),
                Text(l10n.configurationHint, style: text.bodyMedium),
                const SizedBox(height: AppSpacing.lg),
                PackLockedSwitch(
                  locked:
                      pack != null &&
                      !pack.customerOrdering &&
                      !_customerOrderingEnabled,
                  title: l10n.buildingCustomerOrdering,
                  subtitle: l10n.buildingCustomerOrderingHint,
                  value: _customerOrderingEnabled,
                  onChanged: (value) =>
                      setState(() => _customerOrderingEnabled = value),
                ),
                PackLockedSwitch(
                  locked:
                      pack != null &&
                      !pack.cashRegister &&
                      !_cashRegisterEnabled,
                  title: l10n.buildingCashRegister,
                  subtitle: l10n.buildingCashRegisterHint,
                  value: _cashRegisterEnabled,
                  onChanged: (value) =>
                      setState(() => _cashRegisterEnabled = value),
                ),
                PackLockedSwitch(
                  locked:
                      pack != null &&
                      !pack.reservations &&
                      !_reservationsEnabled,
                  title: l10n.buildingReservations,
                  subtitle: l10n.buildingReservationsHint,
                  value: _reservationsEnabled,
                  onChanged: (value) =>
                      setState(() => _reservationsEnabled = value),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.buildingAllowOutOfStockOrders),
                  subtitle: Text(l10n.buildingAllowOutOfStockOrdersHint),
                  value: _allowOutOfStockOrders,
                  onChanged: (value) =>
                      setState(() => _allowOutOfStockOrders = value),
                ),
                PackLockedSwitch(
                  locked:
                      pack != null &&
                      !pack.tableMultiOrder &&
                      !_tableMultiOrder,
                  title: l10n.buildingTableMultiOrder,
                  subtitle: l10n.buildingTableMultiOrderHint,
                  value: _tableMultiOrder,
                  onChanged: (value) =>
                      setState(() => _tableMultiOrder = value),
                ),
                PackLockedSwitch(
                  locked:
                      pack != null &&
                      !pack.allowAppendingItems &&
                      !_allowAppendingItemsToOrder,
                  title: l10n.buildingAllowAppendingItems,
                  subtitle: l10n.buildingAllowAppendingItemsHint,
                  value: _allowAppendingItemsToOrder,
                  onChanged: (value) =>
                      setState(() => _allowAppendingItemsToOrder = value),
                ),
                PackLockedSwitch(
                  locked: pack != null && !pack.strictMode && !_strictMode,
                  title: l10n.buildingStrictMode,
                  subtitle: l10n.buildingStrictModeHint,
                  value: _strictMode,
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        _strictMode = true;
                        _strictModeSteps =
                            _stepsWhileStrict ?? defaultStrictModeSteps();
                        _stepsWhileStrict = null;
                      } else {
                        if (_strictMode) {
                          _stepsWhileStrict = _strictModeSteps;
                        }
                        _strictMode = false;
                        _strictModeSteps = effectiveStrictModeSteps(
                          strictMode: false,
                          steps: _strictModeSteps,
                        );
                      }
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(l10n.buildingStrictModeStepsTitle, style: text.titleSmall),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.buildingStrictModeStepsHint, style: text.bodySmall),
                const SizedBox(height: AppSpacing.sm),
                for (final step in _strictModeSteps)
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(orderItemStatusLabel(l10n, step.status)),
                    subtitle: Text(l10n.buildingStrictModeStepRank(step.rank)),
                    value: step.enabled,
                    onChanged: _strictMode
                        ? (enabled) {
                            setState(() {
                              _strictModeSteps = [
                                for (final current in _strictModeSteps)
                                  if (current.status == step.status)
                                    StrictModeStep(
                                      rank: current.rank,
                                      status: current.status,
                                      enabled: enabled,
                                    )
                                  else
                                    current,
                              ];
                            });
                          }
                        : null,
                  ),
                AppTextField(
                  controller: _reservationFee,
                  label: l10n.reservationFee,
                  helperText: l10n.reservationFeeHint,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    final parsed = double.tryParse(
                      (value ?? '').trim().replaceAll(',', '.'),
                    );
                    if (parsed == null || parsed < 0 || parsed > 1000000) {
                      return l10n.reservationPaidInvalid;
                    }
                    return null;
                  },
                ),
                if (_saved) ...[
                  const SizedBox(height: AppSpacing.md),
                  AppSuccessBanner(message: l10n.configurationSaved),
                ],
                if (_errorKey != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  AppErrorBanner(message: lookupError(l10n, _errorKey!)),
                ],
                const SizedBox(height: AppSpacing.lg),
                AppFilledButton(
                  label: l10n.saveConfiguration,
                  busy: _saving,
                  onPressed: () async {
                    if (!(_formKey.currentState?.validate() ?? false)) {
                      return;
                    }
                    final fee = _parsedFee();
                    if (fee == null) {
                      return;
                    }
                    setState(() {
                      _saving = true;
                      _saved = false;
                      _errorKey = null;
                    });
                    try {
                      final saved = await ref
                          .read(
                            buildingFormViewModelProvider(
                              widget.buildingId,
                            ).notifier,
                          )
                          .saveConfiguration(
                            tableMultiOrder: _tableMultiOrder,
                            allowAppendingItemsToOrder:
                                _allowAppendingItemsToOrder,
                            strictMode: _strictMode,
                            strictModeSteps: _strictModeSteps,
                            reservationFee: fee,
                            customerOrderingEnabled: _customerOrderingEnabled,
                            reservationsEnabled: _reservationsEnabled,
                            allowOutOfStockOrders: _allowOutOfStockOrders,
                            cashRegisterEnabled: _cashRegisterEnabled,
                          );
                      if (!context.mounted) {
                        return;
                      }
                      getIt<BuildingSession>().upsert(saved);
                      setState(() {
                        _saving = false;
                        _saved = true;
                      });
                      showSavedSnackBar(context);
                    } catch (error) {
                      if (!mounted) {
                        return;
                      }
                      setState(() {
                        _saving = false;
                        _errorKey = captureError(context, error);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
