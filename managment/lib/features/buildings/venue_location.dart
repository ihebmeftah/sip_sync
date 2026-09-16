import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

/// Device GPS plus reverse geocoding for the building form.
class VenueLocation {
  const VenueLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  final double latitude;
  final double longitude;
  final String? address;
}

sealed class VenueLocationException implements Exception {
  const VenueLocationException(this.l10nKey);
  final String l10nKey;
}

class VenueLocationDenied extends VenueLocationException {
  const VenueLocationDenied() : super('errorLocationDenied');
}

class VenueLocationDisabled extends VenueLocationException {
  const VenueLocationDisabled() : super('errorLocationDisabled');
}

class VenueLocationFailed extends VenueLocationException {
  const VenueLocationFailed() : super('errorLocationFailed');
}

/// Reads the current position with [Geolocator] and an address with [geocoding].
class VenueLocationPicker {
  /// Asks for when-in-use permission, then fills coordinates and a street line.
  Future<VenueLocation> pickCurrent() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const VenueLocationDisabled();
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      throw const VenueLocationDenied();
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      String? address;
      try {
        final marks = await Geocoding().placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (marks.isNotEmpty) {
          address = _formatPlacemark(marks.first);
        }
      } catch (_) {
        // Coordinates are still usable if reverse geocoding is unavailable.
      }
      return VenueLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      );
    } catch (error) {
      if (error is VenueLocationException) {
        rethrow;
      }
      throw const VenueLocationFailed();
    }
  }

  String? _formatPlacemark(Placemark mark) {
    final parts = [
      mark.street,
      mark.subLocality,
      mark.locality,
      mark.administrativeArea,
      mark.country,
    ].where((part) => part != null && part.trim().isNotEmpty).toList();
    if (parts.isEmpty) {
      return null;
    }
    return parts.join(', ');
  }
}
