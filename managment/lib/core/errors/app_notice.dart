import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import 'error_mapper.dart';

/// How a floating notice should read: a save, a failure, or a plain message.
enum AppNoticeKind { neutral, success, error }

/// Floating notice. Uses the root messenger so it stays after a form pops.
void showAppSnackBar(
  BuildContext context,
  String message, {
  AppNoticeKind kind = AppNoticeKind.neutral,
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(buildAppSnackBar(context, message, kind: kind));
}

/// Snack bar built before a route pop, then shown on a captured messenger.
SnackBar buildAppSnackBar(
  BuildContext context,
  String message, {
  AppNoticeKind kind = AppNoticeKind.neutral,
}) {
  final scheme = Theme.of(context).colorScheme;
  final (background, foreground) = switch (kind) {
    AppNoticeKind.success => (scheme.primary, scheme.onPrimary),
    AppNoticeKind.error => (scheme.error, scheme.onError),
    AppNoticeKind.neutral => (scheme.inverseSurface, scheme.onInverseSurface),
  };
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    width: webSnackBarWidth(context),
    backgroundColor: background,
    showCloseIcon: true,
    closeIconColor: foreground,
    content: Text(
      message,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: foreground),
    ),
  );
}

/// Caps a floating snack bar on a wide browser. Narrow web keeps the default.
double? webSnackBarWidth(BuildContext context) {
  if (!kIsWeb) {
    return null;
  }
  const maxWidth = 400.0;
  final viewport = MediaQuery.sizeOf(context).width;
  if (viewport < maxWidth + 48) {
    return null;
  }
  return maxWidth;
}

/// Closes the current route, then shows [message] on the shell messenger.
void popWithSnackBar(
  BuildContext context,
  String message, {
  Object? result = true,
  AppNoticeKind kind = AppNoticeKind.success,
}) {
  final messenger = ScaffoldMessenger.of(context);
  final bar = buildAppSnackBar(context, message, kind: kind);
  Navigator.of(context).pop(result);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(bar);
}

/// Confirms a create or update that stayed on this route.
void showSavedSnackBar(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  showAppSnackBar(context, l10n.noticeSaved, kind: AppNoticeKind.success);
}

/// Confirms a delete that stayed on this route.
void showRemovedSnackBar(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  showAppSnackBar(context, l10n.noticeRemoved, kind: AppNoticeKind.success);
}

/// Snackbar for an already-mapped l10n key.
void showErrorKey(BuildContext context, String key) {
  final l10n = AppLocalizations.of(context)!;
  showAppSnackBar(context, lookupError(l10n, key), kind: AppNoticeKind.error);
}

/// Snackbar for a thrown failure.
void showFailureSnackBar(BuildContext context, Object error) {
  showErrorKey(context, mapError(error).l10nKey);
}

/// Keeps the form banner and raises a snackbar for every action failure.
String captureError(BuildContext context, Object error) {
  final key = mapError(error).l10nKey;
  showErrorKey(context, key);
  return key;
}

/// One snackbar when a screen's load fails, including a failure already
/// present when the screen opens. Rebuilds with the same error stay quiet.
class LoadFailureNotice extends StatefulWidget {
  const LoadFailureNotice({super.key, this.error});

  final Object? error;

  @override
  State<LoadFailureNotice> createState() => _LoadFailureNoticeState();
}

class _LoadFailureNoticeState extends State<LoadFailureNotice> {
  Object? _reported;

  @override
  void initState() {
    super.initState();
    _queue(widget.error);
  }

  @override
  void didUpdateWidget(LoadFailureNotice oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(widget.error, oldWidget.error)) {
      _queue(widget.error);
    }
  }

  void _queue(Object? error) {
    if (error == null || identical(error, _reported)) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !identical(widget.error, error)) {
        return;
      }
      if (identical(_reported, error)) {
        return;
      }
      _reported = error;
      showFailureSnackBar(context, error);
    });
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
