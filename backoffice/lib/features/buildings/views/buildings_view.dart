import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../console/views/console_shell.dart';
import '../view_models/buildings_view_model.dart';
import 'building_detail_dialog.dart';

/// Platform building list. A row opens the location and contact dialog.
class BuildingsView extends ConsumerWidget {
  const BuildingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final buildings = ref.watch(buildingsViewModelProvider);
    return ConsolePage(
      title: l10n.buildingsTitle,
      subtitle: l10n.buildingsSubtitle,
      child: buildings.when(
        loading: () => const LinearProgressIndicator(),
        error: (error, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppErrorBanner(message: lookupError(l10n, mapError(error).l10nKey)),
            TextButton(
              onPressed: () =>
                  ref.read(buildingsViewModelProvider.notifier).refresh(),
              child: Text(l10n.retry),
            ),
          ],
        ),
        data: (rows) {
          if (rows.isEmpty) {
            return Text(
              l10n.empty,
              style: Theme.of(context).textTheme.bodyMedium,
            );
          }
          return Column(
            children: [
              for (final building in rows) ...[
                _BuildingCard(building: building),
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _BuildingCard extends StatelessWidget {
  const _BuildingCard({required this.building});

  final AdminBuildingView building;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final owner = '${building.ownerFirstName} ${building.ownerLastName}'.trim();
    return AppSurfaceCard(
      child: InkWell(
        onTap: () => showDialog<void>(
          context: context,
          builder: (_) => BuildingDetailDialog(building: building),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(building.name, style: text.titleLarge)),
                Chip(
                  label: Text(building.type),
                  visualDensity: VisualDensity.compact,
                ),
                IconButton(
                  tooltip: l10n.viewDetails,
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (_) => BuildingDetailDialog(building: building),
                  ),
                  icon: const Icon(Icons.info_outline),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.owner, style: text.labelMedium),
            Text(
              '$owner · ${building.ownerEmail} · ${building.ownerPhoneNumber}',
              style: text.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.contact, style: text.labelMedium),
            Text(_contact(building), style: text.bodyMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.viewDetails,
              style: text.labelLarge?.copyWith(color: scheme.secondary),
            ),
          ],
        ),
      ),
    );
  }

  String _contact(AdminBuildingView building) {
    return [
      building.phoneNumber,
      if ((building.whatsapp ?? '').isNotEmpty) building.whatsapp!,
      if ((building.instagram ?? '').isNotEmpty) building.instagram!,
      if ((building.facebook ?? '').isNotEmpty) building.facebook!,
    ].join(' · ');
  }
}
