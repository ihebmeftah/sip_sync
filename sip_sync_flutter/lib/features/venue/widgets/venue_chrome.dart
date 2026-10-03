import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_icons.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Leaves the venue page, or returns home when this screen was opened directly.
class VenueBackButton extends StatelessWidget {
  const VenueBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return IconButton(
      tooltip: l10n.back,
      onPressed: () {
        if (context.canPop()) {
          context.pop();
          return;
        }
        const HomeRoute().go(context);
      },
      icon: Transform.flip(
        flipX: Directionality.of(context) == TextDirection.rtl,
        child: const Icon(AppIcons.back),
      ),
    );
  }
}
