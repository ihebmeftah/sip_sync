import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/views/register_view.dart';
import '../../features/auth/views/sign_in_view.dart';
import '../../features/buildings/views/buildings_view.dart';
import '../../features/console/views/console_shell.dart';
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
    TypedGoRoute<UsersRoute>(path: '/users', name: 'users'),
    TypedGoRoute<BuildingsRoute>(path: '/buildings', name: 'buildings'),
  ],
)
class ConsoleShellRoute extends ShellRouteData {
  const ConsoleShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return ConsoleShell(child: navigator);
  }
}

class UsersRoute extends GoRouteData with $UsersRoute {
  const UsersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const UsersView();
}

class BuildingsRoute extends GoRouteData with $BuildingsRoute {
  const BuildingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BuildingsView();
}
