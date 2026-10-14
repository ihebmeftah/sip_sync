import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../generated/protocol.dart';
import '../reservations/reservation_service.dart';

/// House counts for the management dashboard.
///
/// The owner of the building and employees with consultAllOrders can read it.
/// The client sends the venue's local calendar day as a UTC midnight instant,
/// the same key the reservation day list uses.
class DashboardService {
  final _reservations = ReservationService();

  /// Counts for [buildingId] on the UTC calendar day of [day].
  ///
  /// The owner of the building, and employees there with consultAllOrders, can read it.
  Future<DashboardSummary> summary(
    Session session,
    UuidValue buildingId,
    DateTime day,
  ) async {
    await _requireBuildingMember(session, buildingId);
    final range = _utcDay(day);
    await _reservations.settleNoShows(session, buildingId);

    final orders = await Future.wait([
      _orderCount(session, buildingId, range),
      _orderCount(session, buildingId, range, status: OrderStatus.progress),
      _orderCount(session, buildingId, range, status: OrderStatus.payed),
      _orderCount(session, buildingId, range, status: OrderStatus.cancelled),
      _orderCount(
        session,
        buildingId,
        range,
        launchedBy: ActorType.customer,
      ),
    ]);
    final items = await Future.wait([
      for (final status in OrderItemStatus.values)
        _itemCount(session, buildingId, range, status),
    ]);
    final pending = await Reservation.db.count(
      session,
      where: (t) =>
          t.buildingId.equals(buildingId) &
          t.status.equals(ReservationStatus.requested),
    );
    final today = await Reservation.db.count(
      session,
      where: (t) =>
          t.buildingId.equals(buildingId) &
          (t.startsAt >= range.start) &
          (t.startsAt < range.end),
    );
    final restock = await _ingredientsToRestock(session, buildingId);

    return DashboardSummary(
      orderTotal: orders[0],
      ordersProgress: orders[1],
      ordersPayed: orders[2],
      ordersCancelled: orders[3],
      customerOrders: orders[4],
      itemsProgress: items[OrderItemStatus.progress.index],
      itemsPicked: items[OrderItemStatus.picked.index],
      itemsReady: items[OrderItemStatus.ready.index],
      itemsServed: items[OrderItemStatus.served.index],
      itemsPayed: items[OrderItemStatus.payed.index],
      itemsCancelled: items[OrderItemStatus.cancelled.index],
      pendingReservations: pending,
      reservationsToday: today,
      ingredientsToRestock: restock,
    );
  }

  Future<int> _orderCount(
    Session session,
    UuidValue buildingId,
    ({DateTime start, DateTime end}) range, {
    OrderStatus? status,
    ActorType? launchedBy,
  }) {
    return VenueOrder.db.count(
      session,
      where: (t) {
        Expression filter =
            t.buildingId.equals(buildingId) &
            (t.createdAt >= range.start) &
            (t.createdAt < range.end);
        if (status != null) {
          filter = filter & t.status.equals(status);
        }
        if (launchedBy != null) {
          filter = filter & t.launchedByType.equals(launchedBy);
        }
        return filter;
      },
    );
  }

  Future<int> _itemCount(
    Session session,
    UuidValue buildingId,
    ({DateTime start, DateTime end}) range,
    OrderItemStatus status,
  ) {
    return VenueOrderItem.db.count(
      session,
      where: (t) =>
          t.order.buildingId.equals(buildingId) &
          (t.createdAt >= range.start) &
          (t.createdAt < range.end) &
          t.status.equals(status),
    );
  }

  /// Current stock under 10% of the full level. Exactly 10% stays off the list.
  Future<int> _ingredientsToRestock(
    Session session,
    UuidValue buildingId,
  ) async {
    final rows = await Ingredient.db.find(
      session,
      where: (t) => t.buildingId.equals(buildingId),
    );
    var low = 0;
    for (final row in rows) {
      if (_needsRestock(row)) low++;
    }
    return low;
  }

  bool _needsRestock(Ingredient row) {
    if (row.initialStock <= 0) {
      return row.currentStock <= 0;
    }
    return row.currentStock / row.initialStock < 0.10;
  }

  ({DateTime start, DateTime end}) _utcDay(DateTime instant) {
    final utc = instant.toUtc();
    final start = DateTime.utc(utc.year, utc.month, utc.day);
    return (start: start, end: start.add(const Duration(days: 1)));
  }

  Future<void> _requireBuildingMember(
    Session session,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null) {
      throw AccountException(
        message: 'Building not found.',
        code: AccountErrorCode.notFound,
      );
    }
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType == ActorType.owner && building.ownerId == ctx.actorId) {
      return;
    }
    if (ctx.actorType == ActorType.employee) {
      final employee = await Employee.db.findById(
        session,
        ctx.actorId,
        include: Employee.include(access: EmployeeAccess.include()),
      );
      if (employee != null &&
          employee.buildingId == buildingId &&
          employee.access?.consultAllOrders == true) {
        return;
      }
    }
    throw AccountException(
      message: 'Not allowed for this building.',
      code: AccountErrorCode.notAuthorized,
    );
  }
}
