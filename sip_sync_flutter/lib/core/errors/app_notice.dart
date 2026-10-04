import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import 'error_mapper.dart';

/// Floating notice. Plan errors use the same colors as the rest of the app.
void showAppSnackBar(BuildContext context, String message) {
  final scheme = Theme.of(context).colorScheme;
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: scheme.inverseSurface,
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: scheme.onInverseSurface,
        ),
      ),
    ),
  );
}

/// Snackbar for a failed customer action, including a plan rejection.
void showMappedError(BuildContext context, Object error) {
  final l10n = AppLocalizations.of(context)!;
  showAppSnackBar(context, lookupError(l10n, mapError(error).l10nKey));
}
