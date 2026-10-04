import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/auth/password_hasher.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:sip_sync_server/src/packs/pack_term.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given a venue on the free pack', (sessionBuilder, endpoints) {
    const sessionId = '01900000-0000-7000-8000-0000000000e1';

    Future<
      ({
        SuperAdmin admin,
        dynamic adminSession,
        dynamic ownerSession,
        BuildingView building,
      })
    >
    seed() async {
      final session = sessionBuilder.build();
      final admin = await SuperAdmin.db.insertRow(
        session,
        SuperAdmin(
          email: 'building-pack@sipsync.dev',
          phoneNumber: '+21623000011',
          firstName: 'Pack',
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
          email: 'building-pack-owner@sipsync.dev',
          password: 'password1',
          phoneNumber: '+21623000012',
          firstName: 'Nour',
          lastName: 'Owner',
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          registered.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: '01900000-0000-7000-8000-0000000000e2',
        ),
      );
      final building = await endpoints.building.create(
        ownerSession,
        BuildingCreate(
          name: 'Pack Café',
          type: 'cafe',
          address: '2 Rue de la Kasbah',
          latitude: 36.8,
          longitude: 10.18,
          openingMinutes: 480,
          closingMinutes: 1380,
          phoneNumber: '+21671113344',
          otherLinks: const [],
          currencyCode: 'TND',
          strictModeSteps: const [],
        ),
      );
      return (
        admin: admin,
        adminSession: adminSession,
        ownerSession: ownerSession,
        building: building,
      );
    }

    BuildingUpdate _update(
      BuildingView building, {
      required bool tableMultiOrder,
    }) {
      return BuildingUpdate(
        id: building.id,
        name: building.name,
        type: building.type,
        address: building.address,
        latitude: building.latitude,
        longitude: building.longitude,
        openingMinutes: building.openingMinutes,
        closingMinutes: building.closingMinutes,
        currencyCode: building.currencyCode,
        phoneNumber: building.phoneNumber,
        whatsapp: building.whatsapp,
        instagram: building.instagram,
        facebook: building.facebook,
        otherLinks: building.otherLinks,
        tableMultiOrder: tableMultiOrder,
        allowAppendingItemsToOrder: building.allowAppendingItemsToOrder,
        strictMode: building.strictMode,
        strictModeSteps: building.strictModeSteps,
      );
    }

    test('admin detail shows the free pack and empty counts', () async {
      final seeded = await seed();
      final detail = await endpoints.building.adminDetail(
        seeded.adminSession,
        seeded.building.id,
      );
      expect(detail.pack.code, 'free');
      expect(detail.pack.isPublic, isFalse);
      expect(detail.categoryCount, 0);
      expect(detail.articleCount, 0);
      expect(detail.tableCount, 0);
      expect(detail.orderCount, 0);
      expect(detail.customerSales, 0);
      expect(detail.feeEarned, 0);
      expect(detail.packBillingPeriod, isNull);
      expect(detail.packExpiresAt, isNull);
      expect(detail.packHistory, hasLength(1));
      expect(detail.packHistory.single.packCode, 'free');
      expect(detail.packHistory.single.endedAt, isNull);
      expect(seeded.building.pack.code, 'free');
    });

    test('turning on multi-order is rejected on the free pack', () async {
      final seeded = await seed();
      await expectLater(
        endpoints.building.update(
          seeded.ownerSession,
          _update(seeded.building, tableMultiOrder: true),
        ),
        throwsA(
          isA<PackException>().having(
            (error) => error.code,
            'code',
            PackErrorCode.featureOff,
          ),
        ),
      );
    });

    test('a third employee is rejected on the free pack', () async {
      final seeded = await seed();
      final session = sessionBuilder.build();
      final access = await EmployeeAccess.db.findFirstRow(
        session,
        where: (t) => t.buildingId.equals(seeded.building.id),
      );
      expect(access, isNotNull);
      for (var i = 0; i < 2; i++) {
        await endpoints.employee.add(
          seeded.ownerSession,
          EmployeeCreate(
            password: 'password1',
            phoneNumber: '+2162400001$i',
            firstName: 'Staff',
            lastName: '$i',
            buildingId: seeded.building.id,
            accessId: access!.id!,
          ),
        );
      }
      await expectLater(
        endpoints.employee.add(
          seeded.ownerSession,
          EmployeeCreate(
            password: 'password1',
            phoneNumber: '+21624000013',
            firstName: 'Staff',
            lastName: 'Extra',
            buildingId: seeded.building.id,
            accessId: access!.id!,
          ),
        ),
        throwsA(
          isA<PackException>().having(
            (error) => error.code,
            'code',
            PackErrorCode.limitReached,
          ),
        ),
      );
    });

    test('assigning a private custom pack shows it on the detail', () async {
      final seeded = await seed();
      final created = await endpoints.pack.create(
        seeded.adminSession,
        PackCreate(
          code: 'popup',
          name: 'Pop-up',
          monthlyMillimes: 10000,
          customerOrderFeeBps: 200,
          isPublic: false,
          isEnabled: true,
          sortOrder: 50,
          capabilities: PackCapabilities(
            maxEmployees: 1,
            customerDiscovery: true,
            tableQr: false,
            customerOrdering: false,
            inventory: true,
            allowAppendingItems: true,
            tableMultiOrder: false,
            strictMode: false,
            customAccessProfiles: false,
          ),
        ),
      );
      expect(created.isPublic, isFalse);
      final expires = DateTime.now().toUtc().add(const Duration(days: 400));
      final detail = await endpoints.building.assignPack(
        seeded.adminSession,
        seeded.building.id,
        created.id,
        billingPeriod: PackBillingPeriod.yearly,
        expiresAt: expires,
      );
      expect(detail.pack.code, 'popup');
      expect(detail.pack.isPublic, isFalse);
      expect(detail.building.id, seeded.building.id);
      expect(detail.packBillingPeriod, PackBillingPeriod.yearly);
      expect(detail.packExpiresAt, expires);
      expect(detail.packHistory, hasLength(2));
      expect(detail.packHistory.first.packCode, 'popup');
      expect(detail.packHistory.first.endedAt, isNull);
      expect(detail.packHistory.last.packCode, 'free');
      expect(detail.packHistory.last.endReason, BuildingPackEndReason.replaced);
    });

    test('a paid pack without a term is rejected', () async {
      final seeded = await seed();
      final packs = (await endpoints.pack.list(seeded.adminSession)).items;
      final floor = packs.firstWhere((pack) => pack.code == 'floor');
      await expectLater(
        endpoints.building.assignPack(
          seeded.adminSession,
          seeded.building.id,
          floor.id,
        ),
        throwsA(
          isA<PackException>().having(
            (error) => error.code,
            'code',
            PackErrorCode.invalidInput,
          ),
        ),
      );
    });

    test('a past end date is rejected', () async {
      final seeded = await seed();
      final packs = (await endpoints.pack.list(seeded.adminSession)).items;
      final floor = packs.firstWhere((pack) => pack.code == 'floor');
      await expectLater(
        endpoints.building.assignPack(
          seeded.adminSession,
          seeded.building.id,
          floor.id,
          billingPeriod: PackBillingPeriod.monthly,
          expiresAt: DateTime.now().toUtc().subtract(const Duration(days: 1)),
        ),
        throwsA(
          isA<PackException>().having(
            (error) => error.code,
            'code',
            PackErrorCode.invalidInput,
          ),
        ),
      );
    });

    test('a monthly date before one month is rejected', () async {
      final seeded = await seed();
      final packs = (await endpoints.pack.list(seeded.adminSession)).items;
      final floor = packs.firstWhere((pack) => pack.code == 'floor');
      await expectLater(
        endpoints.building.assignPack(
          seeded.adminSession,
          seeded.building.id,
          floor.id,
          billingPeriod: PackBillingPeriod.monthly,
          expiresAt: DateTime.now().toUtc().add(const Duration(days: 20)),
        ),
        throwsA(
          isA<PackException>().having(
            (error) => error.code,
            'code',
            PackErrorCode.invalidInput,
          ),
        ),
      );
    });

    test('a yearly date before one year is rejected', () async {
      final seeded = await seed();
      final packs = (await endpoints.pack.list(seeded.adminSession)).items;
      final floor = packs.firstWhere((pack) => pack.code == 'floor');
      await expectLater(
        endpoints.building.assignPack(
          seeded.adminSession,
          seeded.building.id,
          floor.id,
          billingPeriod: PackBillingPeriod.yearly,
          expiresAt: DateTime.now().toUtc().add(const Duration(days: 40)),
        ),
        throwsA(
          isA<PackException>().having(
            (error) => error.code,
            'code',
            PackErrorCode.invalidInput,
          ),
        ),
      );
    });

    test('a daily term within 20 days stays daily', () async {
      final seeded = await seed();
      final packs = (await endpoints.pack.list(seeded.adminSession)).items;
      final floor = packs.firstWhere((pack) => pack.code == 'floor');
      final expires = DateTime.now().toUtc().add(const Duration(days: 10));
      final detail = await endpoints.building.assignPack(
        seeded.adminSession,
        seeded.building.id,
        floor.id,
        billingPeriod: PackBillingPeriod.daily,
        expiresAt: expires,
      );
      expect(detail.packBillingPeriod, PackBillingPeriod.daily);
      expect(detail.packExpiresAt, expires);
    });

    test('a daily date past 20 days starts a monthly term', () async {
      final seeded = await seed();
      final packs = (await endpoints.pack.list(seeded.adminSession)).items;
      final floor = packs.firstWhere((pack) => pack.code == 'floor');
      final before = DateTime.now().toUtc();
      final detail = await endpoints.building.assignPack(
        seeded.adminSession,
        seeded.building.id,
        floor.id,
        billingPeriod: PackBillingPeriod.daily,
        expiresAt: before.add(const Duration(days: 25)),
      );
      final minimum = packTermEnd(PackBillingPeriod.monthly, from: before);
      expect(detail.packBillingPeriod, PackBillingPeriod.monthly);
      expect(
        detail.packExpiresAt!.toUtc().difference(minimum).inSeconds.abs(),
        lessThan(30),
      );
    });

    test(
      'a daily date past one month stays on that later monthly date',
      () async {
        final seeded = await seed();
        final packs = (await endpoints.pack.list(seeded.adminSession)).items;
        final floor = packs.firstWhere((pack) => pack.code == 'floor');
        final expires = DateTime.now().toUtc().add(const Duration(days: 45));
        final detail = await endpoints.building.assignPack(
          seeded.adminSession,
          seeded.building.id,
          floor.id,
          billingPeriod: PackBillingPeriod.daily,
          expiresAt: expires,
        );
        expect(detail.packBillingPeriod, PackBillingPeriod.monthly);
        expect(detail.packExpiresAt, expires);
      },
    );

    test('a paid plan blocks another assignment', () async {
      final seeded = await seed();
      final packs = (await endpoints.pack.list(seeded.adminSession)).items;
      final floor = packs.firstWhere((pack) => pack.code == 'floor');
      final free = packs.firstWhere((pack) => pack.code == 'free');
      await endpoints.building.assignPack(
        seeded.adminSession,
        seeded.building.id,
        floor.id,
        billingPeriod: PackBillingPeriod.monthly,
        expiresAt: DateTime.now().toUtc().add(const Duration(days: 40)),
      );
      await expectLater(
        endpoints.building.assignPack(
          seeded.adminSession,
          seeded.building.id,
          free.id,
        ),
        throwsA(
          isA<PackException>().having(
            (error) => error.code,
            'code',
            PackErrorCode.paidPlanActive,
          ),
        ),
      );
    });

    test('a venue returns to free after the end date', () async {
      final seeded = await seed();
      final packs = (await endpoints.pack.list(seeded.adminSession)).items;
      final floor = packs.firstWhere((pack) => pack.code == 'floor');
      await endpoints.building.assignPack(
        seeded.adminSession,
        seeded.building.id,
        floor.id,
        billingPeriod: PackBillingPeriod.monthly,
        expiresAt: DateTime.now().toUtc().add(const Duration(days: 40)),
      );
      final session = sessionBuilder.build();
      final row = await Building.db.findById(session, seeded.building.id);
      await Building.db.updateRow(
        session,
        row!.copyWith(
          packExpiresAt: DateTime.now().toUtc().subtract(
            const Duration(minutes: 1),
          ),
        ),
      );
      final view = await endpoints.building.get(
        seeded.ownerSession,
        seeded.building.id,
      );
      expect(view.pack.code, 'free');
      final detail = await endpoints.building.adminDetail(
        seeded.adminSession,
        seeded.building.id,
      );
      expect(detail.pack.code, 'free');
      expect(detail.packBillingPeriod, isNull);
      expect(detail.packExpiresAt, isNull);
      expect(detail.packHistory.first.packCode, 'free');
      expect(detail.packHistory.first.endedAt, isNull);
      expect(
        detail.packHistory.any(
          (row) =>
              row.packCode == 'floor' &&
              row.endReason == BuildingPackEndReason.expired,
        ),
        isTrue,
      );
    });
  });
}
