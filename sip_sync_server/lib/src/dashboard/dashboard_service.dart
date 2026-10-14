import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../generated/protocol.dart';
import '../menu/ingredient_service.dart';
import '../reservations/reservation_service.dart';

/// House counts for the management dashboard.
///
/// The owner of the building and employees with consultAllOrders can read it.
/// The client sends the venue's local calendar day as a UTC midnight instant,
/// the same key the reservation day list uses.
class DashboardService {
  final _reservations = ReservationService();
  final _ingredients = IngredientService();

  /// Counts for [buildingId] on the UTC calendar day of [day].
  ///
  /// When the venue requires a cash register, order and item counts use
  /// [cashRegisterSessionId], or the shift in progress when that id is
  /// omitted. A shut drawer zeros those counts. Reservations and stock
  /// stay on the calendar day.
  ///
  /// The owner of the building, and employees there with consultAllOrders, can read it.
  Future<DashboardSummary> summary(
    Session session,
    UuidValue buildingId,
    DateTime day, {
    UuidValue? cashRegisterSessionId,
  }) async {
    await _requireBuildingMember(session, buildingId);
    final range = _utcDay(day);
    await _reservations.settleNoShows(session, buildingId);
    final registerScope = await _registerScope(
      session,
      buildingId,
      cashRegisterSessionId,
    );

    final orders = registerScope.zero
        ? List<int>.filled(5, 0)
        : await Future.wait([
            _orderCount(
              session,
              buildingId,
              range,
              cashRegisterSessionId: registerScope.sessionId,
            ),
            _orderCount(
              session,
              buildingId,
              range,
              status: OrderStatus.progress,
              cashRegisterSessionId: registerScope.sessionId,
            ),
            _orderCount(
              session,
              buildingId,
              range,
              status: OrderStatus.payed,
              cashRegisterSessionId: registerScope.sessionId,
            ),
            _orderCount(
              session,
              buildingId,
              range,
              status: OrderStatus.cancelled,
              cashRegisterSessionId: registerScope.sessionId,
            ),
            _orderCount(
              session,
              buildingId,
              range,
              launchedBy: ActorType.customer,
              cashRegisterSessionId: registerScope.sessionId,
            ),
          ]);
    final items = registerScope.zero
        ? List<int>.filled(OrderItemStatus.values.length, 0)
        : await Future.wait([
            for (final status in OrderItemStatus.values)
              _itemCount(
                session,
                buildingId,
                range,
                status,
                cashRegisterSessionId: registerScope.sessionId,
              ),
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
          t.status.equals(ReservationStatus.confirmed) &
          (t.startsAt >= range.start) &
          (t.startsAt < range.end),
    );
    final restock = await _ingredients.outOfStockCount(session, buildingId);

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

  /// [sessionId] set means the shift replaces the calendar day. [zero] means
  /// the venue requires a register and none is open.
  Future<({UuidValue? sessionId, bool zero})> _registerScope(
    Session session,
    UuidValue buildingId,
    UuidValue? requested,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null || !building.cashRegisterEnabled) {
      return (sessionId: null, zero: false);
    }
    if (requested != null) {
      final row = await CashRegisterSession.db.findById(session, requested);
      if (row == null || row.buildingId != buildingId) {
        throw AccountException(
          message: 'Cash register not found.',
          code: AccountErrorCode.notFound,
        );
      }
      return (sessionId: row.id, zero: false);
    }
    final open = await CashRegisterSession.db.findFirstRow(
      session,
      where: (t) =>
          t.buildingId.equals(buildingId) &
          t.status.equals(CashRegisterStatus.progress),
    );
    if (open == null) {
      return (sessionId: null, zero: true);
    }
    return (sessionId: open.id, zero: false);
  }

  Future<int> _orderCount(
    Session session,
    UuidValue buildingId,
    ({DateTime start, DateTime end}) range, {
    OrderStatus? status,
    ActorType? launchedBy,
    UuidValue? cashRegisterSessionId,
  }) {
    return VenueOrder.db.count(
      session,
      where: (t) {
        var filter = t.buildingId.equals(buildingId);
        if (cashRegisterSessionId != null) {
          filter =
              filter & t.cashRegisterSessionId.equals(cashRegisterSessionId);
        } else {
          filter =
              filter & (t.createdAt >= range.start) & (t.createdAt < range.end);
        }
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
    OrderItemStatus status, {
    UuidValue? cashRegisterSessionId,
  }) {
    return VenueOrderItem.db.count(
      session,
      where: (t) {
        var filter =
            t.order.buildingId.equals(buildingId) & t.status.equals(status);
        if (cashRegisterSessionId != null) {
          filter =
              filter &
              t.order.cashRegisterSessionId.equals(cashRegisterSessionId);
        } else {
          filter =
              filter & (t.createdAt >= range.start) & (t.createdAt < range.end);
        }
        return filter;
      },
    );
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
