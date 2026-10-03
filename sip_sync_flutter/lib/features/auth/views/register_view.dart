import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_server_error.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_phone_field.dart';
import '../../../core/widgets/auth_shell.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/auth_view_model.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey();
  final _phoneKey = GlobalKey();
  final _passwordKey = GlobalKey();
  final _bannerKey = GlobalKey();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _first = TextEditingController();
  final _last = TextEditingController();
  var _phone = '';

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _first.dispose();
    _last.dispose();
    super.dispose();
  }

  void _clearServerError() {
    if (ref.read(authViewModelProvider).errorKey == null) {
      return;
    }
    ref.read(authViewModelProvider.notifier).clearError();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _formKey.currentState?.validate();
      }
    });
  }

  void _reveal(String? errorKey) {
    _formKey.currentState?.validate();
    final target = FormServerError.email.contains(errorKey)
        ? _emailKey
        : FormServerError.phone.contains(errorKey)
        ? _phoneKey
        : FormServerError.password.contains(errorKey)
        ? _passwordKey
        : _bannerKey;
    final context = target.currentContext;
    if (context == null) {
      return;
    }
    Scrollable.ensureVisible(
      context,
      alignment: 0.2,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final auth = ref.watch(authViewModelProvider);
    final text = Theme.of(context).textTheme;
    final errorKey = auth.errorKey;
    final banner = errorKey != null && !FormServerError.isFieldScoped(errorKey)
        ? lookupError(l10n, errorKey)
        : null;
    return AuthShell(
      form: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.registerLead, style: text.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.tagline, style: text.bodyLarge),
            const SizedBox(height: AppSpacing.xl),
            AppTextField(
              controller: _first,
              label: l10n.firstName,
              prefixIcon: AppIcons.person,
              textInputAction: TextInputAction.next,
              onChanged: (_) => _clearServerError(),
              validator: (value) => FormValidators.requiredName(l10n, value),
            ),
            AppTextField(
              controller: _last,
              label: l10n.lastName,
              prefixIcon: AppIcons.badge,
              textInputAction: TextInputAction.next,
              onChanged: (_) => _clearServerError(),
              validator: (value) => FormValidators.requiredName(l10n, value),
            ),
            AppTextField(
              key: _emailKey,
              controller: _email,
              label: l10n.email,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: AppIcons.mail,
              textInputAction: TextInputAction.next,
              onChanged: (_) => _clearServerError(),
              validator: (value) {
                final local = FormValidators.email(l10n, value);
                if (local != null) {
                  return local;
                }
                return FormServerError.message(
                  l10n,
                  ref.read(authViewModelProvider).errorKey,
                  FormServerError.email,
                );
              },
            ),
            AppPhoneField(
              key: _phoneKey,
              label: l10n.phone,
              value: _phone,
              serverError: FormServerError.message(
                l10n,
                errorKey,
                FormServerError.phone,
              ),
              onChanged: (value) {
                setState(() => _phone = value);
                _clearServerError();
              },
            ),
            AppTextField(
              key: _passwordKey,
              controller: _password,
              label: l10n.password,
              obscure: true,
              prefixIcon: AppIcons.lock,
              textInputAction: TextInputAction.done,
              onChanged: (_) => _clearServerError(),
              validator: (value) {
                final local = FormValidators.password(l10n, value);
                if (local != null) {
                  return local;
                }
                return FormServerError.message(
                  l10n,
                  ref.read(authViewModelProvider).errorKey,
                  FormServerError.password,
                );
              },
            ),
            KeyedSubtree(
              key: _bannerKey,
              child: AppFormMessage(
                message: banner,
                onDismiss: () =>
                    ref.read(authViewModelProvider.notifier).clearError(),
              ),
            ),
            AppFilledButton(
              label: l10n.register,
              busy: auth.isLoading,
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                if (!(_formKey.currentState?.validate() ?? false)) {
                  return;
                }
                final ok = await ref
                    .read(authViewModelProvider.notifier)
                    .register(
                      email: _email.text.trim(),
                      password: _password.text,
                      phoneNumber: _phone,
                      firstName: _first.text.trim(),
                      lastName: _last.text.trim(),
                    );
                if (!mounted || ok) {
                  return;
                }
                final failure = ref.read(authViewModelProvider).errorKey;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    _reveal(failure);
                  }
                });
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: () => const SignInRoute().go(context),
              child: Text(l10n.hasAccount),
            ),
          ],
        ),
      ),
    );
  }
}
