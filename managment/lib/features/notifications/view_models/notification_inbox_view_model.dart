import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/paging/list_paging.dart';
import 'notification_toasts.dart';

part 'notification_inbox_view_model.g.dart';

/// Alerts loaded for the signed-in owner or employee.
///
/// [unread] is the open venue only: the owner's current building, or the
/// building the employee works in. [appliedBuildingId] is that venue.
class NotificationInboxState {
  const NotificationInboxState({
    required this.items,
    required this.total,
    required this.unread,
    this.loadingMore = false,
    this.markingAll = false,
    this.currentMonth = false,
    this.unreadOnly = false,
    this.appliedBuildingId,
  });

  final List<AppNotificationView> items;
  final int total;
  final int unread;
  final bool loadingMore;
  final bool markingAll;
  final bool currentMonth;
  final bool unreadOnly;

  /// Venue the shell last focused. Null until a building is open.
  final String? appliedBuildingId;

  bool get hasMore => items.length < total;

  NotificationInboxState copyWith({
    List<AppNotificationView>? items,
    int? total,
    int? unread,
    bool? loadingMore,
    bool? markingAll,
    bool? currentMonth,
    bool? unreadOnly,
    String? appliedBuildingId,
  }) {
    return NotificationInboxState(
      items: items ?? this.items,
      total: total ?? this.total,
      unread: unread ?? this.unread,
      loadingMore: loadingMore ?? this.loadingMore,
      markingAll: markingAll ?? this.markingAll,
      currentMonth: currentMonth ?? this.currentMonth,
      unreadOnly: unreadOnly ?? this.unreadOnly,
      appliedBuildingId: appliedBuildingId ?? this.appliedBuildingId,
    );
  }
}

/// Badge count plus the list. A live stream inserts new rows.
@Riverpod(keepAlive: true)
class NotificationInbox extends _$NotificationInbox {
  StreamSubscription<AppNotificationView>? _live;
  UuidValue? _buildingId;
  var _currentMonth = false;
  var _unreadOnly = false;
  var _focused = false;

  @override
  Future<NotificationInboxState> build() async {
    final signedIn = ref.watch(appSessionStoreProvider).isSignedIn;
    _buildingId = null;
    _currentMonth = false;
    _unreadOnly = false;
    _focused = false;
    if (!signedIn) {
      return const NotificationInboxState(items: [], total: 0, unread: 0);
    }
    await _listen();
    if (_focused && _buildingId != null) {
      return _load();
    }
    return const NotificationInboxState(items: [], total: 0, unread: 0);
  }

  /// Keeps the bell and the list on [id].
  ///
  /// Owners pass the venue they have open. Employees pass the building they
  /// work in. If the inbox is still loading, that load applies this focus
  /// when it finishes so the two requests do not overwrite each other.
  Future<void> focusBuilding(UuidValue id) async {
    final changed = !_focused || _buildingId != id;
    _buildingId = id;
    _focused = true;
    if (state.isLoading) {
      return;
    }
    final applied = state.asData?.value.appliedBuildingId;
    if (!changed && !state.hasError && applied == id.uuid) {
      return;
    }
    await refresh();
  }

  /// [value] limits the list to the current calendar month.
  Future<void> setCurrentMonth(bool value) async {
    if (_currentMonth == value) {
      return;
    }
    _currentMonth = value;
    await refresh();
  }

  /// [value] hides alerts that were already opened.
  Future<void> setUnreadOnly(bool value) async {
    if (_unreadOnly == value) {
      return;
    }
    _unreadOnly = value;
    await refresh();
  }

  Future<void> refresh() async {
    if (!ref.read(appSessionStoreProvider).isSignedIn) {
      return;
    }
    state = AsyncData(_stamp(await _load()));
  }

  Future<NotificationInboxState> _load() async {
    final page = await _page(offset: 0);
    final unread = await _unreadInBuilding();
    return NotificationInboxState(
      items: page.items,
      total: page.total,
      unread: unread,
    );
  }

  /// Unread rows for the focused venue, ignoring the month chip.
  Future<int> _unreadInBuilding() async {
    final id = _buildingId;
    if (id == null) {
      return 0;
    }
    return ref.read(notificationRepositoryProvider).unreadCount(buildingId: id);
  }

  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || current.loadingMore || !current.hasMore) {
      return;
    }
    state = AsyncData(current.copyWith(loadingMore: true));
    try {
      final page = await _page(offset: current.items.length);
      final seen = {for (final row in current.items) row.id};
      state = AsyncData(
        current.copyWith(
          items: [
            ...current.items,
            for (final row in page.items)
              if (!seen.contains(row.id)) row,
          ],
          total: page.total,
          loadingMore: false,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(loadingMore: false));
    }
  }

  Future<void> markRead(UuidValue id) async {
    final current = state.asData?.value;
    final saved = await ref.read(notificationRepositoryProvider).markRead(id);
    if (current == null) {
      return;
    }
    final wasUnread = current.items.any((row) => row.id == id && !row.read);
    final hide = _unreadOnly && wasUnread;
    state = AsyncData(
      current.copyWith(
        items: [
          for (final row in current.items)
            if (row.id != id) row else if (!hide) saved,
        ],
        total: hide && current.total > 0 ? current.total - 1 : current.total,
        unread: wasUnread && current.unread > 0
            ? current.unread - 1
            : current.unread,
      ),
    );
  }

  /// Marks unread rows in the open venue and the current month scope.
  Future<void> markAllRead() async {
    final current = state.asData?.value;
    final buildingId = _buildingId;
    if (current == null || current.markingAll || buildingId == null) {
      return;
    }
    state = AsyncData(current.copyWith(markingAll: true));
    try {
      final month = _monthBounds();
      await ref
          .read(notificationRepositoryProvider)
          .markAllRead(
            buildingId: buildingId,
            createdFrom: month?.$1,
            createdTo: month?.$2,
          );
      await refresh();
    } catch (error) {
      state = AsyncData(current.copyWith(markingAll: false));
      rethrow;
    }
  }

  Future<AppNotificationPage> _page({required int offset}) {
    final month = _monthBounds();
    return ref
        .read(notificationRepositoryProvider)
        .list(
          buildingId: _buildingId,
          createdFrom: month?.$1,
          createdTo: month?.$2,
          unreadOnly: _unreadOnly,
          limit: listPageSize,
          offset: offset,
        );
  }

  Future<void> _listen() async {
    await _live?.cancel();
    _live = ref
        .read(notificationRepositoryProvider)
        .watch()
        .listen(_onLive, onError: (_, _) {});
    ref.onDispose(() {
      _live?.cancel();
      _live = null;
    });
  }

  void _onLive(AppNotificationView view) {
    final current = state.asData?.value;
    if (current == null ||
        _buildingId == null ||
        view.buildingId != _buildingId ||
        current.items.any((row) => row.id == view.id)) {
      return;
    }
    ref.read(notificationToastsProvider.notifier).push(view);
    final shown = _matches(view);
    state = AsyncData(
      current.copyWith(
        items: shown ? [view, ...current.items] : current.items,
        total: shown ? current.total + 1 : current.total,
        unread: view.read ? current.unread : current.unread + 1,
      ),
    );
  }

  bool _matches(AppNotificationView view) {
    if (_buildingId == null || view.buildingId != _buildingId) {
      return false;
    }
    if (_unreadOnly && view.read) {
      return false;
    }
    final month = _monthBounds();
    if (month != null) {
      final created = view.createdAt.toUtc();
      if (created.isBefore(month.$1) || !created.isBefore(month.$2)) {
        return false;
      }
    }
    return true;
  }

  NotificationInboxState _stamp(NotificationInboxState value) {
    return value.copyWith(
      currentMonth: _currentMonth,
      unreadOnly: _unreadOnly,
      appliedBuildingId: _buildingId?.uuid,
    );
  }

  (DateTime, DateTime)? _monthBounds() {
    if (!_currentMonth) {
      return null;
    }
    final now = DateTime.now();
    final from = DateTime(now.year, now.month);
    final to = DateTime(now.year, now.month + 1);
    return (from.toUtc(), to.toUtc());
  }
}
