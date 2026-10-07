import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'pack_expiry.dart';

/// Checks a venue's pack before a write is stored.
class PackGate {
  /// The pack stored on [buildingId].
  static Future<Pack> ofBuilding(
    Session session,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(
      session,
      buildingId,
      include: Building.include(pack: Pack.include()),
    );
    if (building == null || building.pack == null) {
      throw PackException(
        message: 'This venue has no pack.',
        code: PackErrorCode.notFound,
      );
    }
    final current = await PackExpiry.apply(session, building);
    final pack = current.pack;
    if (pack == null) {
      throw PackException(
        message: 'This venue has no pack.',
        code: PackErrorCode.notFound,
      );
    }
    return pack;
  }

  /// Rejects a write the pack does not include.
  static void requireFeature(bool allowed, PackFeature feature) {
    if (!allowed) {
      throw PackException(
        message: 'This pack does not include that.',
        code: PackErrorCode.featureOff,
        feature: feature,
      );
    }
  }

  /// Rejects only when the caller is turning the capability on.
  static void requireIfRequested(
    bool requested,
    bool allowed,
    PackFeature feature,
  ) {
    if (requested) {
      requireFeature(allowed, feature);
    }
  }

  /// Rejects a write that would pass [max]. Null [max] means no cap.
  static void requireRoom({
    required int? max,
    required int current,
    required int adding,
    required PackFeature feature,
  }) {
    if (max == null) {
      return;
    }
    if (adding < 1 || current + adding > max) {
      throw PackException(
        message: 'This pack has reached its limit.',
        code: PackErrorCode.limitReached,
        feature: feature,
      );
    }
  }

  /// Owner-facing summary of [pack].
  static BuildingPackView summary(Pack pack) {
    return BuildingPackView(
      code: pack.code,
      name: pack.name,
      monthlyMillimes: pack.monthlyMillimes,
      customerOrderFeeBps: pack.customerOrderFeeBps,
      maxEmployees: pack.maxEmployees,
      maxTables: pack.maxTables,
      maxCategories: pack.maxCategories,
      maxArticles: pack.maxArticles,
      maxIngredients: pack.maxIngredients,
      customerDiscovery: pack.customerDiscovery,
      tableQr: pack.tableQr,
      customerOrdering: pack.customerOrdering,
      inventory: pack.inventory,
      allowAppendingItems: pack.allowAppendingItems,
      tableMultiOrder: pack.tableMultiOrder,
      strictMode: pack.strictMode,
      customAccessProfiles: pack.customAccessProfiles,
      reservations: pack.reservations,
      maxReservationsPerDay: pack.maxReservationsPerDay,
    );
  }
}
