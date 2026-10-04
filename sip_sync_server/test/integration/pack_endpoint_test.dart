import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/auth/password_hasher.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:sip_sync_server/src/packs/pack_catalog.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the pack catalog', (sessionBuilder, endpoints) {
    const sessionId = '01900000-0000-7000-8000-0000000000d1';

    Future<SuperAdmin> seedAdmin(Session session) {
      return SuperAdmin.db.insertRow(
        session,
        SuperAdmin(
          email: 'packs@sipsync.dev',
          phoneNumber: '+21623000001',
          firstName: 'Pack',
          lastName: 'Admin',
          passwordHash: PasswordHasher().hash('password1'),
        ),
      );
    }

    TestSessionBuilder asAdmin(UuidValue id) {
      return sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          id.uuid,
          {Scope('sip.superAdmin')},
          authId: sessionId,
        ),
      );
    }

    TestSessionBuilder asOwner(UuidValue id) {
      return sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          id.uuid,
          {Scope('sip.owner')},
          authId: sessionId,
        ),
      );
    }

    PackCapabilities caps({
      int? maxEmployees = 2,
      int? maxTables = 8,
      int? maxCategories = 4,
      int? maxArticles = 20,
      int? maxIngredients = 15,
      bool customerOrdering = false,
      bool tableMultiOrder = false,
      bool strictMode = false,
      bool customAccessProfiles = false,
    }) {
      return PackCapabilities(
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

    test(
      'when the table is empty then the launch packs are inserted',
      () async {
        final session = sessionBuilder.build();
        await PackCatalog.ensure(session);
        await PackCatalog.ensure(session);
        final admin = await seedAdmin(session);
        final rows = (await endpoints.pack.list(asAdmin(admin.id!))).items;

        expect(rows.map((row) => row.code), [
          'free',
          'counter',
          'floor',
          'house',
          'group',
        ]);
        final free = rows.first;
        expect(free.isSystem, isTrue);
        expect(free.isPublic, isFalse);
        expect(free.monthlyMillimes, 0);
        expect(free.capabilities.maxEmployees, 2);
        final floor = rows.firstWhere((row) => row.code == 'floor');
        expect(floor.isPublic, isTrue);
        expect(floor.customerOrderFeeBps, 150);
        expect(floor.capabilities.customerOrdering, isTrue);
        final house = rows.firstWhere((row) => row.code == 'house');
        expect(house.capabilities.maxArticles, isNull);

        final public = await endpoints.pack.listPublic(asAdmin(admin.id!));
        expect(public.map((row) => row.code), ['counter', 'floor', 'house']);
      },
    );

    test('when an owner lists the admin catalog then it is rejected', () async {
      final session = sessionBuilder.build();
      final admin = await seedAdmin(session);
      final owner = UuidValue.fromString(
        '01900000-0000-7000-8000-0000000000d2',
      );
      await expectLater(
        endpoints.pack.list(asOwner(owner)),
        throwsA(
          isA<AccountException>().having(
            (error) => error.code,
            'code',
            AccountErrorCode.notAuthorized,
          ),
        ),
      );
      await expectLater(
        endpoints.pack.list(sessionBuilder),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
      expect(admin.id, isNotNull);
    });

    test(
      'when an owner creates a venue then it starts on the free pack',
      () async {
        final session = sessionBuilder.build();
        final admin = await seedAdmin(session);
        final registered = await endpoints.ownerAuth.register(
          sessionBuilder,
          EmailRegisterCreate(
            email: 'pack-owner@sipsync.dev',
            password: 'password1',
            phoneNumber: '+21623000002',
            firstName: 'Lina',
            lastName: 'Ben',
          ),
        );
        final ownerId = registered.owner!.id;
        final ownerSession = asOwner(ownerId);
        final building = await endpoints.building.create(
          ownerSession,
          BuildingCreate(
            name: 'Free Café',
            type: 'cafe',
            address: '1 Rue de la Kasbah',
            latitude: 36.8,
            longitude: 10.18,
            openingMinutes: 480,
            closingMinutes: 1380,
            phoneNumber: '+21671112233',
            otherLinks: const [],
            currencyCode: 'TND',
            strictModeSteps: const [],
          ),
        );
        final stored = await Building.db.findById(session, building.id);
        final free = await Pack.db.findFirstRow(
          session,
          where: (t) => t.code.equals(PackCatalog.freeCode),
        );
        expect(stored?.packId, free?.id);

        final authed = asAdmin(admin.id!);
        final created = await endpoints.pack.create(
          authed,
          PackCreate(
            code: 'Friends',
            name: 'Friends',
            monthlyMillimes: 0,
            customerOrderFeeBps: 0,
            isPublic: false,
            isEnabled: true,
            sortOrder: 5,
            capabilities: caps(maxEmployees: 4),
          ),
        );
        expect(created.isSystem, isFalse);
        final ownerView = await endpoints.pack.listPublic(ownerSession);
        expect(ownerView.map((row) => row.code), isNot(contains('friends')));

        final updated = await endpoints.pack.update(
          authed,
          PackUpdate(
            id: created.id,
            name: 'Friends plus',
            monthlyMillimes: 10000,
            customerOrderFeeBps: 0,
            isPublic: true,
            isEnabled: false,
            sortOrder: 5,
            capabilities: caps(maxEmployees: null, maxArticles: null),
          ),
        );
        expect(updated.name, 'Friends plus');
        expect(updated.capabilities.maxEmployees, isNull);
        expect(updated.annualMillimes, isNull);
        final stillHidden = await endpoints.pack.listPublic(ownerSession);
        expect(stillHidden.map((row) => row.code), isNot(contains('friends')));

        await Building.db.updateRow(
          session,
          stored!.copyWith(packId: created.id),
        );
        await expectLater(
          endpoints.pack.delete(authed, created.id),
          throwsA(
            isA<PackException>().having(
              (error) => error.code,
              'code',
              PackErrorCode.packInUse,
            ),
          ),
        );
      },
    );

    test('when deleting the free pack then it is rejected', () async {
      final session = sessionBuilder.build();
      await PackCatalog.ensure(session);
      final admin = await seedAdmin(session);
      final authed = asAdmin(admin.id!);
      final rows = (await endpoints.pack.list(authed)).items;
      final free = rows.firstWhere((row) => row.code == 'free');
      await expectLater(
        endpoints.pack.delete(authed, free.id),
        throwsA(
          isA<PackException>().having(
            (error) => error.code,
            'code',
            PackErrorCode.cannotDeleteSystemPack,
          ),
        ),
      );

      final counter = rows.firstWhere((row) => row.code == 'counter');
      await endpoints.pack.delete(authed, counter.id);
      final left = (await endpoints.pack.list(authed)).items;
      expect(left.map((row) => row.code), isNot(contains('counter')));
    });

    test('when the code is taken or invalid then create fails', () async {
      final session = sessionBuilder.build();
      final admin = await seedAdmin(session);
      final authed = asAdmin(admin.id!);
      final request = PackCreate(
        code: 'popup',
        name: 'Pop up',
        monthlyMillimes: 5000,
        customerOrderFeeBps: 0,
        isPublic: true,
        isEnabled: true,
        sortOrder: 1,
        capabilities: caps(),
      );
      await endpoints.pack.create(authed, request);
      await expectLater(
        endpoints.pack.create(authed, request),
        throwsA(
          isA<PackException>().having(
            (error) => error.code,
            'code',
            PackErrorCode.codeTaken,
          ),
        ),
      );
      await expectLater(
        endpoints.pack.create(
          authed,
          PackCreate(
            code: '1bad',
            name: 'Bad',
            monthlyMillimes: 0,
            customerOrderFeeBps: 0,
            isPublic: false,
            isEnabled: true,
            sortOrder: 1,
            capabilities: caps(),
          ),
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
  });
}
