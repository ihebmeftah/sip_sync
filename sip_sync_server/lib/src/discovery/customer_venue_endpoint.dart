import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../generated/protocol.dart';

/// Public venue cards for signed-in customers.
class CustomerVenueEndpoint extends Endpoint {
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
    );
    return [
      for (final row in rows)
        if (row.id != null)
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
}
