import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/generated/app_localizations.dart';
import '../di/app_providers.dart';
import '../theme/app_tokens.dart';
import 'pack_catalog_sheet.dart';
import 'pack_locked_action.dart';

/// Names the venue's pack. Owners can open the public catalog from here.
class PackBanner extends ConsumerWidget {
  const PackBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pack = ref.watch(buildingSelectionProvider)?.pack;
    if (pack == null) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isOwner = ref.watch(appSessionStoreProvider).isOwner;
    return Material(
      color: scheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.packBannerTitle(pack.name),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: scheme.onSecondaryContainer,
                    ),
                  ),
                  Text(
                    l10n.packBannerHint,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            if (isOwner) ...[
              const SizedBox(width: AppSpacing.md),
              PackUpgradeChip(onTap: () => showPackCatalog(context)),
            ],
          ],
        ),
      ),
    );
  }
}
