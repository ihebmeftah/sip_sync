import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';
import 'console_shell.dart';

/// Placeholder for a console section that does not have a feature yet.
class WorkingView extends StatelessWidget {
  const WorkingView({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);
    return ConsolePage(
      title: title,
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.xxl),
        child: Column(
          children: [
            Icon(icon, size: 28, color: theme.colorScheme.mutedForeground),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.screenWorking,
              style: theme.textTheme.muted,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
