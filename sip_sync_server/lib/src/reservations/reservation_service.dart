import 'package:serverpod/serverpod.dart';

import '../auth/auth_context.dart';
import '../auth/auth_guard.dart';
import '../core/phone_numbers.dart';
import '../generated/protocol.dart';
import '../notifications/notification_service.dart';
import '../packs/pack_gate.dart';

/// How long before the start the floor calls a booking "soon".
const reservationSoonWindow = Duration(minutes: 30);

/// Length applied when a booking only names a start.
const reservationSeatLength = Duration(hours: 2);

/// Reservations: a customer request, a staff confirmation, then a table.
class ReservationService {
  final _notifications = NotificationService();

  /// Bookings whose start falls on the UTC date of [day].
  ///
  /// Newest rows come first.
  Future<List<ReservationView>> listForDay(
    Session session,
    UuidValue buildingId,
    DateTime day,
  ) async {
    await _requireStaff(session, buildingId);
    await _prepare(session);
    await settleNoShows(session, buildingId);
    final range = _utcDay(day);
    final rows = await Reservation.db.find(
      session,
      where: (t) =>
          t.buildingId.equals(buildingId) &
          (t.startsAt >= range.start) &
          (t.startsAt < range.end),
      include: Reservation.include(
        links: TableReservation.includeList(
          include: TableReservation.include(venueTable: VenueTable.include()),
        ),
      ),
      orderBy: (t) => t.createdAt.desc(),
    );
    return rows.map(_view).toList();
  }

  /// Customer requests for [buildingId] that staff have not accepted or cancelled.
  Future<int> pendingCount(Session session, UuidValue buildingId) async {
    await _requireStaff(session, buildingId);
    await _prepare(session);
    await settleNoShows(session, buildingId);
    return Reservation.db.count(
      session,
      where: (t) =>
          t.buildingId.equals(buildingId) &
          t.status.equals(ReservationStatus.requested),
    );
  }

  /// Upcoming requests and bookings for the signed-in customer.
  ///
  /// Newest rows come first.
  Future<List<ReservationView>> listMine(Session session) async {
    final ctx = _requireCustomer(session);
    await _prepare(session);
    await _settleForCustomer(session, ctx.actorId);
    final now = DateTime.now().toUtc();
    final rows = await Reservation.db.find(
      session,
      where: (t) =>
          t.customerId.equals(ctx.actorId) &
          (t.endsAt > now) &
          (t.status.equals(ReservationStatus.requested) |
              t.status.equals(ReservationStatus.confirmed) |
              t.status.equals(ReservationStatus.arrived)),
      include: Reservation.include(
        links: TableReservation.includeList(
          include: TableReservation.include(venueTable: VenueTable.include()),
        ),
      ),
      orderBy: (t) => t.createdAt.desc(),
    );
    return rows.map(_view).toList();
  }

  /// Staff booking. Stored as confirmed, with no table until [assignTables].
  Future<ReservationView> create(
    Session session,
    ReservationCreate request,
  ) async {
    final ctx = await _requireStaff(session, request.buildingId);
    await _prepare(session);
    final guest = await _guestForStaff(session, request);
    return _insert(
      session,
      buildingId: request.buildingId,
      startsAt: request.startsAt,
      endsAt: request.endsAt ?? request.startsAt.add(reservationSeatLength),
      customerId: guest.customerId,
      guestName: guest.name,
      guestPhone: guest.phone,
      paidAmount: request.paidAmount,
      status: ReservationStatus.confirmed,
      createdBy: ctx,
      confirmedById: ctx.actorId,
      customerMustBeFuture: false,
    );
  }

  /// Customer asks for a time. Staff confirm it before a table can be assigned.
  Future<ReservationView> createForCustomer(
    Session session,
    CustomerReservationCreate request,
  ) async {
    final ctx = _requireCustomer(session);
    await _prepare(session);
    final customer = await Customer.db.findById(session, ctx.actorId);
    if (customer == null) {
      throw ReservationException(
        message: 'Customer not found.',
        code: ReservationErrorCode.notFound,
      );
    }
    return _insert(
      session,
      buildingId: request.buildingId,
      startsAt: request.startsAt,
      endsAt: request.endsAt ?? request.startsAt.add(reservationSeatLength),
      customerId: customer.id,
      guestName: '${customer.firstName} ${customer.lastName}'.trim(),
      guestPhone: customer.phoneNumber,
      paidAmount: 0,
      status: ReservationStatus.requested,
      createdBy: ctx,
      confirmedById: null,
      customerMustBeFuture: true,
    );
  }

  /// Looks up a customer by phone for a staff booking. Exact E.164 match.
  Future<ReservationCustomerMatch> findCustomer(
    Session session,
    UuidValue buildingId,
    String phone,
  ) async {
    await _requireStaff(session, buildingId);
    if (!PhoneNumbers.isValid(phone)) {
      throw ReservationException(
        message: 'Enter a valid phone number.',
        code: ReservationErrorCode.invalidInput,
      );
    }
    final customer = await Customer.db.findFirstRow(
      session,
      where: (t) => t.phoneNumber.equals(PhoneNumbers.normalize(phone)),
    );
    if (customer == null || customer.id == null) {
      throw ReservationException(
        message: 'No customer with that phone.',
        code: ReservationErrorCode.notFound,
      );
    }
    return ReservationCustomerMatch(
      id: customer.id!,
      firstName: customer.firstName,
      lastName: customer.lastName,
      phoneNumber: customer.phoneNumber,
      email: customer.email,
    );
  }

  /// Customers whose name, phone, or email contains [query].
  ///
  /// Empty when [query] is shorter than two characters.
  Future<List<ReservationCustomerMatch>> searchCustomers(
    Session session,
    UuidValue buildingId,
    String query,
  ) async {
    await _requireStaff(session, buildingId);
    final text = query.trim();
    if (text.length < 2 || text.length > 80) {
      return [];
    }
    final pattern = '%${_escapeLike(text)}%';
    final parts = text
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    final first = parts.length >= 2 ? '%${_escapeLike(parts.first)}%' : null;
    final rest = parts.length >= 2
        ? '%${_escapeLike(parts.sublist(1).join(' '))}%'
        : null;
    final rows = await Customer.db.find(
      session,
      where: (t) {
        var match =
            t.firstName.ilike(pattern) |
            t.lastName.ilike(pattern) |
            t.phoneNumber.ilike(pattern) |
            t.email.ilike(pattern);
        if (first != null && rest != null) {
          match =
              match |
              (t.firstName.ilike(first) & t.lastName.ilike(rest)) |
              (t.lastName.ilike(first) & t.firstName.ilike(rest));
        }
        return match;
      },
      orderBy: (t) => t.firstName,
      limit: 20,
    );
    return [
      for (final customer in rows)
        if (customer.id != null)
          ReservationCustomerMatch(
            id: customer.id!,
            firstName: customer.firstName,
            lastName: customer.lastName,
            phoneNumber: customer.phoneNumber,
            email: customer.email,
          ),
    ];
  }

  String _escapeLike(String value) {
    return value
        .replaceAll(r'\', r'\\')
        .replaceAll('%', r'\%')
        .replaceAll('_', r'\_');
  }

  /// Accepts a customer request. The table is assigned afterwards.
  Future<ReservationView> confirm(Session session, UuidValue id) async {
    await _prepare(session);
    final ctx = AuthGuard.requireAny(session);
    final row = await _load(session, id);
    await _requireStaff(session, row.buildingId);
    await settleNoShows(session, row.buildingId);
    final current = await _load(session, id);
    if (current.status != ReservationStatus.requested) {
      throw ReservationException(
        message: 'Only a request can be confirmed.',
        code: ReservationErrorCode.invalidInput,
      );
    }
    await Reservation.db.updateRow(
      session,
      current.copyWith(
        status: ReservationStatus.confirmed,
        confirmedAt: DateTime.now().toUtc(),
        confirmedById: ctx.actorId,
      ),
    );
    final saved = await _load(session, id);
    await _notifications.recordReservationChange(
      session,
      reservation: saved,
      status: ReservationStatus.confirmed,
      actorType: ctx.actorType,
      actorId: ctx.actorId,
    );
    return _view(saved);
  }

  /// Attaches active tables to a confirmed reservation. Replaces any previous set.
  Future<ReservationView> assignTables(
    Session session,
    UuidValue id,
    List<UuidValue> tableIds,
  ) async {
    await _prepare(session);
    final row = await _load(session, id);
    await _requireStaff(session, row.buildingId);
    if (row.status != ReservationStatus.confirmed) {
      throw ReservationException(
        message: 'Assign a table only after the reservation is confirmed.',
        code: ReservationErrorCode.invalidInput,
      );
    }
    final tables = await _tables(session, row.buildingId, tableIds);
    await settleNoShows(session, row.buildingId);
    final current = await _load(session, id);
    if (current.status != ReservationStatus.confirmed) {
      throw ReservationException(
        message: 'This reservation can no longer take a table.',
        code: ReservationErrorCode.invalidInput,
      );
    }
    await _assertNoOverlap(
      session,
      tables.map((table) => table.id!).toList(),
      current.startsAt.toUtc(),
      current.endsAt.toUtc(),
      exceptReservationId: current.id,
    );
    await session.db.transaction((transaction) async {
      await TableReservation.db.deleteWhere(
        session,
        where: (t) => t.reservationId.equals(current.id!),
        transaction: transaction,
      );
      await TableReservation.db.insert(
        session,
        [
          for (final table in tables)
            TableReservation(
              reservationId: current.id!,
              venueTableId: table.id!,
            ),
        ],
        transaction: transaction,
      );
    });
    return _view(await _load(session, id));
  }

  /// Cancels a request or a confirmed reservation that has not arrived.
  ///
  /// Customers can cancel only their own future one.
  Future<ReservationView> cancel(Session session, UuidValue id) async {
    await _prepare(session);
    final ctx = AuthGuard.requireAny(session);
    final row = await _load(session, id);
    if (row.status != ReservationStatus.requested &&
        row.status != ReservationStatus.confirmed) {
      throw ReservationException(
        message: 'This reservation can no longer be cancelled.',
        code: ReservationErrorCode.invalidInput,
      );
    }
    if (ctx.actorType == ActorType.customer) {
      if (row.customerId != ctx.actorId ||
          !row.startsAt.toUtc().isAfter(DateTime.now().toUtc())) {
        throw ReservationException(
          message: 'Not allowed to cancel this reservation.',
          code: ReservationErrorCode.notAuthorized,
        );
      }
    } else {
      await _requireStaff(session, row.buildingId);
    }
    await Reservation.db.updateRow(
      session,
      row.copyWith(status: ReservationStatus.cancelled),
    );
    final saved = await _load(session, id);
    await _notifications.recordReservationChange(
      session,
      reservation: saved,
      status: ReservationStatus.cancelled,
      actorType: ctx.actorType,
      actorId: ctx.actorId,
    );
    return _view(saved);
  }

  /// Scan confirmation. Marks the holding booking on [tableId] as arrived.
  Future<ReservationView> confirmByTable(
    Session session,
    UuidValue buildingId,
    UuidValue tableId,
  ) async {
    await _requireStaff(session, buildingId);
    await _prepare(session);
    await settleNoShows(session, buildingId);
    final holding = await _holdingForTable(session, tableId);
    if (holding == null || holding.buildingId != buildingId) {
      throw ReservationException(
        message: 'This table has no reservation to start.',
        code: ReservationErrorCode.notFound,
      );
    }
    final updated = await Reservation.db.updateRow(
      session,
      holding.copyWith(status: ReservationStatus.arrived),
    );
    return _view(await _load(session, updated.id!));
  }

  /// Phase and guest for each table that should show a booking on the floor.
  Future<Map<UuidValue, TableReservationSignal>> signalsForBuilding(
    Session session,
    UuidValue buildingId,
  ) async {
    await _prepare(session);
    await settleNoShows(session, buildingId);
    final now = DateTime.now().toUtc();
    final horizon = now.add(reservationSoonWindow);
    final rows = await Reservation.db.find(
      session,
      where: (t) =>
          t.buildingId.equals(buildingId) &
          t.status.equals(ReservationStatus.confirmed) &
          (t.endsAt > now) &
          (t.startsAt <= horizon),
      include: Reservation.include(
        links: TableReservation.includeList(),
      ),
    );
    final signals = <UuidValue, TableReservationSignal>{};
    for (final row in rows) {
      final phase = _phase(row, now);
      if (phase == ReservationPhase.none) {
        continue;
      }
      for (final link in row.links ?? const <TableReservation>[]) {
        final tableId = link.venueTableId;
        final current = signals[tableId];
        if (current != null && current.phase == ReservationPhase.holding) {
          continue;
        }
        signals[tableId] = TableReservationSignal(
          phase: phase,
          guestName: row.guestName,
          startsAt: row.startsAt,
        );
      }
    }
    return signals;
  }

  /// Turns ended confirmed rows into `noShow`, and unanswered requests into
  /// `cancelled`, so a table can take orders again and the daily cap frees up.
  Future<void> settleNoShows(Session session, UuidValue buildingId) async {
    await _prepare(session);
    final now = DateTime.now().toUtc();
    final due = await Reservation.db.find(
      session,
      where: (t) =>
          t.buildingId.equals(buildingId) &
          (t.endsAt <= now) &
          (t.status.equals(ReservationStatus.confirmed) |
              t.status.equals(ReservationStatus.requested)),
    );
    for (final row in due) {
      final next = row.status == ReservationStatus.requested
          ? ReservationStatus.cancelled
          : ReservationStatus.noShow;
      final saved = await Reservation.db.updateRow(
        session,
        row.copyWith(status: next),
      );
      if (next == ReservationStatus.cancelled) {
        await _notifications.recordReservationChange(
          session,
          reservation: saved,
          status: ReservationStatus.cancelled,
        );
      }
    }
  }

  /// Older builds stored an accepted booking as `booked`. Rewrite those rows
  /// before the ORM reads them, because that value is no longer a status.
  Future<void> _prepare(Session session) async {
    await session.db.unsafeQuery('''
UPDATE "reservation"
SET "status" = 'confirmed',
    "confirmedAt" = COALESCE("confirmedAt", "createdAt"),
    "confirmedById" = COALESCE("confirmedById", "createdById")
WHERE "status" = 'booked'
RETURNING "id"
''');
  }

  Future<void> _settleForCustomer(Session session, UuidValue customerId) async {
    final buildings = await Reservation.db.find(
      session,
      where: (t) =>
          t.customerId.equals(customerId) &
          (t.status.equals(ReservationStatus.requested) |
              t.status.equals(ReservationStatus.confirmed)),
    );
    final ids = buildings.map((row) => row.buildingId).toSet();
    for (final buildingId in ids) {
      await settleNoShows(session, buildingId);
    }
  }

  Future<ReservationView> _insert(
    Session session, {
    required UuidValue buildingId,
    required DateTime startsAt,
    required DateTime endsAt,
    required UuidValue? customerId,
    required String guestName,
    required String? guestPhone,
    required double paidAmount,
    required ReservationStatus status,
    required AuthContext createdBy,
    required UuidValue? confirmedById,
    required bool customerMustBeFuture,
  }) async {
    final pack = await PackGate.ofBuilding(session, buildingId);
    PackGate.requireFeature(pack.reservations, PackFeature.reservations);
    final building = await Building.db.findById(session, buildingId);
    if (building == null || !building.reservationsEnabled) {
      throw ReservationException(
        message: 'This venue has turned off reservations.',
        code: ReservationErrorCode.disabled,
      );
    }
    final start = startsAt.toUtc();
    final end = endsAt.toUtc();
    _validateWindow(start, end, customerMustBeFuture: customerMustBeFuture);
    _validatePaid(paidAmount);
    await settleNoShows(session, buildingId);
    final range = _utcDay(start);
    final count = await Reservation.db.count(
      session,
      where: (t) =>
          t.buildingId.equals(buildingId) &
          (t.startsAt >= range.start) &
          (t.startsAt < range.end) &
          t.status.notEquals(ReservationStatus.cancelled),
    );
    PackGate.requireRoom(
      max: pack.maxReservationsPerDay,
      current: count,
      adding: 1,
      feature: PackFeature.reservations,
    );
    final now = DateTime.now().toUtc();
    final row = await Reservation.db.insertRow(
      session,
      Reservation(
        buildingId: buildingId,
        startsAt: start,
        endsAt: end,
        customerId: customerId,
        guestName: guestName,
        guestPhone: guestPhone,
        paidAmount: paidAmount,
        status: status,
        createdByType: createdBy.actorType,
        createdById: createdBy.actorId,
        confirmedAt: status == ReservationStatus.confirmed ? now : null,
        confirmedById: confirmedById,
      ),
    );
    final saved = await _load(session, row.id!);
    if (status == ReservationStatus.requested) {
      await _notifications.recordReservationRequest(
        session,
        reservation: saved,
      );
    } else if (status == ReservationStatus.confirmed) {
      await _notifications.recordReservationChange(
        session,
        reservation: saved,
        status: ReservationStatus.confirmed,
        actorType: createdBy.actorType,
        actorId: createdBy.actorId,
      );
    }
    return _view(saved);
  }

  Future<({String name, String? phone, UuidValue? customerId})> _guestForStaff(
    Session session,
    ReservationCreate request,
  ) async {
    if (request.customerId != null) {
      final customer = await Customer.db.findById(session, request.customerId!);
      if (customer == null) {
        throw ReservationException(
          message: 'Customer not found.',
          code: ReservationErrorCode.notFound,
        );
      }
      return (
        name: '${customer.firstName} ${customer.lastName}'.trim(),
        phone: customer.phoneNumber,
        customerId: customer.id,
      );
    }
    final name = (request.guestName ?? '').trim();
    if (name.isEmpty || name.length > 80) {
      throw ReservationException(
        message: 'Enter the guest name.',
        code: ReservationErrorCode.invalidInput,
      );
    }
    final rawPhone = (request.guestPhone ?? '').trim();
    String? phone;
    if (rawPhone.isNotEmpty) {
      if (!PhoneNumbers.isValid(rawPhone)) {
        throw ReservationException(
          message: 'Enter a valid phone number.',
          code: ReservationErrorCode.invalidInput,
        );
      }
      phone = PhoneNumbers.normalize(rawPhone);
    }
    return (name: name, phone: phone, customerId: null);
  }

  /// Length and future-start only. The building's opening and closing
  /// times do not limit when a reservation may start or end.
  void _validateWindow(
    DateTime start,
    DateTime end, {
    required bool customerMustBeFuture,
  }) {
    final length = end.difference(start);
    if (!end.isAfter(start) ||
        length < const Duration(minutes: 30) ||
        length > const Duration(hours: 8)) {
      throw ReservationException(
        message: 'A reservation lasts between 30 minutes and 8 hours.',
        code: ReservationErrorCode.invalidInput,
      );
    }
    final now = DateTime.now().toUtc();
    if (customerMustBeFuture && !start.isAfter(now)) {
      throw ReservationException(
        message: 'Pick a start time in the future.',
        code: ReservationErrorCode.invalidInput,
      );
    }
    if (!end.isAfter(now)) {
      throw ReservationException(
        message: 'The reservation has already ended.',
        code: ReservationErrorCode.invalidInput,
      );
    }
  }

  void _validatePaid(double paidAmount) {
    if (paidAmount < 0 || paidAmount > 1000000) {
      throw ReservationException(
        message: 'Check the paid amount.',
        code: ReservationErrorCode.invalidInput,
      );
    }
  }

  Future<List<VenueTable>> _tables(
    Session session,
    UuidValue buildingId,
    List<UuidValue> tableIds,
  ) async {
    final unique = tableIds.toSet().toList();
    if (unique.isEmpty || unique.length > 20) {
      throw ReservationException(
        message: 'Select between 1 and 20 tables.',
        code: ReservationErrorCode.invalidInput,
      );
    }
    final rows = await VenueTable.db.find(
      session,
      where: (t) =>
          t.id.inSet(unique.toSet()) & t.buildingId.equals(buildingId),
    );
    if (rows.length != unique.length || rows.any((row) => !row.isActive)) {
      throw ReservationException(
        message: 'Choose active tables from this venue.',
        code: ReservationErrorCode.invalidInput,
      );
    }
    return rows;
  }

  Future<void> _assertNoOverlap(
    Session session,
    List<UuidValue> tableIds,
    DateTime start,
    DateTime end, {
    UuidValue? exceptReservationId,
  }) async {
    final links = await TableReservation.db.find(
      session,
      where: (t) => t.venueTableId.inSet(tableIds.toSet()),
      include: TableReservation.include(reservation: Reservation.include()),
    );
    for (final link in links) {
      final other = link.reservation;
      if (other == null || other.id == exceptReservationId) {
        continue;
      }
      if (other.status != ReservationStatus.confirmed &&
          other.status != ReservationStatus.arrived) {
        continue;
      }
      final overlaps =
          other.startsAt.toUtc().isBefore(end) &&
          start.isBefore(other.endsAt.toUtc());
      if (overlaps) {
        throw ReservationException(
          message: 'A table is already reserved for that time.',
          code: ReservationErrorCode.overlap,
        );
      }
    }
  }

  Future<Reservation?> _holdingForTable(
    Session session,
    UuidValue tableId,
  ) async {
    final now = DateTime.now().toUtc();
    final links = await TableReservation.db.find(
      session,
      where: (t) => t.venueTableId.equals(tableId),
      include: TableReservation.include(reservation: Reservation.include()),
    );
    for (final link in links) {
      final row = link.reservation;
      if (row == null || row.status != ReservationStatus.confirmed) {
        continue;
      }
      if (!row.startsAt.toUtc().isAfter(now) &&
          row.endsAt.toUtc().isAfter(now)) {
        return row;
      }
    }
    return null;
  }

  Future<Reservation> _load(Session session, UuidValue id) async {
    final row = await Reservation.db.findById(
      session,
      id,
      include: Reservation.include(
        links: TableReservation.includeList(
          include: TableReservation.include(venueTable: VenueTable.include()),
        ),
      ),
    );
    if (row == null) {
      throw ReservationException(
        message: 'Reservation not found.',
        code: ReservationErrorCode.notFound,
      );
    }
    return row;
  }

  Future<AuthContext> _requireStaff(
    Session session,
    UuidValue buildingId,
  ) async {
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType == ActorType.owner) {
      final building = await Building.db.findById(session, buildingId);
      if (building == null || building.ownerId != ctx.actorId) {
        throw ReservationException(
          message: 'Not allowed to manage reservations here.',
          code: ReservationErrorCode.notAuthorized,
        );
      }
      return ctx;
    }
    if (ctx.actorType == ActorType.employee) {
      final employee = await Employee.db.findById(
        session,
        ctx.actorId,
        include: Employee.include(access: EmployeeAccess.include()),
      );
      if (employee == null ||
          employee.buildingId != buildingId ||
          employee.access?.reservations != true) {
        throw ReservationException(
          message: 'Not allowed to manage reservations here.',
          code: ReservationErrorCode.notAuthorized,
        );
      }
      return ctx;
    }
    throw ReservationException(
      message: 'Not allowed to manage reservations here.',
      code: ReservationErrorCode.notAuthorized,
    );
  }

  AuthContext _requireCustomer(Session session) {
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType != ActorType.customer) {
      throw ReservationException(
        message: 'Not allowed.',
        code: ReservationErrorCode.notAuthorized,
      );
    }
    return ctx;
  }

  ReservationPhase _phase(Reservation row, DateTime now) {
    if (row.status != ReservationStatus.confirmed) {
      return ReservationPhase.none;
    }
    if (row.links == null || row.links!.isEmpty) {
      return ReservationPhase.none;
    }
    final start = row.startsAt.toUtc();
    final end = row.endsAt.toUtc();
    if (!start.isAfter(now) && end.isAfter(now)) {
      return ReservationPhase.holding;
    }
    if (start.isAfter(now) && !start.isAfter(now.add(reservationSoonWindow))) {
      return ReservationPhase.soon;
    }
    return ReservationPhase.none;
  }

  ({DateTime start, DateTime end}) _utcDay(DateTime instant) {
    final utc = instant.toUtc();
    final start = DateTime.utc(utc.year, utc.month, utc.day);
    return (start: start, end: start.add(const Duration(days: 1)));
  }

  ReservationView _view(Reservation row) {
    final links = row.links ?? const <TableReservation>[];
    final tables = [
      for (final link in links)
        if (link.venueTable != null) link.venueTable!,
    ]..sort((a, b) => a.number.compareTo(b.number));
    return ReservationView(
      id: row.id!,
      buildingId: row.buildingId,
      startsAt: row.startsAt,
      endsAt: row.endsAt,
      status: row.status,
      tableIds: [for (final table in tables) table.id!],
      tableNumbers: [for (final table in tables) table.number],
      customerId: row.customerId,
      guestName: row.guestName,
      guestPhone: row.guestPhone,
      paidAmount: row.paidAmount,
      createdByType: row.createdByType,
    );
  }
}

/// Floor copy for one table that has a booking starting soon or on hold.
class TableReservationSignal {
  const TableReservationSignal({
    required this.phase,
    required this.guestName,
    required this.startsAt,
  });

  final ReservationPhase phase;
  final String guestName;
  final DateTime startsAt;
}
