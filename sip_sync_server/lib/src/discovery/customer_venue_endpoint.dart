import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../generated/protocol.dart';
import 'customer_venue_service.dart';

/// Public venue cards for signed-in customers.
class CustomerVenueEndpoint extends Endpoint {
  final _venues = CustomerVenueService();

  @override
  bool get requireLogin => true;

  /// Public venue cards, name order, or nearest first when a place is set.
  ///
  /// Customers only. [nearbyOnly] keeps venues inside 15 km of
  /// [latitude]/[longitude]. [limit] defaults to 20 and is capped at 100.
  /// Omits owner identity, staff, and order-pipeline flags.
  Future<CustomerVenuePage> list(
    Session session, {
    int? limit,
    int? offset,
    double? latitude,
    double? longitude,
    bool nearbyOnly = false,
  }) {
    AuthGuard.requireCustomer(session);
    return _venues.list(
      session,
      limit: limit,
      offset: offset,
      latitude: latitude,
      longitude: longitude,
      nearbyOnly: nearbyOnly,
    );
  }

  /// Venue page: free tables and the top categories and articles.
  ///
  /// Customers only. Missing venues throw [BuildingException.notFound].
  Future<CustomerVenueDetail> detail(
    Session session,
    UuidValue buildingId,
  ) async {
    AuthGuard.requireCustomer(session);
    return _venues.detail(session, buildingId);
  }

  /// Menu window in catalog order, plus every category for the rail.
  ///
  /// Customers only. [limit] defaults to 20 articles and is capped at 100.
  Future<CustomerMenu> menu(
    Session session,
    UuidValue buildingId, {
    int? limit,
    int? offset,
  }) async {
    AuthGuard.requireCustomer(session);
    return _venues.menu(session, buildingId, limit: limit, offset: offset);
  }

  /// Confirms a scanned table sticker belongs to an active table.
  ///
  /// Customers only. A missing, inactive, or mismatched sticker throws
  /// [BuildingException]. Occupied tables still resolve: the customer is
  /// sitting there, and the venue page marks that seat.
  Future<CustomerSeatedTable> resolveTable(
    Session session,
    UuidValue buildingId,
    UuidValue tableId,
    int number,
  ) async {
    AuthGuard.requireCustomer(session);
    return _venues.resolveTable(session, buildingId, tableId, number);
  }
}
