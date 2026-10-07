import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/access_profiles_view_model.dart';

/// Owner form to create or edit an access profile.
class AccessProfileFormView extends ConsumerStatefulWidget {
  const AccessProfileFormView({
    super.key,
    required this.buildingId,
    this.existing,
  });

  final String buildingId;
  final EmployeeAccessView? existing;

  @override
  ConsumerState<AccessProfileFormView> createState() =>
      _AccessProfileFormViewState();
}

class _AccessProfileFormViewState extends ConsumerState<AccessProfileFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late bool _orderCreation;
  late bool _orderPayment;
  late bool _cancelOrder;
  late bool _preparation;
  late bool _serving;
  late bool _consultAllOrders;
  late bool _reservations;
  var _saving = false;
  var _deleting = false;
  String? _errorKey;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _name = TextEditingController(text: existing?.name ?? '');
    _orderCreation = existing?.orderCreation ?? false;
    _orderPayment = existing?.orderPayment ?? false;
    _cancelOrder = existing?.cancelOrder ?? false;
    _preparation = existing?.preparation ?? false;
    _serving = existing?.serving ?? false;
    _consultAllOrders = existing?.consultAllOrders ?? false;
    _reservations = existing?.reservations ?? false;
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    setState(() {
      _saving = true;
      _errorKey = null;
    });
    try {
      final vm = ref.read(
        accessProfilesViewModelProvider(widget.buildingId).notifier,
      );
      if (_isEdit) {
        await vm.updateProfile(
          id: widget.existing!.id,
          name: _name.text,
          orderCreation: _orderCreation,
          orderPayment: _orderPayment,
          cancelOrder: _cancelOrder,
          preparation: _preparation,
          serving: _serving,
          consultAllOrders: _consultAllOrders,
          reservations: _reservations,
        );
      } else {
        await vm.createProfile(
          name: _name.text,
          orderCreation: _orderCreation,
          orderPayment: _orderPayment,
          cancelOrder: _cancelOrder,
          preparation: _preparation,
          serving: _serving,
          consultAllOrders: _consultAllOrders,
          reservations: _reservations,
        );
      }
      if (!mounted) return;
      AccessProfilesRoute(buildingId: widget.buildingId).go(context);
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

  Future<void> _delete() async {
    final existing = widget.existing;
    if (existing == null) return;
    final l10n = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteAccessProfile),
        content: Text(l10n.deleteAccessProfileConfirm(existing.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.close),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.deleteAccessProfile),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    setState(() {
      _deleting = true;
      _errorKey = null;
    });
    try {
      await ref
          .read(accessProfilesViewModelProvider(widget.buildingId).notifier)
          .deleteProfile(existing.id);
      if (!mounted) return;
      AccessProfilesRoute(buildingId: widget.buildingId).go(context);
    } catch (error) {
      if (mounted) {
        setState(() => _errorKey = captureError(context, error));
      }
    } finally {
      if (mounted) {
        setState(() => _deleting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.formMax),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              Text(
                _isEdit ? l10n.editAccessProfile : l10n.addAccessProfile,
                style: text.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              AppSurfaceCard(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppTextField(
                        controller: _name,
                        label: l10n.accessProfileName,
                        prefixIcon: Icons.badge_outlined,
                        validator: (value) {
                          final v = value?.trim() ?? '';
                          if (v.isEmpty || v.length > 80) {
                            return l10n.validationAccessName;
                          }
                          return null;
                        },
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.accessOrderCreation),
                        subtitle: Text(l10n.accessOrderCreationHint),
                        value: _orderCreation,
                        onChanged: (v) => setState(() => _orderCreation = v),
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.accessOrderPayment),
                        subtitle: Text(l10n.accessOrderPaymentHint),
                        value: _orderPayment,
                        onChanged: (v) => setState(() => _orderPayment = v),
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.accessCancelOrder),
                        subtitle: Text(l10n.accessCancelOrderHint),
                        value: _cancelOrder,
                        onChanged: (v) => setState(() => _cancelOrder = v),
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.accessPreparation),
                        subtitle: Text(l10n.accessPreparationHint),
                        value: _preparation,
                        onChanged: (v) => setState(() => _preparation = v),
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.accessServing),
                        subtitle: Text(l10n.accessServingHint),
                        value: _serving,
                        onChanged: (v) => setState(() => _serving = v),
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.accessConsultAllOrders),
                        subtitle: Text(l10n.accessConsultAllOrdersHint),
                        value: _consultAllOrders,
                        onChanged: (v) => setState(() => _consultAllOrders = v),
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.accessReservations),
                        subtitle: Text(l10n.accessReservationsHint),
                        value: _reservations,
                        onChanged: (v) => setState(() => _reservations = v),
                      ),
                      if (_errorKey != null)
                        AppErrorBanner(message: lookupError(l10n, _errorKey!)),
                      AppFilledButton(
                        label: _isEdit
                            ? l10n.saveAccessProfile
                            : l10n.addAccessProfile,
                        busy: _saving,
                        onPressed: _deleting ? null : () => _submit(),
                      ),
                      if (_isEdit) ...[
                        const SizedBox(height: AppSpacing.md),
                        OutlinedButton(
                          onPressed: _saving || _deleting ? null : _delete,
                          child: _deleting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: AppBusyIndicator(),
                                )
                              : Text(l10n.deleteAccessProfile),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
