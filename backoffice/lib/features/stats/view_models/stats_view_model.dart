import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';

part 'stats_view_model.g.dart';

/// Platform totals for the stats screen.
@Riverpod(keepAlive: true)
class StatsViewModel extends _$StatsViewModel {
  @override
  Future<PlatformStats> build() {
    return ref.read(platformStatsRepositoryProvider).summary();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(platformStatsRepositoryProvider).summary(),
    );
  }
}
