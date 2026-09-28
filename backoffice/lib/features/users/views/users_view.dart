import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
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

    return ConsolePage(
      title: l10n.usersTitle,
      subtitle: l10n.usersSubtitle,
      action: FilledButton.icon(
        onPressed: () => showDialog<void>(
          context: context,
          builder: (_) => const UserFormDialog(),
        ),
        icon: const Icon(Icons.person_add_alt_1),
        label: Text(l10n.createUser),
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
                TextButton(
                  onPressed: () => ref.invalidate(usersViewModelProvider),
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
              return AppSurfaceCard(
                child: Column(
                  children: [
                    for (final user in rows)
                      _UserRow(
                        user: user,
                        locked: user.isSystemDefault || user.id == selfId,
                        onEdit: () => showDialog<void>(
                          context: context,
                          builder: (_) => UserFormDialog(user: user),
                        ),
                        onToggle: (enabled) async {
                          final error = await ref
                              .read(usersViewModelProvider.notifier)
                              .setEnabled(user.id, enabled);
                          if (!mounted) return;
                          setState(() => _bannerKey = error);
                        },
                        onDelete: user.isSystemDefault
                            ? null
                            : () => _confirmDelete(user),
                      ),
                  ],
                ),
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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteUser),
        content: Text(l10n.deleteUserConfirm(name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
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
    final scheme = Theme.of(context).colorScheme;
    final initial = user.firstName.isEmpty ? '?' : user.firstName[0];
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: scheme.secondaryContainer,
        foregroundColor: scheme.onSecondaryContainer,
        child: Text(initial),
      ),
      title: Text('${user.firstName} ${user.lastName}'),
      subtitle: Text(
        [
          user.email,
          user.phoneNumber,
          if (user.isSystemDefault) l10n.defaultAdminFlag,
          user.isEnabled ? l10n.enabled : l10n.disabled,
        ].join(' · '),
      ),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.xs,
        children: [
          Switch(value: user.isEnabled, onChanged: locked ? null : onToggle),
          IconButton(
            tooltip: l10n.editUser,
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined),
          ),
          if (onDelete != null)
            IconButton(
              tooltip: l10n.deleteUser,
              onPressed: onDelete,
              icon: Icon(Icons.delete_outline, color: scheme.error),
            ),
        ],
      ),
    );
  }
}
