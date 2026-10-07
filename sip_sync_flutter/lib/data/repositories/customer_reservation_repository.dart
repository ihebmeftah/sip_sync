import 'package:sip_sync_client/sip_sync_client.dart';

/// The signed-in customer's own bookings.
class CustomerReservationRepository {
  CustomerReservationRepository(this._client);

  final Client _client;

  Future<List<ReservationView>> listMine() => _client.reservation.listMine();

  Future<ReservationView> create(CustomerReservationCreate request) {
    return _client.reservation.createForCustomer(request);
  }

  Future<ReservationView> cancel(UuidValue id) =>
      _client.reservation.cancel(id);
}
