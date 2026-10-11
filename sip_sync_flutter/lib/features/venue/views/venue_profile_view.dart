import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/view_models/auth_view_model.dart';

/// Signed-in customer on this visit. Notifications and a fuller profile come later.
class VenueProfileView extends ConsumerWidget {
  const VenueProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final session = ref.watch(authViewModelProvider).session;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          const Spacer(),
          Icon(AppIcons.person, size: 56, color: scheme.primary),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.profileTitle, style: text.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          Text(
            session == null
                ? l10n.profileReady
                : l10n.welcome(session.firstName),
            textAlign: TextAlign.center,
            style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
          ),
          if (session != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.profileReady,
              textAlign: TextAlign.center,
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          if (session == null)
            AppFilledButton(
              label: l10n.signIn,
              onPressed: () => const SignInRoute().go(context),
            )
          else
            AppTonalButton(
              label: l10n.signOut,
              icon: AppIcons.logout,
              onPressed: () =>
                  ref.read(authViewModelProvider.notifier).signOut(),
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
