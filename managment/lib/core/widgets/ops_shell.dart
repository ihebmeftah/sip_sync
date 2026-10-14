import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../features/auth/view_models/auth_view_model.dart';
import '../../features/notifications/view_models/notification_inbox_view_model.dart';
import '../../features/orders/view_models/order_draft_view_model.dart';
import '../../features/products/view_models/ingredients_view_model.dart';
import '../../features/reservations/view_models/reservations_view_model.dart';
import '../../l10n/generated/app_localizations.dart';
import '../access/floor_access.dart';
import '../di/app_providers.dart';
import '../di/building_session.dart';
import '../di/service_locator.dart';
import '../di/theme_controller.dart';
import '../routing/app_routes.dart';
import '../theme/app_tokens.dart';
import 'app_controls.dart';
import 'pack_banner.dart';
import 'pack_catalog_sheet.dart';
import 'pack_locked_action.dart';

Widget _upgradeIcon(
  IconData icon, {
  required bool upgrade,
  required AppLocalizations l10n,
  required ColorScheme scheme,
}) {
  final glyph = Icon(icon);
  if (!upgrade) {
    return glyph;
  }
  return Badge(
    label: Text(l10n.packUpgrade),
    backgroundColor: scheme.tertiary,
    textColor: scheme.onTertiary,
    child: glyph,
  );
}

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
    _scopeNotifications();
  }

  @override
  void didUpdateWidget(covariant OpsShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.buildingId != widget.buildingId) {
      _syncBuilding();
      _scopeNotifications();
    }
  }

  /// Bell and inbox follow the open venue. For an employee that id is the
  /// building they work in; the router does not let them open another.
  void _scopeNotifications() {
    final raw = widget.buildingId;
    if (raw == null || raw.isEmpty) {
      return;
    }
    final id = UuidValue.fromString(raw);
    Future<void>(() async {
      try {
        await ref.read(notificationInboxProvider.notifier).focusBuilding(id);
      } catch (_) {
        // The notifications screen surfaces the failure when it opens.
      }
    });
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

  int? _bottomIndexFor(
    String location, {
    required bool isEmployee,
    required bool employeeDashboard,
  }) {
    if (isEmployee && employeeDashboard) {
      if (location.endsWith('/dashboard')) {
        return 0;
      }
      if (location.contains('/tables/scan')) {
        return 2;
      }
      if (location.endsWith('/tables') || location.contains('/tables/')) {
        return 1;
      }
      if (location.contains('/orders')) {
        return 3;
      }
      return null;
    }
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
    required bool employeeDashboard,
    required bool scanLocked,
  }) {
    final scanIndex = isEmployee && employeeDashboard ? 2 : 1;
    if (isEmployee && index == scanIndex && scanLocked) {
      showPackCatalog(context);
      return;
    }
    setState(() => _lastBottomIndex = index);
    if (isEmployee && employeeDashboard) {
      switch (index) {
        case 0:
          DashboardRoute(buildingId: buildingId).go(context);
        case 1:
          TablesRoute(buildingId: buildingId).go(context);
        case 2:
          TableQrScanRoute(buildingId: buildingId).go(context);
        case 3:
          OrdersRoute(buildingId: buildingId).go(context);
        default:
          break;
      }
      return;
    }
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
        final store = ref.watch(appSessionStoreProvider);
        final isEmployee = store.isEmployee;
        final employeeDashboard =
            isEmployee && FloorAccess.fromSession(store).canConsultAll;
        final pendingReservations = buildingId.isEmpty
            ? 0
            : ref
                      .watch(pendingReservationCountProvider(buildingId))
                      .asData
                      ?.value ??
                  0;
        final scanLocked =
            ref.watch(buildingSelectionProvider)?.pack.tableQr == false;
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
                Expanded(
                  child: Column(
                    children: [
                      AppBar(
                        automaticallyImplyLeading: false,
                        title: Text(l10n.appTitle),
                        actions: [_NotificationButton(buildingId: buildingId)],
                      ),
                      Expanded(child: _withPackBanner(widget.child)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        final routeIndex = _bottomIndexFor(
          location,
          isEmployee: isEmployee,
          employeeDashboard: employeeDashboard,
        );
        final destinations = employeeDashboard
            ? [
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
                  icon: _upgradeIcon(
                    Icons.qr_code_scanner_outlined,
                    upgrade: scanLocked,
                    l10n: l10n,
                    scheme: scheme,
                  ),
                  selectedIcon: _upgradeIcon(
                    Icons.qr_code_scanner,
                    upgrade: scanLocked,
                    l10n: l10n,
                    scheme: scheme,
                  ),
                  label: l10n.navScanTable,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.receipt_long_outlined),
                  selectedIcon: const Icon(Icons.receipt_long),
                  label: l10n.navOrders,
                ),
              ]
            : isEmployee
            ? [
                NavigationDestination(
                  icon: const Icon(Icons.table_restaurant_outlined),
                  selectedIcon: const Icon(Icons.table_restaurant),
                  label: l10n.navTables,
                ),
                NavigationDestination(
                  icon: _upgradeIcon(
                    Icons.qr_code_scanner_outlined,
                    upgrade: scanLocked,
                    l10n: l10n,
                    scheme: scheme,
                  ),
                  selectedIcon: _upgradeIcon(
                    Icons.qr_code_scanner,
                    upgrade: scanLocked,
                    l10n: l10n,
                    scheme: scheme,
                  ),
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
              ];
        final rawIndex = routeIndex ?? _lastBottomIndex;
        final bottomIndex = rawIndex < 0
            ? 0
            : rawIndex >= destinations.length
            ? destinations.length - 1
            : rawIndex;
        // Article picker / order detail / QR scan: drop shell chrome so the
        // screen's own AppBar owns the viewport (FAB already hidden via [_buildFab]).
        final immersiveOrderScreen = _isImmersiveOrderScreen(location);

        return Scaffold(
          appBar: immersiveOrderScreen
              ? null
              : AppBar(
                  leading: Builder(
                    builder: (context) => IconButton(
                      tooltip: MaterialLocalizations.of(
                        context,
                      ).openAppDrawerTooltip,
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: Badge(
                        isLabelVisible: pendingReservations > 0,
                        label: Text(
                          pendingReservations > 99
                              ? '99+'
                              : '$pendingReservations',
                        ),
                        child: const Icon(Icons.menu),
                      ),
                    ),
                  ),
                  title: Text(l10n.appTitle),
                  actions: [_NotificationButton(buildingId: buildingId)],
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
                  selectedIndex: bottomIndex,
                  onDestinationSelected: (index) => _onBottomNavSelected(
                    buildingId,
                    index,
                    isEmployee: isEmployee,
                    employeeDashboard: employeeDashboard,
                    scanLocked: scanLocked,
                  ),
                  destinations: destinations,
                ),
          body: _withPackBanner(widget.child, show: !immersiveOrderScreen),
        );
      },
    );
  }

  Widget _withPackBanner(Widget child, {bool show = true}) {
    if (!show) {
      return child;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PackBanner(),
        Expanded(child: child),
      ],
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
    final canReserve = FloorAccess.fromSession(store).canManageReservations;
    final firstName = store.owner?.firstName ?? store.employee?.firstName ?? '';
    final lastName = store.owner?.lastName ?? store.employee?.lastName ?? '';
    final subtitle = isOwner
        ? (store.owner?.email ?? '')
        : (store.employee?.username ?? '');
    final selected = ref.watch(buildingSelectionProvider);
    final pendingReservations = buildingId.isEmpty
        ? 0
        : ref
                  .watch(pendingReservationCountProvider(buildingId))
                  .asData
                  ?.value ??
              0;
    final location = GoRouterState.of(context).uri.path;
    final outOfStock = buildingId.isEmpty
        ? 0
        : ref
                  .watch(outOfStockIngredientCountProvider(buildingId))
                  .asData
                  ?.value ??
              0;
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
                    Image.asset(
                      'assets/branding/logo.png',
                      height: 40,
                      fit: BoxFit.contain,
                      alignment: AlignmentDirectional.centerStart,
                      semanticLabel: l10n.appTitle,
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
                        icon: Icons.tune_outlined,
                        label: l10n.navConfiguration,
                        selected: location.endsWith('/configuration'),
                        onTap: () => BuildingConfigurationRoute(
                          buildingId: buildingId,
                        ).go(context),
                      ),
                    if (isOwner || FloorAccess.fromSession(store).canConsultAll)
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
                    _ProductsNav(
                      key: ValueKey(productsOpen),
                      initiallyExpanded: productsOpen,
                      label: l10n.navProducts,
                      badgeCount: outOfStock,
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
                          onTap: () =>
                              ArticlesRoute(buildingId: buildingId).go(context),
                        ),
                        _NavTile(
                          icon: Icons.science_outlined,
                          label: l10n.navIngredients,
                          badgeCount: outOfStock,
                          indent: true,
                          upgradeLocked: selected?.pack.inventory == false,
                          selected: location.endsWith('/products/ingredients'),
                          onTap: () {
                            if (selected?.pack.inventory == false) {
                              showPackCatalog(context, closeDrawer: inDrawer);
                              return;
                            }
                            ref
                                .read(
                                  ingredientListFilterProvider(
                                    buildingId,
                                  ).notifier,
                                )
                                .setOutOfStockOnly(false);
                            IngredientsRoute(
                              buildingId: buildingId,
                            ).go(context);
                          },
                        ),
                      ],
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
                    if (isOwner ||
                        FloorAccess.fromSession(store).canOperateRegister)
                      _NavTile(
                        icon: Icons.point_of_sale_outlined,
                        label: l10n.navCashRegister,
                        upgradeLocked: selected?.pack.cashRegister == false,
                        selected: location.contains('/cash-register'),
                        onTap: () {
                          if (selected?.pack.cashRegister == false) {
                            showPackCatalog(context, closeDrawer: inDrawer);
                            return;
                          }
                          CashRegisterRoute(buildingId: buildingId).go(context);
                        },
                      ),
                    if (canReserve)
                      _NavTile(
                        icon: Icons.event_available_outlined,
                        label: l10n.navReservations,
                        badgeCount: pendingReservations,
                        upgradeLocked: selected?.pack.reservations == false,
                        selected: location.contains('/reservations'),
                        onTap: () {
                          if (selected?.pack.reservations == false) {
                            showPackCatalog(context, closeDrawer: inDrawer);
                            return;
                          }
                          ReservationsRoute(buildingId: buildingId).go(context);
                        },
                      ),
                    if (isEmployee)
                      _NavTile(
                        icon: Icons.qr_code_scanner_outlined,
                        label: l10n.navScanTable,
                        upgradeLocked: selected?.pack.tableQr == false,
                        selected: location.contains('/tables/scan'),
                        onTap: () {
                          if (selected?.pack.tableQr == false) {
                            showPackCatalog(context, closeDrawer: inDrawer);
                            return;
                          }
                          TableQrScanRoute(buildingId: buildingId).go(context);
                        },
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
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: IconButton(
                            tooltip: l10n.signOut,
                            onPressed: () => ref
                                .read(authViewModelProvider.notifier)
                                .signOut(),
                            icon: Icon(Icons.logout, color: scheme.onSurface),
                          ),
                        ),
                      if (inDrawer)
                        Material(
                          type: MaterialType.transparency,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                            ),
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
                      const _AppearanceControls(),
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

/// Products header uses the same row metrics as the other destinations.
class _ProductsNav extends StatefulWidget {
  const _ProductsNav({
    super.key,
    required this.initiallyExpanded,
    required this.label,
    required this.children,
    this.badgeCount = 0,
  });

  final bool initiallyExpanded;
  final String label;
  final List<Widget> children;
  final int badgeCount;

  @override
  State<_ProductsNav> createState() => _ProductsNavState();
}

class _ProductsNavState extends State<_ProductsNav> {
  late bool _open = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        _NavTile(
          icon: Icons.inventory_2_outlined,
          label: widget.label,
          selected: false,
          badgeCount: widget.badgeCount,
          trailing: Icon(
            _open ? Icons.expand_less : Icons.expand_more,
            size: 20,
            color: scheme.onSurface,
          ),
          onTap: () => setState(() => _open = !_open),
        ),
        if (_open) ...widget.children,
      ],
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
    this.upgradeLocked = false,
    this.badgeCount = 0,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final bool indent;
  final int badgeCount;
  final Widget? trailing;

  /// Pack turns this destination off. The row stays tappable and opens plans.
  final bool upgradeLocked;

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
                  Opacity(
                    opacity: upgradeLocked ? 0.45 : 1,
                    child: Icon(icon, color: fg, size: 22),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Opacity(
                      opacity: upgradeLocked ? 0.45 : 1,
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
                  ),
                  if (badgeCount > 0)
                    Badge(label: Text(badgeCount > 99 ? '99+' : '$badgeCount')),
                  if (upgradeLocked) const PackUpgradeChip(),
                  ?trailing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Bell for the open venue. Lives in the app bar, not the drawer.
class _NotificationButton extends ConsumerWidget {
  const _NotificationButton({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final location = GoRouterState.of(context).uri.path;
    final unread =
        ref.watch(notificationInboxProvider).asData?.value.unread ?? 0;
    final open = location.endsWith('/notifications');
    return IconButton(
      tooltip: l10n.notifications,
      onPressed: () => NotificationsRoute(buildingId: buildingId).go(context),
      icon: Badge(
        isLabelVisible: unread > 0,
        label: Text(unread > 99 ? '99+' : '$unread'),
        child: Icon(
          Icons.notifications_outlined,
          color: open ? scheme.primary : null,
        ),
      ),
    );
  }
}

/// Dark-mode switch and language, pinned to the drawer and rail footer.
class _AppearanceControls extends ConsumerWidget {
  const _AppearanceControls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final tilePadding = const EdgeInsets.symmetric(horizontal: AppSpacing.sm);
    return Column(
      children: [
        ListTile(
          contentPadding: tilePadding,
          leading: Icon(
            dark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            color: scheme.onSurface,
          ),
          title: Text(
            dark ? l10n.themeDark : l10n.themeLight,
            style: TextStyle(color: scheme.onSurface),
          ),
          trailing: Switch(
            value: dark,
            onChanged: (enabled) {
              ref
                  .read(themeControllerProvider.notifier)
                  .setMode(enabled ? ThemeMode.dark : ThemeMode.light);
            },
          ),
        ),
        ListTile(
          contentPadding: tilePadding,
          leading: Icon(Icons.language, color: scheme.onSurface),
          title: Text(l10n.language, style: TextStyle(color: scheme.onSurface)),
          trailing: const LocaleMenuButton(),
        ),
      ],
    );
  }
}
