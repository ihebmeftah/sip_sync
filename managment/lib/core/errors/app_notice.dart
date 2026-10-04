import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import 'error_mapper.dart';

/// Floating notice for a plan limit or a missing feature.
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
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: scheme.onInverseSurface),
      ),
    ),
  );
}

/// Keeps the form banner and also raises a snackbar for plan errors.
String captureError(BuildContext context, Object error) {
  final key = mapError(error).l10nKey;
  if (key.startsWith('errorPack')) {
    final l10n = AppLocalizations.of(context)!;
    showAppSnackBar(context, lookupError(l10n, key));
  }
  return key;
}

/// False when [current] is already at [max]. Shows [message].
bool allowPackRoom(
  BuildContext context, {
  required int? max,
  required int current,
  required String message,
}) {
  if (max != null && current >= max) {
    showAppSnackBar(context, message);
    return false;
  }
  return true;
}

/// False when [allowed] is false. Shows [message].
bool allowPackFeature(
  BuildContext context, {
  required bool allowed,
  required String message,
}) {
  if (!allowed) {
    showAppSnackBar(context, message);
    return false;
  }
  return true;
}
