import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/app_phone_field.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/profile_view_model.dart';

class ProfileViewPage extends ConsumerStatefulWidget {
  const ProfileViewPage({super.key});

  @override
  ConsumerState<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends ConsumerState<ProfileViewPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  var _phone = '';
  var _filled = false;

  @override
  void dispose() {
    _email.dispose();
    _username.dispose();
    _first.dispose();
    _last.dispose();
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _fillFromSession() {
    if (_filled) {
      return;
    }
    final store = ref.read(appSessionStoreProvider);
    if (store.isOwner && store.owner != null) {
      final o = store.owner!;
      _email.text = o.email;
      _phone = o.phoneNumber;
      _first.text = o.firstName;
      _last.text = o.lastName;
      _filled = true;
    } else if (store.isEmployee && store.employee != null) {
      final e = store.employee!;
      _username.text = e.username;
      _phone = e.phoneNumber;
      _first.text = e.firstName;
      _last.text = e.lastName;
      _filled = true;
    }
  }

  Future<void> _submitPassword() async {
    if (!(_passwordFormKey.currentState?.validate() ?? false)) {
      return;
    }
    final ok = await ref
        .read(profileViewModelProvider.notifier)
        .changePassword(
          currentPassword: _currentPassword.text,
          newPassword: _newPassword.text,
        );
    if (!mounted || !ok) {
      return;
    }
    _currentPassword.clear();
    _newPassword.clear();
    _confirmPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final store = ref.watch(appSessionStoreProvider);
    final ui = ref.watch(profileViewModelProvider);
    final text = Theme.of(context).textTheme;
    final isEmployee = store.isEmployee;
    _fillFromSession();

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.formMax),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              if (!store.isSignedIn ||
                  (store.isOwner && store.owner == null) ||
                  (store.isEmployee && store.employee == null))
                const AppScreenLoader(),
              AppSurfaceCard(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(l10n.myProfile, style: text.headlineSmall),
                      const SizedBox(height: AppSpacing.sm),
                      Text(l10n.profileHint, style: text.bodyMedium),
                      const SizedBox(height: AppSpacing.lg),
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
                      if (isEmployee)
                        AppTextField(
                          controller: _username,
                          label: l10n.username,
                          readOnly: true,
                          helperText: l10n.usernameLocked,
                          prefixIcon: Icons.alternate_email,
                        )
                      else
                        AppTextField(
                          controller: _email,
                          label: l10n.email,
                          readOnly: true,
                          helperText: l10n.emailLocked,
                          prefixIcon: Icons.mail_outline,
                        ),
                      AppPhoneField(
                        label: l10n.phone,
                        value: _phone,
                        onChanged: (value) => setState(() => _phone = value),
                      ),
                      if (ui.errorKey != null)
                        AppErrorBanner(
                          message: lookupError(l10n, ui.errorKey!),
                        ),
                      if (ui.saved)
                        AppSuccessBanner(message: l10n.profileSaved),
                      AppFilledButton(
                        label: l10n.saveProfile,
                        busy: ui.saving,
                        onPressed: () {
                          if (!(_formKey.currentState?.validate() ?? false)) {
                            return;
                          }
                          ref
                              .read(profileViewModelProvider.notifier)
                              .save(
                                phoneNumber: _phone,
                                firstName: _first.text,
                                lastName: _last.text,
                              );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppSurfaceCard(
                child: Form(
                  key: _passwordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(l10n.changePassword, style: text.titleLarge),
                      const SizedBox(height: AppSpacing.sm),
                      Text(l10n.changePasswordHint, style: text.bodyMedium),
                      const SizedBox(height: AppSpacing.lg),
                      AppTextField(
                        controller: _currentPassword,
                        label: l10n.currentPassword,
                        obscure: true,
                        prefixIcon: Icons.lock_outline,
                        validator: (value) =>
                            FormValidators.password(l10n, value),
                      ),
                      AppTextField(
                        controller: _newPassword,
                        label: l10n.newPassword,
                        obscure: true,
                        prefixIcon: Icons.lock_outline,
                        validator: (value) =>
                            FormValidators.password(l10n, value),
                      ),
                      AppTextField(
                        controller: _confirmPassword,
                        label: l10n.confirmPassword,
                        obscure: true,
                        prefixIcon: Icons.lock_outline,
                        validator: (value) {
                          if (value != _newPassword.text) {
                            return l10n.validationPasswordMatch;
                          }
                          return FormValidators.password(l10n, value);
                        },
                      ),
                      if (ui.passwordErrorKey != null)
                        AppErrorBanner(
                          message: lookupError(l10n, ui.passwordErrorKey!),
                        ),
                      if (ui.passwordChanged)
                        AppSuccessBanner(message: l10n.passwordChanged),
                      AppFilledButton(
                        label: l10n.updatePassword,
                        busy: ui.changingPassword,
                        onPressed: _submitPassword,
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
