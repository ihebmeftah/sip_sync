import 'package:sip_sync_server/src/seed/dev_seed.dart';
import 'package:test/test.dart';

void main() {
  test('demo catalog is 30 venues with 10 categories each', () {
    expect(DevSeed.validateCatalog, returnsNormally);
  });
}
