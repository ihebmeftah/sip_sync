import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'reservations_view_model.g.dart';

/// One UTC calendar day of bookings for a venue.
class ReservationDay {
  const ReservationDay({required this.day, required this.items});

  /// Midnight UTC of the day being shown.
  final DateTime day;
  final List<ReservationView> items;
}

/// Staff list of reservations. The server enforces who may open it.
@Riverpod(keepAlive: true)
class ReservationsViewModel extends _$ReservationsViewModel {
  late String _buildingId;
  late DateTime _day;

  @override
  Future<ReservationDay> build(String buildingId) async {
    _buildingId = buildingId;
    final now = DateTime.now();
    _day = DateTime.utc(now.year, now.month, now.day);
    ref.watch(signedInActorIdProvider);
    return _load();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(_load);
  }

  Future<void> shiftDay(int delta) async {
    _day = _day.add(Duration(days: delta));
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  /// Accepts a customer request. The table is assigned afterwards.
  Future<void> confirm(UuidValue id) async {
    await ref.read(reservationRepositoryProvider).confirm(id);
    await refresh();
  }

  /// Attaches tables to a confirmed reservation.
  Future<void> assignTables(UuidValue id, List<UuidValue> tableIds) async {
    await ref.read(reservationRepositoryProvider).assignTables(id, tableIds);
    await refresh();
  }

  Future<void> cancel(UuidValue id) async {
    await ref.read(reservationRepositoryProvider).cancel(id);
    await refresh();
  }

  Future<ReservationDay> _load() {
    if (_buildingId.isEmpty) {
      return Future.value(ReservationDay(day: _day, items: const []));
    }
    return ref
        .read(reservationRepositoryProvider)
        .listForDay(UuidValue.fromString(_buildingId), _day)
        .then((items) => ReservationDay(day: _day, items: items));
  }
}
