import 'dart:convert';
import 'dart:io';

/// One Nominatim result before it is mapped to the protocol [PlaceHit].
class NominatimHit {
  const NominatimHit({
    required this.label,
    required this.latitude,
    required this.longitude,
  });

  final String label;
  final double latitude;
  final double longitude;
}

/// Parses a Nominatim search body (`format=jsonv2`).
List<NominatimHit> parseNominatimSearch(String body) {
  final decoded = jsonDecode(body);
  if (decoded is! List) {
    return const [];
  }
  final hits = <NominatimHit>[];
  for (final row in decoded) {
    final hit = _hitFromMap(row);
    if (hit != null) {
      hits.add(hit);
    }
  }
  return hits;
}

/// Parses a Nominatim reverse body. Returns null when the place is unknown.
NominatimHit? parseNominatimReverse(String body) {
  final decoded = jsonDecode(body);
  if (decoded is! Map) {
    return null;
  }
  if (decoded['error'] != null) {
    return null;
  }
  return _hitFromMap(decoded);
}

NominatimHit? _hitFromMap(Object? row) {
  if (row is! Map) {
    return null;
  }
  final label = row['display_name'];
  final lat = double.tryParse('${row['lat']}');
  final lon = double.tryParse('${row['lon']}');
  if (label is! String || label.trim().isEmpty || lat == null || lon == null) {
    return null;
  }
  if (lat < -90 || lat > 90 || lon < -180 || lon > 180) {
    return null;
  }
  return NominatimHit(label: label.trim(), latitude: lat, longitude: lon);
}

/// Server-side Nominatim client. Browsers cannot call Nominatim (no CORS).
class NominatimClient {
  NominatimClient({HttpClient? httpClient})
    : _http = httpClient ?? HttpClient();

  static const _base = 'https://nominatim.openstreetmap.org';
  static const userAgent = 'SipSync/1.0 (customer place search)';

  final HttpClient _http;

  /// Address search. Caller enforces a minimum query length.
  Future<List<NominatimHit>> search(String query) async {
    final uri = Uri.parse('$_base/search').replace(
      queryParameters: {
        'q': query,
        'format': 'jsonv2',
        'limit': '5',
        'addressdetails': '0',
      },
    );
    final body = await _get(uri);
    return parseNominatimSearch(body);
  }

  /// Reverse geocode. Null when Nominatim has no label for the point.
  Future<NominatimHit?> reverse(double latitude, double longitude) async {
    final uri = Uri.parse('$_base/reverse').replace(
      queryParameters: {
        'lat': '$latitude',
        'lon': '$longitude',
        'format': 'jsonv2',
        'addressdetails': '0',
      },
    );
    final body = await _get(uri);
    return parseNominatimReverse(body);
  }

  Future<String> _get(Uri uri) async {
    final request = await _http.getUrl(uri);
    request.headers.set(HttpHeaders.userAgentHeader, userAgent);
    request.headers.set(HttpHeaders.acceptHeader, 'application/json');
    final response = await request.close().timeout(const Duration(seconds: 8));
    final body = await utf8.decoder.bind(response).join();
    if (response.statusCode != 200) {
      throw HttpException(
        'Nominatim ${response.statusCode}',
        uri: uri,
      );
    }
    return body;
  }
}
