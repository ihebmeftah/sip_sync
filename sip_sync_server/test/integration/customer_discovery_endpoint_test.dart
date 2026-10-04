import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given customer discovery', (sessionBuilder, endpoints) {
    test('customer receives public venue cards without ops fields', () async {
      final ownerAuth = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'discover-owner@example.com',
          password: 'password1',
          phoneNumber: '+21621100001',
          firstName: 'Disc',
          lastName: 'Owner',
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          ownerAuth.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: 'test-session-discover-owner',
        ),
      );
      await endpoints.building.create(
        ownerSession,
        BuildingCreate(
          name: 'Olive Café',
          type: 'cafe',
          address: '12 Rue Habib',
          latitude: 36.8065,
          longitude: 10.1815,
          openingMinutes: 480,
          closingMinutes: 1380,
          phoneNumber: '+21671110001',
          otherLinks: const [],
          currencyCode: 'TND',
          strictModeSteps: [],
        ),
      );

      final customer = await endpoints.customerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'discover-guest@example.com',
          password: 'password1',
          phoneNumber: '+21621100002',
          firstName: 'Guest',
          lastName: 'One',
        ),
      );
      final customerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          customer.customer!.id.uuid,
          {Scope('sip.customer')},
          authId: 'test-session-discover-customer',
        ),
      );

      final cards = (await endpoints.customerVenue.list(
        customerSession,
        nearbyOnly: false,
      )).items;
      expect(cards, isNotEmpty);
      final olive = cards.singleWhere((card) => card.name == 'Olive Café');
      expect(olive.type, 'cafe');
      expect(olive.address, '12 Rue Habib');
      expect(olive.latitude, 36.8065);
      expect(olive.longitude, 10.1815);
      expect(olive.openingMinutes, 480);
      expect(olive.closingMinutes, 1380);
      expect(olive.phoneNumber, '+21671110001');
      expect(olive.id.uuid, isNotEmpty);
    });

    test('a place still returns venues ordered from that point', () async {
      final ownerAuth = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'discover-owner-near@example.com',
          password: 'password1',
          phoneNumber: '+21621100011',
          firstName: 'Near',
          lastName: 'Owner',
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          ownerAuth.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: 'test-session-discover-owner-near',
        ),
      );
      await endpoints.building.create(
        ownerSession,
        BuildingCreate(
          name: 'Near Café',
          type: 'cafe',
          address: '1 Avenue Habib',
          latitude: 36.8,
          longitude: 10.18,
          openingMinutes: 480,
          closingMinutes: 1380,
          phoneNumber: '+21671110011',
          otherLinks: const [],
          currencyCode: 'TND',
          strictModeSteps: [],
        ),
      );
      final customer = await endpoints.customerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'discover-guest-near@example.com',
          password: 'password1',
          phoneNumber: '+21621100012',
          firstName: 'Near',
          lastName: 'Guest',
        ),
      );
      final customerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          customer.customer!.id.uuid,
          {Scope('sip.customer')},
          authId: 'test-session-discover-customer-near',
        ),
      );

      final page = await endpoints.customerVenue.list(
        customerSession,
        latitude: 36.8,
        longitude: 10.18,
        nearbyOnly: true,
      );
      expect(page.items.map((card) => card.name), contains('Near Café'));
      expect(page.total, greaterThan(0));
    });

    test('owner token is rejected from the customer venue list', () async {
      final ownerAuth = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'discover-owner2@example.com',
          password: 'password1',
          phoneNumber: '+21621100003',
          firstName: 'Disc',
          lastName: 'Two',
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          ownerAuth.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: 'test-session-discover-owner-2',
        ),
      );

      await expectLater(
        endpoints.customerVenue.list(ownerSession, nearbyOnly: false),
        throwsA(
          isA<AccountException>().having(
            (error) => error.code,
            'code',
            AccountErrorCode.notAuthorized,
          ),
        ),
      );
    });

    test('short address query is rejected before lookup', () async {
      final customer = await endpoints.customerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'discover-guest2@example.com',
          password: 'password1',
          phoneNumber: '+21621100004',
          firstName: 'Guest',
          lastName: 'Two',
        ),
      );
      final customerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          customer.customer!.id.uuid,
          {Scope('sip.customer')},
          authId: 'test-session-discover-customer-2',
        ),
      );

      await expectLater(
        endpoints.customerPlace.search(customerSession, 'ab'),
        throwsA(
          isA<PlaceException>().having(
            (error) => error.code,
            'code',
            PlaceErrorCode.invalidInput,
          ),
        ),
      );
      await expectLater(
        endpoints.customerPlace.reverse(customerSession, 120, 10),
        throwsA(
          isA<PlaceException>().having(
            (error) => error.code,
            'code',
            PlaceErrorCode.invalidInput,
          ),
        ),
      );
    });
  });
}
