import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given ingredients', (sessionBuilder, endpoints) {
    Future<({dynamic ownerSession, BuildingView building})>
    _ownerWithBuilding() async {
      final auth = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'ingredient-owner@example.com',
          password: 'password1',
          phoneNumber: '+21621110003',
          firstName: 'Stock',
          lastName: 'Owner',
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          auth.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: UuidValue.fromString(
            '00000000-0000-7000-8000-000000000003',
          ).uuid,
        ),
      );
      final building = await endpoints.building.create(
        ownerSession,
        BuildingCreate(
          name: 'Stock House',
          type: 'cafe',
          address: '3 Main St',
          latitude: 36.8,
          longitude: 10.1,
          openingMinutes: 480,
          closingMinutes: 1380,
          currencyCode: 'TND',
        ),
      );
      return (ownerSession: ownerSession, building: building);
    }

    test(
      'owner creates lists and deletes ingredients with unique names',
      () async {
        final setup = await _ownerWithBuilding();
        final created = await endpoints.ingredient.create(
          setup.ownerSession,
          IngredientCreate(
            buildingId: setup.building.id,
            name: 'Espresso beans',
            unit: UnitsType.kilogram,
            currentStock: 12.5,
            thresholdStock: 2,
          ),
        );
        expect(created.name, 'Espresso beans');
        expect(created.unit, UnitsType.kilogram);
        expect(created.currentStock, 12.5);
        expect(created.initialStock, 12.5);
        expect(created.thresholdStock, 2);
        expect(created.belowThreshold, isFalse);
        expect(created.stockProgress, 1.0);

        final restocked = await endpoints.ingredient.restock(
          setup.ownerSession,
          IngredientRestock(id: created.id, quantity: 1.5),
        );
        expect(restocked.currentStock, 14.0);
        expect(restocked.initialStock, 14.0);
        expect(restocked.stockProgress, 1.0);

        final low = await endpoints.ingredient.create(
          setup.ownerSession,
          IngredientCreate(
            buildingId: setup.building.id,
            name: 'Milk',
            unit: UnitsType.liter,
            currentStock: 1,
            thresholdStock: 2,
          ),
        );
        expect(low.belowThreshold, isTrue);

        await expectLater(
          endpoints.ingredient.create(
            setup.ownerSession,
            IngredientCreate(
              buildingId: setup.building.id,
              name: 'espresso beans',
              unit: UnitsType.gram,
              currentStock: 1,
              thresholdStock: 0,
            ),
          ),
          throwsA(isA<IngredientException>()),
        );

        final list = await endpoints.ingredient.list(
          setup.ownerSession,
          setup.building.id,
        );
        expect(list, hasLength(2));

        await endpoints.ingredient.delete(setup.ownerSession, created.id);
        await endpoints.ingredient.delete(setup.ownerSession, low.id);
        final afterDelete = await endpoints.ingredient.list(
          setup.ownerSession,
          setup.building.id,
        );
        expect(afterDelete, isEmpty);
      },
    );
  });
}
