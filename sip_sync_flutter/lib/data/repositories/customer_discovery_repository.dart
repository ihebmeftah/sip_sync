import 'package:sip_sync_client/sip_sync_client.dart';

/// Customer venue list and place lookup.
class CustomerDiscoveryRepository {
  CustomerDiscoveryRepository(this._client);

  final Client _client;

  /// Public venue cards for the signed-in customer.
  Future<List<CustomerVenueCard>> listVenues() => _client.customerVenue.list();

  /// Address suggestions. The server rejects queries shorter than 3 characters.
  Future<List<PlaceHit>> searchPlaces(String query) =>
      _client.customerPlace.search(query);

  /// Street label for a device coordinate.
  Future<PlaceHit> reversePlace({
    required double latitude,
    required double longitude,
  }) => _client.customerPlace.reverse(latitude, longitude);
}
