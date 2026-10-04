import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'platform_stats_service.dart';

/// Platform totals for the backoffice. Super admin only.
class PlatformStatsEndpoint extends Endpoint {
  final _stats = PlatformStatsService();

  @override
  bool get requireLogin => true;

  /// Owners, venues, orders, monthly plan total, and public-pack adoption.
  Future<PlatformStats> summary(Session session) {
    return _stats.summary(session);
  }
}
