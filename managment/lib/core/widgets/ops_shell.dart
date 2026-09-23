import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../features/auth/view_models/auth_view_model.dart';
import '../../features/orders/view_models/order_draft_view_model.dart';
import '../../l10n/generated/app_localizations.dart';
import '../di/app_providers.dart';
import '../di/building_session.dart';
import '../di/service_locator.dart';
import '../di/theme_controller.dart';
import '../routing/app_routes.dart';
import '../theme/app_tokens.dart';
import 'app_controls.dart';

/// Persistent operations chrome: slate rail on wide screens; app bar, drawer,
/// bottom nav (dashboard / tables / orders), and order FAB on compact.
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
  /// Cancels an in-flight hydrate when the route building changes.
  Object? _hydrateToken;

  /// Id currently being fetched — prevents duplicate [building.get] calls.
  UuidValue? _hydratingId;

  /// Last primary tab while visiting drawer-only screens (employees, products…).
  var _lastBottomIndex = 0;

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

  /// Keeps [BuildingSession] aligned with `/b/:buildingId/...`.
  ///
  /// On browser refresh / employee login the session may only have the route id
  /// — load full details once via [BuildingRepository.get].
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
    if (session.selected != null) {
      return;
    }
    if (_hydratingId == id) {
      return;
    }
    final token = Object();
    _hydrateToken = token;
    _hydratingId = id;
    Future<void>(() async {
      try {
        final building = await ref.read(buildingRepositoryProvider).get(id);
        if (!mounted || !identical(_hydrateToken, token)) {
          return;
        }
        if (widget.buildingId != raw) {
          return;
        }
        session.upsert(building);
        session.select(building.id);
      } catch (_) {
        // Leave selection as id-only; screens degrade until user re-picks.
      } finally {
        if (identical(_hydrateToken, token)) {
          _hydrateToken = null;
          _hydratingId = null;
        }
      }
    });
  }

  int? _bottomIndexFor(String location, {required bool isEmployee}) {
    if (isEmployee) {
      if (location.contains('/orders')) {
        return 2;
      }
      if (location.contains('/tables/scan')) {
        return 1;
      }
      if (location.endsWith('/tables') || location.contains('/tables/')) {
        return 0;
      }
      return null;
    }
    if (location.contains('/orders')) {
      return 2;
    }
    if (location.endsWith('/tables')) {
      return 1;
    }
    if (location.endsWith('/dashboard')) {
      return 0;
    }
    return null;
  }

  void _onBottomNavSelected(
    String buildingId,
    int index, {
    required bool isEmployee,
  }) {
    setState(() => _lastBottomIndex = index);
    if (isEmployee) {
      switch (index) {
        case 0:
          TablesRoute(buildingId: buildingId).go(context);
        case 1:
          TableQrScanRoute(buildingId: buildingId).go(context);
        case 2:
          OrdersRoute(buildingId: buildingId).go(context);
        default:
          break;
      }
      return;
    }
    switch (index) {
      case 0:
        DashboardRoute(buildingId: buildingId).go(context);
      case 1:
        TablesRoute(buildingId: buildingId).go(context);
      case 2:
        OrdersRoute(buildingId: buildingId).go(context);
      default:
        break;
    }
  }

  void _onFabPressed(String buildingId, String location, bool hasDraft) {
    final draft = ref.read(orderDraftViewModelProvider(buildingId).notifier);
    if (hasDraft) {
      draft.clear();
      if (location.contains('/orders/new')) {
        TablesRoute(buildingId: buildingId).go(context);
      }
      return;
    }
    draft.beginCreate();
    TablesRoute(buildingId: buildingId).go(context);
  }

  /// Article picker, order detail, or QR scan — focused flows that own chrome.
  bool _isImmersiveOrderScreen(String location) =>
      RegExp(r'/orders/[^/]+').hasMatch(location) ||
      location.contains('/tables/scan');

  Widget? _buildFab({
    required String buildingId,
    required String location,
    required AppLocalizations l10n,
    required ColorScheme scheme,
    required OrderDraftState draft,
    required bool isEmployee,
    required bool compactFab,
  }) {
    // Employees start orders by tapping a table on the floor map.
    if (buildingId.isEmpty || isEmployee || _isImmersiveOrderScreen(location)) {
      return null;
    }
    // Toggle: start table pick, or cancel pick while still on the floor map.
    if (draft.pickingTable) {
      if (compactFab) {
        return FloatingActionButton(
          backgroundColor: scheme.error,
          foregroundColor: scheme.onError,
          tooltip: l10n.cancelOrderDraft,
          onPressed: () => _onFabPressed(buildingId, location, true),
          child: const Icon(Icons.close),
        );
      }
      return FloatingActionButton.extended(
        backgroundColor: scheme.error,
        foregroundColor: scheme.onError,
        onPressed: () => _onFabPressed(buildingId, location, true),
        icon: const Icon(Icons.close),
        label: AppButtonLabel(l10n.cancelOrderDraft),
      );
    }
    if (compactFab) {
      return FloatingActionButton(
        tooltip: l10n.newOrder,
        onPressed: () => _onFabPressed(buildingId, location, false),
        child: const Icon(Icons.add),
      );
    }
    return FloatingActionButton.extended(
      onPressed: () => _onFabPressed(buildingId, location, false),
      icon: const Icon(Icons.add),
      label: AppButtonLabel(l10n.newOrder),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= AppBreakpoints.expanded;
        final compactFab = constraints.maxWidth < 420;
        final buildingId = widget.buildingId ?? '';
        final location = GoRouterState.of(context).uri.path;
        final l10n = AppLocalizations.of(context)!;
        final scheme = Theme.of(context).colorScheme;
        final isEmployee = ref.watch(appSessionStoreProvider).isEmployee;
        final draft = buildingId.isEmpty
            ? const OrderDraftState()
            : ref.watch(orderDraftViewModelProvider(buildingId));
        final fab = _buildFab(
          buildingId: buildingId,
          location: location,
          l10n: l10n,
          scheme: scheme,
          draft: draft,
          isEmployee: isEmployee,
          compactFab: compactFab,
        );

        if (wide) {
          return Scaffold(
            floatingActionButton: fab,
            body: Row(
              children: [
                OpsSideBar(buildingId: buildingId),
                Expanded(child: widget.child),
              ],
            ),
          );
        }

        final routeIndex = _bottomIndexFor(location, isEmployee: isEmployee);
        final bottomIndex = routeIndex ?? _lastBottomIndex;
        // Article picker / order detail / QR scan: drop shell chrome so the
        // screen's own AppBar owns the viewport (FAB already hidden via [_buildFab]).
        final immersiveOrderScreen = _isImmersiveOrderScreen(location);

        return Scaffold(
          appBar: immersiveOrderScreen
              ? null
              : AppBar(
                  title: Text(l10n.appTitle),
                  actions: const [_ThemeToggle(), LocaleMenuButton()],
                ),
          drawer: immersiveOrderScreen
              ? null
              : Drawer(
                  child: OpsSideBar(buildingId: buildingId, inDrawer: true),
                ),
          floatingActionButton: fab,
          bottomNavigationBar: immersiveOrderScreen
              ? null
              : NavigationBar(
                  selectedIndex: bottomIndex.clamp(0, 2),
                  onDestinationSelected: (index) => _onBottomNavSelected(
                    buildingId,
                    index,
                    isEmployee: isEmployee,
                  ),
                  destinations: isEmployee
                      ? [
                          NavigationDestination(
                            icon: const Icon(Icons.table_restaurant_outlined),
                            selectedIcon: const Icon(Icons.table_restaurant),
                            label: l10n.navTables,
                          ),
                          NavigationDestination(
                            icon: const Icon(Icons.qr_code_scanner_outlined),
                            selectedIcon: const Icon(Icons.qr_code_scanner),
                            label: l10n.navScanTable,
                          ),
                          NavigationDestination(
                            icon: const Icon(Icons.receipt_long_outlined),
                            selectedIcon: const Icon(Icons.receipt_long),
                            label: l10n.navOrders,
                          ),
                        ]
                      : [
                          NavigationDestination(
                            icon: const Icon(Icons.grid_view_outlined),
                            selectedIcon: const Icon(Icons.grid_view_rounded),
                            label: l10n.navDashboard,
                          ),
                          NavigationDestination(
                            icon: const Icon(Icons.table_restaurant_outlined),
                            selectedIcon: const Icon(Icons.table_restaurant),
                            label: l10n.navTables,
                          ),
                          NavigationDestination(
                            icon: const Icon(Icons.receipt_long_outlined),
                            selectedIcon: const Icon(Icons.receipt_long),
                            label: l10n.navOrders,
                          ),
                        ],
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
    final isEmployee = store.isEmployee;
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

    // Material (not ColoredBox): ExpansionTile/ListTile ink must paint on a
    // Material ancestor without an intervening opaque ColoredBox.
    return Material(
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
                    if (isOwner)
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
                      icon: Icons.receipt_long_outlined,
                      label: l10n.navOrders,
                      selected: location.contains('/orders'),
                      onTap: () =>
                          OrdersRoute(buildingId: buildingId).go(context),
                    ),
                    _NavTile(
                      icon: Icons.table_restaurant_outlined,
                      label: l10n.navTables,
                      selected:
                          location.endsWith('/tables') ||
                          (location.contains('/tables/') &&
                              !location.contains('/tables/scan')),
                      onTap: () =>
                          TablesRoute(buildingId: buildingId).go(context),
                    ),
                    if (isEmployee)
                      _NavTile(
                        icon: Icons.qr_code_scanner_outlined,
                        label: l10n.navScanTable,
                        selected: location.contains('/tables/scan'),
                        onTap: () => TableQrScanRoute(
                          buildingId: buildingId,
                        ).go(context),
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
                        Material(
                          type: MaterialType.transparency,
                          child: ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: scheme.onSurface,
                            ),
                            title: Text(
                              l10n.signOut,
                              style: TextStyle(color: scheme.onSurface),
                            ),
                            onTap: () => ref
                                .read(authViewModelProvider.notifier)
                                .signOut(),
                          ),
                        ),
                      const SizedBox(height: AppSpacing.sm),
                      Material(
                        color: scheme.onSurface.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(AppRadii.md),
                        clipBehavior: Clip.antiAlias,
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
