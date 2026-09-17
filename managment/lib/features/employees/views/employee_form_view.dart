import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/employee_form_view_model.dart';

class EmployeeFormView extends ConsumerStatefulWidget {
  const EmployeeFormView({
    super.key,
    required this.buildingId,
    this.authUserId,
  });

  final String buildingId;
  final String? authUserId;

  @override
  ConsumerState<EmployeeFormView> createState() => _EmployeeFormViewState();
}

class _EmployeeFormViewState extends ConsumerState<EmployeeFormView> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _phone = TextEditingController();
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _username = TextEditingController();
  var _filled = false;

  bool get _isEdit => (widget.authUserId ?? '').isNotEmpty;

  String get _employeeKey => widget.authUserId ?? '';

  @override
  void dispose() {
    _password.dispose();
    _phone.dispose();
    _first.dispose();
    _last.dispose();
    _username.dispose();
    super.dispose();
  }

  void _fill(EmployeeFormState ui) {
    final existing = ui.existing;
    if (existing == null || _filled) {
      return;
    }
    _username.text = existing.username;
    _phone.text = existing.phoneNumber;
    _first.text = existing.firstName;
    _last.text = existing.lastName;
    _filled = true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ui = ref.watch(employeeFormViewModelProvider(_employeeKey));
    _fill(ui);
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
                _isEdit ? l10n.editEmployee : l10n.addEmployee,
                style: text.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              if (ui.loading) const LinearProgressIndicator(),
              AppSurfaceCard(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppTextField(
                        controller: _first,
                        label: l10n.firstName,
                        prefixIcon: Icons.person_outline,
                        validator: (value) =>
                            FormValidators.requiredName(l10n, value),
                      ),
                      AppTextField(
                        controller: _last,
                        label: l10n.lastName,
                        prefixIcon: Icons.badge_outlined,
                        validator: (value) =>
                            FormValidators.requiredName(l10n, value),
                      ),
                      if (_isEdit)
                        AppTextField(
                          controller: _username,
                          label: l10n.username,
                          readOnly: true,
                          helperText: l10n.usernameLocked,
                          prefixIcon: Icons.alternate_email,
                        )
                      else
                        Text(l10n.employeeUsernameHint, style: text.bodySmall),
                      if (!_isEdit) const SizedBox(height: AppSpacing.lg),
                      AppTextField(
                        controller: _phone,
                        label: l10n.phone,
                        prefixIcon: Icons.phone_outlined,
                        validator: (value) => FormValidators.phone(l10n, value),
                      ),
                      if (!_isEdit)
                        AppTextField(
                          controller: _password,
                          label: l10n.password,
                          obscure: true,
                          prefixIcon: Icons.lock_outline,
                          validator: (value) =>
                              FormValidators.password(l10n, value),
                        ),
                      if (ui.errorKey != null)
                        AppErrorBanner(
                          message: lookupError(l10n, ui.errorKey!),
                        ),
                      AppFilledButton(
                        label: _isEdit ? l10n.saveEmployee : l10n.addEmployee,
                        busy: ui.saving,
                        onPressed: () async {
                          if (!(_formKey.currentState?.validate() ?? false)) {
                            return;
                          }
                          final saved = await ref
                              .read(
                                employeeFormViewModelProvider(
                                  _employeeKey,
                                ).notifier,
                              )
                              .save(
                                password: _password.text,
                                phoneNumber: _phone.text,
                                firstName: _first.text,
                                lastName: _last.text,
                                buildingId: UuidValue.fromString(
                                  widget.buildingId,
                                ),
                              );
                          if (!context.mounted || saved == null) {
                            return;
                          }
                          EmployeeDetailsRoute(
                            buildingId: widget.buildingId,
                            authUserId: saved.authUserId.uuid,
                          ).go(context);
                        },
                      ),
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
