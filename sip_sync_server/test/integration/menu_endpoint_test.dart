import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given menu catalog', (sessionBuilder, endpoints) {
    Future<({dynamic ownerSession, BuildingView building})>
    ownerWithBuilding() async {
      final auth = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'menu-owner@example.com',
          password: 'password1',
          phoneNumber: '+21621110002',
          firstName: 'Menu',
          lastName: 'Owner',
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          auth.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: UuidValue.fromString(
            '00000000-0000-7000-8000-000000000002',
          ).uuid,
        ),
      );
      final building = await endpoints.building.create(
        ownerSession,
        BuildingCreate(
          name: 'Menu House',
          type: 'cafe',
          address: '2 Main St',
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

    test('owner creates and updates categories with unique names', () async {
      final setup = await ownerWithBuilding();
      final created = await endpoints.menuCategory.create(
        setup.ownerSession,
        MenuCategoryCreate(
          buildingId: setup.building.id,
          name: 'Coffee',
          description: 'Hot drinks',
        ),
      );
      expect(created.name, 'Coffee');
      expect(created.description, 'Hot drinks');

      await expectLater(
        endpoints.menuCategory.create(
          setup.ownerSession,
          MenuCategoryCreate(
            buildingId: setup.building.id,
            name: 'coffee',
            description: null,
          ),
        ),
        throwsA(isA<MenuCategoryException>()),
      );

      final updated = await endpoints.menuCategory.update(
        setup.ownerSession,
        MenuCategoryUpdate(
          id: created.id,
          name: 'Espresso bar',
          description: null,
        ),
      );
      expect(updated.name, 'Espresso bar');
      expect(updated.description, isNull);

      final list = await endpoints.menuCategory.list(
        setup.ownerSession,
        setup.building.id,
      );
      expect(list, hasLength(1));
    });

    test('owner creates articles under a category with unique names', () async {
      final setup = await ownerWithBuilding();
      final category = await endpoints.menuCategory.create(
        setup.ownerSession,
        MenuCategoryCreate(
          buildingId: setup.building.id,
          name: 'Pastries',
          description: null,
        ),
      );
      final article = await endpoints.menuArticle.create(
        setup.ownerSession,
        MenuArticleCreate(
          buildingId: setup.building.id,
          categoryId: category.id,
          name: 'Croissant',
          description: 'Butter',
          price: 3.5,
        ),
      );
      expect(article.categoryName, 'Pastries');
      expect(article.price, 3.5);

      await expectLater(
        endpoints.menuArticle.create(
          setup.ownerSession,
          MenuArticleCreate(
            buildingId: setup.building.id,
            categoryId: category.id,
            name: 'CROISSANT',
            description: null,
            price: 4,
          ),
        ),
        throwsA(isA<MenuArticleException>()),
      );

      final updated = await endpoints.menuArticle.update(
        setup.ownerSession,
        MenuArticleUpdate(
          id: article.id,
          categoryId: category.id,
          name: 'Almond croissant',
          description: 'Filled',
          price: 4.2,
        ),
      );
      expect(updated.name, 'Almond croissant');
      expect(updated.price, 4.2);

      final list = await endpoints.menuArticle.list(
        setup.ownerSession,
        setup.building.id,
      );
      expect(list, hasLength(1));
      expect(list.first.categoryName, 'Pastries');
    });
  });
}
