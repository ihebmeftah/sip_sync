import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_validators.dart';
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
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final auth = ref.watch(authViewModelProvider);
    final theme = ShadTheme.of(context);
    return AuthShell(
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.authLead, style: theme.textTheme.h3),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.tagline, style: theme.textTheme.muted),
          const SizedBox(height: AppSpacing.xl),
          AppTextField(
            controller: _email,
            label: l10n.email,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: LucideIcons.mail,
            textInputAction: TextInputAction.next,
            error: _emailError,
            onChanged: (_) {
              if (_emailError != null) {
                setState(() => _emailError = null);
              }
            },
          ),
          AppTextField(
            controller: _password,
            label: l10n.password,
            obscure: true,
            prefixIcon: LucideIcons.lock,
            textInputAction: TextInputAction.done,
            error: _passwordError,
            onChanged: (_) {
              if (_passwordError != null) {
                setState(() => _passwordError = null);
              }
            },
          ),
          if (auth.errorKey != null)
            AppErrorBanner(message: lookupError(l10n, auth.errorKey!)),
          AppFilledButton(
            label: l10n.signIn,
            busy: auth.isLoading,
            onPressed: () async {
              final emailError = FormValidators.email(l10n, _email.text);
              final passwordError = FormValidators.password(
                l10n,
                _password.text,
              );
              setState(() {
                _emailError = emailError;
                _passwordError = passwordError;
              });
              if (emailError != null || passwordError != null) {
                return;
              }
              await ref
                  .read(authViewModelProvider.notifier)
                  .login(_email.text.trim(), _password.text);
            },
          ),
        ],
      ),
    );
  }
}
