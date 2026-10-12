import 'package:sip_sync_client/sip_sync_client.dart';

/// Reads the signed-in actor's stored alerts and the live stream of new ones.
class NotificationRepository {
  NotificationRepository(this._client);

  final Client _client;

  /// Newest page. [offset] skips rows already shown.
  ///
  /// [buildingId] keeps one venue. The date bounds are the current month when
  /// the customer asks for it.
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

  /// Alerts not opened yet. The bell badge uses this count for every venue.
  Future<int> unreadCount() => _client.notification.unreadCount();

  /// Marks one alert read. The server rejects another actor's id.
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

  /// New alerts after this call. History comes from [list].
  Stream<AppNotificationView> watch() => _client.notification.watch();
}
