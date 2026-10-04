import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'pack_catalog.dart';
import 'pack_history.dart';

/// Returns a venue to the free pack once [Building.packExpiresAt] has passed.
class PackExpiry {
  /// Moves every venue whose term has ended onto the free pack.
  static Future<int> revertDue(Session session, {DateTime? now}) async {
    final clock = (now ?? DateTime.now()).toUtc();
    final due = await Building.db.find(
      session,
      where: (t) => t.packExpiresAt <= clock,
    );
    if (due.isEmpty) {
      return 0;
    }
    final free = await PackCatalog.requireFree(session);
    for (final row in due) {
      await _toFree(session, row, free);
    }
    session.log(
      'PackExpiry: returned ${due.length} venue(s) to the free pack.',
    );
    return due.length;
  }

  /// Returns [row] unchanged, or the free-pack row when its term has ended.
  static Future<Building> apply(Session session, Building row) async {
    final expires = row.packExpiresAt;
    if (expires == null || expires.toUtc().isAfter(DateTime.now().toUtc())) {
      return row;
    }
    final free = await PackCatalog.requireFree(session);
    return _toFree(session, row, free);
  }

  static Future<Building> _toFree(
    Session session,
    Building row,
    Pack free,
  ) {
    return BuildingPackHistory.change(
      session,
      building: row,
      pack: free,
      billingPeriod: null,
      expiresAt: null,
      reason: BuildingPackEndReason.expired,
    );
  }
}
