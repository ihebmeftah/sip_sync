import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'notification_service.dart';

/// Stored alerts for the signed-in actor. Rows are written by the server
/// when an order changes; this endpoint only reads and marks them read.
class NotificationEndpoint extends Endpoint {
  final _notifications = NotificationService();

  @override
  bool get requireLogin => true;

  /// Newest alerts for the signed-in actor. [limit] defaults to 20.
  ///
  /// [buildingId] keeps one venue. [createdFrom] and [createdTo] are an
  /// inclusive-exclusive window of at most 32 days. [unreadOnly] drops rows
  /// that were already opened.
  Future<AppNotificationPage> list(
    Session session, {
    UuidValue? buildingId,
    DateTime? createdFrom,
    DateTime? createdTo,
    bool? unreadOnly,
    int? limit,
    int? offset,
  }) {
    return _notifications.list(
      session,
      buildingId: buildingId,
      createdFrom: createdFrom,
      createdTo: createdTo,
      unreadOnly: unreadOnly,
      limit: limit,
      offset: offset,
    );
  }

  /// How many of this actor's alerts are still unread.
  Future<int> unreadCount(Session session) {
    return _notifications.unreadCount(session);
  }

  /// Marks one alert read. Another actor's id is not found.
  Future<AppNotificationView> markRead(Session session, UuidValue id) {
    return _notifications.markRead(session, id);
  }

  /// Marks this actor's unread alerts read. [buildingId] and the date window
  /// use the same limits as [list]. Returns how many rows changed.
  Future<int> markAllRead(
    Session session, {
    UuidValue? buildingId,
    DateTime? createdFrom,
    DateTime? createdTo,
  }) {
    return _notifications.markAllRead(
      session,
      buildingId: buildingId,
      createdFrom: createdFrom,
      createdTo: createdTo,
    );
  }

  /// Each new alert for this actor, after the call starts. Use [list] for
  /// history. The channel is the signed-in actor, not a client argument.
  Stream<AppNotificationView> watch(Session session) {
    return _notifications.watch(session);
  }
}
