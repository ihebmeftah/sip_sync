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
  Future<ReservationView> create(Session session, ReservationCreate request) {
    return _reservations.create(session, request);
  }

  /// Customer books for their own account.
  Future<ReservationView> createForCustomer(
    Session session,
    CustomerReservationCreate request,
  ) {
    return _reservations.createForCustomer(session, request);
  }

  /// Exact phone match so staff can attach an account instead of typing a guest.
  Future<ReservationCustomerMatch> findCustomer(
    Session session,
    UuidValue buildingId,
    String phone,
  ) {
    return _reservations.findCustomer(session, buildingId, phone);
  }

  /// Cancels a booked reservation.
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
