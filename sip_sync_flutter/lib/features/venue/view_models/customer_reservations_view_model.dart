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

  /// Puts a booking the customer just sent at the top of the list.
  void remember(ReservationView view) {
    final current = state.asData?.value;
    if (current == null) {
      return;
    }
    state = AsyncData([
      view,
      for (final row in current)
        if (row.id != view.id) row,
    ]);
  }

  /// Drops a future request or confirmed reservation the customer owns.
  ///
  /// Replaces that row so the rest of the list stays put.
  Future<void> cancel(UuidValue id) async {
    final updated = await ref
        .read(customerReservationRepositoryProvider)
        .cancel(id);
    final current = state.asData?.value ?? const <ReservationView>[];
    state = AsyncData([
      for (final row in current)
        if (row.id == id) updated else row,
    ]);
  }
}
