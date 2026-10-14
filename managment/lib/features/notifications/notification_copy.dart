import 'package:sip_sync_client/sip_sync_client.dart';

import '../../l10n/generated/app_localizations.dart';

/// One sentence for an alert in the inbox and the snackbar stack.
String notificationBody(AppLocalizations l10n, AppNotificationView row) {
  if (row.kind == AppNotificationKind.reservation) {
    return switch (row.reservationStatus) {
      ReservationStatus.cancelled => l10n.notificationReservationCancelled,
      ReservationStatus.requested => l10n.notificationReservationRequested(
        row.venueName,
      ),
      _ => l10n.notificationReservationAccepted,
    };
  }
  return row.venueName;
}
