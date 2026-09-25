import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given venue tables', (sessionBuilder, endpoints) {
    Future<({dynamic ownerSession, BuildingView building})>
    ownerWithBuilding() async {
      final auth = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'tables-owner@example.com',
          password: 'password1',
          phoneNumber: '+21621110001',
          firstName: 'Table',
          lastName: 'Owner',
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          auth.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: UuidValue.fromString(
            '00000000-0000-7000-8000-000000000001',
          ).uuid,
        ),
      );
      final building = await endpoints.building.create(
        ownerSession,
        BuildingCreate(
          name: 'Floor House',
          type: 'cafe',
          address: '1 Main St',
          latitude: 36.8,
          longitude: 10.1,
          openingMinutes: 480,
          closingMinutes: 1380,
          currencyCode: 'TND',
          strictModeSteps: [],
        ),
      );
      return (ownerSession: ownerSession, building: building);
    }

    test(
      'owner creates sequential tables with computed available status',
      () async {
        final setup = await ownerWithBuilding();
        final created = await endpoints.venueTable.create(
          setup.ownerSession,
          VenueTableCreate(
            buildingId: setup.building.id,
            count: 3,
            maxSeats: 4,
            isActive: true,
          ),
        );
        expect(created, hasLength(3));
        expect(created.map((t) => t.number).toList(), [1, 2, 3]);
        expect(created.first.maxSeats, 4);
        expect(created.first.isActive, isTrue);
        expect(created.first.status, TableFloorStatus.available);

        final more = await endpoints.venueTable.create(
          setup.ownerSession,
          VenueTableCreate(
            buildingId: setup.building.id,
            count: 2,
            maxSeats: 6,
            isActive: true,
          ),
        );
        expect(more.map((t) => t.number).toList(), [4, 5]);

        final list = await endpoints.venueTable.list(
          setup.ownerSession,
          setup.building.id,
          TableListFilter.all,
        );
        expect(list, hasLength(5));
      },
    );

    test('owner can update seats and active but number stays fixed', () async {
      final setup = await ownerWithBuilding();
      final created = await endpoints.venueTable.create(
        setup.ownerSession,
        VenueTableCreate(
          buildingId: setup.building.id,
          count: 1,
          maxSeats: 8,
          isActive: true,
        ),
      );
      final updated = await endpoints.venueTable.update(
        setup.ownerSession,
        VenueTableUpdate(
          id: created.first.id,
          maxSeats: 10,
          isActive: false,
        ),
      );
      expect(updated.number, 1);
      expect(updated.maxSeats, 10);
      expect(updated.isActive, isFalse);
      expect(updated.status, TableFloorStatus.available);
    });
  });
}
