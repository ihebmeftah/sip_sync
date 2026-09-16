import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/auth/account_service.dart';
import 'package:sip_sync_server/src/auth/auth_bootstrap.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Account endpoint', (sessionBuilder, endpoints) {
    setUp(() {
      configureSipSyncAuth();
    });

    test(
      'when registering as customer then session includes customer role',
      () async {
        final result = await endpoints.account.register(
          sessionBuilder,
          SelfRegisterCreate(
            email: 'guest@example.com',
            password: 'password1',
            username: 'guestuser',
            phoneNumber: '+21620000001',
            firstName: 'Guest',
            lastName: 'One',
            app: SipApp.customer,
          ),
        );

        expect(result.session.profile.email, 'guest@example.com');
        expect(result.session.profile.roles, contains('customer'));
        expect(result.authSuccess.token, isNotEmpty);
      },
    );

    test(
      'when the same email registers as owner then both roles are present',
      () async {
        await endpoints.account.register(
          sessionBuilder,
          SelfRegisterCreate(
            email: 'both@example.com',
            password: 'password1',
            username: 'bothuser',
            phoneNumber: '+21620000002',
            firstName: 'Both',
            lastName: 'Roles',
            app: SipApp.customer,
          ),
        );

        final ownerResult = await endpoints.account.register(
          sessionBuilder,
          SelfRegisterCreate(
            email: 'both@example.com',
            password: 'password1',
            username: 'ignoredname',
            phoneNumber: '+21620000099',
            firstName: 'Ignored',
            lastName: 'Name',
            app: SipApp.management,
          ),
        );

        expect(
          ownerResult.session.profile.roles,
          containsAll(['customer', 'owner']),
        );
        expect(ownerResult.session.profile.username, 'bothuser');
      },
    );

    test(
      'when a customer logs into management then access is denied',
      () async {
        await endpoints.account.register(
          sessionBuilder,
          SelfRegisterCreate(
            email: 'onlyguest@example.com',
            password: 'password1',
            username: 'onlyguest',
            phoneNumber: '+21620000003',
            firstName: 'Only',
            lastName: 'Guest',
            app: SipApp.customer,
          ),
        );

        await expectLater(
          endpoints.account.login(
            sessionBuilder,
            LoginRequest(
              email: 'onlyguest@example.com',
              password: 'password1',
              app: SipApp.management,
            ),
          ),
          throwsA(
            isA<AccountException>().having(
              (e) => e.code,
              'code',
              AccountErrorCode.appAccessDenied,
            ),
          ),
        );
      },
    );

    test(
      'when owner adds an employee then the employee can log into management',
      () async {
        final owner = await endpoints.account.register(
          sessionBuilder,
          SelfRegisterCreate(
            email: 'owner@example.com',
            password: 'password1',
            username: 'cafeowner',
            phoneNumber: '+21620000004',
            firstName: 'Cafe',
            lastName: 'Owner',
            app: SipApp.management,
          ),
        );

        final ownerSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            owner.authSuccess.authUserId.uuid,
            {Scope('sip.owner')},
          ),
        );

        await endpoints.account.addEmployee(
          ownerSession,
          EmployeeCreate(
            email: 'staff@example.com',
            password: 'password1',
            username: 'barista',
            phoneNumber: '+21620000005',
            firstName: 'Bar',
            lastName: 'Ista',
          ),
        );

        final staffLogin = await endpoints.account.login(
          sessionBuilder,
          LoginRequest(
            email: 'staff@example.com',
            password: 'password1',
            app: SipApp.management,
          ),
        );

        expect(staffLogin.session.profile.roles, contains('employee'));
      },
    );

    test(
      'when default admin is seeded then it cannot be deleted',
      () async {
        final session = sessionBuilder.build();
        await AccountService().ensureDefaultAdmin(session);

        final adminLogin = await endpoints.account.login(
          sessionBuilder,
          LoginRequest(
            email: 'admin@sipsync.local',
            password: 'SipSyncAdmin8!',
            app: SipApp.backoffice,
          ),
        );

        expect(adminLogin.session.isSystemDefaultAdmin, isTrue);
        expect(adminLogin.session.isBackofficeAdmin, isTrue);

        final adminSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            adminLogin.authSuccess.authUserId.uuid,
            {Scope('sip.backoffice'), Scope('sip.backoffice.admin')},
          ),
        );

        await expectLater(
          endpoints.account.deleteBackofficeUser(
            adminSession,
            adminLogin.authSuccess.authUserId,
          ),
          throwsA(
            isA<AccountException>().having(
              (e) => e.code,
              'code',
              AccountErrorCode.cannotDeleteDefaultAdmin,
            ),
          ),
        );
      },
    );

    test(
      'when username is reused then registration fails',
      () async {
        await endpoints.account.register(
          sessionBuilder,
          SelfRegisterCreate(
            email: 'first@example.com',
            password: 'password1',
            username: 'takenname',
            phoneNumber: '+21620000006',
            firstName: 'First',
            lastName: 'User',
            app: SipApp.customer,
          ),
        );

        await expectLater(
          endpoints.account.register(
            sessionBuilder,
            SelfRegisterCreate(
              email: 'second@example.com',
              password: 'password1',
              username: 'takenname',
              phoneNumber: '+21620000007',
              firstName: 'Second',
              lastName: 'User',
              app: SipApp.customer,
            ),
          ),
          throwsA(
            isA<AccountException>().having(
              (e) => e.code,
              'code',
              AccountErrorCode.usernameTaken,
            ),
          ),
        );
      },
    );

    test(
      'when owner updates their profile then session reflects the new name',
      () async {
        final owner = await endpoints.account.register(
          sessionBuilder,
          SelfRegisterCreate(
            email: 'rename@example.com',
            password: 'password1',
            username: 'oldowner',
            phoneNumber: '+21620000008',
            firstName: 'Old',
            lastName: 'Name',
            app: SipApp.management,
          ),
        );

        final ownerSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            owner.authSuccess.authUserId.uuid,
            {Scope('sip.owner')},
          ),
        );

        final updated = await endpoints.account.updateMyProfile(
          ownerSession,
          ProfileUpdate(
            username: 'newowner',
            phoneNumber: '+21620000008',
            firstName: 'New',
            lastName: 'Owner',
          ),
        );

        expect(updated.profile.username, 'newowner');
        expect(updated.profile.firstName, 'New');
        expect(updated.profile.email, 'rename@example.com');
      },
    );

    test(
      'when owner reads an added employee then the profile is returned',
      () async {
        final owner = await endpoints.account.register(
          sessionBuilder,
          SelfRegisterCreate(
            email: 'boss@example.com',
            password: 'password1',
            username: 'theboss',
            phoneNumber: '+21620000009',
            firstName: 'The',
            lastName: 'Boss',
            app: SipApp.management,
          ),
        );

        final ownerSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            owner.authSuccess.authUserId.uuid,
            {Scope('sip.owner')},
          ),
        );

        final employee = await endpoints.account.addEmployee(
          ownerSession,
          EmployeeCreate(
            email: 'cook@example.com',
            password: 'password1',
            username: 'linecook',
            phoneNumber: '+21620000010',
            firstName: 'Line',
            lastName: 'Cook',
          ),
        );

        final viewed = await endpoints.account.getEmployee(
          ownerSession,
          employee.authUserId,
        );

        expect(viewed.email, 'cook@example.com');
        expect(viewed.roles, contains('employee'));
      },
    );
  });
}
