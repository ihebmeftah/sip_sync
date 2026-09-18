import 'package:sip_sync_client/sip_sync_client.dart';

/// Floor table CRUD for a building.
class VenueTableRepository {
  VenueTableRepository(this._client);

  final Client _client;

  Future<List<VenueTableView>> list(UuidValue buildingId) =>
      _client.venueTable.list(buildingId);

  /// Creates [count] tables; the server assigns sequential numbers.
  Future<List<VenueTableView>> create({
    required UuidValue buildingId,
    required int count,
    required int maxSeats,
    required bool isActive,
  }) {
    return _client.venueTable.create(
      VenueTableCreate(
        buildingId: buildingId,
        count: count,
        maxSeats: maxSeats,
        isActive: isActive,
      ),
    );
  }

  /// Updates seats and active only (number is immutable).
  Future<VenueTableView> update({
    required UuidValue id,
    required int maxSeats,
    required bool isActive,
  }) {
    return _client.venueTable.update(
      VenueTableUpdate(id: id, maxSeats: maxSeats, isActive: isActive),
    );
  }
}
