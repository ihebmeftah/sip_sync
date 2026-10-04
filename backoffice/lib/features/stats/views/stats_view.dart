import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../console/views/console_shell.dart';
import '../../packs/pack_money.dart';
import '../view_models/stats_view_model.dart';

/// Platform counts and how many venues and owners sit on each public pack.
class StatsView extends ConsumerWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final stats = ref.watch(statsViewModelProvider);
    return ConsolePage(
      title: l10n.statsTitle,
      subtitle: l10n.statsSubtitle,
      child: stats.when(
        loading: () => const LinearProgressIndicator(),
        error: (error, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppErrorBanner(message: lookupError(l10n, mapError(error).l10nKey)),
            ShadButton.outline(
              onPressed: () =>
                  ref.read(statsViewModelProvider.notifier).refresh(),
              child: Text(l10n.retry),
            ),
          ],
        ),
        data: (row) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _MetricGrid(stats: row),
            const SizedBox(height: AppSpacing.xxl),
            Text(
              l10n.publicPacksTitle,
              style: ShadTheme.of(context).textTheme.h3,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.publicPacksSubtitle,
              style: ShadTheme.of(context).textTheme.muted,
            ),
            const SizedBox(height: AppSpacing.lg),
            if (row.publicPacks.isEmpty)
              Text(l10n.empty, style: ShadTheme.of(context).textTheme.muted)
            else
              Column(
                children: [
                  for (final pack in row.publicPacks) ...[
                    _PublicPackCard(pack: pack),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.stats});

  final PlatformStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tiles = [
      (l10n.statOwners, '${stats.ownerCount}'),
      (l10n.statCustomers, '${stats.customerCount}'),
      (l10n.statVenues, '${stats.venueCount}'),
      (l10n.statEmployees, '${stats.employeeCount}'),
      (l10n.statOrders, '${stats.orderCount}'),
      (l10n.gainCustomerOrders, '${stats.customerOrderCount}'),
      (
        l10n.statSubscription,
        l10n.packPriceMonth(formatMillimes(stats.subscriptionMillimes)),
      ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900
            ? 4
            : constraints.maxWidth >= 560
            ? 2
            : 1;
        const gap = AppSpacing.md;
        final tileWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final tile in tiles)
              SizedBox(
                width: tileWidth,
                child: _MetricCard(label: tile.$1, value: tile.$2),
              ),
          ],
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadCard(
      title: Text(value, style: theme.textTheme.h3),
      description: Text(label),
    );
  }
}

class _PublicPackCard extends StatelessWidget {
  const _PublicPackCard({required this.pack});

  final PublicPackUsage pack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ShadCard(
      width: double.infinity,
      title: Text(pack.name),
      description: Text(
        l10n.packPriceMonth(formatMillimes(pack.monthlyMillimes)),
      ),
      trailing: pack.isEnabled
          ? null
          : ShadBadge.outline(child: Text(l10n.disabled)),
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.lg),
        child: Wrap(
          spacing: AppSpacing.xl,
          runSpacing: AppSpacing.md,
          children: [
            _Count(value: pack.venueCount, label: l10n.statVenues),
            _Count(value: pack.ownerCount, label: l10n.statOwners),
          ],
        ),
      ),
    );
  }
}

class _Count extends StatelessWidget {
  const _Count({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$value', style: theme.textTheme.h4),
        Text(label, style: theme.textTheme.muted),
      ],
    );
  }
}
