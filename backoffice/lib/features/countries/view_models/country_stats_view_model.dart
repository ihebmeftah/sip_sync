import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';

part 'country_stats_view_model.g.dart';

/// Venue counts per country for the map screen.
@Riverpod(keepAlive: true)
class CountryStatsViewModel extends _$CountryStatsViewModel {
  @override
  Future<List<CountryBuildingStat>> build() {
    return ref.read(adminBuildingRepositoryProvider).countryStats();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(adminBuildingRepositoryProvider).countryStats(),
    );
  }
}
