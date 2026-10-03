import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../view_models/users_view_model.dart';

/// Create or update a backoffice user. Enable/disable is part of update.
class UserFormDialog extends ConsumerStatefulWidget {
  const UserFormDialog({super.key, this.user});

  final SuperAdminView? user;

  @override
  ConsumerState<UserFormDialog> createState() => _UserFormDialogState();
}

class _UserFormDialogState extends ConsumerState<UserFormDialog> {
  late final TextEditingController _first;
  late final TextEditingController _last;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _password;
  late bool _enabled;
  String? _errorKey;
  bool _saving = false;

  bool get _editing => widget.user != null;

  @override
  void initState() {
    super.initState();
    final user = widget.user;
    _first = TextEditingController(text: user?.firstName ?? '');
    _last = TextEditingController(text: user?.lastName ?? '');
    _email = TextEditingController(text: user?.email ?? '');
    _phone = TextEditingController(text: user?.phoneNumber ?? '');
    _password = TextEditingController();
    _enabled = user?.isEnabled ?? true;
  }

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final selfId = ref.watch(authViewModelProvider).session?.id;
    final user = widget.user;
    final lockDefault = user?.isSystemDefault ?? false;
    final lockSelf = user != null && user.id == selfId;
    final lockEnabled = lockDefault || lockSelf;

    final theme = ShadTheme.of(context);
    return ShadDialog(
      title: Text(_editing ? l10n.editUser : l10n.createUser),
      constraints: const BoxConstraints(maxWidth: AppBreakpoints.formMax),
      scrollable: true,
      actions: [
        ShadButton.outline(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        ShadButton(onPressed: _saving ? null : _submit, child: Text(l10n.save)),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_errorKey != null)
            AppErrorBanner(message: lookupError(l10n, _errorKey!)),
          AppTextField(
            controller: _first,
            label: l10n.firstName,
            prefixIcon: LucideIcons.user,
            textInputAction: TextInputAction.next,
          ),
          AppTextField(
            controller: _last,
            label: l10n.lastName,
            prefixIcon: LucideIcons.userRound,
            textInputAction: TextInputAction.next,
          ),
          AppTextField(
            controller: _email,
            label: l10n.email,
            prefixIcon: LucideIcons.mail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          AppTextField(
            controller: _phone,
            label: l10n.phone,
            prefixIcon: LucideIcons.phone,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
          AppTextField(
            controller: _password,
            label: _editing ? l10n.passwordOptional : l10n.password,
            obscure: true,
            prefixIcon: LucideIcons.lock,
          ),
          if (_editing) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    _enabled ? l10n.enabled : l10n.disabled,
                    style: theme.textTheme.small,
                  ),
                ),
                ShadSwitch(
                  value: _enabled,
                  enabled: !lockEnabled,
                  onChanged: lockEnabled
                      ? null
                      : (value) => setState(() => _enabled = value),
                ),
              ],
            ),
            if (lockDefault)
              Text(l10n.enabledLockedDefault, style: theme.textTheme.muted),
            if (lockSelf && !lockDefault)
              Text(l10n.enabledLockedSelf, style: theme.textTheme.muted),
          ],
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final first = _first.text.trim();
    final last = _last.text.trim();
    final email = _email.text.trim();
    final phone = _phone.text.trim();
    final password = _password.text;
    if (first.isEmpty || last.isEmpty || email.isEmpty || phone.isEmpty) {
      setState(() => _errorKey = 'errorInvalidInput');
      return;
    }
    if (!_editing && password.trim().length < 8) {
      setState(() => _errorKey = 'errorPasswordTooWeak');
      return;
    }
    if (_editing && password.isNotEmpty && password.trim().length < 8) {
      setState(() => _errorKey = 'errorPasswordTooWeak');
      return;
    }

    setState(() {
      _saving = true;
      _errorKey = null;
    });
    final notifier = ref.read(usersViewModelProvider.notifier);
    final errorKey = _editing
        ? await notifier.save(
            id: widget.user!.id,
            email: email,
            phoneNumber: phone,
            firstName: first,
            lastName: last,
            isEnabled: _enabled,
            password: password.trim().isEmpty ? null : password,
          )
        : await notifier.create(
            email: email,
            password: password,
            phoneNumber: phone,
            firstName: first,
            lastName: last,
          );
    if (!mounted) {
      return;
    }
    if (errorKey == null) {
      Navigator.of(context).pop();
      return;
    }
    setState(() {
      _saving = false;
      _errorKey = errorKey;
    });
  }
}
