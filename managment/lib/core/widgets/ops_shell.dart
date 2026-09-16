import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/view_models/auth_view_model.dart';
import '../../l10n/generated/app_localizations.dart';
import '../di/app_providers.dart';
import '../di/theme_controller.dart';
import '../routing/app_routes.dart';
import '../theme/app_tokens.dart';
import 'app_controls.dart';

/// Persistent operations chrome: slate rail on wide screens, drawer on compact.
class OpsShell extends ConsumerWidget {
  const OpsShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= AppBreakpoints.expanded;
        if (wide) {
          return Scaffold(
            body: Row(
              children: [
                const OpsSideBar(),
                Expanded(child: child),
              ],
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.appTitle),
            actions: const [_ThemeToggle(), LocaleMenuButton()],
          ),
          drawer: const Drawer(child: OpsSideBar(inDrawer: true)),
          body: child,
        );
      },
    );
  }
}

/// Brand + destinations used by the rail and the compact drawer.
class OpsSideBar extends ConsumerWidget {
  const OpsSideBar({super.key, this.inDrawer = false});

  final bool inDrawer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final session = ref.watch(authViewModelProvider).session;
    final selected = ref.watch(buildingSelectionProvider);
    final locked = selected == null;
    final location = GoRouterState.of(context).uri.path;
    final productsOpen =
        location.startsWith('/products') ||
        location == const ArticlesRoute().location ||
        location == const IngredientsRoute().location;

    return ColoredBox(
      color: scheme.surfaceContainerHigh,
      child: SafeArea(
        child: SizedBox(
          width: inDrawer ? null : 272,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.appTitle,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: scheme.onSurface),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.opsRailTagline,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    if (selected != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        selected.name,
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(color: scheme.primary),
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                  children: [
                    _NavTile(
                      icon: Icons.storefront_outlined,
                      label: l10n.navBuildings,
                      selected: location.startsWith('/buildings'),
                      onTap: () => const BuildingsRoute().go(context),
                    ),
                    _NavTile(
                      icon: Icons.grid_view_rounded,
                      label: l10n.navDashboard,
                      selected: location == const DashboardRoute().location,
                      onTap: locked
                          ? null
                          : () => const DashboardRoute().go(context),
                    ),
                    _NavTile(
                      icon: Icons.person_outline,
                      label: l10n.navProfile,
                      selected: location == const ProfileRoute().location,
                      onTap: locked
                          ? null
                          : () => const ProfileRoute().go(context),
                    ),
                    _NavTile(
                      icon: Icons.groups_outlined,
                      label: l10n.navEmployees,
                      selected: location.startsWith('/employees'),
                      onTap: locked
                          ? null
                          : () => const EmployeesRoute().go(context),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        expansionTileTheme: ExpansionTileThemeData(
                          iconColor: scheme.onSurface,
                          collapsedIconColor: scheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                          textColor: scheme.onSurface,
                          collapsedTextColor: scheme.onSurface,
                        ),
                      ),
                      child: ExpansionTile(
                        key: ValueKey(productsOpen),
                        initiallyExpanded: productsOpen,
                        leading: Icon(
                          Icons.inventory_2_outlined,
                          color: scheme.onSurface,
                        ),
                        title: Text(
                          l10n.navProducts,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(color: scheme.onSurface),
                        ),
                        children: [
                          _NavTile(
                            icon: Icons.restaurant_menu_outlined,
                            label: l10n.navArticles,
                            indent: true,
                            selected:
                                location == const ArticlesRoute().location,
                            onTap: locked
                                ? null
                                : () => const ArticlesRoute().go(context),
                          ),
                          _NavTile(
                            icon: Icons.science_outlined,
                            label: l10n.navIngredients,
                            indent: true,
                            selected:
                                location == const IngredientsRoute().location,
                            onTap: locked
                                ? null
                                : () => const IngredientsRoute().go(context),
                          ),
                        ],
                      ),
                    ),
                    _NavTile(
                      icon: Icons.point_of_sale_outlined,
                      label: l10n.navPos,
                      selected: location == const PosRoute().location,
                      onTap: locked ? null : () => const PosRoute().go(context),
                    ),
                    _NavTile(
                      icon: Icons.table_restaurant_outlined,
                      label: l10n.navTables,
                      selected: location == const TablesRoute().location,
                      onTap: locked
                          ? null
                          : () => const TablesRoute().go(context),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: IconTheme(
                  data: IconThemeData(color: scheme.onSurface),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!inDrawer)
                        Row(
                          children: [
                            const _ThemeToggle(),
                            const LocaleMenuButton(),
                            const Spacer(),
                            IconButton(
                              tooltip: l10n.signOut,
                              onPressed: () => ref
                                  .read(authViewModelProvider.notifier)
                                  .signOut(),
                              icon: Icon(Icons.logout, color: scheme.onSurface),
                            ),
                          ],
                        ),
                      if (inDrawer)
                        ListTile(
                          leading: Icon(Icons.logout, color: scheme.onSurface),
                          title: Text(
                            l10n.signOut,
                            style: TextStyle(color: scheme.onSurface),
                          ),
                          onTap: () => ref
                              .read(authViewModelProvider.notifier)
                              .signOut(),
                        ),
                      const SizedBox(height: AppSpacing.sm),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: scheme.onSurface.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(AppRadii.md),
                        ),
                        child: ListTile(
                          onTap: locked
                              ? null
                              : () => const ProfileRoute().go(context),
                          leading: CircleAvatar(
                            backgroundColor: scheme.secondary,
                            foregroundColor: scheme.onSecondary,
                            child: Text(
                              (session?.profile.firstName.isNotEmpty ?? false)
                                  ? session!.profile.firstName.characters.first
                                  : '?',
                            ),
                          ),
                          title: Text(
                            '${session?.profile.firstName ?? ''} ${session?.profile.lastName ?? ''}'
                                .trim(),
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(color: scheme.onSurface),
                          ),
                          subtitle: Text(
                            (session?.profile.roles.contains('employee') ??
                                    false)
                                ? (session?.profile.username ?? '')
                                : (session?.profile.email ?? ''),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: scheme.onSurface.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ],
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

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.indent = false,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final bool indent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = selected ? scheme.primary : scheme.onSurface;
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: indent ? AppSpacing.lg : 0,
        bottom: AppSpacing.xs,
      ),
      child: Material(
        color: selected ? scheme.primaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadii.sm),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.sm),
          child: Opacity(
            opacity: onTap == null ? 0.38 : 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              child: Row(
                children: [
                  Icon(icon, color: fg, size: 22),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: fg,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
