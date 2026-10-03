import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/auth_shell.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Backoffice is invite-only; self-register is not available.
class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);
    return AuthShell(
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.registerLead, style: theme.textTheme.h3),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.tagline, style: theme.textTheme.muted),
          const SizedBox(height: AppSpacing.xl),
          AppErrorBanner(message: l10n.errorAppAccessDenied),
          AppFilledButton(
            label: l10n.signIn,
            onPressed: () => const SignInRoute().go(context),
          ),
        ],
      ),
    );
  }
}
