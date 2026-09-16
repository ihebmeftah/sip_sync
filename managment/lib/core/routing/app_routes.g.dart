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
      path: '/profile',
      name: 'profile',
      hasOverriddenOnExit: false,
      factory: $ProfileRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'employees/:authUserId',
          name: 'employeeProfile',
          hasOverriddenOnExit: false,
          factory: $EmployeeProfileRoute._fromState,
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

mixin $EmployeeProfileRoute on GoRouteData {
  static EmployeeProfileRoute _fromState(GoRouterState state) =>
      EmployeeProfileRoute(authUserId: state.pathParameters['authUserId']!);

  EmployeeProfileRoute get _self => this as EmployeeProfileRoute;

  @override
  String get location => GoRouteData.$location(
    '/profile/employees/${Uri.encodeComponent(_self.authUserId)}',
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
