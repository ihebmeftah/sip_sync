import 'package:flutter/material.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../l10n/generated/app_localizations.dart';
import 'order_status_labels.dart';

/// Asks which predefined reason applies. Returns null when the dialog is dismissed.
Future<OrderCancellationReason?> showCancellationReasonDialog(
  BuildContext context,
) {
  return showDialog<OrderCancellationReason>(
    context: context,
    builder: (context) => const _CancellationReasonDialog(),
  );
}

class _CancellationReasonDialog extends StatefulWidget {
  const _CancellationReasonDialog();

  @override
  State<_CancellationReasonDialog> createState() =>
      _CancellationReasonDialogState();
}

class _CancellationReasonDialogState extends State<_CancellationReasonDialog> {
  OrderCancellationReason? _reason;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return AlertDialog(
      title: Text(l10n.cancelReasonTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final reason in OrderCancellationReason.values)
            ListTile(
              contentPadding: EdgeInsets.zero,
              selected: _reason == reason,
              leading: Icon(
                _reason == reason
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: _reason == reason ? scheme.primary : scheme.onSurface,
              ),
              title: Text(orderCancellationReasonLabel(l10n, reason)),
              onTap: () => setState(() => _reason = reason),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.close),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: scheme.error,
            foregroundColor: scheme.onError,
          ),
          onPressed: _reason == null
              ? null
              : () => Navigator.of(context).pop(_reason),
          child: Text(l10n.cancelReasonConfirm),
        ),
      ],
    );
  }
}
