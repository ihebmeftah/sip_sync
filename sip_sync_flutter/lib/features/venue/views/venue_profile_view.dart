import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_phone_field.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../profile/view_models/profile_view_model.dart';

/// Customer account on a venue visit: name, phone, and password.
class VenueProfileView extends ConsumerStatefulWidget {
  const VenueProfileView({super.key});

  @override
  ConsumerState<VenueProfileView> createState() => _VenueProfileViewState();
}

class _VenueProfileViewState extends ConsumerState<VenueProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _email = TextEditingController();
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
    final session = ref.read(authViewModelProvider).session;
    if (session == null) {
      return;
    }
    _email.text = session.email;
    _first.text = session.firstName;
    _last.text = session.lastName;
    _phone = session.phoneNumber;
    _filled = true;
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
    final text = Theme.of(context).textTheme;
    final session = ref.watch(authViewModelProvider).session;
    final ui = ref.watch(profileViewModelProvider);
    _fillFromSession();
    if (session == null) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            const Spacer(),
            Icon(
              AppIcons.person,
              size: 56,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.profileTitle, style: text.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.profileReady,
              textAlign: TextAlign.center,
              style: text.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppFilledButton(
              label: l10n.signIn,
              onPressed: () => const SignInRoute().go(context),
            ),
            const Spacer(),
          ],
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      children: [
        AppSurfaceCard(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.profileTitle, style: text.headlineSmall),
                const SizedBox(height: AppSpacing.sm),
                Text(l10n.profileHint, style: text.bodyMedium),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  controller: _first,
                  label: l10n.firstName,
                  prefixIcon: AppIcons.person,
                  validator: (value) =>
                      FormValidators.requiredName(l10n, value),
                ),
                AppTextField(
                  controller: _last,
                  label: l10n.lastName,
                  prefixIcon: AppIcons.person,
                  validator: (value) =>
                      FormValidators.requiredName(l10n, value),
                ),
                AppTextField(
                  controller: _email,
                  label: l10n.email,
                  readOnly: true,
                  helperText: l10n.emailLocked,
                  prefixIcon: AppIcons.mail,
                ),
                AppPhoneField(
                  label: l10n.phone,
                  value: _phone,
                  onChanged: (value) => setState(() => _phone = value),
                ),
                if (ui.errorKey != null)
                  AppErrorBanner(message: lookupError(l10n, ui.errorKey!)),
                if (ui.saved)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                    child: Text(
                      l10n.profileSaved,
                      style: text.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                AppFilledButton(
                  label: l10n.saveProfile,
                  busy: ui.saving,
                  onPressed: () {
                    if (!(_formKey.currentState?.validate() ?? false)) {
                      return;
                    }
                    final phoneError = FormValidators.phone(l10n, _phone);
                    if (phoneError != null) {
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
                  prefixIcon: AppIcons.lock,
                  validator: (value) => FormValidators.password(l10n, value),
                ),
                AppTextField(
                  controller: _newPassword,
                  label: l10n.newPassword,
                  obscure: true,
                  prefixIcon: AppIcons.lock,
                  validator: (value) => FormValidators.password(l10n, value),
                ),
                AppTextField(
                  controller: _confirmPassword,
                  label: l10n.confirmPassword,
                  obscure: true,
                  prefixIcon: AppIcons.lock,
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                    child: Text(
                      l10n.passwordChanged,
                      style: text.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                AppFilledButton(
                  label: l10n.updatePassword,
                  busy: ui.changingPassword,
                  onPressed: _submitPassword,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppTonalButton(
          label: l10n.signOut,
          icon: AppIcons.logout,
          onPressed: () => ref.read(authViewModelProvider.notifier).signOut(),
        ),
      ],
    );
  }
}
