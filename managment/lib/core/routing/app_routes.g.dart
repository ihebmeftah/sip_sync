// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $signInRoute,
  $registerRoute,
  $buildingsGateShellRoute,
  $opsShellRoute,
];

RouteBase get $signInRoute => GoRouteData.$route(
  path: '/sign-in',
  name: 'signIn',
  hasOverriddenOnExit: false,
  factory: $SignInRoute._fromState,
);

mixin $SignInRoute on GoRouteData {
  static SignInRoute _fromState(GoRouterState state) => const SignInRoute();

  @override
  String get location => GoRouteData.$location('/sign-in');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $registerRoute => GoRouteData.$route(
  path: '/register',
  name: 'register',
  hasOverriddenOnExit: false,
  factory: $RegisterRoute._fromState,
);

mixin $RegisterRoute on GoRouteData {
  static RegisterRoute _fromState(GoRouterState state) => const RegisterRoute();

  @override
  String get location => GoRouteData.$location('/register');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $buildingsGateShellRoute => ShellRouteData.$route(
  factory: $BuildingsGateShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/buildings',
      name: 'buildings',
      hasOverriddenOnExit: false,
      factory: $BuildingsRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'new',
          name: 'buildingCreate',
          hasOverriddenOnExit: false,
          factory: $BuildingCreateRoute._fromState,
        ),
        GoRouteData.$route(
          path: ':buildingId/edit',
          name: 'buildingEdit',
          hasOverriddenOnExit: false,
          factory: $BuildingEditRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $BuildingsGateShellRouteExtension on BuildingsGateShellRoute {
  static BuildingsGateShellRoute _fromState(GoRouterState state) =>
      const BuildingsGateShellRoute();
}

mixin $BuildingsRoute on GoRouteData {
  static BuildingsRoute _fromState(GoRouterState state) =>
      const BuildingsRoute();

  @override
  String get location => GoRouteData.$location('/buildings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $BuildingCreateRoute on GoRouteData {
  static BuildingCreateRoute _fromState(GoRouterState state) =>
      const BuildingCreateRoute();

  @override
  String get location => GoRouteData.$location('/buildings/new');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $BuildingEditRoute on GoRouteData {
  static BuildingEditRoute _fromState(GoRouterState state) =>
      BuildingEditRoute(buildingId: state.pathParameters['buildingId']!);

  BuildingEditRoute get _self => this as BuildingEditRoute;

  @override
  String get location => GoRouteData.$location(
    '/buildings/${Uri.encodeComponent(_self.buildingId)}/edit',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $opsShellRoute => ShellRouteData.$route(
  factory: $OpsShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/b/:buildingId/dashboard',
      name: 'dashboard',
      hasOverriddenOnExit: false,
      factory: $DashboardRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/profile',
      name: 'profile',
      hasOverriddenOnExit: false,
      factory: $ProfileRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/employees',
      name: 'employees',
      hasOverriddenOnExit: false,
      factory: $EmployeesRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/employees/new',
      name: 'employeeCreate',
      hasOverriddenOnExit: false,
      factory: $EmployeeCreateRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/employees/:employeeId/edit',
      name: 'employeeEdit',
      hasOverriddenOnExit: false,
      factory: $EmployeeEditRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/employees/:employeeId',
      name: 'employeeDetails',
      hasOverriddenOnExit: false,
      factory: $EmployeeDetailsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/pos',
      name: 'pos',
      hasOverriddenOnExit: false,
      factory: $PosRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/orders/new/articles',
      name: 'orderCreateArticles',
      hasOverriddenOnExit: false,
      factory: $OrderCreateArticlesRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/orders/:orderId',
      name: 'orderDetail',
      hasOverriddenOnExit: false,
      factory: $OrderDetailRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/orders',
      name: 'orders',
      hasOverriddenOnExit: false,
      factory: $OrdersRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/tables',
      name: 'tables',
      hasOverriddenOnExit: false,
      factory: $TablesRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/tables/new',
      name: 'tableCreate',
      hasOverriddenOnExit: false,
      factory: $TableCreateRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/tables/:tableId/edit',
      name: 'tableEdit',
      hasOverriddenOnExit: false,
      factory: $TableEditRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/products/categories',
      name: 'categories',
      hasOverriddenOnExit: false,
      factory: $CategoriesRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/products/categories/new',
      name: 'categoryCreate',
      hasOverriddenOnExit: false,
      factory: $CategoryCreateRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/products/categories/:categoryId/edit',
      name: 'categoryEdit',
      hasOverriddenOnExit: false,
      factory: $CategoryEditRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/products/articles',
      name: 'articles',
      hasOverriddenOnExit: false,
      factory: $ArticlesRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/products/articles/new',
      name: 'articleCreate',
      hasOverriddenOnExit: false,
      factory: $ArticleCreateRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/products/articles/:articleId/edit',
      name: 'articleEdit',
      hasOverriddenOnExit: false,
      factory: $ArticleEditRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/products/articles/:articleId/composition',
      name: 'articleComposition',
      hasOverriddenOnExit: false,
      factory: $ArticleCompositionRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/products/ingredients',
      name: 'ingredients',
      hasOverriddenOnExit: false,
      factory: $IngredientsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/b/:buildingId/products/ingredients/new',
      name: 'ingredientCreate',
      hasOverriddenOnExit: false,
      factory: $IngredientCreateRoute._fromState,
    ),
  ],
);

extension $OpsShellRouteExtension on OpsShellRoute {
  static OpsShellRoute _fromState(GoRouterState state) => const OpsShellRoute();
}

mixin $DashboardRoute on GoRouteData {
  static DashboardRoute _fromState(GoRouterState state) =>
      DashboardRoute(buildingId: state.pathParameters['buildingId']!);

  DashboardRoute get _self => this as DashboardRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/dashboard',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) =>
      ProfileRoute(buildingId: state.pathParameters['buildingId']!);

  ProfileRoute get _self => this as ProfileRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/profile',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EmployeesRoute on GoRouteData {
  static EmployeesRoute _fromState(GoRouterState state) =>
      EmployeesRoute(buildingId: state.pathParameters['buildingId']!);

  EmployeesRoute get _self => this as EmployeesRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/employees',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EmployeeCreateRoute on GoRouteData {
  static EmployeeCreateRoute _fromState(GoRouterState state) =>
      EmployeeCreateRoute(buildingId: state.pathParameters['buildingId']!);

  EmployeeCreateRoute get _self => this as EmployeeCreateRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/employees/new',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EmployeeEditRoute on GoRouteData {
  static EmployeeEditRoute _fromState(GoRouterState state) => EmployeeEditRoute(
    buildingId: state.pathParameters['buildingId']!,
    employeeId: state.pathParameters['employeeId']!,
  );

  EmployeeEditRoute get _self => this as EmployeeEditRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/employees/${Uri.encodeComponent(_self.employeeId)}/edit',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EmployeeDetailsRoute on GoRouteData {
  static EmployeeDetailsRoute _fromState(GoRouterState state) =>
      EmployeeDetailsRoute(
        buildingId: state.pathParameters['buildingId']!,
        employeeId: state.pathParameters['employeeId']!,
      );

  EmployeeDetailsRoute get _self => this as EmployeeDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/employees/${Uri.encodeComponent(_self.employeeId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PosRoute on GoRouteData {
  static PosRoute _fromState(GoRouterState state) =>
      PosRoute(buildingId: state.pathParameters['buildingId']!);

  PosRoute get _self => this as PosRoute;

  @override
  String get location =>
      GoRouteData.$location('/b/${Uri.encodeComponent(_self.buildingId)}/pos');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $OrderCreateArticlesRoute on GoRouteData {
  static OrderCreateArticlesRoute _fromState(GoRouterState state) =>
      OrderCreateArticlesRoute(buildingId: state.pathParameters['buildingId']!);

  OrderCreateArticlesRoute get _self => this as OrderCreateArticlesRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/orders/new/articles',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $OrderDetailRoute on GoRouteData {
  static OrderDetailRoute _fromState(GoRouterState state) => OrderDetailRoute(
    buildingId: state.pathParameters['buildingId']!,
    orderId: state.pathParameters['orderId']!,
  );

  OrderDetailRoute get _self => this as OrderDetailRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/orders/${Uri.encodeComponent(_self.orderId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $OrdersRoute on GoRouteData {
  static OrdersRoute _fromState(GoRouterState state) =>
      OrdersRoute(buildingId: state.pathParameters['buildingId']!);

  OrdersRoute get _self => this as OrdersRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/orders',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TablesRoute on GoRouteData {
  static TablesRoute _fromState(GoRouterState state) =>
      TablesRoute(buildingId: state.pathParameters['buildingId']!);

  TablesRoute get _self => this as TablesRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/tables',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TableCreateRoute on GoRouteData {
  static TableCreateRoute _fromState(GoRouterState state) => TableCreateRoute(
    buildingId: state.pathParameters['buildingId']!,
    suggestedNumber: _$convertMapValue(
      'suggested-number',
      state.uri.queryParameters,
      int.tryParse,
    ),
  );

  TableCreateRoute get _self => this as TableCreateRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/tables/new',
    queryParams: {
      if (_self.suggestedNumber != null)
        'suggested-number': _self.suggestedNumber!.toString(),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TableEditRoute on GoRouteData {
  static TableEditRoute _fromState(GoRouterState state) => TableEditRoute(
    buildingId: state.pathParameters['buildingId']!,
    tableId: state.pathParameters['tableId']!,
  );

  TableEditRoute get _self => this as TableEditRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/tables/${Uri.encodeComponent(_self.tableId)}/edit',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CategoriesRoute on GoRouteData {
  static CategoriesRoute _fromState(GoRouterState state) =>
      CategoriesRoute(buildingId: state.pathParameters['buildingId']!);

  CategoriesRoute get _self => this as CategoriesRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/products/categories',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CategoryCreateRoute on GoRouteData {
  static CategoryCreateRoute _fromState(GoRouterState state) =>
      CategoryCreateRoute(buildingId: state.pathParameters['buildingId']!);

  CategoryCreateRoute get _self => this as CategoryCreateRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/products/categories/new',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CategoryEditRoute on GoRouteData {
  static CategoryEditRoute _fromState(GoRouterState state) => CategoryEditRoute(
    buildingId: state.pathParameters['buildingId']!,
    categoryId: state.pathParameters['categoryId']!,
  );

  CategoryEditRoute get _self => this as CategoryEditRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/products/categories/${Uri.encodeComponent(_self.categoryId)}/edit',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ArticlesRoute on GoRouteData {
  static ArticlesRoute _fromState(GoRouterState state) =>
      ArticlesRoute(buildingId: state.pathParameters['buildingId']!);

  ArticlesRoute get _self => this as ArticlesRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/products/articles',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ArticleCreateRoute on GoRouteData {
  static ArticleCreateRoute _fromState(GoRouterState state) =>
      ArticleCreateRoute(buildingId: state.pathParameters['buildingId']!);

  ArticleCreateRoute get _self => this as ArticleCreateRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/products/articles/new',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ArticleEditRoute on GoRouteData {
  static ArticleEditRoute _fromState(GoRouterState state) => ArticleEditRoute(
    buildingId: state.pathParameters['buildingId']!,
    articleId: state.pathParameters['articleId']!,
  );

  ArticleEditRoute get _self => this as ArticleEditRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/products/articles/${Uri.encodeComponent(_self.articleId)}/edit',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ArticleCompositionRoute on GoRouteData {
  static ArticleCompositionRoute _fromState(GoRouterState state) =>
      ArticleCompositionRoute(
        buildingId: state.pathParameters['buildingId']!,
        articleId: state.pathParameters['articleId']!,
      );

  ArticleCompositionRoute get _self => this as ArticleCompositionRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/products/articles/${Uri.encodeComponent(_self.articleId)}/composition',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $IngredientsRoute on GoRouteData {
  static IngredientsRoute _fromState(GoRouterState state) =>
      IngredientsRoute(buildingId: state.pathParameters['buildingId']!);

  IngredientsRoute get _self => this as IngredientsRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/products/ingredients',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $IngredientCreateRoute on GoRouteData {
  static IngredientCreateRoute _fromState(GoRouterState state) =>
      IngredientCreateRoute(buildingId: state.pathParameters['buildingId']!);

  IngredientCreateRoute get _self => this as IngredientCreateRoute;

  @override
  String get location => GoRouteData.$location(
    '/b/${Uri.encodeComponent(_self.buildingId)}/products/ingredients/new',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}
