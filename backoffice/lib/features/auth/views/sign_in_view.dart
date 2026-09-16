import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/error_mapper.dart';
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
    final text = Theme.of(context).textTheme;
    return AuthShell(
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.authLead, style: text.headlineMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.tagline, style: text.bodyLarge),
          const SizedBox(height: AppSpacing.xl),
          AppTextField(
            controller: _email,
            label: l10n.email,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.mail_outline,
            textInputAction: TextInputAction.next,
          ),
          AppTextField(
            controller: _password,
            label: l10n.password,
            obscure: true,
            prefixIcon: Icons.lock_outline,
            textInputAction: TextInputAction.done,
          ),
          if (auth.errorKey != null)
            AppErrorBanner(message: lookupError(l10n, auth.errorKey!)),
          AppFilledButton(
            label: l10n.signIn,
            busy: auth.isLoading,
            onPressed: () async {
              await ref
                  .read(authViewModelProvider.notifier)
                  .login(_email.text, _password.text);
            },
          ),
        ],
      ),
    );
  }
}
