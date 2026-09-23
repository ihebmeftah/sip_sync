import 'package:sip_sync_client/sip_sync_client.dart';

/// Encoded content for a printable / scannable table sticker.
///
/// Format: `sipsync:table:v1:<buildingId>:<tableId>:<number>`
class TableQrPayload {
  const TableQrPayload({
    required this.buildingId,
    required this.tableId,
    required this.number,
  });

  final UuidValue buildingId;
  final UuidValue tableId;
  final int number;

  static const prefix = 'sipsync:table:v1:';

  factory TableQrPayload.fromTable({
    required UuidValue buildingId,
    required VenueTableView table,
  }) {
    return TableQrPayload(
      buildingId: buildingId,
      tableId: table.id,
      number: table.number,
    );
  }

  String encode() => '$prefix${buildingId.uuid}:${tableId.uuid}:$number';

  /// Returns null when the string is not a Sip Sync table sticker.
  static TableQrPayload? tryParse(String raw) {
    final value = raw.trim();
    if (!value.startsWith(prefix)) {
      return null;
    }
    final parts = value.substring(prefix.length).split(':');
    if (parts.length != 3) {
      return null;
    }
    final number = int.tryParse(parts[2]);
    if (number == null || number < 1) {
      return null;
    }
    try {
      return TableQrPayload(
        buildingId: UuidValue.fromString(parts[0]),
        tableId: UuidValue.fromString(parts[1]),
        number: number,
      );
    } catch (_) {
      return null;
    }
  }
}
