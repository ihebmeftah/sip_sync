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
            phoneNumber: '+21620000001',
            firstName: 'Guest',
            lastName: 'One',
            app: SipApp.customer,
          ),
        );

        expect(result.session.profile.email, 'guest@example.com');
        expect(result.session.profile.username, isNull);
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
        expect(ownerResult.session.profile.username, isNull);
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
              identifier: 'onlyguest@example.com',
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
      'when owner adds an employee then the employee logs in with username',
      () async {
        final owner = await endpoints.account.register(
          sessionBuilder,
          SelfRegisterCreate(
            email: 'owner@example.com',
            password: 'password1',
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

        final building = await endpoints.building.create(
          ownerSession,
          BuildingCreate(
            name: 'Owner Cafe',
            type: 'cafe',
            address: '1 Main St',
            latitude: 36.8,
            longitude: 10.18,
            openingMinutes: 480,
            closingMinutes: 1380,
            currencyCode: 'TND',
          ),
        );

        final employee = await endpoints.employee.add(
          ownerSession,
          EmployeeCreate(
            password: 'password1',
            phoneNumber: '+21620000005',
            firstName: 'Bar',
            lastName: 'Ista',
            buildingId: building.id,
          ),
        );

        expect(employee.username, startsWith('bar.ista'));
        expect(employee.username, matches(RegExp(r'^bar\.ista\d{4}$')));
        expect(employee.buildingId, building.id);

        final staffLogin = await endpoints.account.login(
          sessionBuilder,
          LoginRequest(
            identifier: employee.username,
            password: 'password1',
            app: SipApp.management,
          ),
        );

        expect(staffLogin.session.profile.roles, contains('employee'));
        expect(staffLogin.session.profile.username, employee.username);
        expect(staffLogin.session.buildingId, building.id);
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
            identifier: 'admin@sipsync.local',
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
      'when owner updates their profile then session reflects the new name',
      () async {
        final owner = await endpoints.account.register(
          sessionBuilder,
          SelfRegisterCreate(
            email: 'rename@example.com',
            password: 'password1',
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
            phoneNumber: '+21620000008',
            firstName: 'New',
            lastName: 'Owner',
          ),
        );

        expect(updated.profile.firstName, 'New');
        expect(updated.profile.email, 'rename@example.com');
        expect(updated.profile.username, isNull);
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

        final building = await endpoints.building.create(
          ownerSession,
          BuildingCreate(
            name: 'Boss Kitchen',
            type: 'restaurant',
            address: '9 Side St',
            latitude: 36.8,
            longitude: 10.18,
            openingMinutes: 480,
            closingMinutes: 1380,
            currencyCode: 'TND',
          ),
        );

        final employee = await endpoints.employee.add(
          ownerSession,
          EmployeeCreate(
            password: 'password1',
            phoneNumber: '+21620000010',
            firstName: 'Line',
            lastName: 'Cook',
            buildingId: building.id,
          ),
        );

        final viewed = await endpoints.employee.get(
          ownerSession,
          employee.authUserId,
        );

        expect(viewed.username, startsWith('line.cook'));
        expect(viewed.roles, contains('employee'));
        expect(viewed.isEnabled, isTrue);
        expect(viewed.buildingId, building.id);
      },
    );

    test(
      'when owner updates and disables an employee then login is denied',
      () async {
        final owner = await endpoints.account.register(
          sessionBuilder,
          SelfRegisterCreate(
            email: 'host@example.com',
            password: 'password1',
            phoneNumber: '+21620000011',
            firstName: 'Host',
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

        final building = await endpoints.building.create(
          ownerSession,
          BuildingCreate(
            name: 'Host Lounge',
            type: 'lounge',
            address: '11 Host Ave',
            latitude: 36.8,
            longitude: 10.18,
            openingMinutes: 480,
            closingMinutes: 1380,
            currencyCode: 'TND',
          ),
        );

        final employee = await endpoints.employee.add(
          ownerSession,
          EmployeeCreate(
            password: 'password1',
            phoneNumber: '+21620000012',
            firstName: 'Wait',
            lastName: 'Er',
            buildingId: building.id,
          ),
        );

        final renamed = await endpoints.employee.update(
          ownerSession,
          EmployeeUpdate(
            authUserId: employee.authUserId,
            phoneNumber: '+21620000012',
            firstName: 'Waiter',
            lastName: 'Two',
          ),
        );
        expect(renamed.username, employee.username);
        expect(renamed.firstName, 'Waiter');

        final listed = await endpoints.building.listEmployees(
          ownerSession,
          building.id,
        );
        expect(listed, hasLength(1));
        expect(listed.single.username, employee.username);

        final disabled = await endpoints.employee.setEnabled(
          ownerSession,
          employee.authUserId,
          false,
        );
        expect(disabled.isEnabled, isFalse);

        await expectLater(
          endpoints.account.login(
            sessionBuilder,
            LoginRequest(
              identifier: employee.username,
              password: 'password1',
              app: SipApp.management,
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
      },
    );
  });
}
