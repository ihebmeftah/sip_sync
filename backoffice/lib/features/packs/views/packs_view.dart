import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/list_page_bar.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../console/views/console_shell.dart';
import '../pack_money.dart';
import '../view_models/packs_view_model.dart';
import 'pack_form_dialog.dart';

/// Catalog of commercial packs. Public plans are listed in the apps.
class PacksView extends ConsumerStatefulWidget {
  const PacksView({super.key});

  @override
  ConsumerState<PacksView> createState() => _PacksViewState();
}

class _PacksViewState extends ConsumerState<PacksView> {
  String? _bannerKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final packs = ref.watch(packsViewModelProvider);
    final theme = ShadTheme.of(context);

    return ConsolePage(
      title: l10n.packsTitle,
      subtitle: l10n.packsSubtitle,
      action: ShadButton(
        leading: const Icon(LucideIcons.plus, size: 16),
        onPressed: () => showShadDialog<void>(
          context: context,
          builder: (_) => const PackFormDialog(),
        ),
        child: Text(l10n.createPack),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_bannerKey != null)
            AppErrorBanner(message: lookupError(l10n, _bannerKey!)),
          packs.when(
            loading: () => const AppScreenLoader(),
            error: (error, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadFailureNotice(error: error),
                AppErrorBanner(
                  message: lookupError(l10n, mapError(error).l10nKey),
                ),
                ShadButton.outline(
                  onPressed: () => ref.invalidate(packsViewModelProvider),
                  child: Text(l10n.retry),
                ),
              ],
            ),
            data: (page) {
              final rows = page.items;
              if (rows.isEmpty) {
                return Text(l10n.empty, style: theme.textTheme.muted);
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.card,
                      borderRadius: theme.radius,
                      border: Border.all(color: theme.colorScheme.border),
                    ),
                    child: Column(
                      children: [
                        for (var i = 0; i < rows.length; i++) ...[
                          if (i > 0) const ShadSeparator.horizontal(),
                          _PackRow(
                            pack: rows[i],
                            onEdit: () => showShadDialog<void>(
                              context: context,
                              builder: (_) => PackFormDialog(pack: rows[i]),
                            ),
                            onDelete: rows[i].isSystem
                                ? null
                                : () => _confirmDelete(rows[i]),
                          ),
                        ],
                      ],
                    ),
                  ),
                  ListPageBar(
                    total: page.total,
                    limit: page.limit,
                    offset: page.offset,
                    onPrevious: () => ref
                        .read(packsViewModelProvider.notifier)
                        .previousPage(),
                    onNext: () =>
                        ref.read(packsViewModelProvider.notifier).nextPage(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(PackView pack) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text(l10n.deletePack),
        description: Text(l10n.deletePackConfirm(pack.name)),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          ShadButton.destructive(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.deletePack),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) {
      return;
    }
    final error = await ref
        .read(packsViewModelProvider.notifier)
        .delete(pack.id);
    if (!mounted) {
      return;
    }
    setState(() => _bannerKey = error);
    if (error == null) {
      showRemovedSnackBar(context);
    } else {
      showErrorKey(context, error);
    }
  }
}

class _PackRow extends StatelessWidget {
  const _PackRow({
    required this.pack,
    required this.onEdit,
    required this.onDelete,
  });

  final PackView pack;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);
    final price = l10n.packPriceMonth(formatMillimes(pack.monthlyMillimes));
    final annual = pack.annualMillimes == null
        ? null
        : l10n.packPriceYear(formatMillimes(pack.annualMillimes!));
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pack.name, style: theme.textTheme.small),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  annual == null
                      ? '${pack.code} · $price'
                      : '${pack.code} · $price · $annual',
                  style: theme.textTheme.muted,
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  children: [
                    pack.isPublic
                        ? ShadBadge.secondary(child: Text(l10n.packPublic))
                        : ShadBadge.outline(child: Text(l10n.packPrivate)),
                    pack.isEnabled
                        ? ShadBadge.secondary(child: Text(l10n.enabled))
                        : ShadBadge.outline(child: Text(l10n.disabled)),
                    if (pack.isSystem)
                      ShadBadge.outline(child: Text(l10n.packSystem)),
                  ],
                ),
              ],
            ),
          ),
          ShadIconButton.ghost(
            icon: const Icon(LucideIcons.pencil, size: 16),
            onPressed: onEdit,
          ),
          if (onDelete != null)
            ShadIconButton.ghost(
              foregroundColor: theme.colorScheme.destructive,
              icon: Icon(
                LucideIcons.trash2,
                size: 16,
                color: theme.colorScheme.destructive,
              ),
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }
}
