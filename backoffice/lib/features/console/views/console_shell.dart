import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/view_models/auth_view_model.dart';

/// Graphite rail for the signed-in console. Child routes fill the page.
class ConsoleShell extends ConsumerWidget {
  const ConsoleShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= AppBreakpoints.expanded;
        if (wide) {
          return Scaffold(
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(width: 248, child: _ConsoleNav()),
                Expanded(child: child),
              ],
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.appTitle),
            actions: const [LocaleMenuButton()],
          ),
          drawer: Drawer(
            child: Builder(
              builder: (drawerContext) => _ConsoleNav(
                onNavigate: () => Navigator.of(drawerContext).pop(),
              ),
            ),
          ),
          body: child,
        );
      },
    );
  }
}

class _ConsoleNav extends ConsumerWidget {
  const _ConsoleNav({this.onNavigate});

  final VoidCallback? onNavigate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final path = GoRouterState.of(context).uri.path;
    final session = ref.watch(authViewModelProvider).session;
    final name = session == null
        ? ''
        : '${session.firstName} ${session.lastName}'.trim();

    return ColoredBox(
      color: scheme.inverseSurface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.xl,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.appTitle,
                style: text.titleLarge?.copyWith(
                  color: scheme.onInverseSurface,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                name,
                style: text.bodyMedium?.copyWith(
                  color: scheme.onInverseSurface.withValues(alpha: 0.72),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              _NavButton(
                icon: Icons.people_outline,
                label: l10n.navUsers,
                selected: path.startsWith('/users'),
                onPressed: () {
                  onNavigate?.call();
                  const UsersRoute().go(context);
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              _NavButton(
                icon: Icons.storefront_outlined,
                label: l10n.navBuildings,
                selected: path.startsWith('/buildings'),
                onPressed: () {
                  onNavigate?.call();
                  const BuildingsRoute().go(context);
                },
              ),
              const Spacer(),
              const LocaleSwitcher(),
              const SizedBox(height: AppSpacing.md),
              TextButton.icon(
                onPressed: () =>
                    ref.read(authViewModelProvider.notifier).signOut(),
                icon: Icon(Icons.logout, color: scheme.inversePrimary),
                label: Text(
                  l10n.signOut,
                  style: text.labelLarge?.copyWith(
                    color: scheme.onInverseSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final foreground = selected
        ? scheme.inversePrimary
        : scheme.onInverseSurface;
    return Material(
      color: selected
          ? scheme.onInverseSurface.withValues(alpha: 0.08)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Icon(icon, color: foreground, size: 20),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: text.titleSmall?.copyWith(color: foreground),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shared page frame for console sections.
class ConsolePage extends StatelessWidget {
  const ConsolePage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.action,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: text.headlineMedium),
                      const SizedBox(height: AppSpacing.xs),
                      Text(subtitle, style: text.bodyMedium),
                    ],
                  ),
                ),
                if (action != null) ...[
                  const SizedBox(width: AppSpacing.lg),
                  action!,
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            child,
          ],
        ),
      ),
    );
  }
}
