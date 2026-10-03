import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the platform directory', (sessionBuilder, endpoints) {
    const adminSessionId = '01900000-0000-7000-8000-0000000000c1';

    Future<AuthTokenResult> registerOwner() {
      return endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'dir-owner@sipsync.dev',
          password: 'password1',
          phoneNumber: '+21622000011',
          firstName: 'Nora',
          lastName: 'Owner',
        ),
      );
    }

    Future<AuthTokenResult> registerCustomer() {
      return endpoints.customerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'dir-guest@sipsync.dev',
          password: 'password1',
          phoneNumber: '+21622000012',
          firstName: 'Sam',
          lastName: 'Guest',
        ),
      );
    }

    test(
      'when a super admin lists people then each row has contact and createdAt',
      () async {
        final ownerAuth = await registerOwner();
        final customerAuth = await registerCustomer();
        final session = sessionBuilder.build();
        final admin = await SuperAdmin.db.insertRow(
          session,
          SuperAdmin(
            email: 'dir-admin@sipsync.dev',
            phoneNumber: '+21622000013',
            firstName: 'Ada',
            lastName: 'Admin',
            passwordHash: 'hash',
          ),
        );
        final authed = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            admin.id!.uuid,
            {Scope('sip.superAdmin')},
            authId: adminSessionId,
          ),
        );

        final owners = await endpoints.platformDirectory.listOwners(authed);
        final customers = await endpoints.platformDirectory.listCustomers(
          authed,
        );

        expect(owners, hasLength(1));
        expect(owners.single.id, ownerAuth.owner!.id);
        expect(owners.single.email, 'dir-owner@sipsync.dev');
        expect(owners.single.phoneNumber, '+21622000011');
        expect(owners.single.firstName, 'Nora');
        expect(owners.single.createdAt, isA<DateTime>());

        expect(customers, hasLength(1));
        expect(customers.single.id, customerAuth.customer!.id);
        expect(customers.single.email, 'dir-guest@sipsync.dev');
        expect(customers.single.lastName, 'Guest');
        expect(customers.single.createdAt, isA<DateTime>());
      },
    );

    test('when an owner lists the directory then it is rejected', () async {
      final ownerAuth = await registerOwner();
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          ownerAuth.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: '01900000-0000-7000-8000-0000000000c2',
        ),
      );

      await expectLater(
        endpoints.platformDirectory.listOwners(ownerSession),
        throwsA(
          isA<AccountException>().having(
            (error) => error.code,
            'code',
            AccountErrorCode.notAuthorized,
          ),
        ),
      );
      await expectLater(
        endpoints.platformDirectory.listCustomers(ownerSession),
        throwsA(
          isA<AccountException>().having(
            (error) => error.code,
            'code',
            AccountErrorCode.notAuthorized,
          ),
        ),
      );
    });
  });
}
