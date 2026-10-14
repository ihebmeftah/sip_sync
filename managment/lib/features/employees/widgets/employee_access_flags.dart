import 'package:flutter/material.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Profile name and the actions that profile allows.
class EmployeeAccessFlags extends StatelessWidget {
  const EmployeeAccessFlags({super.key, required this.access});

  final EmployeeAccessView? access;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final profile = access;
    if (profile == null) {
      return Text(l10n.accessProfileNone, style: text.bodyMedium);
    }
    final granted = <String>[
      if (profile.orderCreation) l10n.accessOrderCreation,
      if (profile.orderPayment) l10n.accessOrderPayment,
      if (profile.cancelOrder) l10n.accessCancelOrder,
      if (profile.preparation) l10n.accessPreparation,
      if (profile.serving) l10n.accessServing,
      if (profile.consultAllOrders) l10n.accessConsultAllOrders,
      if (profile.reservations) l10n.accessReservations,
      if (profile.cashRegister) l10n.accessCashRegister,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(profile.name, style: text.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        if (granted.isEmpty)
          Text(l10n.accessFlagsNone, style: text.bodyMedium)
        else
          for (final label in granted)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                children: [
                  Icon(Icons.check, size: 18, color: scheme.primary),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: Text(label, style: text.bodyMedium)),
                ],
              ),
            ),
      ],
    );
  }
}
