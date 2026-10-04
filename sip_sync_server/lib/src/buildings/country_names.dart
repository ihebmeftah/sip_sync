import 'package:serverpod/serverpod.dart';

import '../core/phone_numbers.dart';
import '../generated/protocol.dart';

/// Writes the English country name onto venues that only have a code.
abstract final class CountryNames {
  /// Fills blank [Building.countryName] rows from [Building.countryCode].
  static Future<void> fillMissing(Session session) async {
    final rows = await Building.db.find(
      session,
      where: (table) => table.countryName.equals(''),
    );
    for (final row in rows) {
      final name = PhoneNumbers.countryNameFromCode(row.countryCode);
      if (name == null) {
        continue;
      }
      await Building.db.updateRow(session, row.copyWith(countryName: name));
    }
  }
}
