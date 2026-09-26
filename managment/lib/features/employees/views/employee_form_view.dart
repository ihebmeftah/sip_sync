import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_phone_field.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../employee_access/view_models/access_profiles_view_model.dart';
import '../view_models/employee_form_view_model.dart';

class EmployeeFormView extends ConsumerStatefulWidget {
  const EmployeeFormView({
    super.key,
    required this.buildingId,
    this.employeeId,
  });

  final String buildingId;
  final String? employeeId;

  @override
  ConsumerState<EmployeeFormView> createState() => _EmployeeFormViewState();
}

class _EmployeeFormViewState extends ConsumerState<EmployeeFormView> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _username = TextEditingController();
  var _phone = '';
  var _filled = false;
  UuidValue? _accessId;

  bool get _isEdit => (widget.employeeId ?? '').isNotEmpty;

  String get _employeeKey => widget.employeeId ?? '';

  @override
  void dispose() {
    _password.dispose();
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
    _phone = existing.phoneNumber;
    _first.text = existing.firstName;
    _last.text = existing.lastName;
    _accessId = existing.accessId;
    _filled = true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ui = ref.watch(employeeFormViewModelProvider(_employeeKey));
    final profilesAsync = ref.watch(
      accessProfilesViewModelProvider(widget.buildingId),
    );
    _fill(ui);
    final text = Theme.of(context).textTheme;

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox.expand(
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
                          Text(
                            l10n.employeeUsernameHint,
                            style: text.bodySmall,
                          ),
                        if (!_isEdit) const SizedBox(height: AppSpacing.lg),
                        AppPhoneField(
                          label: l10n.phone,
                          value: _phone,
                          onChanged: (value) => setState(() => _phone = value),
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
                        profilesAsync.when(
                          loading: () => const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: LinearProgressIndicator(),
                          ),
                          error: (error, _) => AppErrorBanner(
                            message: lookupError(l10n, mapError(error).l10nKey),
                          ),
                          data: (profiles) {
                            if (profiles.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.md,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    AppErrorBanner(
                                      message: l10n.employeeNeedsAccessProfile,
                                    ),
                                    TextButton(
                                      onPressed: () => AccessProfilesRoute(
                                        buildingId: widget.buildingId,
                                      ).go(context),
                                      child: Text(l10n.navAccessProfiles),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return DropdownButtonFormField<UuidValue>(
                              // ignore: deprecated_member_use
                              value: profiles.any((p) => p.id == _accessId)
                                  ? _accessId
                                  : null,
                              decoration: InputDecoration(
                                labelText: l10n.accessProfile,
                                prefixIcon: const Icon(Icons.lock_outline),
                              ),
                              items: [
                                for (final profile in profiles)
                                  DropdownMenuItem(
                                    value: profile.id,
                                    child: Text(profile.name),
                                  ),
                              ],
                              onChanged: (value) =>
                                  setState(() => _accessId = value),
                              validator: (value) => value == null
                                  ? l10n.validationAccessRequired
                                  : null,
                            );
                          },
                        ),
                        SizedBox(height: AppSpacing.lg),
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
                            final accessId = _accessId;
                            if (accessId == null) {
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
                                  phoneNumber: _phone,
                                  firstName: _first.text,
                                  lastName: _last.text,
                                  buildingId: UuidValue.fromString(
                                    widget.buildingId,
                                  ),
                                  accessId: accessId,
                                );
                            if (!context.mounted || saved == null) {
                              return;
                            }
                            EmployeeDetailsRoute(
                              buildingId: widget.buildingId,
                              employeeId: saved.id.uuid,
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
      ),
    );
  }
}
