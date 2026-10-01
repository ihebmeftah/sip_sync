import 'package:sip_sync_server/src/discovery/nominatim_client.dart';
import 'package:test/test.dart';

void main() {
  test('search parser keeps labeled coordinates and skips junk', () {
    const body = '''
[
  {"display_name":"Avenue Habib Bourguiba, Tunis","lat":"36.800","lon":"10.180"},
  {"display_name":"","lat":"1","lon":"2"},
  {"error":"nope"}
]
''';
    final hits = parseNominatimSearch(body);
    expect(hits, hasLength(1));
    expect(hits.single.label, 'Avenue Habib Bourguiba, Tunis');
    expect(hits.single.latitude, 36.8);
    expect(hits.single.longitude, 10.18);
  });

  test('reverse parser returns null when Nominatim reports an error', () {
    expect(
      parseNominatimReverse('{"error":"Unable to geocode"}'),
      isNull,
    );
    final hit = parseNominatimReverse(
      '{"display_name":"Olive Café","lat":"36.8065","lon":"10.1815"}',
    );
    expect(hit?.label, 'Olive Café');
    expect(hit?.latitude, 36.8065);
  });
}
