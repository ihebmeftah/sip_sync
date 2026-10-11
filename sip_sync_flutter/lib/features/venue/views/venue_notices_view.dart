import 'package:flutter/material.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Placeholder until customer notifications exist. The copy is the whole screen.
class VenueNoticesView extends StatelessWidget {
  const VenueNoticesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          const Spacer(),
          Icon(AppIcons.notifications, size: 56, color: scheme.primary),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.notifications, style: text.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.notificationsReady,
            textAlign: TextAlign.center,
            style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
