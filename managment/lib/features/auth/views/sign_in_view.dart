import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/auth_shell.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/auth_view_model.dart';

enum _LoginMode { owner, employee }

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _identifier = TextEditingController();
  final _password = TextEditingController();
  var _mode = _LoginMode.owner;

  @override
  void dispose() {
    _identifier.dispose();
    _password.dispose();
    super.dispose();
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
            Text(l10n.authLead, style: text.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.tagline, style: text.bodyLarge),
            const SizedBox(height: AppSpacing.lg),
            SegmentedButton<_LoginMode>(
              segments: [
                ButtonSegment(
                  value: _LoginMode.owner,
                  label: Text(l10n.loginAsOwner),
                ),
                ButtonSegment(
                  value: _LoginMode.employee,
                  label: Text(l10n.loginAsEmployee),
                ),
              ],
              selected: {_mode},
              onSelectionChanged: (next) => setState(() => _mode = next.first),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              controller: _identifier,
              label: _mode == _LoginMode.owner ? l10n.email : l10n.username,
              helperText: _mode == _LoginMode.owner
                  ? null
                  : l10n.loginIdentifierHint,
              prefixIcon: _mode == _LoginMode.owner
                  ? Icons.email_outlined
                  : Icons.badge_outlined,
              textInputAction: TextInputAction.next,
              validator: (value) => _mode == _LoginMode.owner
                  ? FormValidators.email(l10n, value)
                  : FormValidators.loginIdentifier(l10n, value),
            ),
            AppTextField(
              controller: _password,
              label: l10n.password,
              obscure: true,
              prefixIcon: Icons.lock_outline,
              textInputAction: TextInputAction.done,
              validator: (value) => FormValidators.password(l10n, value),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {
                  if (_mode == _LoginMode.employee) {
                    showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(l10n.forgotPassword),
                        content: Text(l10n.forgotPasswordEmployeeHint),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(l10n.close),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  const ForgotPasswordRoute().go(context);
                },
                child: Text(l10n.forgotPassword),
              ),
            ),
            if (auth.errorKey != null)
              AppErrorBanner(message: lookupError(l10n, auth.errorKey!)),
            AppFilledButton(
              label: l10n.signIn,
              busy: auth.isLoading,
              onPressed: () async {
                if (!(_formKey.currentState?.validate() ?? false)) {
                  return;
                }
                final ok = _mode == _LoginMode.owner
                    ? await ref
                          .read(authViewModelProvider.notifier)
                          .loginOwner(_identifier.text, _password.text)
                    : await ref
                          .read(authViewModelProvider.notifier)
                          .loginEmployee(_identifier.text, _password.text);
                if (!context.mounted || !ok) {
                  return;
                }
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
