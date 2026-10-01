import 'package:geolocator/geolocator.dart';

/// Device coordinates from the platform location service.
class DeviceLocation {
  const DeviceLocation({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
}

sealed class DeviceLocationException implements Exception {
  const DeviceLocationException(this.l10nKey);
  final String l10nKey;
}

class DeviceLocationDenied extends DeviceLocationException {
  const DeviceLocationDenied() : super('errorLocationDenied');
}

class DeviceLocationDisabled extends DeviceLocationException {
  const DeviceLocationDisabled() : super('errorLocationDisabled');
}

class DeviceLocationFailed extends DeviceLocationException {
  const DeviceLocationFailed() : super('errorLocationFailed');
}

/// Reads the current position after asking for when-in-use permission.
class DeviceLocationReader {
  Future<DeviceLocation> current() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const DeviceLocationDisabled();
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      throw const DeviceLocationDenied();
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 12),
        ),
      );
      return DeviceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (_) {
      throw const DeviceLocationFailed();
    }
  }
}
