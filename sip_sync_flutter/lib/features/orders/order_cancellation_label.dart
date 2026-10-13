import 'package:sip_sync_client/sip_sync_client.dart';

import '../../l10n/generated/app_localizations.dart';

/// Reasons a venue can attach when it cancels an order or a line.
String orderCancellationReasonLabel(
  AppLocalizations l10n,
  OrderCancellationReason reason,
) {
  return switch (reason) {
    OrderCancellationReason.ingredientOutOfStock => l10n.cancelReasonOutOfStock,
    OrderCancellationReason.closingSoon => l10n.cancelReasonClosingSoon,
    OrderCancellationReason.workBreakdown => l10n.cancelReasonWorkBreakdown,
    OrderCancellationReason.customerRequest => l10n.cancelReasonCustomerRequest,
  };
}
