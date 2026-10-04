import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Writes the assignment row each time a venue changes plan.
///
/// [Building.packId] stays the current plan so gates and the expiry sweep
/// stay a single-row read. This table is the history of those changes.
class BuildingPackHistory {
  /// Opens the first row for a venue that was just created on [packId].
  static Future<void> openInitial(
    Session session, {
    required UuidValue buildingId,
    required UuidValue packId,
    Transaction? transaction,
  }) {
    return BuildingPackAssignment.db.insertRow(
      session,
      BuildingPackAssignment(
        buildingId: buildingId,
        packId: packId,
        startedAt: DateTime.now().toUtc(),
      ),
      transaction: transaction,
    );
  }

  /// Closes the open row with [reason] and stores [pack] as the current plan.
  static Future<Building> change(
    Session session, {
    required Building building,
    required Pack pack,
    required PackBillingPeriod? billingPeriod,
    required DateTime? expiresAt,
    required BuildingPackEndReason reason,
  }) {
    final buildingId = building.id;
    final packId = pack.id;
    if (buildingId == null || packId == null) {
      throw PackException(
        message: 'This venue has no pack.',
        code: PackErrorCode.notFound,
      );
    }
    return session.db.transaction((transaction) async {
      final now = DateTime.now().toUtc();
      final rows = await BuildingPackAssignment.db.find(
        session,
        where: (t) => t.buildingId.equals(buildingId),
        transaction: transaction,
      );
      for (final row in rows) {
        if (row.endedAt != null) {
          continue;
        }
        await BuildingPackAssignment.db.updateRow(
          session,
          row.copyWith(endedAt: now, endReason: reason),
          transaction: transaction,
        );
      }
      await BuildingPackAssignment.db.insertRow(
        session,
        BuildingPackAssignment(
          buildingId: buildingId,
          packId: packId,
          billingPeriod: billingPeriod,
          startedAt: now,
          expiresAt: expiresAt,
        ),
        transaction: transaction,
      );
      return Building.db.updateRow(
        session,
        building.copyWith(
          packId: packId,
          pack: pack,
          packBillingPeriod: billingPeriod,
          packExpiresAt: expiresAt,
        ),
        transaction: transaction,
      );
    });
  }

  /// Newest assignment first. The open row has a null end.
  static Future<List<BuildingPackAssignmentView>> list(
    Session session,
    UuidValue buildingId,
  ) async {
    final rows = await BuildingPackAssignment.db.find(
      session,
      where: (t) => t.buildingId.equals(buildingId),
      include: BuildingPackAssignment.include(pack: Pack.include()),
      orderBy: (t) => t.startedAt.desc(),
    );
    return [
      for (final row in rows)
        if (row.id != null && row.pack != null && row.pack!.id != null)
          BuildingPackAssignmentView(
            id: row.id!,
            packId: row.pack!.id!,
            packCode: row.pack!.code,
            packName: row.pack!.name,
            billingPeriod: row.billingPeriod,
            startedAt: row.startedAt,
            expiresAt: row.expiresAt,
            endedAt: row.endedAt,
            endReason: row.endReason,
          ),
    ];
  }
}
