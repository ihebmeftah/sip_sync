import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../core/page_window.dart';
import '../generated/protocol.dart';
import '../packs/pack_gate.dart';

/// Open and close one cash-register shift per venue.
///
/// Owners and employees with the cash-register flag can open, close, and
/// read history. Any member of the building can read the shift in progress
/// so the order board and dashboard can follow it.
class CashRegisterService {
  /// The shift in progress for [buildingId], or null when the drawer is shut.
  Future<CashRegisterSessionView?> current(
    Session session,
    UuidValue buildingId,
  ) async {
    await _requireMember(session, buildingId);
    final row = await _progress(session, buildingId);
    if (row == null) {
      return null;
    }
    return _view(session, row);
  }

  /// Opens a shift. Rejects a second one, a pack that leaves it off, and a
  /// venue that has not turned the switch on.
  ///
  /// [startCash] is optional. A negative amount is rejected.
  Future<CashRegisterSessionView> open(
    Session session,
    UuidValue buildingId, {
    double? startCash,
  }) async {
    _requireAmount(startCash);
    final building = await _requireOperator(session, buildingId);
    if (!building.cashRegisterEnabled) {
      throw CashRegisterException(
        message: 'This venue has not turned on the cash register.',
        code: CashRegisterErrorCode.disabled,
      );
    }
    final pack = await PackGate.ofBuilding(session, buildingId);
    PackGate.requireFeature(pack.cashRegister, PackFeature.cashRegister);
    final existing = await _progress(session, buildingId);
    if (existing != null) {
      throw CashRegisterException(
        message: 'A cash register is already open.',
        code: CashRegisterErrorCode.registerAlreadyOpen,
      );
    }
    final ctx = AuthGuard.requireAny(session);
    final row = await CashRegisterSession.db.insertRow(
      session,
      CashRegisterSession(
        buildingId: buildingId,
        status: CashRegisterStatus.progress,
        openedByType: ctx.actorType,
        openedById: ctx.actorId,
        openedAt: DateTime.now().toUtc(),
        startCash: startCash,
      ),
    );
    return _view(session, row);
  }

  /// Closes [id] when that shift has no order still in progress.
  ///
  /// Allowed after the venue switch is turned off, so a shift that is
  /// already open can still end.
  ///
  /// [endCash] is required when this shift stored an opening count.
  Future<CashRegisterSessionView> close(
    Session session,
    UuidValue id, {
    double? endCash,
  }) async {
    _requireAmount(endCash);
    final row = await CashRegisterSession.db.findById(session, id);
    if (row == null) {
      throw CashRegisterException(
        message: 'Cash register not found.',
        code: CashRegisterErrorCode.notFound,
      );
    }
    await _requireOperator(session, row.buildingId);
    if (row.status != CashRegisterStatus.progress) {
      throw CashRegisterException(
        message: 'This cash register is not open.',
        code: CashRegisterErrorCode.registerNotOpen,
      );
    }
    if (row.startCash != null && endCash == null) {
      throw CashRegisterException(
        message: 'Enter the closing cash. This shift has an opening count.',
        code: CashRegisterErrorCode.endCashRequired,
      );
    }
    final openOrders = await VenueOrder.db.count(
      session,
      where: (t) =>
          t.cashRegisterSessionId.equals(row.id!) &
          t.status.equals(OrderStatus.progress),
    );
    if (openOrders > 0) {
      throw CashRegisterException(
        message: 'Pay or cancel the open tickets before closing.',
        code: CashRegisterErrorCode.registerHasOpenOrders,
      );
    }
    final ctx = AuthGuard.requireAny(session);
    final updated = await CashRegisterSession.db.updateRow(
      session,
      row.copyWith(
        status: CashRegisterStatus.closed,
        closedByType: ctx.actorType,
        closedById: ctx.actorId,
        closedAt: DateTime.now().toUtc(),
        endCash: endCash,
      ),
    );
    return _view(session, updated);
  }

  /// Replaces the counted cash. Only the venue owner can call this.
  Future<CashRegisterSessionView> correct(
    Session session,
    UuidValue id, {
    double? startCash,
    double? endCash,
  }) async {
    _requireAmount(startCash);
    _requireAmount(endCash);
    final row = await CashRegisterSession.db.findById(session, id);
    if (row == null) {
      throw CashRegisterException(
        message: 'Cash register not found.',
        code: CashRegisterErrorCode.notFound,
      );
    }
    await _requireOwner(session, row.buildingId);
    if (row.status == CashRegisterStatus.progress) {
      if (endCash != null) {
        throw CashRegisterException(
          message: 'Closing cash is counted when the register is closed.',
          code: CashRegisterErrorCode.registerNotOpen,
        );
      }
      final updated = await CashRegisterSession.db.updateRow(
        session,
        row.copyWith(startCash: startCash),
      );
      return _view(session, updated);
    }
    if (startCash != null && endCash == null) {
      throw CashRegisterException(
        message: 'Enter the closing cash. This shift has an opening count.',
        code: CashRegisterErrorCode.endCashRequired,
      );
    }
    final updated = await CashRegisterSession.db.updateRow(
      session,
      row.copyWith(startCash: startCash, endCash: endCash),
    );
    return _view(session, updated);
  }

  /// Closed and open shifts for [buildingId], newest first.
  ///
  /// [openedFrom] and [openedTo] together keep shifts that started in that
  /// window. One bound without the other is rejected.
  Future<CashRegisterPage> list(
    Session session,
    UuidValue buildingId, {
    DateTime? openedFrom,
    DateTime? openedTo,
    int? limit,
    int? offset,
  }) async {
    await _requireOperator(session, buildingId);
    final day = _openedWindow(openedFrom, openedTo);
    final window = PageWindow.from(limit: limit, offset: offset);
    Expression where(CashRegisterSessionTable t) {
      var filter = t.buildingId.equals(buildingId);
      if (day != null) {
        filter = filter & (t.openedAt >= day.from) & (t.openedAt < day.to);
      }
      return filter;
    }

    final total = await CashRegisterSession.db.count(session, where: where);
    final rows = await CashRegisterSession.db.find(
      session,
      where: where,
      orderBy: (t) => t.openedAt.desc(),
      limit: window.limit,
      offset: window.offset,
    );
    final totals = await _paidTotals(session, [
      for (final row in rows)
        if (row.id != null) row.id!,
    ]);
    final items = <CashRegisterSessionView>[];
    for (final row in rows) {
      items.add(
        await _view(session, row, paidTotal: totals[row.id] ?? 0),
      );
    }
    return CashRegisterPage(
      items: items,
      total: total,
      limit: window.limit,
      offset: window.offset,
    );
  }

  /// One local day, or null when the caller wants every shift.
  ({DateTime from, DateTime to})? _openedWindow(
    DateTime? openedFrom,
    DateTime? openedTo,
  ) {
    if (openedFrom == null && openedTo == null) {
      return null;
    }
    if (openedFrom == null ||
        openedTo == null ||
        !openedTo.isAfter(openedFrom) ||
        openedTo.difference(openedFrom) > const Duration(hours: 36)) {
      throw CashRegisterException(
        message: 'Pick a single day.',
        code: CashRegisterErrorCode.invalidAmount,
      );
    }
    return (from: openedFrom, to: openedTo);
  }

  /// Blank cash is allowed. A counted amount must be zero or greater.
  void _requireAmount(double? amount) {
    if (amount == null) {
      return;
    }
    if (amount.isNaN || amount.isInfinite || amount < 0) {
      throw CashRegisterException(
        message: 'Cash amount must be zero or greater.',
        code: CashRegisterErrorCode.invalidAmount,
      );
    }
  }

  Future<CashRegisterSession?> _progress(
    Session session,
    UuidValue buildingId,
  ) {
    return CashRegisterSession.db.findFirstRow(
      session,
      where: (t) =>
          t.buildingId.equals(buildingId) &
          t.status.equals(CashRegisterStatus.progress),
    );
  }

  Future<CashRegisterSessionView> _view(
    Session session,
    CashRegisterSession row, {
    double? paidTotal,
  }) async {
    final count = await VenueOrder.db.count(
      session,
      where: (t) => t.cashRegisterSessionId.equals(row.id!),
    );
    final paid = paidTotal ?? await _paidTotal(session, row.id!);
    return CashRegisterSessionView(
      id: row.id!,
      buildingId: row.buildingId,
      status: row.status,
      openedBy: await _actor(session, row.openedByType, row.openedById),
      openedAt: row.openedAt,
      startCash: row.startCash,
      closedBy: await _actorOrNull(
        session,
        row.closedByType,
        row.closedById,
      ),
      closedAt: row.closedAt,
      endCash: row.endCash,
      orderCount: count,
      paidTotal: paid,
    );
  }

  Future<double> _paidTotal(Session session, UuidValue sessionId) async {
    final totals = await _paidTotals(session, [sessionId]);
    return totals[sessionId] ?? 0;
  }

  /// Sum of payed lines stamped with each session. Cancelled lines are skipped.
  Future<Map<UuidValue, double>> _paidTotals(
    Session session,
    List<UuidValue> sessionIds,
  ) async {
    if (sessionIds.isEmpty) {
      return const {};
    }
    final orders = await VenueOrder.db.find(
      session,
      where: (t) =>
          t.cashRegisterSessionId.inSet(sessionIds.toSet()) &
          t.status.equals(OrderStatus.payed),
      include: VenueOrder.include(items: VenueOrderItem.includeList()),
    );
    final totals = <UuidValue, double>{};
    for (final order in orders) {
      final id = order.cashRegisterSessionId;
      if (id == null) {
        continue;
      }
      var sum = totals[id] ?? 0;
      for (final item in order.items ?? const <VenueOrderItem>[]) {
        if (item.status == OrderItemStatus.cancelled) {
          continue;
        }
        sum += item.unitPrice;
      }
      totals[id] = sum;
    }
    return totals;
  }

  Future<OrderActorView?> _actorOrNull(
    Session session,
    ActorType? type,
    UuidValue? id,
  ) async {
    if (type == null || id == null) {
      return null;
    }
    return _actor(session, type, id);
  }

  Future<OrderActorView> _actor(
    Session session,
    ActorType type,
    UuidValue id,
  ) async {
    var first = '';
    var last = '';
    switch (type) {
      case ActorType.owner:
        final owner = await Owner.db.findById(session, id);
        first = owner?.firstName ?? '';
        last = owner?.lastName ?? '';
      case ActorType.employee:
        final employee = await Employee.db.findById(session, id);
        first = employee?.firstName ?? '';
        last = employee?.lastName ?? '';
      case ActorType.customer:
      case ActorType.superAdmin:
        break;
    }
    return OrderActorView(type: type, id: id, firstName: first, lastName: last);
  }

  /// Owner of the building, or an employee assigned there.
  Future<Building> _requireMember(Session session, UuidValue buildingId) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null) {
      throw CashRegisterException(
        message: 'Building not found.',
        code: CashRegisterErrorCode.notFound,
      );
    }
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType == ActorType.owner && building.ownerId == ctx.actorId) {
      return building;
    }
    if (ctx.actorType == ActorType.employee) {
      final employee = await Employee.db.findById(session, ctx.actorId);
      if (employee != null && employee.buildingId == buildingId) {
        return building;
      }
    }
    throw CashRegisterException(
      message: 'Not allowed for this building.',
      code: CashRegisterErrorCode.notAuthorized,
    );
  }

  /// The owner of [buildingId]. Employees cannot correct counted cash.
  Future<Building> _requireOwner(Session session, UuidValue buildingId) async {
    final building = await _requireMember(session, buildingId);
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType == ActorType.owner && building.ownerId == ctx.actorId) {
      return building;
    }
    throw CashRegisterException(
      message: 'Only the owner can correct the counted cash.',
      code: CashRegisterErrorCode.notAuthorized,
    );
  }

  /// Owner, or an employee whose profile includes the cash-register flag.
  Future<Building> _requireOperator(
    Session session,
    UuidValue buildingId,
  ) async {
    final building = await _requireMember(session, buildingId);
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType == ActorType.owner) {
      return building;
    }
    final employee = await Employee.db.findById(
      session,
      ctx.actorId,
      include: Employee.include(access: EmployeeAccess.include()),
    );
    if (employee?.access?.cashRegister == true) {
      return building;
    }
    throw CashRegisterException(
      message: 'Not allowed to operate the cash register.',
      code: CashRegisterErrorCode.notAuthorized,
    );
  }
}
