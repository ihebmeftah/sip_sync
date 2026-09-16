import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/auth_shell.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/auth_view_model.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _username = TextEditingController();
  final _phone = TextEditingController();
  final _first = TextEditingController();
  final _last = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    _phone.dispose();
    _first.dispose();
    _last.dispose();
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
          Text(l10n.registerLead, style: text.headlineMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.tagline, style: text.bodyLarge),
          const SizedBox(height: AppSpacing.xl),
          AppTextField(
            controller: _first,
            label: l10n.firstName,
            prefixIcon: Icons.person_outline,
            textInputAction: TextInputAction.next,
          ),
          AppTextField(
            controller: _last,
            label: l10n.lastName,
            prefixIcon: Icons.badge_outlined,
            textInputAction: TextInputAction.next,
          ),
          AppTextField(
            controller: _username,
            label: l10n.username,
            prefixIcon: Icons.alternate_email,
            textInputAction: TextInputAction.next,
          ),
          AppTextField(
            controller: _email,
            label: l10n.email,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.mail_outline,
            textInputAction: TextInputAction.next,
          ),
          AppTextField(
            controller: _phone,
            label: l10n.phone,
            keyboardType: TextInputType.phone,
            prefixIcon: Icons.phone_outlined,
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
            label: l10n.register,
            busy: auth.isLoading,
            onPressed: () async {
              await ref
                  .read(authViewModelProvider.notifier)
                  .register(
                    email: _email.text,
                    password: _password.text,
                    username: _username.text,
                    phoneNumber: _phone.text,
                    firstName: _first.text,
                    lastName: _last.text,
                  );
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: () => const SignInRoute().go(context),
            child: Text(l10n.hasAccount),
          ),
        ],
      ),
    );
  }
}
