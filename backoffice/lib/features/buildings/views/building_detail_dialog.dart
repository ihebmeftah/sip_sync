import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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
    final theme = ShadTheme.of(context);
    return ShadDialog(
      title: Text(building.name),
      constraints: const BoxConstraints(maxWidth: AppBreakpoints.formMax),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.close),
        ),
      ],
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
            style: theme.textTheme.small,
          ),
        ],
      ),
    );
  }
}

class _DetailLine extends StatelessWidget {
  const _DetailLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.muted),
          const SizedBox(height: AppSpacing.xs),
          Text(value, style: theme.textTheme.small),
        ],
      ),
    );
  }
}
