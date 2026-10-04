import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/list_page_bar.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../console/views/console_shell.dart';
import '../view_models/users_view_model.dart';
import 'user_form_dialog.dart';

/// Lists backoffice users and opens create or update dialogs.
class UsersView extends ConsumerStatefulWidget {
  const UsersView({super.key});

  @override
  ConsumerState<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends ConsumerState<UsersView> {
  String? _bannerKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final users = ref.watch(usersViewModelProvider);
    final selfId = ref.watch(authViewModelProvider).session?.id;
    final theme = ShadTheme.of(context);

    return ConsolePage(
      title: l10n.usersTitle,
      subtitle: l10n.usersSubtitle,
      action: ShadButton(
        leading: const Icon(LucideIcons.plus, size: 16),
        onPressed: () => showShadDialog<void>(
          context: context,
          builder: (_) => const UserFormDialog(),
        ),
        child: Text(l10n.createUser),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_bannerKey != null)
            AppErrorBanner(message: lookupError(l10n, _bannerKey!)),
          users.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppErrorBanner(
                  message: lookupError(l10n, mapError(error).l10nKey),
                ),
                ShadButton.outline(
                  onPressed: () => ref.invalidate(usersViewModelProvider),
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
                          _UserRow(
                            user: rows[i],
                            locked:
                                rows[i].isSystemDefault || rows[i].id == selfId,
                            onEdit: () => showShadDialog<void>(
                              context: context,
                              builder: (_) => UserFormDialog(user: rows[i]),
                            ),
                            onToggle: (enabled) async {
                              final error = await ref
                                  .read(usersViewModelProvider.notifier)
                                  .setEnabled(rows[i].id, enabled);
                              if (!mounted) return;
                              setState(() => _bannerKey = error);
                            },
                            onDelete: rows[i].isSystemDefault
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
                        .read(usersViewModelProvider.notifier)
                        .previousPage(),
                    onNext: () =>
                        ref.read(usersViewModelProvider.notifier).nextPage(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(SuperAdminView user) async {
    final l10n = AppLocalizations.of(context)!;
    final name = '${user.firstName} ${user.lastName}'.trim();
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text(l10n.deleteUser),
        description: Text(l10n.deleteUserConfirm(name)),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          ShadButton.destructive(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.deleteUser),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final error = await ref
        .read(usersViewModelProvider.notifier)
        .delete(user.id);
    if (!mounted) return;
    setState(() => _bannerKey = error);
  }
}

class _UserRow extends StatelessWidget {
  const _UserRow({
    required this.user,
    required this.locked,
    required this.onEdit,
    required this.onToggle,
    required this.onDelete,
  });

  final SuperAdminView user;
  final bool locked;
  final VoidCallback onEdit;
  final ValueChanged<bool> onToggle;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);
    final initial = user.firstName.isEmpty ? '?' : user.firstName[0];
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 36,
              height: 36,
              child: Center(child: Text(initial, style: theme.textTheme.small)),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: theme.textTheme.small,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${user.email} · ${user.phoneNumber}',
                  style: theme.textTheme.muted,
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  children: [
                    if (user.isSystemDefault)
                      ShadBadge.outline(child: Text(l10n.defaultAdminFlag)),
                    user.isEnabled
                        ? ShadBadge.secondary(child: Text(l10n.enabled))
                        : ShadBadge.outline(child: Text(l10n.disabled)),
                  ],
                ),
              ],
            ),
          ),
          ShadSwitch(
            value: user.isEnabled,
            enabled: !locked,
            onChanged: locked ? null : onToggle,
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
