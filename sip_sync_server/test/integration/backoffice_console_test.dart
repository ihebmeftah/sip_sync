import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/auth/password_hasher.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the backoffice console', (sessionBuilder, endpoints) {
    const sessionId = '01900000-0000-7000-8000-0000000000aa';

    Future<SuperAdmin> seedAdmin(
      Session session, {
      required String email,
      required String phone,
      required bool isSystemDefault,
    }) {
      return SuperAdmin.db.insertRow(
        session,
        SuperAdmin(
          email: email,
          phoneNumber: phone,
          firstName: 'Ada',
          lastName: 'Admin',
          passwordHash: PasswordHasher().hash('password1'),
          isSystemDefault: isSystemDefault,
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

    test(
      'when an admin updates and disables a user then login stops',
      () async {
        final session = sessionBuilder.build();
        final actor = await seedAdmin(
          session,
          email: 'lead@sipsync.dev',
          phone: '+21621000001',
          isSystemDefault: false,
        );
        final target = await seedAdmin(
          session,
          email: 'staff@sipsync.dev',
          phone: '+21621000002',
          isSystemDefault: false,
        );
        final authed = asAdmin(actor.id!);

        final updated = await endpoints.superAdminAuth.update(
          authed,
          SuperAdminUpdate(
            id: target.id!,
            email: 'staff@sipsync.dev',
            phoneNumber: '+21621000002',
            firstName: 'Floor',
            lastName: 'Lead',
            isEnabled: true,
          ),
        );
        expect(updated.firstName, 'Floor');
        expect(updated.isEnabled, isTrue);

        final disabled = await endpoints.superAdminAuth.setEnabled(
          authed,
          target.id!,
          false,
        );
        expect(disabled.isEnabled, isFalse);

        await expectLater(
          endpoints.superAdminAuth.login(
            sessionBuilder,
            EmailLoginRequest(
              email: 'staff@sipsync.dev',
              password: 'password1',
            ),
          ),
          throwsA(
            isA<AccountException>().having(
              (e) => e.code,
              'code',
              AccountErrorCode.accountDisabled,
            ),
          ),
        );

        final enabled = await endpoints.superAdminAuth.setEnabled(
          authed,
          target.id!,
          true,
        );
        expect(enabled.isEnabled, isTrue);
        final login = await endpoints.superAdminAuth.login(
          sessionBuilder,
          EmailLoginRequest(email: 'staff@sipsync.dev', password: 'password1'),
        );
        expect(login.superAdmin?.id, target.id);
      },
    );

    test(
      'when disabling self or the default admin then it is rejected',
      () async {
        final session = sessionBuilder.build();
        final actor = await seedAdmin(
          session,
          email: 'self@sipsync.dev',
          phone: '+21621000003',
          isSystemDefault: false,
        );
        final fallback = await seedAdmin(
          session,
          email: 'root@sipsync.dev',
          phone: '+21621000004',
          isSystemDefault: true,
        );
        final authed = asAdmin(actor.id!);

        await expectLater(
          endpoints.superAdminAuth.setEnabled(authed, actor.id!, false),
          throwsA(
            isA<AccountException>().having(
              (e) => e.code,
              'code',
              AccountErrorCode.cannotDisableSelf,
            ),
          ),
        );
        await expectLater(
          endpoints.superAdminAuth.setEnabled(authed, fallback.id!, false),
          throwsA(
            isA<AccountException>().having(
              (e) => e.code,
              'code',
              AccountErrorCode.cannotDisableDefaultAdmin,
            ),
          ),
        );
      },
    );

    test(
      'when a super admin lists buildings then owner and contact are included',
      () async {
        final ownerAuth = await endpoints.ownerAuth.register(
          sessionBuilder,
          EmailRegisterCreate(
            email: 'venue-admin@example.com',
            password: 'password1',
            phoneNumber: '+21621000005',
            firstName: 'Venue',
            lastName: 'Owner',
          ),
        );
        final ownerSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            ownerAuth.owner!.id.uuid,
            {Scope('sip.owner')},
            authId: '01900000-0000-7000-8000-0000000000bb',
          ),
        );
        await endpoints.building.create(
          ownerSession,
          BuildingCreate(
            name: 'Olive Café',
            type: 'cafe',
            address: '12 Rue Habib',
            latitude: 36.8,
            longitude: 10.18,
            openingMinutes: 480,
            closingMinutes: 1380,
            phoneNumber: '+21671100021',
            otherLinks: const [],
            currencyCode: 'TND',
            strictModeSteps: [],
          ),
        );

        await expectLater(
          endpoints.building.listAll(ownerSession),
          throwsA(
            isA<AccountException>().having(
              (e) => e.code,
              'code',
              AccountErrorCode.notAuthorized,
            ),
          ),
        );

        final session = sessionBuilder.build();
        final actor = await seedAdmin(
          session,
          email: 'lister@sipsync.dev',
          phone: '+21621000006',
          isSystemDefault: false,
        );
        final rows = (await endpoints.building.listAll(
          asAdmin(actor.id!),
        )).items;
        expect(rows, hasLength(1));
        expect(rows.single.name, 'Olive Café');
        expect(rows.single.type, 'cafe');
        expect(rows.single.countryCode, 'TN');
        expect(rows.single.currencyCode, 'TND');
        expect(rows.single.phoneNumber, '+21671100021');
        expect(rows.single.address, '12 Rue Habib');
        expect(rows.single.ownerFirstName, 'Venue');
        expect(rows.single.ownerEmail, 'venue-admin@example.com');
        expect(rows.single.ownerPhoneNumber, '+21621000005');
      },
    );
  });
}
