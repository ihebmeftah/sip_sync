import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'reservation_service.dart';

/// Reservations for a venue. Staff, and customers booking themselves.
class ReservationEndpoint extends Endpoint {
  final _reservations = ReservationService();

  @override
  bool get requireLogin => true;

  /// Bookings whose start falls on the UTC date of [day].
  Future<List<ReservationView>> listForDay(
    Session session,
    UuidValue buildingId,
    DateTime day,
  ) {
    return _reservations.listForDay(session, buildingId, day);
  }

  /// The signed-in customer's upcoming bookings.
  Future<List<ReservationView>> listMine(Session session) {
    return _reservations.listMine(session);
  }

  /// Owner or employee with the reservations flag.
  ///
  /// The row is confirmed immediately and still needs a table.
  Future<ReservationView> create(Session session, ReservationCreate request) {
    return _reservations.create(session, request);
  }

  /// Customer asks for a time. Staff confirm it before a table is assigned.
  Future<ReservationView> createForCustomer(
    Session session,
    CustomerReservationCreate request,
  ) {
    return _reservations.createForCustomer(session, request);
  }

  /// Accepts a customer request. Does not assign a table.
  Future<ReservationView> confirm(Session session, UuidValue id) {
    return _reservations.confirm(session, id);
  }

  /// Attaches tables to a confirmed reservation.
  Future<ReservationView> assignTables(
    Session session,
    UuidValue id,
    List<UuidValue> tableIds,
  ) {
    return _reservations.assignTables(session, id, tableIds);
  }

  /// Name or phone search for a staff booking. At most 20 rows.
  ///
  /// A query shorter than two characters returns an empty list.
  Future<List<ReservationCustomerMatch>> searchCustomers(
    Session session,
    UuidValue buildingId,
    String query,
  ) {
    return _reservations.searchCustomers(session, buildingId, query);
  }

  /// Exact phone match so staff can attach an account instead of typing a guest.
  Future<ReservationCustomerMatch> findCustomer(
    Session session,
    UuidValue buildingId,
    String phone,
  ) {
    return _reservations.findCustomer(session, buildingId, phone);
  }

  /// Cancels a request or a confirmed reservation that has not arrived.
  Future<ReservationView> cancel(Session session, UuidValue id) {
    return _reservations.cancel(session, id);
  }

  /// Scan confirmation: the holding booking on [tableId] becomes arrived.
  Future<ReservationView> confirmByTable(
    Session session,
    UuidValue buildingId,
    UuidValue tableId,
  ) {
    return _reservations.confirmByTable(session, buildingId, tableId);
  }
}
