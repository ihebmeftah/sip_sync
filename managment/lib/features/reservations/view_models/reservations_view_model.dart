import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/access/floor_access.dart';
import '../../../core/di/app_providers.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../notifications/view_models/notification_inbox_view_model.dart';

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
  ///
  /// Replaces that row. The rest of the day stays on screen.
  Future<void> confirm(UuidValue id) async {
    final updated = await ref.read(reservationRepositoryProvider).confirm(id);
    _replace(updated);
    await _refreshPending();
  }

  /// Attaches tables to a confirmed reservation.
  Future<void> assignTables(UuidValue id, List<UuidValue> tableIds) async {
    final updated = await ref
        .read(reservationRepositoryProvider)
        .assignTables(id, tableIds);
    _replace(updated);
  }

  Future<void> cancel(UuidValue id) async {
    final updated = await ref.read(reservationRepositoryProvider).cancel(id);
    _replace(updated);
    await _refreshPending();
  }

  void _replace(ReservationView updated) {
    final current = state.asData?.value;
    if (current == null) {
      return;
    }
    state = AsyncData(
      ReservationDay(
        day: current.day,
        items: [
          for (final row in current.items)
            if (row.id == updated.id) updated else row,
        ],
      ),
    );
  }

  Future<void> _refreshPending() {
    return ref
        .read(pendingReservationCountProvider(_buildingId).notifier)
        .refresh();
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

/// Open customer requests for one venue. Owners and reservation staff only.
@Riverpod(keepAlive: true)
class PendingReservationCount extends _$PendingReservationCount {
  late String _buildingId;

  @override
  Future<int> build(String buildingId) async {
    _buildingId = buildingId;
    final store = ref.watch(appSessionStoreProvider);
    ref.listen(notificationInboxProvider, (previous, next) {
      final before = previous?.asData?.value.unread;
      final after = next.asData?.value.unread;
      if (before == null || after == null || before == after) {
        return;
      }
      unawaited(refresh());
    });
    if (!store.isSignedIn ||
        buildingId.isEmpty ||
        !FloorAccess.fromSession(store).canManageReservations) {
      return 0;
    }
    return _fetch(buildingId);
  }

  /// Reloads the count without clearing the badge while the request runs.
  Future<void> refresh() async {
    final store = ref.read(appSessionStoreProvider);
    if (!store.isSignedIn ||
        _buildingId.isEmpty ||
        !FloorAccess.fromSession(store).canManageReservations) {
      state = const AsyncData(0);
      return;
    }
    try {
      state = AsyncData(await _fetch(_buildingId));
    } catch (_) {
      // Keep the last count. The reservations screen reports action errors.
    }
  }

  Future<int> _fetch(String buildingId) {
    return ref
        .read(reservationRepositoryProvider)
        .pendingCount(UuidValue.fromString(buildingId));
  }
}
