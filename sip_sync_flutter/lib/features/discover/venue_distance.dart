import 'dart:math' as math;

import 'package:sip_sync_client/sip_sync_client.dart';

/// Venues inside this radius count as nearby.
const nearbyRadiusKm = 15.0;

/// Straight-line walking pace used for the approximate walk time.
const walkSpeedKmh = 4.8;

/// Great-circle distance in kilometres.
double haversineKm(
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) {
  const earthKm = 6371.0;
  final dLat = _rad(lat2 - lat1);
  final dLon = _rad(lon2 - lon1);
  final a =
      math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(_rad(lat1)) *
          math.cos(_rad(lat2)) *
          math.sin(dLon / 2) *
          math.sin(dLon / 2);
  final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  return earthKm * c;
}

/// Approximate walk minutes at [walkSpeedKmh]. At least one minute.
int walkMinutesFor(double distanceKm) {
  final minutes = distanceKm / walkSpeedKmh * 60;
  if (minutes < 1) {
    return 1;
  }
  return minutes.round();
}

/// One decimal under 10 km, otherwise a whole number.
String formatDistanceValue(double distanceKm) {
  if (distanceKm < 10) {
    return distanceKm.toStringAsFixed(1);
  }
  return distanceKm.round().toString();
}

/// `minutes` from midnight as `HH:mm`.
String formatClock(int minutesFromMidnight) {
  final wrapped = minutesFromMidnight % (24 * 60);
  final hours = wrapped ~/ 60;
  final minutes = wrapped % 60;
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}

/// Venue plus distance from the customer's chosen place.
class RankedVenue {
  const RankedVenue({
    required this.venue,
    this.distanceKm,
    this.walkMinutes,
  });

  final CustomerVenueCard venue;
  final double? distanceKm;
  final int? walkMinutes;
}

/// Sorts [venues] nearest first when [origin] is set.
///
/// When [nearbyOnly] is true and an origin exists, drops venues beyond
/// [nearbyRadiusKm].
List<RankedVenue> rankVenues({
  required List<CustomerVenueCard> venues,
  required double? originLat,
  required double? originLon,
  required bool nearbyOnly,
}) {
  final hasOrigin = originLat != null && originLon != null;
  final ranked = [
    for (final venue in venues)
      if (!hasOrigin)
        RankedVenue(venue: venue)
      else
        RankedVenue(
          venue: venue,
          distanceKm: haversineKm(
            originLat,
            originLon,
            venue.latitude,
            venue.longitude,
          ),
        ),
  ];
  if (!hasOrigin) {
    return ranked;
  }
  final withDistance = [
    for (final row in ranked)
      RankedVenue(
        venue: row.venue,
        distanceKm: row.distanceKm,
        walkMinutes: walkMinutesFor(row.distanceKm!),
      ),
  ]..sort((a, b) => a.distanceKm!.compareTo(b.distanceKm!));
  if (!nearbyOnly) {
    return withDistance;
  }
  return [
    for (final row in withDistance)
      if (row.distanceKm! <= nearbyRadiusKm) row,
  ];
}

double _rad(double degrees) => degrees * math.pi / 180;
