import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/views/register_view.dart';
import '../../features/auth/views/sign_in_view.dart';
import '../../features/buildings/views/building_detail_view.dart';
import '../../features/buildings/views/buildings_view.dart';
import '../../features/console/views/console_shell.dart';
import '../../features/stats/views/stats_view.dart';
import '../../features/customers/views/customers_view.dart';
import '../../features/packs/views/packs_view.dart';
import '../../features/users/views/users_view.dart';

part 'app_routes.g.dart';

@TypedGoRoute<SignInRoute>(path: '/sign-in', name: 'signIn')
class SignInRoute extends GoRouteData with $SignInRoute {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInView();
}

@TypedGoRoute<RegisterRoute>(path: '/register', name: 'register')
class RegisterRoute extends GoRouteData with $RegisterRoute {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RegisterView();
}

@TypedShellRoute<ConsoleShellRoute>(
  routes: [
    TypedGoRoute<StatsRoute>(path: '/stats', name: 'stats'),
    TypedGoRoute<UsersRoute>(path: '/users', name: 'users'),
    TypedGoRoute<CustomersRoute>(path: '/customers', name: 'customers'),
    TypedGoRoute<BuildingsRoute>(
      path: '/buildings',
      name: 'buildings',
      routes: [
        TypedGoRoute<BuildingDetailRoute>(
          path: ':buildingId',
          name: 'buildingDetail',
        ),
      ],
    ),
    TypedGoRoute<PacksRoute>(path: '/packs', name: 'packs'),
  ],
)
class ConsoleShellRoute extends ShellRouteData {
  const ConsoleShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return ConsoleShell(child: navigator);
  }
}

class StatsRoute extends GoRouteData with $StatsRoute {
  const StatsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const StatsView();
}

class UsersRoute extends GoRouteData with $UsersRoute {
  const UsersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const UsersView();
}

class CustomersRoute extends GoRouteData with $CustomersRoute {
  const CustomersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CustomersView();
}

class BuildingsRoute extends GoRouteData with $BuildingsRoute {
  const BuildingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BuildingsView();
}

class BuildingDetailRoute extends GoRouteData with $BuildingDetailRoute {
  const BuildingDetailRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BuildingDetailView(buildingId: buildingId);
  }
}

class PacksRoute extends GoRouteData with $PacksRoute {
  const PacksRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const PacksView();
}
