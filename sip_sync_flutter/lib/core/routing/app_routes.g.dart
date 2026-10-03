// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $onboardingRoute,
  $signInRoute,
  $registerRoute,
  $orderHistoryRoute,
  $homeRoute,
  $tableScanRoute,
  $venueRoute,
  $orderReviewRoute,
  $customerOrderRoute,
  $venueMenuRoute,
];

RouteBase get $onboardingRoute => GoRouteData.$route(
  path: '/onboarding',
  name: 'onboarding',
  hasOverriddenOnExit: false,
  factory: $OnboardingRoute._fromState,
);

mixin $OnboardingRoute on GoRouteData {
  static OnboardingRoute _fromState(GoRouterState state) =>
      const OnboardingRoute();

  @override
  String get location => GoRouteData.$location('/onboarding');

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

RouteBase get $orderHistoryRoute => GoRouteData.$route(
  path: '/orders',
  name: 'orderHistory',
  hasOverriddenOnExit: false,
  factory: $OrderHistoryRoute._fromState,
);

mixin $OrderHistoryRoute on GoRouteData {
  static OrderHistoryRoute _fromState(GoRouterState state) =>
      const OrderHistoryRoute();

  @override
  String get location => GoRouteData.$location('/orders');

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

RouteBase get $homeRoute => GoRouteData.$route(
  path: '/',
  name: 'home',
  hasOverriddenOnExit: false,
  factory: $HomeRoute._fromState,
);

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/');

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

RouteBase get $tableScanRoute => GoRouteData.$route(
  path: '/scan',
  name: 'tableScan',
  hasOverriddenOnExit: false,
  factory: $TableScanRoute._fromState,
);

mixin $TableScanRoute on GoRouteData {
  static TableScanRoute _fromState(GoRouterState state) => TableScanRoute(
    changing:
        _$convertMapValue(
          'changing',
          state.uri.queryParameters,
          _$boolConverter,
        ) ??
        false,
    buildingId: state.uri.queryParameters['building-id'],
  );

  TableScanRoute get _self => this as TableScanRoute;

  @override
  String get location => GoRouteData.$location(
    '/scan',
    queryParams: {
      if (_self.changing != false) 'changing': _self.changing.toString(),
      if (_self.buildingId != null) 'building-id': _self.buildingId,
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

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

bool _$boolConverter(String value) {
  switch (value) {
    case 'true':
      return true;
    case 'false':
      return false;
    default:
      throw UnsupportedError('Cannot convert "$value" into a bool.');
  }
}

RouteBase get $venueRoute => GoRouteData.$route(
  path: '/venues/:id',
  name: 'venue',
  hasOverriddenOnExit: false,
  factory: $VenueRoute._fromState,
);

mixin $VenueRoute on GoRouteData {
  static VenueRoute _fromState(GoRouterState state) =>
      VenueRoute(id: state.pathParameters['id']!);

  VenueRoute get _self => this as VenueRoute;

  @override
  String get location =>
      GoRouteData.$location('/venues/${Uri.encodeComponent(_self.id)}');

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

RouteBase get $orderReviewRoute => GoRouteData.$route(
  path: '/venues/:id/order',
  name: 'orderReview',
  hasOverriddenOnExit: false,
  factory: $OrderReviewRoute._fromState,
);

mixin $OrderReviewRoute on GoRouteData {
  static OrderReviewRoute _fromState(GoRouterState state) => OrderReviewRoute(
    id: state.pathParameters['id']!,
    venueName: state.uri.queryParameters['venue-name'],
    currencyCode: state.uri.queryParameters['currency-code'],
  );

  OrderReviewRoute get _self => this as OrderReviewRoute;

  @override
  String get location => GoRouteData.$location(
    '/venues/${Uri.encodeComponent(_self.id)}/order',
    queryParams: {
      if (_self.venueName != null) 'venue-name': _self.venueName,
      if (_self.currencyCode != null) 'currency-code': _self.currencyCode,
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

RouteBase get $customerOrderRoute => GoRouteData.$route(
  path: '/venues/:id/orders/:orderId',
  name: 'customerOrder',
  hasOverriddenOnExit: false,
  factory: $CustomerOrderRoute._fromState,
);

mixin $CustomerOrderRoute on GoRouteData {
  static CustomerOrderRoute _fromState(GoRouterState state) =>
      CustomerOrderRoute(
        id: state.pathParameters['id']!,
        orderId: state.pathParameters['orderId']!,
      );

  CustomerOrderRoute get _self => this as CustomerOrderRoute;

  @override
  String get location => GoRouteData.$location(
    '/venues/${Uri.encodeComponent(_self.id)}/orders/${Uri.encodeComponent(_self.orderId)}',
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

RouteBase get $venueMenuRoute => GoRouteData.$route(
  path: '/venues/:id/menu',
  name: 'venueMenu',
  hasOverriddenOnExit: false,
  factory: $VenueMenuRoute._fromState,
);

mixin $VenueMenuRoute on GoRouteData {
  static VenueMenuRoute _fromState(GoRouterState state) => VenueMenuRoute(
    id: state.pathParameters['id']!,
    venueName: state.uri.queryParameters['venue-name'],
  );

  VenueMenuRoute get _self => this as VenueMenuRoute;

  @override
  String get location => GoRouteData.$location(
    '/venues/${Uri.encodeComponent(_self.id)}/menu',
    queryParams: {if (_self.venueName != null) 'venue-name': _self.venueName},
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
