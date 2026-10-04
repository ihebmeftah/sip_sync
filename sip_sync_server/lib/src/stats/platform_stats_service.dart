import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../generated/protocol.dart';
import '../packs/pack_catalog.dart';

/// Read-only platform totals. Counts stay on the server so the console
/// does not download every owner, order, or venue.
class PlatformStatsService {
  /// Owners, venues, orders, monthly plan total, and public-pack adoption.
  ///
  /// Super admin only. Private packs stay off [PlatformStats.publicPacks];
  /// their prices still add into [PlatformStats.subscriptionMillimes].
  Future<PlatformStats> summary(Session session) async {
    AuthGuard.requireSuperAdmin(session);
    await PackCatalog.ensure(session);

    final ownerCount = await Owner.db.count(session);
    final customerCount = await Customer.db.count(session);
    final employeeCount = await Employee.db.count(session);
    final orderCount = await VenueOrder.db.count(session);
    final customerOrderCount = await VenueOrder.db.count(
      session,
      where: (t) =>
          t.launchedByType.equals(ActorType.customer) &
          t.status.notEquals(OrderStatus.cancelled),
    );
    final buildings = await Building.db.find(
      session,
      include: Building.include(pack: Pack.include()),
    );
    final packs = await Pack.db.find(
      session,
      where: (t) => t.isPublic.equals(true),
    );
    packs.sort(_bySortThenName);

    var subscriptionMillimes = 0;
    final venuesByPack = <String, List<Building>>{};
    for (final building in buildings) {
      subscriptionMillimes += building.pack?.monthlyMillimes ?? 0;
      final packId = building.packId;
      venuesByPack.putIfAbsent(packId.uuid, () => []).add(building);
    }

    return PlatformStats(
      ownerCount: ownerCount,
      customerCount: customerCount,
      employeeCount: employeeCount,
      venueCount: buildings.length,
      orderCount: orderCount,
      customerOrderCount: customerOrderCount,
      subscriptionMillimes: subscriptionMillimes,
      publicPacks: [
        for (final pack in packs)
          if (pack.id != null)
            _usage(pack, venuesByPack[pack.id!.uuid] ?? const []),
      ],
    );
  }

  PublicPackUsage _usage(Pack pack, List<Building> venues) {
    final owners = venues.map((building) => building.ownerId.uuid).toSet();
    return PublicPackUsage(
      id: pack.id!,
      code: pack.code,
      name: pack.name,
      monthlyMillimes: pack.monthlyMillimes,
      customerOrderFeeBps: pack.customerOrderFeeBps,
      isEnabled: pack.isEnabled,
      venueCount: venues.length,
      ownerCount: owners.length,
    );
  }

  int _bySortThenName(Pack a, Pack b) {
    final byOrder = a.sortOrder.compareTo(b.sortOrder);
    if (byOrder != 0) {
      return byOrder;
    }
    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  }
}
