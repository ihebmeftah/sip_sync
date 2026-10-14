import 'package:serverpod/serverpod.dart';

import '../auth/auth_context.dart';
import '../auth/auth_guard.dart';
import '../core/page_window.dart';
import '../generated/protocol.dart';

/// Stores alerts and publishes each new row on a per-actor channel.
///
/// The channel name is derived from the signed-in actor, never from the
/// client, so one user cannot subscribe to another's alerts.
class NotificationService {
  static String channel(ActorType type, UuidValue id) =>
      'app-notification:${type.name}:${id.uuid}';

  /// Alerts the customer who launched [order] that one line changed.
  ///
  /// When that change also moves the order (paid or cancelled), a second
  /// alert is stored for the order. Staff-launched orders are skipped until
  /// management recipients are chosen.
  Future<void> recordItemChange(
    Session session, {
    required VenueOrder order,
    required VenueOrderItem item,
    required String venueName,
    required OrderStatus previousOrderStatus,
    required OrderStatus nextOrderStatus,
  }) async {
    if (order.launchedByType != ActorType.customer || order.id == null) {
      return;
    }
    await _record(
      session,
      recipientType: order.launchedByType,
      recipientId: order.launchedById,
      buildingId: order.buildingId,
      venueName: venueName,
      subjectId: order.id!,
      kind: AppNotificationKind.orderItem,
      orderItemId: item.id,
      orderRef: order.ref,
      articleName: item.articleName,
      itemStatus: item.status,
      cancellationReason: item.cancellationReason,
    );
    if (nextOrderStatus == previousOrderStatus) {
      return;
    }
    await _record(
      session,
      recipientType: order.launchedByType,
      recipientId: order.launchedById,
      buildingId: order.buildingId,
      venueName: venueName,
      subjectId: order.id!,
      kind: AppNotificationKind.order,
      orderRef: order.ref,
      orderStatus: nextOrderStatus,
      cancellationReason: nextOrderStatus == OrderStatus.cancelled
          ? item.cancellationReason
          : null,
    );
  }

  /// One alert for a whole-order cancel. Lines cancelled with it are not
  /// each announced; the order alert carries the reason.
  Future<void> recordOrderCancelled(
    Session session, {
    required VenueOrder order,
    required String venueName,
    required OrderCancellationReason reason,
  }) async {
    if (order.launchedByType != ActorType.customer || order.id == null) {
      return;
    }
    await _record(
      session,
      recipientType: order.launchedByType,
      recipientId: order.launchedById,
      buildingId: order.buildingId,
      venueName: venueName,
      subjectId: order.id!,
      kind: AppNotificationKind.order,
      orderRef: order.ref,
      orderStatus: OrderStatus.cancelled,
      cancellationReason: reason,
    );
  }

  /// Tells the venue owner and staff who can manage reservations that a
  /// customer asked to book.
  ///
  /// The customer who sent the request is not notified. The row stays in the
  /// inbox until it is opened.
  Future<void> recordReservationRequest(
    Session session, {
    required Reservation reservation,
  }) async {
    if (reservation.id == null) {
      return;
    }
    final building = await Building.db.findById(
      session,
      reservation.buildingId,
    );
    if (building == null) {
      return;
    }
    final targets = await _reservationDesk(session, building);
    for (final target in targets) {
      await _record(
        session,
        recipientType: target.type,
        recipientId: target.id,
        buildingId: reservation.buildingId,
        venueName: building.name,
        subjectId: reservation.id!,
        kind: AppNotificationKind.reservation,
        reservationStatus: ReservationStatus.requested,
      );
    }
  }

  /// Tells the customer, the owner, and staff who can manage reservations
  /// that a reservation was accepted or cancelled.
  ///
  /// Staff are not notified of their own change. A customer who cancels their
  /// own reservation still receives the alert.
  Future<void> recordReservationChange(
    Session session, {
    required Reservation reservation,
    required ReservationStatus status,
    ActorType? actorType,
    UuidValue? actorId,
  }) async {
    if (reservation.id == null) {
      return;
    }
    if (status != ReservationStatus.confirmed &&
        status != ReservationStatus.cancelled) {
      return;
    }
    final building = await Building.db.findById(
      session,
      reservation.buildingId,
    );
    if (building == null) {
      return;
    }
    final customerCancelled =
        status == ReservationStatus.cancelled &&
        actorType == ActorType.customer;
    final targets = <({ActorType type, UuidValue id})>[
      if (reservation.customerId != null)
        (type: ActorType.customer, id: reservation.customerId!),
      ...await _reservationDesk(session, building),
    ];
    for (final target in targets) {
      final isActor = target.type == actorType && target.id == actorId;
      if (isActor &&
          !(customerCancelled && target.type == ActorType.customer)) {
        continue;
      }
      await _record(
        session,
        recipientType: target.type,
        recipientId: target.id,
        buildingId: reservation.buildingId,
        venueName: building.name,
        subjectId: reservation.id!,
        kind: AppNotificationKind.reservation,
        reservationStatus: status,
      );
    }
  }

  /// Owner of [building], plus enabled employees whose access includes
  /// reservations.
  Future<List<({ActorType type, UuidValue id})>> _reservationDesk(
    Session session,
    Building building,
  ) async {
    final staff = await Employee.db.find(
      session,
      where: (t) =>
          t.buildingId.equals(building.id!) & t.isEnabled.equals(true),
      include: Employee.include(access: EmployeeAccess.include()),
    );
    return [
      (type: ActorType.owner, id: building.ownerId),
      for (final employee in staff)
        if (employee.id != null && employee.access?.reservations == true)
          (type: ActorType.employee, id: employee.id!),
    ];
  }

  /// Newest alerts for the signed-in actor.
  ///
  /// [buildingId] limits the page to one venue. An employee is always limited
  /// to the building they work in; another id is not authorized. [createdFrom]
  /// and [createdTo] are both omitted or both set, and the window is at most
  /// 32 days. [unreadOnly] keeps rows that have not been opened.
  Future<AppNotificationPage> list(
    Session session, {
    UuidValue? buildingId,
    DateTime? createdFrom,
    DateTime? createdTo,
    bool? unreadOnly,
    int? limit,
    int? offset,
  }) async {
    final ctx = _actor(session);
    final venueId = await _venueLimit(session, ctx, buildingId);
    _checkWindow(createdFrom, createdTo);
    final window = PageWindow.from(limit: limit, offset: offset);
    Expression where(AppNotificationTable t) => _scope(
      t,
      ctx,
      buildingId: venueId,
      createdFrom: createdFrom,
      createdTo: createdTo,
      unreadOnly: unreadOnly ?? false,
    );
    final total = await AppNotification.db.count(session, where: where);
    final rows = await AppNotification.db.find(
      session,
      where: where,
      orderBy: (t) => t.createdAt.desc(),
      limit: window.limit,
      offset: window.offset,
    );
    return AppNotificationPage(
      items: [for (final row in rows) _view(row)],
      total: total,
      limit: window.limit,
      offset: window.offset,
    );
  }

  /// Alerts this actor has not opened.
  ///
  /// An employee is counted only in the building they work in. An owner or
  /// customer is counted across every venue unless the client passes one.
  Future<int> unreadCount(Session session, {UuidValue? buildingId}) async {
    final ctx = _actor(session);
    final venueId = await _venueLimit(session, ctx, buildingId);
    return AppNotification.db.count(
      session,
      where: (t) => _scope(
        t,
        ctx,
        buildingId: venueId,
        unreadOnly: true,
      ),
    );
  }

  /// Marks every unread alert in the same scope as [list]. Returns the count.
  Future<int> markAllRead(
    Session session, {
    UuidValue? buildingId,
    DateTime? createdFrom,
    DateTime? createdTo,
  }) async {
    final ctx = _actor(session);
    final venueId = await _venueLimit(session, ctx, buildingId);
    _checkWindow(createdFrom, createdTo);
    final now = DateTime.now().toUtc();
    Expression where(AppNotificationTable t) => _scope(
      t,
      ctx,
      buildingId: venueId,
      createdFrom: createdFrom,
      createdTo: createdTo,
      unreadOnly: true,
    );
    final count = await AppNotification.db.count(session, where: where);
    if (count == 0) {
      return 0;
    }
    await AppNotification.db.updateWhere(
      session,
      where: where,
      columnValues: (t) => [t.readAt(now)],
      noReturn: true,
    );
    return count;
  }

  /// Marks one of this actor's alerts read. Another actor's id looks missing.
  Future<AppNotificationView> markRead(Session session, UuidValue id) async {
    final ctx = _actor(session);
    final row = await AppNotification.db.findById(session, id);
    if (row == null ||
        row.recipientType != ctx.actorType ||
        row.recipientId != ctx.actorId) {
      throw NotificationException(
        message: 'Notification not found.',
        code: NotificationErrorCode.notFound,
      );
    }
    if (row.readAt != null) {
      return _view(row);
    }
    final saved = await AppNotification.db.updateRow(
      session,
      row.copyWith(readAt: DateTime.now().toUtc()),
    );
    return _view(saved);
  }

  /// New alerts for the signed-in actor. History is [list], not this stream.
  Stream<AppNotificationView> watch(Session session) async* {
    final ctx = _actor(session);
    final updates = session.messages.createStream<AppNotificationView>(
      channel(ctx.actorType, ctx.actorId),
    );
    yield* updates;
  }

  Future<void> _record(
    Session session, {
    required ActorType recipientType,
    required UuidValue recipientId,
    required UuidValue buildingId,
    required String venueName,
    required UuidValue subjectId,
    required AppNotificationKind kind,
    UuidValue? orderItemId,
    int? orderRef,
    String? articleName,
    OrderItemStatus? itemStatus,
    OrderStatus? orderStatus,
    ReservationStatus? reservationStatus,
    OrderCancellationReason? cancellationReason,
  }) async {
    final saved = await AppNotification.db.insertRow(
      session,
      AppNotification(
        recipientType: recipientType,
        recipientId: recipientId,
        buildingId: buildingId,
        venueName: venueName,
        subjectId: subjectId,
        kind: kind,
        orderItemId: orderItemId,
        orderRef: orderRef,
        articleName: articleName,
        itemStatus: itemStatus,
        orderStatus: orderStatus,
        reservationStatus: reservationStatus,
        cancellationReason: cancellationReason,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    await session.messages.postMessage(
      channel(saved.recipientType, saved.recipientId),
      _view(saved),
    );
  }

  AuthContext _actor(Session session) => AuthGuard.requireAny(session);

  /// Employees only read the building they work in.
  ///
  /// Omitting [buildingId] selects that workplace. A different id is rejected.
  /// Owners and customers keep the id they sent, including null for every
  /// venue they already receive.
  Future<UuidValue?> _venueLimit(
    Session session,
    AuthContext ctx,
    UuidValue? buildingId,
  ) async {
    if (ctx.actorType != ActorType.employee) {
      return buildingId;
    }
    final employee = await Employee.db.findById(session, ctx.actorId);
    if (employee == null) {
      throw NotificationException(
        message: 'Notification not found.',
        code: NotificationErrorCode.notFound,
      );
    }
    if (buildingId != null && buildingId != employee.buildingId) {
      throw NotificationException(
        message: 'Not allowed for this building.',
        code: NotificationErrorCode.notAuthorized,
      );
    }
    return employee.buildingId;
  }

  /// Both bounds or neither. A month is the longest window the apps send.
  void _checkWindow(DateTime? from, DateTime? to) {
    if (from == null && to == null) {
      return;
    }
    if (from == null ||
        to == null ||
        !to.isAfter(from) ||
        to.difference(from) > const Duration(days: 32)) {
      throw NotificationException(
        message: 'Notification window is not valid.',
        code: NotificationErrorCode.invalidInput,
      );
    }
  }

  Expression _scope(
    AppNotificationTable t,
    AuthContext ctx, {
    UuidValue? buildingId,
    DateTime? createdFrom,
    DateTime? createdTo,
    required bool unreadOnly,
  }) {
    var expression =
        t.recipientType.equals(ctx.actorType) &
        t.recipientId.equals(ctx.actorId);
    if (buildingId != null) {
      expression = expression & t.buildingId.equals(buildingId);
    }
    if (createdFrom != null && createdTo != null) {
      expression =
          expression & (t.createdAt >= createdFrom) & (t.createdAt < createdTo);
    }
    if (unreadOnly) {
      expression = expression & t.readAt.equals(null);
    }
    return expression;
  }

  AppNotificationView _view(AppNotification row) {
    return AppNotificationView(
      id: row.id!,
      buildingId: row.buildingId,
      venueName: row.venueName,
      subjectId: row.subjectId,
      orderItemId: row.orderItemId,
      orderRef: row.orderRef,
      articleName: row.articleName,
      kind: row.kind,
      itemStatus: row.itemStatus,
      orderStatus: row.orderStatus,
      reservationStatus: row.reservationStatus,
      cancellationReason: row.cancellationReason,
      read: row.readAt != null,
      createdAt: row.createdAt,
    );
  }
}
