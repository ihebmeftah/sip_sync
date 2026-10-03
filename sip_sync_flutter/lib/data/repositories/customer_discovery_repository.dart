import 'package:sip_sync_client/sip_sync_client.dart';

/// Customer venue list, place lookup, and the public menu.
class CustomerDiscoveryRepository {
  CustomerDiscoveryRepository(this._client);

  final Client _client;

  /// Public venue cards for the signed-in customer.
  Future<List<CustomerVenueCard>> listVenues() => _client.customerVenue.list();

  /// Free tables and the top categories and articles for one venue.
  Future<CustomerVenueDetail> venueDetail(UuidValue buildingId) =>
      _client.customerVenue.detail(buildingId);

  /// Full menu in catalog order.
  Future<CustomerMenu> venueMenu(UuidValue buildingId) =>
      _client.customerVenue.menu(buildingId);

  /// Confirms a scanned sticker is an active table in that venue.
  Future<CustomerSeatedTable> resolveTable({
    required UuidValue buildingId,
    required UuidValue tableId,
    required int number,
  }) => _client.customerVenue.resolveTable(buildingId, tableId, number);

  /// Address suggestions. The server rejects queries shorter than 3 characters.
  Future<List<PlaceHit>> searchPlaces(String query) =>
      _client.customerPlace.search(query);

  /// Street label for a device coordinate.
  Future<PlaceHit> reversePlace({
    required double latitude,
    required double longitude,
  }) => _client.customerPlace.reverse(latitude, longitude);
}
