import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';

part 'buildings_view_model.g.dart';

/// Platform building list for the backoffice console.
@Riverpod(keepAlive: true)
class BuildingsViewModel extends _$BuildingsViewModel {
  @override
  Future<List<AdminBuildingView>> build() {
    return ref.read(adminBuildingRepositoryProvider).listAll();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(adminBuildingRepositoryProvider).listAll(),
    );
  }
}
