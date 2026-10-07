import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/di/building_session.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/paging/list_paging.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'buildings_view_model.g.dart';

@Riverpod(keepAlive: true)
class BuildingsViewModel extends _$BuildingsViewModel {
  var _offset = 0;

  @override
  Future<BuildingPage> build() async {
    _offset = 0;
    final actorId = ref.watch(signedInActorIdProvider);
    if (actorId == null) {
      getIt<BuildingSession>().replace(const []);
      return BuildingPage(
        items: const [],
        total: 0,
        limit: listPageSize,
        offset: 0,
      );
    }
    return _load();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<void> previousPage() => _show(_offset - listPageSize);

  Future<void> nextPage() => _show(_offset + listPageSize);

  Future<void> _show(int offset) async {
    _offset = offset < 0 ? 0 : offset;
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<BuildingPage> _load() async {
    final page = await ref
        .read(buildingRepositoryProvider)
        .listMine(limit: listPageSize, offset: _offset);
    if (page.items.isEmpty && page.offset > 0 && page.total > 0) {
      _offset = ((page.total - 1) ~/ listPageSize) * listPageSize;
      return _load();
    }
    getIt<BuildingSession>().showPage(page.items);
    return page;
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
    required String phoneNumber,
    String? whatsapp,
    String? instagram,
    String? facebook,
    required List<String> otherLinks,
    required bool tableMultiOrder,
    required bool allowAppendingItemsToOrder,
    required bool strictMode,
    required List<StrictModeStep> strictModeSteps,
    required double reservationFee,
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
              phoneNumber: phoneNumber,
              whatsapp: whatsapp,
              instagram: instagram,
              facebook: facebook,
              otherLinks: otherLinks,
              tableMultiOrder: tableMultiOrder,
              allowAppendingItemsToOrder: allowAppendingItemsToOrder,
              strictMode: strictMode,
              strictModeSteps: strictModeSteps,
              reservationFee: reservationFee,
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
              phoneNumber: phoneNumber,
              whatsapp: whatsapp,
              instagram: instagram,
              facebook: facebook,
              otherLinks: otherLinks,
              tableMultiOrder: tableMultiOrder,
              allowAppendingItemsToOrder: allowAppendingItemsToOrder,
              strictMode: strictMode,
              strictModeSteps: strictModeSteps,
              reservationFee: reservationFee,
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
