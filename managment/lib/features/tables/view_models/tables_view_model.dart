import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'tables_view_model.g.dart';

@Riverpod(keepAlive: true)
class TablesViewModel extends _$TablesViewModel {
  late String _buildingId;
  TableListFilter _filter = TableListFilter.all;

  /// Current floor chip filter.
  TableListFilter get filter => _filter;

  @override
  Future<List<VenueTableView>> build(String buildingId) async {
    _buildingId = buildingId;
    ref.watch(signedInActorIdProvider);
    if (buildingId.isEmpty) {
      return const [];
    }
    return ref
        .read(venueTableRepositoryProvider)
        .list(UuidValue.fromString(buildingId), filter: _filter);
  }

  /// Changes the floor chip and reloads from the server.
  Future<void> setFilter(TableListFilter filter) async {
    if (_filter == filter) return;
    _filter = filter;
    await refresh();
  }

  /// Remount: reset chip to All and refetch (keepAlive otherwise keeps the filter).
  Future<void> onScreenAppeared() async {
    _filter = TableListFilter.all;
    await refresh();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      if (_buildingId.isEmpty) {
        return const <VenueTableView>[];
      }
      return ref
          .read(venueTableRepositoryProvider)
          .list(UuidValue.fromString(_buildingId), filter: _filter);
    });
  }

  /// Unfiltered list for QR sticker export (all tables in the building).
  Future<List<VenueTableView>> listAllForExport() {
    if (_buildingId.isEmpty) {
      return Future.value(const []);
    }
    return ref
        .read(venueTableRepositoryProvider)
        .list(UuidValue.fromString(_buildingId), filter: TableListFilter.all);
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
