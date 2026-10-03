import 'package:flutter_test/flutter_test.dart';
import 'package:sip_sync_client/sip_sync_client.dart';
import 'package:sip_sync_flutter/features/venue/table_qr_payload.dart';

void main() {
  test('parses a table sticker and rejects anything else', () {
    const building = '01990000-0000-7000-8000-000000000010';
    const table = '01990000-0000-7000-8000-000000000011';
    final payload = TableQrPayload.tryParse(
      'sipsync:table:v1:$building:$table:4',
    );

    expect(payload, isNotNull);
    expect(payload!.buildingId, UuidValue.fromString(building));
    expect(payload.tableId, UuidValue.fromString(table));
    expect(payload.number, 4);
    expect(TableQrPayload.tryParse('https://example.com'), isNull);
    expect(
      TableQrPayload.tryParse('sipsync:table:v1:$building:$table:0'),
      isNull,
    );
  });
}
