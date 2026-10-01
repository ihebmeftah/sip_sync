import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../generated/protocol.dart';
import 'nominatim_client.dart';

/// Address search and reverse geocoding for signed-in customers.
///
/// Proxies Nominatim so the Flutter web app is not blocked by CORS.
class CustomerPlaceEndpoint extends Endpoint {
  CustomerPlaceEndpoint({NominatimClient? nominatim})
    : _nominatim = nominatim ?? NominatimClient();

  final NominatimClient _nominatim;

  @override
  bool get requireLogin => true;

  /// Up to five address suggestions. Query must be 3–200 characters.
  Future<List<PlaceHit>> search(Session session, String query) async {
    AuthGuard.requireCustomer(session);
    final trimmed = query.trim();
    if (trimmed.length < 3 || trimmed.length > 200) {
      throw PlaceException(
        message: 'Enter at least 3 characters.',
        code: PlaceErrorCode.invalidInput,
      );
    }
    try {
      final hits = await _nominatim.search(trimmed);
      return [
        for (final hit in hits)
          PlaceHit(
            label: hit.label,
            latitude: hit.latitude,
            longitude: hit.longitude,
          ),
      ];
    } catch (error, stackTrace) {
      session.log(
        'Place search failed',
        level: LogLevel.error,
        exception: error,
        stackTrace: stackTrace,
      );
      throw PlaceException(
        message: 'Address lookup failed.',
        code: PlaceErrorCode.lookupFailed,
      );
    }
  }

  /// Label for a coordinate the customer picked on the device.
  Future<PlaceHit> reverse(
    Session session,
    double latitude,
    double longitude,
  ) async {
    AuthGuard.requireCustomer(session);
    if (latitude < -90 ||
        latitude > 90 ||
        longitude < -180 ||
        longitude > 180) {
      throw PlaceException(
        message: 'Latitude and longitude are out of range.',
        code: PlaceErrorCode.invalidInput,
      );
    }
    try {
      final hit = await _nominatim.reverse(latitude, longitude);
      if (hit == null) {
        throw PlaceException(
          message: 'No address for that position.',
          code: PlaceErrorCode.notFound,
        );
      }
      return PlaceHit(
        label: hit.label,
        latitude: hit.latitude,
        longitude: hit.longitude,
      );
    } on PlaceException {
      rethrow;
    } catch (error, stackTrace) {
      session.log(
        'Reverse geocode failed',
        level: LogLevel.error,
        exception: error,
        stackTrace: stackTrace,
      );
      throw PlaceException(
        message: 'Address lookup failed.',
        code: PlaceErrorCode.lookupFailed,
      );
    }
  }
}
