import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/di/building_session.dart';
import '../../../core/di/service_locator.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'buildings_view_model.g.dart';

@Riverpod(keepAlive: true)
class BuildingsViewModel extends _$BuildingsViewModel {
  @override
  Future<List<BuildingView>> build() async {
    final actorId = ref.watch(signedInActorIdProvider);
    if (actorId == null) {
      getIt<BuildingSession>().replace(const []);
      return const [];
    }
    final list = await ref.read(buildingRepositoryProvider).listMine();
    getIt<BuildingSession>().replace(list);
    return list;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final list = await ref.read(buildingRepositoryProvider).listMine();
      getIt<BuildingSession>().replace(list);
      return list;
    });
  }
}

@riverpod
class BuildingFormViewModel extends _$BuildingFormViewModel {
  @override
  Future<BuildingView?> build(String buildingId) async {
    if (buildingId.isEmpty) {
      return null;
    }
    return ref
        .read(buildingRepositoryProvider)
        .get(UuidValue.fromString(buildingId));
  }

  Future<BuildingView?> save({
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    required bool tableMultiOrder,
    required bool allowAppendingItemsToOrder,
    required bool strictMode,
    required List<StrictModeStep> strictModeSteps,
  }) async {
    try {
      final existing = state.asData?.value;
      late final BuildingView saved;
      if (existing == null) {
        saved = await ref
            .read(buildingRepositoryProvider)
            .create(
              name: name,
              type: type,
              address: address,
              latitude: latitude,
              longitude: longitude,
              openingMinutes: openingMinutes,
              closingMinutes: closingMinutes,
              currencyCode: currencyCode,
              tableMultiOrder: tableMultiOrder,
              allowAppendingItemsToOrder: allowAppendingItemsToOrder,
              strictMode: strictMode,
              strictModeSteps: strictModeSteps,
            );
      } else {
        saved = await ref
            .read(buildingRepositoryProvider)
            .update(
              id: existing.id,
              name: name,
              type: type,
              address: address,
              latitude: latitude,
              longitude: longitude,
              openingMinutes: openingMinutes,
              closingMinutes: closingMinutes,
              currencyCode: currencyCode,
              tableMultiOrder: tableMultiOrder,
              allowAppendingItemsToOrder: allowAppendingItemsToOrder,
              strictMode: strictMode,
              strictModeSteps: strictModeSteps,
            );
      }
      getIt<BuildingSession>().upsert(saved);
      await ref.read(buildingsViewModelProvider.notifier).refresh();
      return saved;
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
      return null;
    }
  }
}
