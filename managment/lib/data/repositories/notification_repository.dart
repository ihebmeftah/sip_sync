import 'package:sip_sync_client/sip_sync_client.dart';

/// Reads the signed-in owner or employee's stored alerts.
class NotificationRepository {
  NotificationRepository(this._client);

  final Client _client;

  /// Newest page. [buildingId] keeps one venue. The date window is a month.
  Future<AppNotificationPage> list({
    UuidValue? buildingId,
    DateTime? createdFrom,
    DateTime? createdTo,
    bool? unreadOnly,
    int? limit,
    int? offset,
  }) {
    return _client.notification.list(
      buildingId: buildingId,
      createdFrom: createdFrom,
      createdTo: createdTo,
      unreadOnly: unreadOnly,
      limit: limit,
      offset: offset,
    );
  }

  /// Unread alerts. [buildingId] keeps one venue: the open house for an owner,
  /// or the workplace for an employee.
  Future<int> unreadCount({UuidValue? buildingId}) {
    return _client.notification.unreadCount(buildingId: buildingId);
  }

  Future<AppNotificationView> markRead(UuidValue id) {
    return _client.notification.markRead(id);
  }

  /// Marks unread rows in the same venue and month scope. Returns the count.
  Future<int> markAllRead({
    UuidValue? buildingId,
    DateTime? createdFrom,
    DateTime? createdTo,
  }) {
    return _client.notification.markAllRead(
      buildingId: buildingId,
      createdFrom: createdFrom,
      createdTo: createdTo,
    );
  }

  /// New alerts for this actor. History comes from [list].
  Stream<AppNotificationView> watch() => _client.notification.watch();
}
