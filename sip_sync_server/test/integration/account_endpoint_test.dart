import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:sip_sync_server/src/packs/pack_catalog.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given custom auth', (sessionBuilder, endpoints) {
    test('owner registers and logs in with email', () async {
      final registered = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'owner@example.com',
          password: 'password1',
          phoneNumber: '+21620000001',
          firstName: 'Cafe',
          lastName: 'Owner',
        ),
      );
      expect(registered.actorType, ActorType.owner);
      expect(registered.owner?.email, 'owner@example.com');
      expect(registered.token, isNotEmpty);

      final login = await endpoints.ownerAuth.login(
        sessionBuilder,
        EmailLoginRequest(email: 'owner@example.com', password: 'password1'),
      );
      expect(login.owner?.id, registered.owner?.id);
    });

    test(
      'customer registers separately from owner with same email allowed',
      () async {
        await endpoints.ownerAuth.register(
          sessionBuilder,
          EmailRegisterCreate(
            email: 'both@example.com',
            password: 'password1',
            phoneNumber: '+21620000002',
            firstName: 'Own',
            lastName: 'Er',
          ),
        );
        final customer = await endpoints.customerAuth.register(
          sessionBuilder,
          EmailRegisterCreate(
            email: 'both@example.com',
            password: 'password1',
            phoneNumber: '+21620000003',
            firstName: 'Cust',
            lastName: 'Omer',
          ),
        );
        expect(customer.actorType, ActorType.customer);
        expect(customer.customer?.email, 'both@example.com');
      },
    );

    test(
      'owner creates building then employee can login and list that building',
      () async {
        final ownerAuth = await endpoints.ownerAuth.register(
          sessionBuilder,
          EmailRegisterCreate(
            email: 'venue@example.com',
            password: 'password1',
            phoneNumber: '+21620000004',
            firstName: 'Venue',
            lastName: 'Owner',
          ),
        );
        final ownerSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            ownerAuth.owner!.id.uuid,
            {Scope('sip.owner')},
            authId: 'test-session-owner',
          ),
        );

        final building = await endpoints.building.create(
          ownerSession,
          BuildingCreate(
            name: 'Maison',
            type: 'cafe',
            address: '12 Rue Habib',
            latitude: 36.8,
            longitude: 10.18,
            openingMinutes: 480,
            closingMinutes: 1380,
            phoneNumber: '+21671100001',
            otherLinks: const [],
            currencyCode: 'TND',
            strictModeSteps: [],
          ),
        );
        expect(building.ownerId, ownerAuth.owner!.id);
        expect(building.employeeIds, isEmpty);
        await PackCatalog.assignCode(
          sessionBuilder.build(),
          building.id,
          'floor',
        );

        final access = await endpoints.employeeAccess.create(
          ownerSession,
          EmployeeAccessCreate(
            buildingId: building.id,
            name: 'Floor',
            orderCreation: true,
            orderPayment: true,
            cancelOrder: true,
            preparation: true,
            serving: true,
            consultAllOrders: true,
          ),
        );

        final employee = await endpoints.employee.add(
          ownerSession,
          EmployeeCreate(
            password: 'password1',
            phoneNumber: '+21620000005',
            firstName: 'Floor',
            lastName: 'Staff',
            buildingId: building.id,
            accessId: access.id,
          ),
        );
        expect(employee.buildingId, building.id);
        expect(employee.accessId, access.id);
        expect(employee.username, startsWith('floor.staff'));

        final staffLogin = await endpoints.employeeAuth.login(
          sessionBuilder,
          UsernameLoginRequest(
            username: employee.username,
            password: 'password1',
          ),
        );
        expect(staffLogin.employee?.buildingId, building.id);

        final staffSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            staffLogin.employee!.id.uuid,
            {Scope('sip.employee')},
            authId: 'test-session-employee',
          ),
        );
        final listed = await endpoints.building.listMine(staffSession);
        expect(listed.single.id, building.id);
      },
    );

    test('disabled employee cannot login', () async {
      final ownerAuth = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'boss@example.com',
          password: 'password1',
          phoneNumber: '+21620000006',
          firstName: 'Boss',
          lastName: 'Owner',
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          ownerAuth.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: 'test-session-boss',
        ),
      );
      final building = await endpoints.building.create(
        ownerSession,
        BuildingCreate(
          name: 'Bar',
          type: 'bar',
          address: '1 Medina',
          latitude: 36.8,
          longitude: 10.18,
          openingMinutes: 480,
          closingMinutes: 100,
          phoneNumber: '+21671100001',
          otherLinks: const [],
          currencyCode: 'TND',
          strictModeSteps: [],
        ),
      );
      await PackCatalog.assignCode(
        sessionBuilder.build(),
        building.id,
        'floor',
      );
      final access = await endpoints.employeeAccess.create(
        ownerSession,
        EmployeeAccessCreate(
          buildingId: building.id,
          name: 'Host',
          orderCreation: true,
          orderPayment: false,
          cancelOrder: false,
          preparation: false,
          serving: true,
          consultAllOrders: false,
        ),
      );
      final employee = await endpoints.employee.add(
        ownerSession,
        EmployeeCreate(
          password: 'password1',
          phoneNumber: '+21620000007',
          firstName: 'Wait',
          lastName: 'Er',
          buildingId: building.id,
          accessId: access.id,
        ),
      );
      await endpoints.employee.setEnabled(ownerSession, employee.id, false);

      await expectLater(
        endpoints.employeeAuth.login(
          sessionBuilder,
          UsernameLoginRequest(
            username: employee.username,
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
    });

    test('invalid building currency fails', () async {
      final ownerAuth = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'badmoney@example.com',
          password: 'password1',
          phoneNumber: '+21620000008',
          firstName: 'Bad',
          lastName: 'Money',
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          ownerAuth.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: 'test-session-money',
        ),
      );
      await expectLater(
        endpoints.building.create(
          ownerSession,
          BuildingCreate(
            name: 'Bad',
            type: 'lounge',
            address: 'Somewhere',
            latitude: 0,
            longitude: 0,
            openingMinutes: 0,
            closingMinutes: 60,
            phoneNumber: '+21671100001',
            otherLinks: const [],
            currencyCode: 'DINA',
            strictModeSteps: [],
          ),
        ),
        throwsA(
          isA<BuildingException>().having(
            (e) => e.code,
            'code',
            BuildingErrorCode.invalidInput,
          ),
        ),
      );
    });

    test('owner can change password then login with new one', () async {
      final registered = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'changepw@example.com',
          password: 'password1',
          phoneNumber: '+21620000009',
          firstName: 'Change',
          lastName: 'Pw',
        ),
      );
      final authed = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          registered.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: '11111111-1111-1111-1111-111111111111',
        ),
      );
      await endpoints.ownerAuth.changePassword(
        authed,
        ChangePasswordRequest(
          currentPassword: 'password1',
          newPassword: 'password2x',
        ),
      );
      await expectLater(
        endpoints.ownerAuth.login(
          sessionBuilder,
          EmailLoginRequest(
            email: 'changepw@example.com',
            password: 'password1',
          ),
        ),
        throwsA(
          isA<AccountException>().having(
            (e) => e.code,
            'code',
            AccountErrorCode.invalidCredentials,
          ),
        ),
      );
      final login = await endpoints.ownerAuth.login(
        sessionBuilder,
        EmailLoginRequest(
          email: 'changepw@example.com',
          password: 'password2x',
        ),
      );
      expect(login.owner?.id, registered.owner?.id);
    });

    test('owner password reset with debug OTP', () async {
      await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'resetme@example.com',
          password: 'password1',
          phoneNumber: '+21620000010',
          firstName: 'Reset',
          lastName: 'Me',
        ),
      );
      final requested = await endpoints.ownerAuth.requestPasswordReset(
        sessionBuilder,
        PasswordResetRequest(email: 'resetme@example.com'),
      );
      expect(requested.debugCode, isNotNull);
      await endpoints.ownerAuth.confirmPasswordReset(
        sessionBuilder,
        PasswordResetConfirm(
          email: 'resetme@example.com',
          code: requested.debugCode!,
          newPassword: 'password9x',
        ),
      );
      final login = await endpoints.ownerAuth.login(
        sessionBuilder,
        EmailLoginRequest(
          email: 'resetme@example.com',
          password: 'password9x',
        ),
      );
      expect(login.owner?.email, 'resetme@example.com');
    });
  });
}
