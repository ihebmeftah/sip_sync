import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/view_models/auth_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  List<ProfileView> _employees = [];
  String? _errorKey;
  bool _loading = true;
  bool _saving = false;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _username = TextEditingController();
  final _phone = TextEditingController();
  final _first = TextEditingController();
  final _last = TextEditingController();

  @override
  void initState() {
    super.initState();
    _reload();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    _phone.dispose();
    _first.dispose();
    _last.dispose();
    super.dispose();
  }

  Future<void> _reload() async {
    final session = ref.read(authViewModelProvider).session;
    final isOwner = session?.profile.roles.contains('owner') ?? false;
    if (!isOwner) {
      setState(() => _loading = false);
      return;
    }
    try {
      final list = await ref.read(accountRepositoryProvider).listEmployees();
      setState(() {
        _employees = list;
        _loading = false;
        _errorKey = null;
      });
    } catch (error) {
      setState(() {
        _loading = false;
        _errorKey = mapError(error).l10nKey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final session = ref.watch(authViewModelProvider).session;
    final isOwner = session?.profile.roles.contains('owner') ?? false;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          const LocaleMenuButton(),
          TextButton(
            onPressed: () => ref.read(authViewModelProvider.notifier).signOut(),
            child: Text(l10n.signOut),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              AppSurfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.welcome(session?.profile.firstName ?? ''),
                      style: text.headlineMedium,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final role
                            in session?.profile.roles ?? const <String>[])
                          Chip(label: Text(role)),
                      ],
                    ),
                  ],
                ),
              ),
              if (isOwner) ...[
                const SizedBox(height: AppSpacing.xl),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final wide =
                        constraints.maxWidth >= AppBreakpoints.expanded;
                    final form = AppSurfaceCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(l10n.addEmployee, style: text.titleLarge),
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
                            controller: _email,
                            label: l10n.email,
                            prefixIcon: Icons.mail_outline,
                          ),
                          AppTextField(
                            controller: _phone,
                            label: l10n.phone,
                            prefixIcon: Icons.phone_outlined,
                          ),
                          AppTextField(
                            controller: _password,
                            label: l10n.password,
                            obscure: true,
                            prefixIcon: Icons.lock_outline,
                          ),
                          if (_errorKey != null)
                            AppErrorBanner(
                              message: lookupError(l10n, _errorKey!),
                            ),
                          AppFilledButton(
                            label: l10n.addEmployee,
                            busy: _saving,
                            onPressed: () async {
                              setState(() => _saving = true);
                              try {
                                await ref
                                    .read(accountRepositoryProvider)
                                    .addEmployee(
                                      email: _email.text,
                                      password: _password.text,
                                      username: _username.text,
                                      phoneNumber: _phone.text,
                                      firstName: _first.text,
                                      lastName: _last.text,
                                    );
                                setState(() => _saving = false);
                                await _reload();
                              } catch (error) {
                                setState(() {
                                  _saving = false;
                                  _errorKey = mapError(error).l10nKey;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    );
                    final team = AppSurfaceCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.employees, style: text.titleLarge),
                          const SizedBox(height: AppSpacing.md),
                          if (_loading) const LinearProgressIndicator(),
                          if (!_loading && _employees.isEmpty)
                            Text(l10n.empty, style: text.bodyMedium),
                          for (final employee in _employees)
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
                              title: Text(
                                '${employee.firstName} ${employee.lastName}',
                              ),
                              subtitle: Text(employee.email),
                            ),
                        ],
                      ),
                    );
                    if (wide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: form),
                          const SizedBox(width: AppSpacing.lg),
                          Expanded(child: team),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        form,
                        const SizedBox(height: AppSpacing.lg),
                        team,
                      ],
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
