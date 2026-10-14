import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'dashboard_service.dart';

/// House counts for the management dashboard of one building.
class DashboardEndpoint extends Endpoint {
  final _dashboard = DashboardService();

  @override
  bool get requireLogin => true;

  /// Orders, item lines, reservations, and low stock for [buildingId].
  ///
  /// [day] is the venue's local calendar date stored as UTC midnight.
  /// The owner of the building, and employees there whose access includes
  /// consultAllOrders, can call this.
  Future<DashboardSummary> summary(
    Session session,
    UuidValue buildingId,
    DateTime day,
  ) {
    return _dashboard.summary(session, buildingId, day);
  }
}
