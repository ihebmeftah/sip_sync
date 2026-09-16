---
name: sip-sync-mvvm-riverpod
description: MVVM with Riverpod generator, go_router_builder, build_runner, and GetIt for Sip Sync Flutter apps. Use when creating screens, ViewModels, providers, repositories, navigation, or DI.
---

# MVVM + Riverpod generator + typed go_router

Run codegen in the **app package** after annotation edits:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Commit `*.g.dart`. Never hand-edit generated files.

## ViewModel (`@riverpod`)

```dart
part 'floor_view_model.g.dart';

@Riverpod(keepAlive: true)
class FloorViewModel extends _$FloorViewModel {
  @override
  Future<FloorState> build() async {
    final tables = await ref.read(accountRepositoryProvider).listForBuilding();
    return FloorState(tables: tables);
  }

  Future<void> refresh() async { state = const AsyncLoading(); state = await AsyncValue.guard(() async { ... }); }
}
```

Views: `ConsumerWidget`. Watch **state**, call **notifier**:

```dart
final state = ref.watch(floorViewModelProvider);
ref.read(floorViewModelProvider.notifier).refresh();
```

No `Client` in widgets.

## GetIt (only when needed)

Register Serverpod `Client` and repositories in `core/di/service_locator.dart`. Use GetIt from `GoRouter.redirect` and other non-widget code. Riverpod providers wrap GetIt:

```dart
@Riverpod(keepAlive: true)
AccountRepository accountRepository(Ref ref) =>
    getIt<AccountRepository>();
```

Do **not** put ViewModels in GetIt.

## Typed routes (`go_router_builder`)

```dart
part 'app_routes.g.dart';

@TypedGoRoute<HomeRoute>(path: '/', name: 'home')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeView();
}
```

```dart
@TypedGoRoute<BuildingRoute>(path: '/buildings/:id', name: 'building')
class BuildingRoute extends GoRouteData with $BuildingRoute {
  const BuildingRoute({required this.id});
  final String id; // UUID string; UuidValue.fromString in the ViewModel
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BuildingView(buildingId: id);
}
```

Navigate: `BuildingRoute(id: building.id.uuid).go(context)`. Router uses `$appRoutes` plus `refreshListenable` on auth. Route guards are **not** security — mirror checks on the endpoint.
