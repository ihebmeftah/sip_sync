import 'package:sip_sync_client/sip_sync_client.dart';

/// Staff reservations for one venue.
class ReservationRepository {
  ReservationRepository(this._client);

  final Client _client;

  /// Bookings whose start falls on the UTC date of [day].
  Future<List<ReservationView>> listForDay(UuidValue buildingId, DateTime day) {
    return _client.reservation.listForDay(buildingId, day);
  }

  Future<ReservationView> create(ReservationCreate request) {
    return _client.reservation.create(request);
  }

  /// Accepts a customer request. A table is assigned separately.
  Future<ReservationView> confirm(UuidValue id) =>
      _client.reservation.confirm(id);

  /// Replaces the tables on a confirmed reservation.
  Future<ReservationView> assignTables(UuidValue id, List<UuidValue> tableIds) {
    return _client.reservation.assignTables(id, tableIds);
  }

  /// Customers whose name or phone contains [query]. At most 20.
  Future<List<ReservationCustomerMatch>> searchCustomers(
    UuidValue buildingId,
    String query,
  ) {
    return _client.reservation.searchCustomers(buildingId, query);
  }

  /// Exact phone match so staff can attach an account.
  Future<ReservationCustomerMatch> findCustomer(
    UuidValue buildingId,
    String phone,
  ) {
    return _client.reservation.findCustomer(buildingId, phone);
  }

  Future<ReservationView> cancel(UuidValue id) =>
      _client.reservation.cancel(id);

  /// Scan confirmation: the holding booking on [tableId] becomes arrived.
  Future<ReservationView> confirmByTable({
    required UuidValue buildingId,
    required UuidValue tableId,
  }) {
    return _client.reservation.confirmByTable(buildingId, tableId);
  }
}
