import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';

part 'building_detail_view_model.g.dart';

/// One venue for the backoffice detail screen.
@riverpod
class BuildingDetailViewModel extends _$BuildingDetailViewModel {
  @override
  Future<AdminBuildingDetail> build(String buildingId) {
    return ref
        .read(adminBuildingRepositoryProvider)
        .detail(UuidValue.fromString(buildingId));
  }

  /// Puts this venue on [packId] and refreshes the screen.
  Future<String?> assignPack(UuidValue packId) async {
    try {
      final detail = await ref
          .read(adminBuildingRepositoryProvider)
          .assignPack(UuidValue.fromString(buildingId), packId);
      state = AsyncData(detail);
      return null;
    } catch (error) {
      return mapError(error).l10nKey;
    }
  }
}
