import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';

part 'dashboard_view_model.g.dart';

/// Today's house counts for one building.
///
/// The local calendar day is sent as UTC midnight, matching the reservation list.
/// A new visit loads fresh counts; pull to refresh does the same while the screen stays open.
@riverpod
class DashboardViewModel extends _$DashboardViewModel {
  @override
  Future<DashboardSummary> build(String buildingId) {
    return _load(buildingId);
  }

  /// Reloads counts without clearing the numbers already on screen.
  Future<void> refresh() async {
    state = await AsyncValue.guard(() => _load(buildingId));
  }

  Future<DashboardSummary> _load(String buildingId) {
    final now = DateTime.now();
    final day = DateTime.utc(now.year, now.month, now.day);
    return ref
        .read(dashboardRepositoryProvider)
        .summary(UuidValue.fromString(buildingId), day);
  }
}
