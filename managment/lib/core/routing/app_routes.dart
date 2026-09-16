import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/ops_shell.dart';
import '../../core/widgets/placeholder_view.dart';
import '../../features/auth/views/register_view.dart';
import '../../features/auth/views/sign_in_view.dart';
import '../../features/buildings/views/building_form_view.dart';
import '../../features/buildings/views/buildings_list_view.dart';
import '../../features/dashboard/views/dashboard_view.dart';
import '../../features/employees/views/employee_details_view.dart';
import '../../features/employees/views/employee_form_view.dart';
import '../../features/employees/views/employees_list_view.dart';
import '../../features/profile/views/profile_view.dart';
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

@TypedShellRoute<OpsShellRoute>(
  routes: [
    TypedGoRoute<DashboardRoute>(path: '/dashboard', name: 'dashboard'),
    TypedGoRoute<BuildingsRoute>(
      path: '/buildings',
      name: 'buildings',
      routes: [
        TypedGoRoute<BuildingCreateRoute>(path: 'new', name: 'buildingCreate'),
        TypedGoRoute<BuildingEditRoute>(
          path: ':buildingId/edit',
          name: 'buildingEdit',
        ),
      ],
    ),
    TypedGoRoute<ProfileRoute>(path: '/profile', name: 'profile'),
    TypedGoRoute<EmployeesRoute>(
      path: '/employees',
      name: 'employees',
      routes: [
        TypedGoRoute<EmployeeCreateRoute>(path: 'new', name: 'employeeCreate'),
        TypedGoRoute<EmployeeDetailsRoute>(
          path: ':authUserId',
          name: 'employeeDetails',
          routes: [
            TypedGoRoute<EmployeeEditRoute>(path: 'edit', name: 'employeeEdit'),
          ],
        ),
      ],
    ),
    TypedGoRoute<PosRoute>(path: '/pos', name: 'pos'),
    TypedGoRoute<TablesRoute>(path: '/tables', name: 'tables'),
    TypedGoRoute<ArticlesRoute>(path: '/products/articles', name: 'articles'),
    TypedGoRoute<IngredientsRoute>(
      path: '/products/ingredients',
      name: 'ingredients',
    ),
  ],
)
class OpsShellRoute extends ShellRouteData {
  const OpsShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return OpsShell(child: navigator);
  }
}

class DashboardRoute extends GoRouteData with $DashboardRoute {
  const DashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DashboardView();
}

class BuildingsRoute extends GoRouteData with $BuildingsRoute {
  const BuildingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BuildingsListView();
}

class BuildingCreateRoute extends GoRouteData with $BuildingCreateRoute {
  const BuildingCreateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BuildingFormView();
}

class BuildingEditRoute extends GoRouteData with $BuildingEditRoute {
  const BuildingEditRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BuildingFormView(buildingId: buildingId);
  }
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileViewPage();
}

class EmployeesRoute extends GoRouteData with $EmployeesRoute {
  const EmployeesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EmployeesListView();
}

class EmployeeCreateRoute extends GoRouteData with $EmployeeCreateRoute {
  const EmployeeCreateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EmployeeFormView();
}

class EmployeeDetailsRoute extends GoRouteData with $EmployeeDetailsRoute {
  const EmployeeDetailsRoute({required this.authUserId});

  final String authUserId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EmployeeDetailsPage(authUserId: authUserId);
  }
}

class EmployeeEditRoute extends GoRouteData with $EmployeeEditRoute {
  const EmployeeEditRoute({required this.authUserId});

  final String authUserId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EmployeeFormView(authUserId: authUserId);
  }
}

class PosRoute extends GoRouteData with $PosRoute {
  const PosRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final name = AppLocalizations.of(context)!.navPos;
    return PlaceholderView(screenName: name);
  }
}

class TablesRoute extends GoRouteData with $TablesRoute {
  const TablesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final name = AppLocalizations.of(context)!.navTables;
    return PlaceholderView(screenName: name);
  }
}

class ArticlesRoute extends GoRouteData with $ArticlesRoute {
  const ArticlesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final name = AppLocalizations.of(context)!.navArticles;
    return PlaceholderView(screenName: name);
  }
}

class IngredientsRoute extends GoRouteData with $IngredientsRoute {
  const IngredientsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final name = AppLocalizations.of(context)!.navIngredients;
    return PlaceholderView(screenName: name);
  }
}
