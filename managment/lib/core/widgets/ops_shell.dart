import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../features/auth/view_models/auth_view_model.dart';
import '../../l10n/generated/app_localizations.dart';
import '../di/app_providers.dart';
import '../di/building_session.dart';
import '../di/service_locator.dart';
import '../di/theme_controller.dart';
import '../routing/app_routes.dart';
import '../theme/app_tokens.dart';
import 'app_controls.dart';

/// Persistent operations chrome: slate rail on wide screens, drawer on compact.
///
/// Requires a [buildingId] path segment; the buildings gate has no sidebar.
class OpsShell extends ConsumerStatefulWidget {
  const OpsShell({super.key, required this.buildingId, required this.child});

  final String? buildingId;
  final Widget child;

  @override
  ConsumerState<OpsShell> createState() => _OpsShellState();
}

class _OpsShellState extends ConsumerState<OpsShell> {
  @override
  void initState() {
    super.initState();
    _syncBuilding();
  }

  @override
  void didUpdateWidget(covariant OpsShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.buildingId != widget.buildingId) {
      _syncBuilding();
    }
  }

  void _syncBuilding() {
    final raw = widget.buildingId;
    if (raw == null || raw.isEmpty) {
      return;
    }
    final id = UuidValue.fromString(raw);
    final session = getIt<BuildingSession>();
    if (session.selectedId != id) {
      session.select(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= AppBreakpoints.expanded;
        if (wide) {
          return Scaffold(
            body: Row(
              children: [
                OpsSideBar(buildingId: widget.buildingId ?? ''),
                Expanded(child: widget.child),
              ],
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.appTitle),
            actions: const [_ThemeToggle(), LocaleMenuButton()],
          ),
          drawer: Drawer(
            child: OpsSideBar(
              buildingId: widget.buildingId ?? '',
              inDrawer: true,
            ),
          ),
          body: widget.child,
        );
      },
    );
  }
}

/// Brand + destinations used by the rail and the compact drawer.
class OpsSideBar extends ConsumerWidget {
  const OpsSideBar({
    super.key,
    required this.buildingId,
    this.inDrawer = false,
  });

  final String buildingId;
  final bool inDrawer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final store = ref.watch(appSessionStoreProvider);
    final isOwner = store.isOwner;
    final firstName = store.owner?.firstName ?? store.employee?.firstName ?? '';
    final lastName = store.owner?.lastName ?? store.employee?.lastName ?? '';
    final subtitle = isOwner
        ? (store.owner?.email ?? '')
        : (store.employee?.username ?? '');
    final selected = ref.watch(buildingSelectionProvider);
    final location = GoRouterState.of(context).uri.path;
    final productsOpen =
        location.contains('/products/') ||
        location.endsWith('/products/articles') ||
        location.endsWith('/products/ingredients');

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
                    if (isOwner)
                      _NavTile(
                        icon: Icons.storefront_outlined,
                        label: l10n.navBuildings,
                        selected: false,
                        onTap: () => const BuildingsRoute().go(context),
                      ),
                    _NavTile(
                      icon: Icons.grid_view_rounded,
                      label: l10n.navDashboard,
                      selected: location.endsWith('/dashboard'),
                      onTap: () =>
                          DashboardRoute(buildingId: buildingId).go(context),
                    ),
                    if (isOwner)
                      _NavTile(
                        icon: Icons.groups_outlined,
                        label: l10n.navEmployees,
                        selected: location.contains('/employees'),
                        onTap: () =>
                            EmployeesRoute(buildingId: buildingId).go(context),
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
                            icon: Icons.category_outlined,
                            label: l10n.navCategories,
                            indent: true,
                            selected: location.endsWith('/products/categories'),
                            onTap: () => CategoriesRoute(
                              buildingId: buildingId,
                            ).go(context),
                          ),
                          _NavTile(
                            icon: Icons.restaurant_menu_outlined,
                            label: l10n.navArticles,
                            indent: true,
                            selected: location.endsWith('/products/articles'),
                            onTap: () => ArticlesRoute(
                              buildingId: buildingId,
                            ).go(context),
                          ),
                          _NavTile(
                            icon: Icons.science_outlined,
                            label: l10n.navIngredients,
                            indent: true,
                            selected: location.endsWith(
                              '/products/ingredients',
                            ),
                            onTap: () => IngredientsRoute(
                              buildingId: buildingId,
                            ).go(context),
                          ),
                        ],
                      ),
                    ),
                    _NavTile(
                      icon: Icons.point_of_sale_outlined,
                      label: l10n.navPos,
                      selected: location.endsWith('/pos'),
                      onTap: () => PosRoute(buildingId: buildingId).go(context),
                    ),
                    _NavTile(
                      icon: Icons.table_restaurant_outlined,
                      label: l10n.navTables,
                      selected: location.endsWith('/tables'),
                      onTap: () =>
                          TablesRoute(buildingId: buildingId).go(context),
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
                          onTap: () =>
                              ProfileRoute(buildingId: buildingId).go(context),
                          leading: CircleAvatar(
                            backgroundColor: scheme.secondary,
                            foregroundColor: scheme.onSecondary,
                            child: Text(
                              firstName.isNotEmpty
                                  ? firstName.characters.first
                                  : '?',
                            ),
                          ),
                          title: Text(
                            '$firstName $lastName'.trim(),
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(color: scheme.onSurface),
                          ),
                          subtitle: Text(
                            subtitle,
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
