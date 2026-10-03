import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/views/register_view.dart';
import '../../features/auth/views/sign_in_view.dart';
import '../../features/home/views/home_view.dart';
import '../../features/onboarding/views/onboarding_view.dart';
import '../../features/orders/views/customer_orders_view.dart';
import '../../features/venue/views/customer_order_receipt_view.dart';
import '../../features/venue/views/order_review_view.dart';
import '../../features/venue/views/table_scan_view.dart';
import '../../features/venue/views/venue_detail_view.dart';
import '../../features/venue/views/venue_menu_view.dart';

part 'app_routes.g.dart';

@TypedGoRoute<OnboardingRoute>(path: '/onboarding', name: 'onboarding')
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingView();
}

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

@TypedGoRoute<OrderHistoryRoute>(path: '/orders', name: 'orderHistory')
class OrderHistoryRoute extends GoRouteData with $OrderHistoryRoute {
  const OrderHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OrderHistoryView();
}

@TypedGoRoute<HomeRoute>(path: '/', name: 'home')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeView();
}

@TypedGoRoute<TableScanRoute>(path: '/scan', name: 'tableScan')
class TableScanRoute extends GoRouteData with $TableScanRoute {
  const TableScanRoute({this.changing = false, this.buildingId});

  /// True when the customer is changing the table they already opened.
  final bool changing;

  /// Venue page that opened the scanner, when there is one.
  final String? buildingId;

  @override
  Widget build(BuildContext context, GoRouterState state) => TableScanView(
    changing: changing,
    buildingId: buildingId,
  );
}

@TypedGoRoute<VenueRoute>(path: '/venues/:id', name: 'venue')
class VenueRoute extends GoRouteData with $VenueRoute {
  const VenueRoute({required this.id});

  /// Building id as a UUID string.
  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      VenueDetailView(buildingId: id);
}

@TypedGoRoute<OrderReviewRoute>(path: '/venues/:id/order', name: 'orderReview')
class OrderReviewRoute extends GoRouteData with $OrderReviewRoute {
  const OrderReviewRoute({
    required this.id,
    this.venueName,
    this.currencyCode,
  });

  /// Building id as a UUID string.
  final String id;

  /// Venue name shown above the selection.
  final String? venueName;

  /// Menu currency used for the preview total.
  final String? currencyCode;

  @override
  Widget build(BuildContext context, GoRouterState state) => OrderReviewView(
    buildingId: id,
    venueName: venueName,
    currencyCode: currencyCode ?? '',
  );
}

@TypedGoRoute<CustomerOrderRoute>(
  path: '/venues/:id/orders/:orderId',
  name: 'customerOrder',
)
class CustomerOrderRoute extends GoRouteData with $CustomerOrderRoute {
  const CustomerOrderRoute({required this.id, required this.orderId});

  /// Building id as a UUID string.
  final String id;

  /// Order id as a UUID string.
  final String orderId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      CustomerOrderReceiptView(buildingId: id, orderId: orderId);
}

@TypedGoRoute<VenueMenuRoute>(path: '/venues/:id/menu', name: 'venueMenu')
class VenueMenuRoute extends GoRouteData with $VenueMenuRoute {
  const VenueMenuRoute({required this.id, this.venueName});

  /// Building id as a UUID string.
  final String id;

  /// Shown as the menu title when the customer opened it from the venue page.
  final String? venueName;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      VenueMenuView(buildingId: id, venueName: venueName);
}
