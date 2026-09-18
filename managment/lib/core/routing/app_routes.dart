import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/buildings_gate_shell.dart';
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
import '../../features/products/views/articles_list_view.dart';
import '../../features/products/views/categories_list_view.dart';
import '../../features/products/views/ingredients_list_view.dart';
import '../../features/tables/views/tables_list_view.dart';
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

@TypedShellRoute<BuildingsGateShellRoute>(
  routes: [
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
  ],
)
class BuildingsGateShellRoute extends ShellRouteData {
  const BuildingsGateShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return BuildingsGateShell(child: navigator);
  }
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

@TypedShellRoute<OpsShellRoute>(
  routes: [
    TypedGoRoute<DashboardRoute>(
      path: '/b/:buildingId/dashboard',
      name: 'dashboard',
    ),
    TypedGoRoute<ProfileRoute>(path: '/b/:buildingId/profile', name: 'profile'),
    // Sibling routes (not nested) so each screen replaces the shell child
    // instead of stacking under the list with no visible navigator slot.
    TypedGoRoute<EmployeesRoute>(
      path: '/b/:buildingId/employees',
      name: 'employees',
    ),
    TypedGoRoute<EmployeeCreateRoute>(
      path: '/b/:buildingId/employees/new',
      name: 'employeeCreate',
    ),
    TypedGoRoute<EmployeeEditRoute>(
      path: '/b/:buildingId/employees/:employeeId/edit',
      name: 'employeeEdit',
    ),
    TypedGoRoute<EmployeeDetailsRoute>(
      path: '/b/:buildingId/employees/:employeeId',
      name: 'employeeDetails',
    ),
    TypedGoRoute<PosRoute>(path: '/b/:buildingId/pos', name: 'pos'),
    TypedGoRoute<TablesRoute>(path: '/b/:buildingId/tables', name: 'tables'),
    TypedGoRoute<CategoriesRoute>(
      path: '/b/:buildingId/products/categories',
      name: 'categories',
    ),
    TypedGoRoute<ArticlesRoute>(
      path: '/b/:buildingId/products/articles',
      name: 'articles',
    ),
    TypedGoRoute<IngredientsRoute>(
      path: '/b/:buildingId/products/ingredients',
      name: 'ingredients',
    ),
  ],
)
class OpsShellRoute extends ShellRouteData {
  const OpsShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    final buildingId = state.pathParameters['buildingId'];
    return OpsShell(buildingId: buildingId, child: navigator);
  }
}

class DashboardRoute extends GoRouteData with $DashboardRoute {
  const DashboardRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DashboardView(buildingId: buildingId);
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileViewPage();
}

class EmployeesRoute extends GoRouteData with $EmployeesRoute {
  const EmployeesRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EmployeesListView(buildingId: buildingId);
  }
}

class EmployeeCreateRoute extends GoRouteData with $EmployeeCreateRoute {
  const EmployeeCreateRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EmployeeFormView(buildingId: buildingId);
  }
}

class EmployeeDetailsRoute extends GoRouteData with $EmployeeDetailsRoute {
  const EmployeeDetailsRoute({
    required this.buildingId,
    required this.employeeId,
  });

  final String buildingId;
  final String employeeId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EmployeeDetailsPage(buildingId: buildingId, employeeId: employeeId);
  }
}

class EmployeeEditRoute extends GoRouteData with $EmployeeEditRoute {
  const EmployeeEditRoute({required this.buildingId, required this.employeeId});

  final String buildingId;
  final String employeeId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EmployeeFormView(buildingId: buildingId, employeeId: employeeId);
  }
}

class PosRoute extends GoRouteData with $PosRoute {
  const PosRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final name = AppLocalizations.of(context)!.navPos;
    return PlaceholderView(screenName: name);
  }
}

class TablesRoute extends GoRouteData with $TablesRoute {
  const TablesRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TablesListView(buildingId: buildingId);
  }
}

class CategoriesRoute extends GoRouteData with $CategoriesRoute {
  const CategoriesRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CategoriesListView(buildingId: buildingId);
  }
}

class ArticlesRoute extends GoRouteData with $ArticlesRoute {
  const ArticlesRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ArticlesListView(buildingId: buildingId);
  }
}

class IngredientsRoute extends GoRouteData with $IngredientsRoute {
  const IngredientsRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return IngredientsListView(buildingId: buildingId);
  }
}
