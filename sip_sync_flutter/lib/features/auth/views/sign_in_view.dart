import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_server_error.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/auth_shell.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/auth_view_model.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey();
  final _passwordKey = GlobalKey();
  final _bannerKey = GlobalKey();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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
    final banner =
        auth.errorKey != null && !FormServerError.isFieldScoped(auth.errorKey)
        ? lookupError(l10n, auth.errorKey!)
        : null;
    return AuthShell(
      form: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.authLead, style: text.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.tagline, style: text.bodyLarge),
            const SizedBox(height: AppSpacing.xl),
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
              label: l10n.signIn,
              busy: auth.isLoading,
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                if (!(_formKey.currentState?.validate() ?? false)) {
                  return;
                }
                final ok = await ref
                    .read(authViewModelProvider.notifier)
                    .login(_email.text.trim(), _password.text);
                if (!mounted || ok) {
                  return;
                }
                final errorKey = ref.read(authViewModelProvider).errorKey;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    _reveal(errorKey);
                  }
                });
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: () => const RegisterRoute().go(context),
              child: Text(l10n.noAccount),
            ),
          ],
        ),
      ),
    );
  }
}
