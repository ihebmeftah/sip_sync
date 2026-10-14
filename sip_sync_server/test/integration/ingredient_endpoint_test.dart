import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given ingredients', (sessionBuilder, endpoints) {
    Future<({dynamic ownerSession, BuildingView building})>
    ownerWithBuilding() async {
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
          phoneNumber: '+21671100001',
          otherLinks: const [],
          currencyCode: 'TND',
          strictModeSteps: [],
        ),
      );
      return (ownerSession: ownerSession, building: building);
    }

    test(
      'owner creates lists and deletes ingredients with unique names',
      () async {
        final setup = await ownerWithBuilding();
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

        final empty = await endpoints.ingredient.create(
          setup.ownerSession,
          IngredientCreate(
            buildingId: setup.building.id,
            name: 'Ice',
            unit: UnitsType.kilogram,
            currentStock: 0,
            thresholdStock: 0,
          ),
        );
        expect(
          await endpoints.ingredient.outOfStockCount(
            setup.ownerSession,
            setup.building.id,
          ),
          1,
        );
        final onlyEmpty = await endpoints.ingredient.list(
          setup.ownerSession,
          setup.building.id,
          outOfStock: true,
        );
        expect(onlyEmpty.total, 1);
        expect(onlyEmpty.items.single.id, empty.id);

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

        final list = (await endpoints.ingredient.list(
          setup.ownerSession,
          setup.building.id,
        )).items;
        expect(list, hasLength(3));
        final page = await endpoints.ingredient.list(
          setup.ownerSession,
          setup.building.id,
          limit: 1,
          offset: 1,
        );
        expect(page.total, 3);
        expect(page.items, hasLength(1));
        expect(page.offset, 1);

        await endpoints.ingredient.delete(setup.ownerSession, created.id);
        await endpoints.ingredient.delete(setup.ownerSession, low.id);
        await endpoints.ingredient.delete(setup.ownerSession, empty.id);
        final afterDelete = (await endpoints.ingredient.list(
          setup.ownerSession,
          setup.building.id,
        )).items;
        expect(afterDelete, isEmpty);
      },
    );
  });
}
