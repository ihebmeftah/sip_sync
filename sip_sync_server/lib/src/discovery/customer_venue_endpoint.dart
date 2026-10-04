import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../generated/protocol.dart';
import 'customer_venue_service.dart';

/// Public venue cards for signed-in customers.
class CustomerVenueEndpoint extends Endpoint {
  final _venues = CustomerVenueService();

  @override
  bool get requireLogin => true;

  /// Every venue as a [CustomerVenueCard]. Customers only.
  ///
  /// Omits owner identity, staff, and order-pipeline flags. Distance is
  /// computed on the client from the customer's chosen place.
  Future<List<CustomerVenueCard>> list(Session session) async {
    AuthGuard.requireCustomer(session);
    final rows = await Building.db.find(
      session,
      orderBy: (t) => t.name,
      include: Building.include(pack: Pack.include()),
    );
    return [
      for (final row in rows)
        if (row.id != null && row.pack?.customerDiscovery == true)
          CustomerVenueCard(
            id: row.id!,
            name: row.name,
            type: row.type,
            address: row.address,
            latitude: row.latitude,
            longitude: row.longitude,
            openingMinutes: row.openingMinutes,
            closingMinutes: row.closingMinutes,
            phoneNumber: row.phoneNumber,
          ),
    ];
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

  /// Full menu in catalog order. Customers only.
  Future<CustomerMenu> menu(Session session, UuidValue buildingId) async {
    AuthGuard.requireCustomer(session);
    return _venues.menu(session, buildingId);
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
