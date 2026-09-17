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
  List<SuperAdminView> _users = [];
  String? _errorKey;
  bool _loading = true;
  bool _saving = false;

  final _email = TextEditingController();
  final _password = TextEditingController();
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
    _phone.dispose();
    _first.dispose();
    _last.dispose();
    super.dispose();
  }

  Future<void> _reload() async {
    try {
      final list = await ref.read(superAdminAuthRepositoryProvider).list();
      setState(() {
        _users = list;
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
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
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
                      l10n.welcome(session?.firstName ?? ''),
                      style: text.headlineMedium,
                    ),
                    if (_errorKey != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      AppErrorBanner(message: lookupError(l10n, _errorKey!)),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth >= AppBreakpoints.expanded;
                  final staff = AppSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.staff, style: text.titleLarge),
                        const SizedBox(height: AppSpacing.md),
                        if (_loading) const LinearProgressIndicator(),
                        if (!_loading && _users.isEmpty)
                          Text(l10n.empty, style: text.bodyMedium),
                        for (final user in _users)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundColor: scheme.secondaryContainer,
                              foregroundColor: scheme.onSecondaryContainer,
                              child: Text(
                                user.firstName.isEmpty
                                    ? '?'
                                    : user.firstName.characters.first,
                              ),
                            ),
                            title: Text('${user.firstName} ${user.lastName}'),
                            subtitle: Text(
                              [
                                user.email,
                                if (user.isSystemDefault) l10n.defaultAdminFlag,
                              ].join(' · '),
                            ),
                            trailing: !user.isSystemDefault
                                ? IconButton(
                                    icon: const Icon(Icons.delete_outline),
                                    onPressed: () async {
                                      try {
                                        await ref
                                            .read(
                                              superAdminAuthRepositoryProvider,
                                            )
                                            .delete(user.id);
                                        await _reload();
                                      } catch (error) {
                                        setState(
                                          () => _errorKey = mapError(
                                            error,
                                          ).l10nKey,
                                        );
                                      }
                                    },
                                  )
                                : null,
                          ),
                      ],
                    ),
                  );
                  final form = AppSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(l10n.addStaff, style: text.titleLarge),
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
                        AppFilledButton(
                          label: l10n.addStaff,
                          busy: _saving,
                          onPressed: () async {
                            setState(() => _saving = true);
                            try {
                              await ref
                                  .read(superAdminAuthRepositoryProvider)
                                  .add(
                                    email: _email.text,
                                    password: _password.text,
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
                  if (wide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: staff),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(child: form),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      staff,
                      const SizedBox(height: AppSpacing.lg),
                      form,
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
