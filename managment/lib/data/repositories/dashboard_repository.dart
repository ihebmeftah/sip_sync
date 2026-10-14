import 'package:sip_sync_client/sip_sync_client.dart';

/// Operational counts for one venue on one local calendar day.
class DashboardRepository {
  DashboardRepository(this._client);

  final Client _client;

  /// [day] is the device's local calendar date stored as UTC midnight.
  Future<DashboardSummary> summary(UuidValue buildingId, DateTime day) {
    return _client.dashboard.summary(buildingId, day);
  }
}
