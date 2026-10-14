import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/paging/list_paging.dart';
import 'notification_toasts.dart';

part 'notification_inbox_view_model.g.dart';

/// Alerts loaded so far, plus the unread count behind the bell.
///
/// [unread] counts every venue. The list can be one venue, this month, or
/// unread rows. [appliedBuildingId] is the venue the screen opened on.
class NotificationInboxState {
  const NotificationInboxState({
    required this.items,
    required this.total,
    required this.unread,
    this.loadingMore = false,
    this.markingAll = false,
    this.thisBuilding = false,
    this.currentMonth = false,
    this.unreadOnly = false,
    this.appliedBuildingId,
  });

  final List<AppNotificationView> items;
  final int total;
  final int unread;
  final bool loadingMore;
  final bool markingAll;
  final bool thisBuilding;
  final bool currentMonth;
  final bool unreadOnly;

  /// Venue the screen last focused. Null until that screen opens.
  final String? appliedBuildingId;

  bool get hasMore => items.length < total;

  NotificationInboxState copyWith({
    List<AppNotificationView>? items,
    int? total,
    int? unread,
    bool? loadingMore,
    bool? markingAll,
    bool? thisBuilding,
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
      thisBuilding: thisBuilding ?? this.thisBuilding,
      currentMonth: currentMonth ?? this.currentMonth,
      unreadOnly: unreadOnly ?? this.unreadOnly,
      appliedBuildingId: appliedBuildingId ?? this.appliedBuildingId,
    );
  }
}

/// The signed-in customer's alerts. A live stream inserts new rows and
/// raises [NotificationInboxState.unread] for the badge.
@Riverpod(keepAlive: true)
class NotificationInbox extends _$NotificationInbox {
  StreamSubscription<AppNotificationView>? _live;
  UuidValue? _buildingId;
  var _thisBuilding = false;
  var _currentMonth = false;
  var _unreadOnly = false;
  var _focused = false;

  @override
  Future<NotificationInboxState> build() async {
    final signedIn = ref.watch(appSessionStoreProvider).isSignedIn;
    _buildingId = null;
    _thisBuilding = false;
    _currentMonth = false;
    _unreadOnly = false;
    _focused = false;
    if (!signedIn) {
      return const NotificationInboxState(items: [], total: 0, unread: 0);
    }
    final unread = await ref.read(notificationRepositoryProvider).unreadCount();
    await _listen();
    if (_focused && _buildingId != null) {
      final page = await _page(offset: 0);
      final freshUnread = await ref
          .read(notificationRepositoryProvider)
          .unreadCount();
      return _stamp(
        NotificationInboxState(
          items: page.items,
          total: page.total,
          unread: freshUnread,
        ),
      );
    }
    return NotificationInboxState(items: [], total: 0, unread: unread);
  }

  /// Opens the list on [id]: this venue, every month, read and unread.
  ///
  /// If the inbox is still loading the badge, that load applies this focus
  /// when it finishes so the two requests do not overwrite each other.
  Future<void> focusBuilding(UuidValue id) async {
    _buildingId = id;
    _thisBuilding = true;
    _currentMonth = false;
    _unreadOnly = false;
    _focused = true;
    if (state.isLoading) {
      return;
    }
    await refresh();
  }

  /// [value] keeps the focused venue. False shows every venue.
  Future<void> setThisBuilding(bool value) async {
    if (_thisBuilding == value) {
      return;
    }
    _thisBuilding = value;
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

  /// Reloads the first page and the badge. Keeps the live stream.
  Future<void> refresh() async {
    final signedIn = ref.read(appSessionStoreProvider).isSignedIn;
    if (!signedIn) {
      return;
    }
    final page = await _page(offset: 0);
    final unread = await ref.read(notificationRepositoryProvider).unreadCount();
    state = AsyncData(
      _stamp(
        NotificationInboxState(
          items: page.items,
          total: page.total,
          unread: unread,
        ),
      ),
    );
  }

  /// Appends the next page.
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

  /// Marks [id] read when it is still unread, then returns the row for navigation.
  Future<AppNotificationView?> markRead(UuidValue id) async {
    final current = state.asData?.value;
    final saved = await ref.read(notificationRepositoryProvider).markRead(id);
    if (current == null) {
      return saved;
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
    return saved;
  }

  /// Marks unread rows in the current venue and month scope.
  Future<void> markAllRead() async {
    final current = state.asData?.value;
    if (current == null || current.markingAll) {
      return;
    }
    state = AsyncData(current.copyWith(markingAll: true));
    try {
      final month = _monthBounds();
      await ref
          .read(notificationRepositoryProvider)
          .markAllRead(
            buildingId: _thisBuilding ? _buildingId : null,
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
          buildingId: _thisBuilding ? _buildingId : null,
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
    if (current == null || current.items.any((row) => row.id == view.id)) {
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
    if (_thisBuilding &&
        _buildingId != null &&
        view.buildingId != _buildingId) {
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
      thisBuilding: _thisBuilding,
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
