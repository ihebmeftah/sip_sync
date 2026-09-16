import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/auth/auth_bootstrap.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Building endpoint', (sessionBuilder, endpoints) {
    setUp(() {
      configureSipSyncAuth();
    });

    Future<dynamic> ownerScoped() async {
      final owner = await endpoints.account.register(
        sessionBuilder,
        SelfRegisterCreate(
          email: 'venueowner@example.com',
          password: 'password1',
          phoneNumber: '+21620000100',
          firstName: 'Venue',
          lastName: 'Owner',
          app: SipApp.management,
        ),
      );
      return sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          owner.authSuccess.authUserId.uuid,
          {Scope('sip.owner')},
        ),
      );
    }

    test('when owner has no venues then list is empty', () async {
      final scoped = await ownerScoped();
      final listed = await endpoints.building.listMine(scoped);
      expect(listed, isEmpty);
    });

    test(
      'when owner creates a cafe then it is listed and custom type is stored',
      () async {
        final scoped = await ownerScoped();
        final created = await endpoints.building.create(
          scoped,
          BuildingCreate(
            name: 'Maison Verte',
            type: 'Cafe',
            address: '12 Rue Habib, Tunis',
            latitude: 36.8065,
            longitude: 10.1815,
            openingMinutes: 8 * 60,
            closingMinutes: 23 * 60,
            currencyCode: 'tnd',
            employeeAuthUserIds: [],
          ),
        );

        expect(created.name, 'Maison Verte');
        expect(created.type, 'cafe');
        expect(created.currencyCode, 'TND');
        expect(created.openingMinutes, 480);

        final custom = await endpoints.building.create(
          scoped,
          BuildingCreate(
            name: 'Rooftop',
            type: 'tea house',
            address: '1 Corniche, Sousse',
            latitude: 35.8254,
            longitude: 10.641,
            openingMinutes: 10 * 60,
            closingMinutes: 2 * 60,
            currencyCode: 'EUR',
            employeeAuthUserIds: [],
          ),
        );
        expect(custom.type, 'tea house');

        final listed = await endpoints.building.listMine(scoped);
        expect(listed, hasLength(2));
      },
    );

    test(
      'when owner assigns an employee then the building lists that staff',
      () async {
        final scoped = await ownerScoped();
        final employee = await endpoints.account.addEmployee(
          scoped,
          EmployeeCreate(
            password: 'password1',
            phoneNumber: '+21620000101',
            firstName: 'Floor',
            lastName: 'Staff',
          ),
        );

        final created = await endpoints.building.create(
          scoped,
          BuildingCreate(
            name: 'Bar Central',
            type: 'bar',
            address: '3 Medina, Tunis',
            latitude: 36.8,
            longitude: 10.18,
            openingMinutes: 18 * 60,
            closingMinutes: 2 * 60,
            currencyCode: 'TND',
            employeeAuthUserIds: [employee.authUserId],
          ),
        );

        expect(created.employeeAuthUserIds, contains(employee.authUserId));
        final staff = await endpoints.building.listEmployees(
          scoped,
          created.id,
        );
        expect(staff.single.username, startsWith('floor.staff'));

        final staffLogin = await endpoints.account.login(
          sessionBuilder,
          LoginRequest(
            identifier: employee.username,
            password: 'password1',
            app: SipApp.management,
          ),
        );
        final staffSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            staffLogin.authSuccess.authUserId.uuid,
            {Scope('sip.employee')},
          ),
        );
        final visible = await endpoints.building.listMine(staffSession);
        expect(visible.single.id, created.id);
      },
    );

    test('when currency is invalid then create fails', () async {
      final scoped = await ownerScoped();
      await expectLater(
        endpoints.building.create(
          scoped,
          BuildingCreate(
            name: 'Bad Money',
            type: 'lounge',
            address: 'Somewhere',
            latitude: 0,
            longitude: 0,
            openingMinutes: 0,
            closingMinutes: 60,
            currencyCode: 'DINA',
            employeeAuthUserIds: [],
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
  });
}
