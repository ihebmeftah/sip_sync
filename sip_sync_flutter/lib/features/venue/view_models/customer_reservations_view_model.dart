import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';

part 'customer_reservations_view_model.g.dart';

/// Upcoming bookings for the signed-in customer.
@riverpod
class MyReservations extends _$MyReservations {
  @override
  Future<List<ReservationView>> build() {
    return ref.watch(customerReservationRepositoryProvider).listMine();
  }

  /// Drops a future booked row the customer owns.
  Future<void> cancel(UuidValue id) async {
    await ref.read(customerReservationRepositoryProvider).cancel(id);
    ref.invalidateSelf();
  }
}
