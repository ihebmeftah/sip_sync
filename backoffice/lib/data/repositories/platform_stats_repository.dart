import 'package:sip_sync_client/sip_sync_client.dart';

/// Platform totals for the backoffice stats screen.
class PlatformStatsRepository {
  PlatformStatsRepository(this._client);

  final Client _client;

  /// Owners, venues, orders, monthly plan total, and public-pack adoption.
  Future<PlatformStats> summary() => _client.platformStats.summary();
}
