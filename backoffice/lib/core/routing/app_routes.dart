import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:shadcn_ui/shadcn_ui.dart';

import '../../features/auth/views/register_view.dart';
import '../../features/auth/views/sign_in_view.dart';
import '../../features/buildings/views/buildings_view.dart';
import '../../features/console/views/console_shell.dart';
import '../../features/console/views/working_view.dart';
import '../../features/customers/views/customers_view.dart';
import '../../features/users/views/users_view.dart';
import '../../l10n/generated/app_localizations.dart';

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
    TypedGoRoute<BuildingsRoute>(path: '/buildings', name: 'buildings'),
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
  Widget build(BuildContext context, GoRouterState state) {
    final l10n = AppLocalizations.of(context)!;
    return WorkingView(title: l10n.statsTitle, icon: LucideIcons.chartColumn);
  }
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

class PacksRoute extends GoRouteData with $PacksRoute {
  const PacksRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final l10n = AppLocalizations.of(context)!;
    return WorkingView(title: l10n.packsTitle, icon: LucideIcons.package);
  }
}
