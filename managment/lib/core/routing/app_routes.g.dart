// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $signInRoute,
  $registerRoute,
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

RouteBase get $opsShellRoute => ShellRouteData.$route(
  factory: $OpsShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/dashboard',
      name: 'dashboard',
      hasOverriddenOnExit: false,
      factory: $DashboardRoute._fromState,
    ),
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
    GoRouteData.$route(
      path: '/profile',
      name: 'profile',
      hasOverriddenOnExit: false,
      factory: $ProfileRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/employees',
      name: 'employees',
      hasOverriddenOnExit: false,
      factory: $EmployeesRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'new',
          name: 'employeeCreate',
          hasOverriddenOnExit: false,
          factory: $EmployeeCreateRoute._fromState,
        ),
        GoRouteData.$route(
          path: ':authUserId',
          name: 'employeeDetails',
          hasOverriddenOnExit: false,
          factory: $EmployeeDetailsRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'edit',
              name: 'employeeEdit',
              hasOverriddenOnExit: false,
              factory: $EmployeeEditRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    GoRouteData.$route(
      path: '/pos',
      name: 'pos',
      hasOverriddenOnExit: false,
      factory: $PosRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/tables',
      name: 'tables',
      hasOverriddenOnExit: false,
      factory: $TablesRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/products/articles',
      name: 'articles',
      hasOverriddenOnExit: false,
      factory: $ArticlesRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/products/ingredients',
      name: 'ingredients',
      hasOverriddenOnExit: false,
      factory: $IngredientsRoute._fromState,
    ),
  ],
);

extension $OpsShellRouteExtension on OpsShellRoute {
  static OpsShellRoute _fromState(GoRouterState state) => const OpsShellRoute();
}

mixin $DashboardRoute on GoRouteData {
  static DashboardRoute _fromState(GoRouterState state) =>
      const DashboardRoute();

  @override
  String get location => GoRouteData.$location('/dashboard');

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

mixin $ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  @override
  String get location => GoRouteData.$location('/profile');

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
      const EmployeesRoute();

  @override
  String get location => GoRouteData.$location('/employees');

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
      const EmployeeCreateRoute();

  @override
  String get location => GoRouteData.$location('/employees/new');

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
      EmployeeDetailsRoute(authUserId: state.pathParameters['authUserId']!);

  EmployeeDetailsRoute get _self => this as EmployeeDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/employees/${Uri.encodeComponent(_self.authUserId)}',
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
  static EmployeeEditRoute _fromState(GoRouterState state) =>
      EmployeeEditRoute(authUserId: state.pathParameters['authUserId']!);

  EmployeeEditRoute get _self => this as EmployeeEditRoute;

  @override
  String get location => GoRouteData.$location(
    '/employees/${Uri.encodeComponent(_self.authUserId)}/edit',
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
  static PosRoute _fromState(GoRouterState state) => const PosRoute();

  @override
  String get location => GoRouteData.$location('/pos');

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
  static TablesRoute _fromState(GoRouterState state) => const TablesRoute();

  @override
  String get location => GoRouteData.$location('/tables');

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
  static ArticlesRoute _fromState(GoRouterState state) => const ArticlesRoute();

  @override
  String get location => GoRouteData.$location('/products/articles');

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
      const IngredientsRoute();

  @override
  String get location => GoRouteData.$location('/products/ingredients');

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
