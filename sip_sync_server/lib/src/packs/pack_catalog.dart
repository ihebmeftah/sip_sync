import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Inserts the launch catalog the first time the pack table is empty.
///
/// Later boots do nothing, so a super admin's edits and deletes stay.
class PackCatalog {
  static const freeCode = 'free';

  /// Seeds Counter, Floor, House, Group, and the private free pack.
  static Future<void>  ensure(Session session) async {
    final existing = await Pack.db.count(session);
    if (existing > 0) {
      return;
    }
    session.log('PackCatalog: inserting launch packs.');
    await Pack.db.insert(session, [for (final seed in _seeds) seed]);
  }

  /// The system free pack. Seeds the catalog when the table is still empty.
  static Future<Pack> requireFree(Session session) async {
    await ensure(session);
    final row = await Pack.db.findFirstRow(
      session,
      where: (t) => t.code.equals(freeCode),
    );
    if (row == null) {
      throw PackException(
        message: 'The free pack is missing.',
        code: PackErrorCode.notFound,
      );
    }
    return row;
  }

  /// Moves [buildingId] onto the seeded pack [code].
  ///
  /// Tests and demo data use this when a venue needs more than the free plan.
  /// A missing code or venue throws [PackException] / [PackErrorCode.notFound].
  static Future<void> assignCode(
    Session session,
    UuidValue buildingId,
    String code,
  ) async {
    await ensure(session);
    final pack = await Pack.db.findFirstRow(
      session,
      where: (t) => t.code.equals(code),
    );
    final building = await Building.db.findById(session, buildingId);
    if (pack == null || pack.id == null || building == null) {
      throw PackException(
        message: 'Pack not found.',
        code: PackErrorCode.notFound,
      );
    }
    await Building.db.updateRow(
      session,
      building.copyWith(packId: pack.id),
    );
  }
}

final _seeds = <Pack>[
  _pack(
    code: PackCatalog.freeCode,
    name: 'Free',
    monthlyMillimes: 0,
    annualMillimes: 0,
    customerOrderFeeBps: 0,
    isPublic: false,
    isSystem: true,
    sortOrder: 0,
    maxEmployees: 2,
    maxTables: 8,
    maxCategories: 4,
    maxArticles: 20,
    maxIngredients: 15,
    customerOrdering: false,
    tableMultiOrder: false,
    strictMode: false,
    customAccessProfiles: false,
  ),
  _pack(
    code: 'counter',
    name: 'Counter',
    monthlyMillimes: 39000,
    annualMillimes: 390000,
    customerOrderFeeBps: 0,
    isPublic: true,
    isSystem: false,
    sortOrder: 10,
    maxEmployees: 3,
    maxTables: 12,
    maxCategories: 6,
    maxArticles: 40,
    maxIngredients: 40,
    customerOrdering: false,
    tableMultiOrder: false,
    strictMode: false,
    customAccessProfiles: false,
  ),
  _pack(
    code: 'floor',
    name: 'Floor',
    monthlyMillimes: 89000,
    annualMillimes: 890000,
    customerOrderFeeBps: 150,
    isPublic: true,
    isSystem: false,
    sortOrder: 20,
    maxEmployees: 12,
    maxTables: 40,
    maxCategories: 20,
    maxArticles: 200,
    maxIngredients: 200,
    customerOrdering: true,
    tableMultiOrder: true,
    strictMode: true,
    customAccessProfiles: true,
  ),
  _pack(
    code: 'house',
    name: 'House',
    monthlyMillimes: 149000,
    annualMillimes: 1490000,
    customerOrderFeeBps: 100,
    isPublic: true,
    isSystem: false,
    sortOrder: 30,
    maxEmployees: 30,
    maxTables: 100,
    maxCategories: null,
    maxArticles: null,
    maxIngredients: null,
    customerOrdering: true,
    tableMultiOrder: true,
    strictMode: true,
    customAccessProfiles: true,
  ),
  _pack(
    code: 'group',
    name: 'Group',
    monthlyMillimes: 249000,
    annualMillimes: 2490000,
    customerOrderFeeBps: 50,
    isPublic: false,
    isSystem: false,
    sortOrder: 40,
    maxEmployees: 80,
    maxTables: 250,
    maxCategories: null,
    maxArticles: null,
    maxIngredients: null,
    customerOrdering: true,
    tableMultiOrder: true,
    strictMode: true,
    customAccessProfiles: true,
  ),
];

Pack _pack({
  required String code,
  required String name,
  required int monthlyMillimes,
  required int? annualMillimes,
  required int customerOrderFeeBps,
  required bool isPublic,
  required bool isSystem,
  required int sortOrder,
  required int? maxEmployees,
  required int? maxTables,
  required int? maxCategories,
  required int? maxArticles,
  required int? maxIngredients,
  required bool customerOrdering,
  required bool tableMultiOrder,
  required bool strictMode,
  required bool customAccessProfiles,
}) {
  return Pack(
    code: code,
    name: name,
    monthlyMillimes: monthlyMillimes,
    annualMillimes: annualMillimes,
    customerOrderFeeBps: customerOrderFeeBps,
    isPublic: isPublic,
    isEnabled: true,
    isSystem: isSystem,
    sortOrder: sortOrder,
    maxEmployees: maxEmployees,
    maxTables: maxTables,
    maxCategories: maxCategories,
    maxArticles: maxArticles,
    maxIngredients: maxIngredients,
    customerDiscovery: true,
    tableQr: true,
    customerOrdering: customerOrdering,
    inventory: true,
    allowAppendingItems: true,
    tableMultiOrder: tableMultiOrder,
    strictMode: strictMode,
    customAccessProfiles: customAccessProfiles,
  );
}
