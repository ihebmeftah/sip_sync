import 'package:sip_sync_client/sip_sync_client.dart';

import '../../l10n/generated/app_localizations.dart';
import '../orders/order_cancellation_label.dart';

/// One sentence for an alert. Cancelled rows include the venue's reason.
String notificationBody(AppLocalizations l10n, AppNotificationView row) {
  final reason = row.cancellationReason == null
      ? null
      : orderCancellationReasonLabel(l10n, row.cancellationReason!);
  if (row.kind == AppNotificationKind.reservation) {
    if (row.reservationStatus == ReservationStatus.cancelled) {
      return l10n.notificationReservationCancelled;
    }
    return l10n.notificationReservationAccepted;
  }
  if (row.kind == AppNotificationKind.orderItem) {
    final article = row.articleName ?? '';
    if (row.itemStatus == OrderItemStatus.cancelled && reason != null) {
      return l10n.notificationLineCancelled(article, reason);
    }
    return l10n.notificationLineStatus(
      article,
      _itemStatus(l10n, row.itemStatus),
    );
  }
  if (row.orderStatus == OrderStatus.cancelled && reason != null) {
    return l10n.notificationOrderCancelled(row.orderRef ?? 0, reason);
  }
  return l10n.notificationOrderStatus(
    row.orderRef ?? 0,
    _orderStatus(l10n, row.orderStatus),
  );
}

String _itemStatus(AppLocalizations l10n, OrderItemStatus? status) {
  return switch (status) {
    OrderItemStatus.picked => l10n.itemStatusPicked,
    OrderItemStatus.ready => l10n.itemStatusReady,
    OrderItemStatus.served => l10n.itemStatusServed,
    OrderItemStatus.payed => l10n.orderStatusPayed,
    OrderItemStatus.cancelled => l10n.orderStatusCancelled,
    OrderItemStatus.progress || null => l10n.orderStatusProgress,
  };
}

String _orderStatus(AppLocalizations l10n, OrderStatus? status) {
  return switch (status) {
    OrderStatus.payed => l10n.orderStatusPayed,
    OrderStatus.cancelled => l10n.orderStatusCancelled,
    OrderStatus.progress || null => l10n.orderStatusProgress,
  };
}
