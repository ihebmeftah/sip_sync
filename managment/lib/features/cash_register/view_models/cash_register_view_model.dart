import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/paging/list_paging.dart';

part 'cash_register_view_model.g.dart';

/// The open shift, when the venue requires one.
///
/// Null when the switch is off or the drawer is shut. Orders and the
/// dashboard watch this so a pull, or an open on this device, retargets them.
@riverpod
Future<CashRegisterSessionView?> openCashRegister(
  Ref ref,
  String buildingId,
) async {
  if (buildingId.isEmpty) {
    return null;
  }
  final building = ref.watch(buildingSelectionProvider);
  if (building == null ||
      building.id.uuid != buildingId ||
      !building.cashRegisterEnabled) {
    return null;
  }
  return ref.watch(cashRegisterRepositoryProvider).current(building.id);
}

/// One page of shifts plus the one that is in progress.
class CashRegisterScreenState {
  const CashRegisterScreenState({
    required this.current,
    required this.history,
    required this.total,
    this.historyDay,
    this.loadingMore = false,
  });

  final CashRegisterSessionView? current;
  final List<CashRegisterSessionView> history;
  final int total;

  /// Local calendar day the history list is limited to. Null lists every shift.
  final DateTime? historyDay;
  final bool loadingMore;

  bool get hasMore => history.length < total;

  CashRegisterScreenState copyWith({
    CashRegisterSessionView? current,
    List<CashRegisterSessionView>? history,
    int? total,
    DateTime? historyDay,
    bool? loadingMore,
    bool clearCurrent = false,
    bool clearHistoryDay = false,
  }) {
    return CashRegisterScreenState(
      current: clearCurrent ? null : (current ?? this.current),
      history: history ?? this.history,
      total: total ?? this.total,
      historyDay: clearHistoryDay ? null : (historyDay ?? this.historyDay),
      loadingMore: loadingMore ?? this.loadingMore,
    );
  }
}

/// Open, close, and history for the venue register.
@riverpod
class CashRegisterViewModel extends _$CashRegisterViewModel {
  @override
  Future<CashRegisterScreenState> build(String buildingId) {
    return _load(buildingId);
  }

  Future<void> refresh() async {
    final day = state.asData?.value.historyDay;
    state = await AsyncValue.guard(() => _load(buildingId, historyDay: day));
  }

  /// Limits history to shifts that started on [day]. Null lists every shift.
  Future<void> setHistoryDay(DateTime? day) async {
    final next = day == null ? null : DateTime(day.year, day.month, day.day);
    state = await AsyncValue.guard(() => _load(buildingId, historyDay: next));
  }

  Future<void> open({double? startCash}) async {
    await ref
        .read(cashRegisterRepositoryProvider)
        .open(UuidValue.fromString(buildingId), startCash: startCash);
    ref.invalidate(openCashRegisterProvider(buildingId));
    await refresh();
  }

  Future<void> close(UuidValue id, {double? endCash}) async {
    await ref.read(cashRegisterRepositoryProvider).close(id, endCash: endCash);
    ref.invalidate(openCashRegisterProvider(buildingId));
    await refresh();
  }

  /// Owner-only correction of the counted drawer.
  Future<void> correct(
    UuidValue id, {
    double? startCash,
    double? endCash,
  }) async {
    await ref
        .read(cashRegisterRepositoryProvider)
        .correct(id, startCash: startCash, endCash: endCash);
    ref.invalidate(openCashRegisterProvider(buildingId));
    await refresh();
  }

  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || current.loadingMore || !current.hasMore) {
      return;
    }
    state = AsyncData(current.copyWith(loadingMore: true));
    try {
      final bounds = _dayBounds(current.historyDay);
      final page = await ref
          .read(cashRegisterRepositoryProvider)
          .list(
            UuidValue.fromString(buildingId),
            openedFrom: bounds?.from,
            openedTo: bounds?.to,
            limit: listPageSize,
            offset: current.history.length,
          );
      final seen = {for (final row in current.history) row.id};
      state = AsyncData(
        current.copyWith(
          history: [
            ...current.history,
            for (final row in page.items)
              if (!seen.contains(row.id)) row,
          ],
          total: page.total,
          loadingMore: false,
        ),
      );
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }

  Future<CashRegisterScreenState> _load(
    String buildingId, {
    DateTime? historyDay,
  }) async {
    if (buildingId.isEmpty) {
      return CashRegisterScreenState(
        current: null,
        history: const [],
        total: 0,
        historyDay: historyDay,
      );
    }
    final id = UuidValue.fromString(buildingId);
    final repo = ref.read(cashRegisterRepositoryProvider);
    final bounds = _dayBounds(historyDay);
    final current = await repo.current(id);
    final page = await repo.list(
      id,
      openedFrom: bounds?.from,
      openedTo: bounds?.to,
      limit: listPageSize,
      offset: 0,
    );
    return CashRegisterScreenState(
      current: current,
      history: page.items,
      total: page.total,
      historyDay: historyDay,
    );
  }
}

({DateTime from, DateTime to})? _dayBounds(DateTime? day) {
  if (day == null) {
    return null;
  }
  final from = DateTime(day.year, day.month, day.day);
  return (from: from, to: DateTime(from.year, from.month, from.day + 1));
}
