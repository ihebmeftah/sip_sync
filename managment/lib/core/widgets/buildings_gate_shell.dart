import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/view_models/auth_view_model.dart';
import '../../l10n/generated/app_localizations.dart';
import '../di/theme_controller.dart';
import 'app_controls.dart';

/// Minimal chrome for the buildings gate (list / create / edit) — no ops sidebar.
class BuildingsGateShell extends ConsumerWidget {
  const BuildingsGateShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navBuildings),
        actions: [
          const _ThemeToggle(),
          const LocaleMenuButton(),
          IconButton(
            tooltip: l10n.signOut,
            onPressed: () => ref.read(authViewModelProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: child,
    );
  }
}

class _ThemeToggle extends ConsumerWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final mode = ref.watch(themeControllerProvider);
    final dark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      tooltip: dark ? l10n.themeLight : l10n.themeDark,
      onPressed: () {
        ref
            .read(themeControllerProvider.notifier)
            .setMode(dark ? ThemeMode.light : ThemeMode.dark);
      },
      icon: Icon(
        mode == ThemeMode.dark || dark
            ? Icons.light_mode_outlined
            : Icons.dark_mode_outlined,
      ),
    );
  }
}
