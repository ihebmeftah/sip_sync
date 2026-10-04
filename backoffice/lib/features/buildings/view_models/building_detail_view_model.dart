import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../pack_assignment.dart';

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

  /// Puts this venue on [assignment] and refreshes the screen.
  Future<String?> assignPack(PackAssignment assignment) async {
    try {
      final detail = await ref
          .read(adminBuildingRepositoryProvider)
          .assignPack(
            UuidValue.fromString(buildingId),
            assignment.packId,
            billingPeriod: assignment.billingPeriod,
            expiresAt: assignment.expiresAt,
          );
      state = AsyncData(detail);
      return null;
    } catch (error) {
      return mapError(error).l10nKey;
    }
  }
}
