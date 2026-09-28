import 'package:flutter/material.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Address, location, currency, phone, and country for one venue.
class BuildingDetailDialog extends StatelessWidget {
  const BuildingDetailDialog({super.key, required this.building});

  final AdminBuildingView building;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    return AlertDialog(
      title: Text(building.name),
      content: SizedBox(
        width: AppBreakpoints.formMax,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DetailLine(label: l10n.address, value: building.address),
            _DetailLine(
              label: l10n.location,
              value: l10n.coordinates(
                building.latitude.toStringAsFixed(5),
                building.longitude.toStringAsFixed(5),
              ),
            ),
            _DetailLine(label: l10n.currency, value: building.currencyCode),
            _DetailLine(label: l10n.phone, value: building.phoneNumber),
            _DetailLine(label: l10n.country, value: building.countryCode),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${building.ownerFirstName} ${building.ownerLastName}',
              style: text.bodyMedium,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.close),
        ),
      ],
    );
  }
}

class _DetailLine extends StatelessWidget {
  const _DetailLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: text.labelMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(value, style: text.titleMedium),
        ],
      ),
    );
  }
}
