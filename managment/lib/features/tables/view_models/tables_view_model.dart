import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'tables_view_model.g.dart';

/// Floor filter chips (status is computed; inactive is persisted).
enum TableFloorFilter { all, available, occupied, reserved, inactive }

@Riverpod(keepAlive: true)
class TablesViewModel extends _$TablesViewModel {
  late String _buildingId;

  @override
  Future<List<VenueTableView>> build(String buildingId) async {
    _buildingId = buildingId;
    ref.watch(signedInActorIdProvider);
    if (buildingId.isEmpty) {
      return const [];
    }
    return ref
        .read(venueTableRepositoryProvider)
        .list(UuidValue.fromString(buildingId));
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      if (_buildingId.isEmpty) {
        return const <VenueTableView>[];
      }
      return ref
          .read(venueTableRepositoryProvider)
          .list(UuidValue.fromString(_buildingId));
    });
  }

  /// Creates [count] tables with sequential numbers assigned by the server.
  Future<List<VenueTableView>> createBatch({
    required int count,
    required int maxSeats,
    required bool isActive,
  }) async {
    final saved = await ref
        .read(venueTableRepositoryProvider)
        .create(
          buildingId: UuidValue.fromString(_buildingId),
          count: count,
          maxSeats: maxSeats,
          isActive: isActive,
        );
    await refresh();
    return saved;
  }

  /// Updates seats / active; table number cannot change.
  Future<VenueTableView> updateTable({
    required UuidValue id,
    required int maxSeats,
    required bool isActive,
  }) async {
    final saved = await ref
        .read(venueTableRepositoryProvider)
        .update(id: id, maxSeats: maxSeats, isActive: isActive);
    await refresh();
    return saved;
  }
}

List<VenueTableView> filterTables(
  List<VenueTableView> tables,
  TableFloorFilter filter,
) {
  return switch (filter) {
    TableFloorFilter.all => tables,
    TableFloorFilter.inactive => tables.where((t) => !t.isActive).toList(),
    TableFloorFilter.available =>
      tables
          .where((t) => t.isActive && t.status == TableFloorStatus.available)
          .toList(),
    TableFloorFilter.occupied =>
      tables
          .where((t) => t.isActive && t.status == TableFloorStatus.occupied)
          .toList(),
    TableFloorFilter.reserved =>
      tables
          .where((t) => t.isActive && t.status == TableFloorStatus.reserved)
          .toList(),
  };
}
