import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/auth/password_hasher.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given platform stats', (sessionBuilder, endpoints) {
    const sessionId = '01900000-0000-7000-8000-0000000000f1';

    Future<
      ({dynamic adminSession, dynamic ownerSession, BuildingView building})
    >
    seed() async {
      final session = sessionBuilder.build();
      final admin = await SuperAdmin.db.insertRow(
        session,
        SuperAdmin(
          email: 'stats@sipsync.dev',
          phoneNumber: '+21623000021',
          firstName: 'Stats',
          lastName: 'Admin',
          passwordHash: PasswordHasher().hash('password1'),
        ),
      );
      final adminSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          admin.id!.uuid,
          {Scope('sip.superAdmin')},
          authId: sessionId,
        ),
      );
      final registered = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'stats-owner@sipsync.dev',
          password: 'password1',
          phoneNumber: '+21623000022',
          firstName: 'Sami',
          lastName: 'Owner',
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          registered.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: '01900000-0000-7000-8000-0000000000f2',
        ),
      );
      final building = await endpoints.building.create(
        ownerSession,
        BuildingCreate(
          name: 'Stats Café',
          type: 'cafe',
          address: '3 Rue de la Kasbah',
          latitude: 36.8,
          longitude: 10.18,
          openingMinutes: 480,
          closingMinutes: 1380,
          phoneNumber: '+21671114455',
          otherLinks: const [],
          currencyCode: 'TND',
          strictModeSteps: const [],
        ),
      );
      return (
        adminSession: adminSession,
        ownerSession: ownerSession,
        building: building,
      );
    }

    test('when an owner asks then it is rejected', () async {
      final seeded = await seed();
      await expectLater(
        endpoints.platformStats.summary(seeded.ownerSession),
        throwsA(
          isA<AccountException>().having(
            (error) => error.code,
            'code',
            AccountErrorCode.notAuthorized,
          ),
        ),
      );
    });

    test('public packs start empty and count venues and owners', () async {
      final seeded = await seed();
      final before = await endpoints.platformStats.summary(seeded.adminSession);
      expect(before.ownerCount, 1);
      expect(before.customerCount, 0);
      expect(before.venueCount, 1);
      expect(before.orderCount, 0);
      expect(before.subscriptionMillimes, 0);
      expect(
        before.publicPacks.map((pack) => pack.code),
        ['counter', 'floor', 'house'],
      );
      expect(before.publicPacks.every((pack) => pack.venueCount == 0), isTrue);
      expect(before.publicPacks.every((pack) => pack.ownerCount == 0), isTrue);

      final counter = before.publicPacks.firstWhere(
        (pack) => pack.code == 'counter',
      );
      final expires = DateTime.now().toUtc().add(const Duration(days: 30));
      await endpoints.building.assignPack(
        seeded.adminSession,
        seeded.building.id,
        counter.id,
        billingPeriod: PackBillingPeriod.monthly,
        expiresAt: expires,
      );
      final second = await endpoints.building.create(
        seeded.ownerSession,
        BuildingCreate(
          name: 'Stats Bar',
          type: 'bar',
          address: '4 Rue de la Kasbah',
          latitude: 36.81,
          longitude: 10.19,
          openingMinutes: 480,
          closingMinutes: 1380,
          phoneNumber: '+21671114456',
          otherLinks: const [],
          currencyCode: 'TND',
          strictModeSteps: const [],
        ),
      );
      await endpoints.building.assignPack(
        seeded.adminSession,
        second.id,
        counter.id,
        billingPeriod: PackBillingPeriod.monthly,
        expiresAt: expires,
      );

      final after = await endpoints.platformStats.summary(seeded.adminSession);
      final used = after.publicPacks.firstWhere(
        (pack) => pack.code == 'counter',
      );
      expect(used.venueCount, 2);
      expect(used.ownerCount, 1);
      expect(after.venueCount, 2);
      expect(after.subscriptionMillimes, 39000 * 2);
      final floor = after.publicPacks.firstWhere(
        (pack) => pack.code == 'floor',
      );
      expect(floor.venueCount, 0);
    });
  });
}
