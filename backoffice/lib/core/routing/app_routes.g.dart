// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $signInRoute,
  $registerRoute,
  $consoleShellRoute,
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

RouteBase get $consoleShellRoute => ShellRouteData.$route(
  factory: $ConsoleShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/stats',
      name: 'stats',
      hasOverriddenOnExit: false,
      factory: $StatsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/users',
      name: 'users',
      hasOverriddenOnExit: false,
      factory: $UsersRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/customers',
      name: 'customers',
      hasOverriddenOnExit: false,
      factory: $CustomersRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/buildings',
      name: 'buildings',
      hasOverriddenOnExit: false,
      factory: $BuildingsRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: ':buildingId',
          name: 'buildingDetail',
          hasOverriddenOnExit: false,
          factory: $BuildingDetailRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: '/packs',
      name: 'packs',
      hasOverriddenOnExit: false,
      factory: $PacksRoute._fromState,
    ),
  ],
);

extension $ConsoleShellRouteExtension on ConsoleShellRoute {
  static ConsoleShellRoute _fromState(GoRouterState state) =>
      const ConsoleShellRoute();
}

mixin $StatsRoute on GoRouteData {
  static StatsRoute _fromState(GoRouterState state) => const StatsRoute();

  @override
  String get location => GoRouteData.$location('/stats');

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

mixin $UsersRoute on GoRouteData {
  static UsersRoute _fromState(GoRouterState state) => const UsersRoute();

  @override
  String get location => GoRouteData.$location('/users');

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

mixin $CustomersRoute on GoRouteData {
  static CustomersRoute _fromState(GoRouterState state) =>
      const CustomersRoute();

  @override
  String get location => GoRouteData.$location('/customers');

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

mixin $BuildingDetailRoute on GoRouteData {
  static BuildingDetailRoute _fromState(GoRouterState state) =>
      BuildingDetailRoute(buildingId: state.pathParameters['buildingId']!);

  BuildingDetailRoute get _self => this as BuildingDetailRoute;

  @override
  String get location => GoRouteData.$location(
    '/buildings/${Uri.encodeComponent(_self.buildingId)}',
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

mixin $PacksRoute on GoRouteData {
  static PacksRoute _fromState(GoRouterState state) => const PacksRoute();

  @override
  String get location => GoRouteData.$location('/packs');

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
