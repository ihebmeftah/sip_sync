import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../view_models/profile_view_model.dart';

class ProfileViewPage extends ConsumerStatefulWidget {
  const ProfileViewPage({super.key});

  @override
  ConsumerState<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends ConsumerState<ProfileViewPage> {
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _phone = TextEditingController();
  final _first = TextEditingController();
  final _last = TextEditingController();

  final _empEmail = TextEditingController();
  final _empPassword = TextEditingController();
  final _empUsername = TextEditingController();
  final _empPhone = TextEditingController();
  final _empFirst = TextEditingController();
  final _empLast = TextEditingController();

  var _filled = false;

  @override
  void dispose() {
    _email.dispose();
    _username.dispose();
    _phone.dispose();
    _first.dispose();
    _last.dispose();
    _empEmail.dispose();
    _empPassword.dispose();
    _empUsername.dispose();
    _empPhone.dispose();
    _empFirst.dispose();
    _empLast.dispose();
    super.dispose();
  }

  void _fillFromSession() {
    final profile = ref.read(authViewModelProvider).session?.profile;
    if (profile == null || _filled) {
      return;
    }
    _email.text = profile.email;
    _username.text = profile.username;
    _phone.text = profile.phoneNumber;
    _first.text = profile.firstName;
    _last.text = profile.lastName;
    _filled = true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final auth = ref.watch(authViewModelProvider);
    final ui = ref.watch(profileViewModelProvider);
    final isOwner = ref.read(profileViewModelProvider.notifier).isOwner;
    final text = Theme.of(context).textTheme;
    _fillFromSession();

    final mine = AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.myProfile, style: text.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.profileHint, style: text.bodyMedium),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: _first,
            label: l10n.firstName,
            prefixIcon: Icons.person_outline,
          ),
          AppTextField(
            controller: _last,
            label: l10n.lastName,
            prefixIcon: Icons.badge_outlined,
          ),
          AppTextField(
            controller: _username,
            label: l10n.username,
            prefixIcon: Icons.alternate_email,
          ),
          AppTextField(
            controller: _phone,
            label: l10n.phone,
            prefixIcon: Icons.phone_outlined,
          ),
          AppTextField(
            controller: _email,
            label: l10n.email,
            readOnly: true,
            helperText: l10n.emailLocked,
            prefixIcon: Icons.mail_outline,
          ),
          if (ui.errorKey != null)
            AppErrorBanner(message: lookupError(l10n, ui.errorKey!)),
          if (ui.saved) AppSuccessBanner(message: l10n.profileSaved),
          AppFilledButton(
            label: l10n.saveProfile,
            busy: ui.saving,
            onPressed: () => ref
                .read(profileViewModelProvider.notifier)
                .save(
                  username: _username.text,
                  phoneNumber: _phone.text,
                  firstName: _first.text,
                  lastName: _last.text,
                ),
          ),
        ],
      ),
    );

    final team = AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.teamProfiles, style: text.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          if (ui.loadingTeam) const LinearProgressIndicator(),
          if (!ui.loadingTeam && ui.employees.isEmpty)
            Text(l10n.empty, style: text.bodyMedium),
          for (final employee in ui.employees)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer,
                child: Text(
                  employee.firstName.isEmpty
                      ? '?'
                      : employee.firstName.characters.first,
                ),
              ),
              title: Text('${employee.firstName} ${employee.lastName}'),
              subtitle: Text(employee.email),
              trailing: Text(l10n.viewProfile),
              onTap: () => EmployeeProfileRoute(
                authUserId: employee.authUserId.uuid,
              ).go(context),
            ),
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.addEmployee, style: text.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: _empFirst,
            label: l10n.firstName,
            prefixIcon: Icons.person_outline,
          ),
          AppTextField(
            controller: _empLast,
            label: l10n.lastName,
            prefixIcon: Icons.badge_outlined,
          ),
          AppTextField(
            controller: _empUsername,
            label: l10n.username,
            prefixIcon: Icons.alternate_email,
          ),
          AppTextField(
            controller: _empEmail,
            label: l10n.email,
            prefixIcon: Icons.mail_outline,
          ),
          AppTextField(
            controller: _empPhone,
            label: l10n.phone,
            prefixIcon: Icons.phone_outlined,
          ),
          AppTextField(
            controller: _empPassword,
            label: l10n.password,
            obscure: true,
            prefixIcon: Icons.lock_outline,
          ),
          AppFilledButton(
            label: l10n.addEmployee,
            busy: ui.adding,
            onPressed: () async {
              final ok = await ref
                  .read(profileViewModelProvider.notifier)
                  .addEmployee(
                    email: _empEmail.text,
                    password: _empPassword.text,
                    username: _empUsername.text,
                    phoneNumber: _empPhone.text,
                    firstName: _empFirst.text,
                    lastName: _empLast.text,
                  );
              if (ok) {
                _empEmail.clear();
                _empPassword.clear();
                _empUsername.clear();
                _empPhone.clear();
                _empFirst.clear();
                _empLast.clear();
              }
            },
          ),
        ],
      ),
    );

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              if (auth.isLoading && auth.session == null)
                const LinearProgressIndicator(),
              LayoutBuilder(
                builder: (context, constraints) {
                  final wide =
                      constraints.maxWidth >= AppBreakpoints.expanded &&
                      isOwner;
                  if (wide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: mine),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(child: team),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      mine,
                      if (isOwner) ...[
                        const SizedBox(height: AppSpacing.lg),
                        team,
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
