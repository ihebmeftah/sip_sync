import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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
    final theme = ShadTheme.of(context);
    return ConsolePage(
      title: l10n.buildingsTitle,
      subtitle: l10n.buildingsSubtitle,
      child: buildings.when(
        loading: () => const LinearProgressIndicator(),
        error: (error, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppErrorBanner(message: lookupError(l10n, mapError(error).l10nKey)),
            ShadButton.outline(
              onPressed: () =>
                  ref.read(buildingsViewModelProvider.notifier).refresh(),
              child: Text(l10n.retry),
            ),
          ],
        ),
        data: (rows) {
          if (rows.isEmpty) {
            return Text(l10n.empty, style: theme.textTheme.muted);
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
    final theme = ShadTheme.of(context);
    final owner = '${building.ownerFirstName} ${building.ownerLastName}'.trim();
    return ShadCard(
      width: double.infinity,
      rowMainAxisSize: MainAxisSize.max,
      columnCrossAxisAlignment: CrossAxisAlignment.stretch,
      title: Text(building.name),
      description: Text(
        '$owner · ${building.ownerEmail} · ${building.ownerPhoneNumber}',
      ),
      trailing: ShadButton.outline(
        size: ShadButtonSize.sm,
        onPressed: () => _open(context),
        child: Text(l10n.viewDetails),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShadBadge.outline(child: Text(building.type)),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.contact, style: theme.textTheme.muted),
            const SizedBox(height: AppSpacing.xs),
            Text(_contact(building), style: theme.textTheme.small),
          ],
        ),
      ),
    );
  }

  void _open(BuildContext context) {
    showShadDialog<void>(
      context: context,
      builder: (_) => BuildingDetailDialog(building: building),
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
