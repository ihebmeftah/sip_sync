import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/auth_shell.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/auth_view_model.dart';

/// Owner password reset: request OTP, then set a new password.
class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _code = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  var _codeSent = false;
  String? _debugCode;

  @override
  void dispose() {
    _email.dispose();
    _code.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _requestCode() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final debug = await ref
        .read(authViewModelProvider.notifier)
        .requestPasswordReset(_email.text);
    if (!mounted) return;
    // null with errorKey means failure; null without error means no debug code.
    final auth = ref.read(authViewModelProvider);
    if (auth.errorKey != null) {
      return;
    }
    setState(() {
      _codeSent = true;
      _debugCode = debug;
      if (debug != null) {
        _code.text = debug;
      }
    });
  }

  Future<void> _confirmReset() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final ok = await ref
        .read(authViewModelProvider.notifier)
        .confirmPasswordReset(
          email: _email.text,
          code: _code.text,
          newPassword: _password.text,
        );
    if (!mounted || !ok) {
      return;
    }
    showAppSnackBar(
      context,
      AppLocalizations.of(context)!.passwordResetDone,
      kind: AppNoticeKind.success,
    );
    const SignInRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final auth = ref.watch(authViewModelProvider);
    final text = Theme.of(context).textTheme;
    return AuthShell(
      form: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.forgotPasswordTitle, style: text.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              _codeSent ? l10n.forgotPasswordCodeHint : l10n.forgotPasswordHint,
              style: text.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppTextField(
              controller: _email,
              label: l10n.email,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.mail_outline,
              textInputAction: TextInputAction.next,
              readOnly: _codeSent,
              validator: (value) => FormValidators.email(l10n, value),
            ),
            if (_codeSent) ...[
              if (_debugCode != null) ...[
                AppSuccessBanner(
                  message: l10n.forgotPasswordDevCode(_debugCode!),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              AppTextField(
                controller: _code,
                label: l10n.resetCode,
                prefixIcon: Icons.pin_outlined,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.length < 4) {
                    return l10n.validationResetCode;
                  }
                  return null;
                },
              ),
              AppTextField(
                controller: _password,
                label: l10n.newPassword,
                obscure: true,
                prefixIcon: Icons.lock_outline,
                textInputAction: TextInputAction.next,
                validator: (value) => FormValidators.password(l10n, value),
              ),
              AppTextField(
                controller: _confirm,
                label: l10n.confirmPassword,
                obscure: true,
                prefixIcon: Icons.lock_outline,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value != _password.text) {
                    return l10n.validationPasswordMatch;
                  }
                  return FormValidators.password(l10n, value);
                },
              ),
            ],
            if (auth.errorKey != null)
              AppErrorBanner(message: lookupError(l10n, auth.errorKey!)),
            AppFilledButton(
              label: _codeSent ? l10n.resetPassword : l10n.sendResetCode,
              busy: auth.isLoading,
              onPressed: _codeSent ? _confirmReset : _requestCode,
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: () => const SignInRoute().go(context),
              child: Text(l10n.backToSignIn),
            ),
          ],
        ),
      ),
    );
  }
}
