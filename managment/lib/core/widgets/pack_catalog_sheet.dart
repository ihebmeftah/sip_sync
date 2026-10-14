import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../l10n/generated/app_localizations.dart';
import '../di/app_providers.dart';
import '../errors/app_notice.dart';
import '../errors/error_mapper.dart';
import '../theme/app_tokens.dart';
import 'app_controls.dart';
import 'app_loader.dart';

/// Opens the public plan catalog.
///
/// [closeDrawer] pops the compact drawer first so the sheet is not covered.
void showPackCatalog(BuildContext context, {bool closeDrawer = false}) {
  if (closeDrawer) {
    final host = Navigator.of(context, rootNavigator: true).context;
    Navigator.of(context).pop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (host.mounted) {
        _presentPackCatalog(host);
      }
    });
    return;
  }
  _presentPackCatalog(context);
}

void _presentPackCatalog(BuildContext context) {
  final wide = MediaQuery.sizeOf(context).width >= AppBreakpoints.expanded;
  if (wide) {
    final size = MediaQuery.sizeOf(context);
    final width = math.min(720.0, size.width - 96);
    final height = math.min(680.0, size.height - 80);
    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: width,
            height: height,
            child: const _PackCatalogSheet(),
          ),
        );
      },
    );
    return;
  }
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      final height = MediaQuery.sizeOf(context).height * 0.92;
      return SizedBox(height: height, child: const _PackCatalogSheet());
    },
  );
}

class _PackCatalogSheet extends ConsumerWidget {
  const _PackCatalogSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final current = ref.watch(buildingSelectionProvider)?.pack;
    final async = ref.watch(publicPacksProvider);
    final intro = current == null
        ? l10n.packCatalogIntro
        : l10n.packCatalogIntroCurrent(current.name);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.md,
            AppSpacing.sm,
            0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(l10n.packCatalogTitle, style: text.titleLarge),
              ),
              IconButton(
                tooltip: l10n.cancel,
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
        Expanded(
          child: async.when(
            loading: () => const AppScreenLoader(),
            error: (error, _) => ListView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [
                LoadFailureNotice(error: error),
                AppErrorBanner(
                  message: lookupError(l10n, mapError(error).l10nKey),
                ),
                TextButton(
                  onPressed: () => ref.invalidate(publicPacksProvider),
                  child: Text(l10n.retry),
                ),
              ],
            ),
            data: (packs) {
              final sorted = [...packs]
                ..sort((a, b) {
                  final byOrder = a.sortOrder.compareTo(b.sortOrder);
                  if (byOrder != 0) {
                    return byOrder;
                  }
                  return a.name.compareTo(b.name);
                });
              return ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.sm,
                  AppSpacing.xl,
                  AppSpacing.xl,
                ),
                children: [
                  Text(intro, style: text.bodyMedium),
                  const SizedBox(height: AppSpacing.lg),
                  if (sorted.isEmpty)
                    Text(l10n.packCatalogEmpty, style: text.bodyMedium)
                  else
                    for (final pack in sorted) ...[
                      _PackCard(
                        pack: pack,
                        current: current != null && pack.code == current.code,
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PackCard extends StatelessWidget {
  const _PackCard({required this.pack, required this.current});

  final PackPublicView pack;
  final bool current;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final caps = pack.capabilities;
    final limits = <(String, int?)>[
      (l10n.packCapEmployees, caps.maxEmployees),
      (l10n.packCapTables, caps.maxTables),
      (l10n.packCapCategories, caps.maxCategories),
      (l10n.packCapArticles, caps.maxArticles),
      (l10n.packCapIngredients, caps.maxIngredients),
      (l10n.packCapReservationsPerDay, caps.maxReservationsPerDay),
    ];
    final flags = <(String, bool)>[
      (l10n.packCapDiscovery, caps.customerDiscovery),
      (l10n.packCapQr, caps.tableQr),
      (l10n.packCapOrdering, caps.customerOrdering),
      (l10n.packCapInventory, caps.inventory),
      (l10n.packCapAppend, caps.allowAppendingItems),
      (l10n.packCapMultiOrder, caps.tableMultiOrder),
      (l10n.packCapStrict, caps.strictMode),
      (l10n.packCapAccess, caps.customAccessProfiles),
      (l10n.packCapReservations, caps.reservations),
      (l10n.packCapCashRegister, caps.cashRegister),
    ];

    return Material(
      color: scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        side: BorderSide(
          color: current
              ? scheme.primary
              : scheme.outline.withValues(alpha: 0.7),
          width: current ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(pack.name, style: text.titleMedium)),
                if (current) const PackCurrentChip(),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.packPriceMonth(_formatMillimes(pack.monthlyMillimes)),
              style: text.titleSmall?.copyWith(
                color: scheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (pack.annualMillimes != null)
              Text(
                l10n.packPriceYear(_formatMillimes(pack.annualMillimes!)),
                style: text.bodyMedium,
              ),
            Text(
              l10n.packFeeLine(_formatBps(pack.customerOrderFeeBps)),
              style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.packLimits, style: text.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final limit in limits)
                  _LimitChip(
                    label: l10n.packLimitValue(
                      limit.$1,
                      limit.$2 == null ? l10n.packUnlimited : '${limit.$2}',
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.packCapabilities, style: text.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            for (final flag in flags)
              _FlagRow(label: flag.$1, included: flag.$2),
          ],
        ),
      ),
    );
  }
}

/// Marks the plan the open venue is already on.
class PackCurrentChip extends StatelessWidget {
  const PackCurrentChip({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          l10n.packCurrent,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: scheme.onPrimaryContainer,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _LimitChip extends StatelessWidget {
  const _LimitChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(label, style: Theme.of(context).textTheme.labelMedium),
      ),
    );
  }
}

class _FlagRow extends StatelessWidget {
  const _FlagRow({required this.label, required this.included});

  final String label;
  final bool included;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = included
        ? scheme.primary
        : scheme.onSurface.withValues(alpha: 0.45);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Icon(
            included ? Icons.check_circle : Icons.remove_circle_outline,
            size: 16,
            color: color,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

/// Catalog money is millimes (1 TND = 1000).
String _formatMillimes(int millimes) {
  final whole = millimes ~/ 1000;
  final frac = millimes.abs() % 1000;
  if (frac == 0) {
    return '$whole';
  }
  final digits = frac.toString().padLeft(3, '0').replaceAll(RegExp(r'0+$'), '');
  return '$whole.$digits';
}

/// Basis points to a percent string (`150` → `1.5`).
String _formatBps(int bps) {
  final whole = bps ~/ 100;
  final frac = bps.abs() % 100;
  if (frac == 0) {
    return '$whole';
  }
  if (frac % 10 == 0) {
    return '$whole.${frac ~/ 10}';
  }
  return '$whole.${frac.toString().padLeft(2, '0')}';
}
