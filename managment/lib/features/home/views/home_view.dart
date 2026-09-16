import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/di/app_providers.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          TextButton(
            onPressed: () => ref.read(authViewModelProvider.notifier).signOut(),
            child: Text(l10n.signOut),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        children: [
          Text(
            l10n.welcome(session?.profile.firstName ?? ''),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final role in session?.profile.roles ?? const <String>[])
                Chip(label: Text(role)),
            ],
          ),
          if (isOwner) ...[
            const SizedBox(height: AppSpacing.xl),
            Text(
              l10n.addEmployee,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            AppTextField(controller: _first, label: l10n.firstName),
            AppTextField(controller: _last, label: l10n.lastName),
            AppTextField(controller: _username, label: l10n.username),
            AppTextField(controller: _email, label: l10n.email),
            AppTextField(controller: _phone, label: l10n.phone),
            AppTextField(
              controller: _password,
              label: l10n.password,
              obscure: true,
            ),
            if (_errorKey != null)
              Text(
                lookupError(l10n, _errorKey!),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            AppFilledButton(
              label: l10n.addEmployee,
              busy: _loading,
              onPressed: () async {
                setState(() => _loading = true);
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
                  await _reload();
                } catch (error) {
                  setState(() {
                    _loading = false;
                    _errorKey = mapError(error).l10nKey;
                  });
                }
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(l10n.employees, style: Theme.of(context).textTheme.titleLarge),
            if (_employees.isEmpty) Text(l10n.empty),
            for (final employee in _employees)
              ListTile(
                title: Text('${employee.firstName} ${employee.lastName}'),
                subtitle: Text(employee.email),
              ),
          ],
        ],
      ),
    );
  }
}
