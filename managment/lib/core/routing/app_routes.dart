import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/buildings_gate_shell.dart';
import '../../core/widgets/ops_shell.dart';
import '../../features/auth/views/forgot_password_view.dart';
import '../../features/auth/views/register_view.dart';
import '../../features/auth/views/sign_in_view.dart';
import '../../features/buildings/views/building_configuration_view.dart';
import '../../features/cash_register/views/cash_register_view.dart';
import '../../features/buildings/views/building_form_view.dart';
import '../../features/buildings/views/buildings_list_view.dart';
import '../../features/dashboard/views/dashboard_view.dart';
import '../../features/employee_access/views/access_profile_edit_page.dart';
import '../../features/employee_access/views/access_profile_form_view.dart';
import '../../features/employee_access/views/access_profiles_list_view.dart';
import '../../features/employees/views/employee_details_view.dart';
import '../../features/employees/views/employee_form_view.dart';
import '../../features/employees/views/employees_list_view.dart';
import '../../features/orders/views/order_create_articles_view.dart';
import '../../features/orders/views/order_detail_view.dart';
import '../../features/notifications/views/notifications_view.dart';
import '../../features/orders/views/orders_page.dart';
import '../../features/products/views/article_composition_view.dart'
    show ArticleCompositionFormView;
import '../../features/products/views/article_form_view.dart';
import '../../features/products/views/articles_list_view.dart';
import '../../features/products/views/categories_list_view.dart';
import '../../features/products/views/category_form_view.dart';
import '../../features/products/views/ingredient_form_view.dart';
import '../../features/products/views/ingredients_list_view.dart';
import '../../features/tables/views/table_qr_scan_view.dart';
import '../../features/tables/views/tables_list_view.dart';
import '../../features/tables/views/venue_table_form_view.dart';
import '../../features/profile/views/profile_view.dart';
import '../../features/reservations/views/reservation_create_view.dart';
import '../../features/reservations/views/reservations_list_view.dart';

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

@TypedGoRoute<ForgotPasswordRoute>(
  path: '/forgot-password',
  name: 'forgotPassword',
)
class ForgotPasswordRoute extends GoRouteData with $ForgotPasswordRoute {
  const ForgotPasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ForgotPasswordView();
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
    TypedGoRoute<BuildingConfigurationRoute>(
      path: '/b/:buildingId/configuration',
      name: 'buildingConfiguration',
    ),
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
    TypedGoRoute<AccessProfilesRoute>(
      path: '/b/:buildingId/access',
      name: 'accessProfiles',
    ),
    TypedGoRoute<AccessProfileCreateRoute>(
      path: '/b/:buildingId/access/new',
      name: 'accessProfileCreate',
    ),
    TypedGoRoute<AccessProfileEditRoute>(
      path: '/b/:buildingId/access/:accessId/edit',
      name: 'accessProfileEdit',
    ),
    TypedGoRoute<PosRoute>(path: '/b/:buildingId/pos', name: 'pos'),
    TypedGoRoute<OrderCreateArticlesRoute>(
      path: '/b/:buildingId/orders/new/articles',
      name: 'orderCreateArticles',
    ),
    TypedGoRoute<OrderDetailRoute>(
      path: '/b/:buildingId/orders/:orderId',
      name: 'orderDetail',
    ),
    TypedGoRoute<OrdersRoute>(path: '/b/:buildingId/orders', name: 'orders'),
    TypedGoRoute<ReservationsRoute>(
      path: '/b/:buildingId/reservations',
      name: 'reservations',
    ),
    TypedGoRoute<CashRegisterRoute>(
      path: '/b/:buildingId/cash-register',
      name: 'cashRegister',
    ),
    TypedGoRoute<NotificationsRoute>(
      path: '/b/:buildingId/notifications',
      name: 'notifications',
    ),
    TypedGoRoute<ReservationCreateRoute>(
      path: '/b/:buildingId/reservations/new',
      name: 'reservationCreate',
    ),
    TypedGoRoute<TablesRoute>(path: '/b/:buildingId/tables', name: 'tables'),
    TypedGoRoute<TableQrScanRoute>(
      path: '/b/:buildingId/tables/scan',
      name: 'tableQrScan',
    ),
    TypedGoRoute<TableCreateRoute>(
      path: '/b/:buildingId/tables/new',
      name: 'tableCreate',
    ),
    TypedGoRoute<TableEditRoute>(
      path: '/b/:buildingId/tables/:tableId/edit',
      name: 'tableEdit',
    ),
    TypedGoRoute<CategoriesRoute>(
      path: '/b/:buildingId/products/categories',
      name: 'categories',
    ),
    TypedGoRoute<CategoryCreateRoute>(
      path: '/b/:buildingId/products/categories/new',
      name: 'categoryCreate',
    ),
    TypedGoRoute<CategoryEditRoute>(
      path: '/b/:buildingId/products/categories/:categoryId/edit',
      name: 'categoryEdit',
    ),
    TypedGoRoute<ArticlesRoute>(
      path: '/b/:buildingId/products/articles',
      name: 'articles',
    ),
    TypedGoRoute<ArticleCreateRoute>(
      path: '/b/:buildingId/products/articles/new',
      name: 'articleCreate',
    ),
    TypedGoRoute<ArticleEditRoute>(
      path: '/b/:buildingId/products/articles/:articleId/edit',
      name: 'articleEdit',
    ),
    TypedGoRoute<ArticleCompositionRoute>(
      path: '/b/:buildingId/products/articles/:articleId/composition',
      name: 'articleComposition',
    ),
    TypedGoRoute<IngredientsRoute>(
      path: '/b/:buildingId/products/ingredients',
      name: 'ingredients',
    ),
    TypedGoRoute<IngredientCreateRoute>(
      path: '/b/:buildingId/products/ingredients/new',
      name: 'ingredientCreate',
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

class BuildingConfigurationRoute extends GoRouteData
    with $BuildingConfigurationRoute {
  const BuildingConfigurationRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BuildingConfigurationView(buildingId: buildingId);
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

class AccessProfilesRoute extends GoRouteData with $AccessProfilesRoute {
  const AccessProfilesRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AccessProfilesListView(buildingId: buildingId);
  }
}

class AccessProfileCreateRoute extends GoRouteData
    with $AccessProfileCreateRoute {
  const AccessProfileCreateRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AccessProfileFormView(buildingId: buildingId);
  }
}

class AccessProfileEditRoute extends GoRouteData with $AccessProfileEditRoute {
  const AccessProfileEditRoute({
    required this.buildingId,
    required this.accessId,
  });

  final String buildingId;
  final String accessId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AccessProfileEditPage(buildingId: buildingId, accessId: accessId);
  }
}

class PosRoute extends GoRouteData with $PosRoute {
  const PosRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OrdersPage(buildingId: buildingId);
  }
}

class NotificationsRoute extends GoRouteData with $NotificationsRoute {
  const NotificationsRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NotificationsView(buildingId: buildingId);
  }
}

class ReservationsRoute extends GoRouteData with $ReservationsRoute {
  const ReservationsRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ReservationsListView(buildingId: buildingId);
  }
}

class CashRegisterRoute extends GoRouteData with $CashRegisterRoute {
  const CashRegisterRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CashRegisterView(buildingId: buildingId);
  }
}

class ReservationCreateRoute extends GoRouteData with $ReservationCreateRoute {
  const ReservationCreateRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ReservationCreateView(buildingId: buildingId);
  }
}

class OrdersRoute extends GoRouteData with $OrdersRoute {
  const OrdersRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OrdersPage(buildingId: buildingId);
  }
}

class OrderCreateArticlesRoute extends GoRouteData
    with $OrderCreateArticlesRoute {
  const OrderCreateArticlesRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OrderCreateArticlesView(buildingId: buildingId);
  }
}

class OrderDetailRoute extends GoRouteData with $OrderDetailRoute {
  const OrderDetailRoute({required this.buildingId, required this.orderId});

  final String buildingId;
  final String orderId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OrderDetailView(buildingId: buildingId, orderId: orderId);
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

class TableQrScanRoute extends GoRouteData with $TableQrScanRoute {
  const TableQrScanRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TableQrScanView(buildingId: buildingId);
  }
}

class TableCreateRoute extends GoRouteData with $TableCreateRoute {
  const TableCreateRoute({required this.buildingId, this.suggestedNumber});

  final String buildingId;
  final int? suggestedNumber;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VenueTableFormView(
      buildingId: buildingId,
      suggestedNumber: suggestedNumber,
    );
  }
}

class TableEditRoute extends GoRouteData with $TableEditRoute {
  const TableEditRoute({required this.buildingId, required this.tableId});

  final String buildingId;
  final String tableId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VenueTableFormView(buildingId: buildingId, tableId: tableId);
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

class CategoryCreateRoute extends GoRouteData with $CategoryCreateRoute {
  const CategoryCreateRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CategoryFormView(buildingId: buildingId);
  }
}

class CategoryEditRoute extends GoRouteData with $CategoryEditRoute {
  const CategoryEditRoute({required this.buildingId, required this.categoryId});

  final String buildingId;
  final String categoryId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CategoryFormView(buildingId: buildingId, categoryId: categoryId);
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

class ArticleCreateRoute extends GoRouteData with $ArticleCreateRoute {
  const ArticleCreateRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ArticleFormView(buildingId: buildingId);
  }
}

class ArticleEditRoute extends GoRouteData with $ArticleEditRoute {
  const ArticleEditRoute({required this.buildingId, required this.articleId});

  final String buildingId;
  final String articleId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ArticleFormView(buildingId: buildingId, articleId: articleId);
  }
}

class ArticleCompositionRoute extends GoRouteData
    with $ArticleCompositionRoute {
  const ArticleCompositionRoute({
    required this.buildingId,
    required this.articleId,
  });

  final String buildingId;
  final String articleId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ArticleCompositionFormView(
      buildingId: buildingId,
      articleId: articleId,
    );
  }
}

class IngredientsRoute extends GoRouteData with $IngredientsRoute {
  const IngredientsRoute({required this.buildingId, this.outOfStock = false});

  final String buildingId;

  /// Opens the list limited to ingredients with no current stock.
  final bool outOfStock;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return IngredientsListView(
      buildingId: buildingId,
      outOfStockOnly: outOfStock,
    );
  }
}

class IngredientCreateRoute extends GoRouteData with $IngredientCreateRoute {
  const IngredientCreateRoute({required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return IngredientFormView(buildingId: buildingId);
  }
}
