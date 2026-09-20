import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given article composition', (sessionBuilder, endpoints) {
    Future<
        ({
          dynamic ownerSession,
          BuildingView building,
          MenuArticleView article,
          IngredientView beans,
          IngredientView milk,
        })> _setup() async {
      final auth = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'composition-owner@example.com',
          password: 'password1',
          phoneNumber: '+21621110004',
          firstName: 'Recipe',
          lastName: 'Owner',
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          auth.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: UuidValue.fromString(
            '00000000-0000-7000-8000-000000000004',
          ).uuid,
        ),
      );
      final building = await endpoints.building.create(
        ownerSession,
        BuildingCreate(
          name: 'Recipe House',
          type: 'cafe',
          address: '4 Main St',
          latitude: 36.8,
          longitude: 10.1,
          openingMinutes: 480,
          closingMinutes: 1380,
          currencyCode: 'TND',
          strictModeSteps: [],
        ),
      );
      final category = await endpoints.menuCategory.create(
        ownerSession,
        MenuCategoryCreate(
          buildingId: building.id,
          name: 'Drinks',
          description: null,
        ),
      );
      final article = await endpoints.menuArticle.create(
        ownerSession,
        MenuArticleCreate(
          buildingId: building.id,
          categoryId: category.id,
          name: 'Latte',
          description: null,
          price: 8,
        ),
      );
      expect(article.compositionLineCount, 0);
      final beans = await endpoints.ingredient.create(
        ownerSession,
        IngredientCreate(
          buildingId: building.id,
          name: 'Espresso beans',
          unit: UnitsType.gram,
          currentStock: 1000,
          thresholdStock: 100,
        ),
      );
      final milk = await endpoints.ingredient.create(
        ownerSession,
        IngredientCreate(
          buildingId: building.id,
          name: 'Milk',
          unit: UnitsType.milliliter,
          currentStock: 5000,
          thresholdStock: 500,
        ),
      );
      return (
        ownerSession: ownerSession,
        building: building,
        article: article,
        beans: beans,
        milk: milk,
      );
    }

    test('owner manages optional composition lines', () async {
      final setup = await _setup();
      final empty = await endpoints.articleComposition.list(
        setup.ownerSession,
        setup.article.id,
      );
      expect(empty, isEmpty);

      final line = await endpoints.articleComposition.create(
        setup.ownerSession,
        ArticleCompositionCreate(
          articleId: setup.article.id,
          ingredientId: setup.beans.id,
          quantity: 18,
        ),
      );
      expect(line.ingredientName, 'Espresso beans');
      expect(line.unit, UnitsType.gram);
      expect(line.quantity, 18);

      await expectLater(
        endpoints.articleComposition.create(
          setup.ownerSession,
          ArticleCompositionCreate(
            articleId: setup.article.id,
            ingredientId: setup.beans.id,
            quantity: 20,
          ),
        ),
        throwsA(isA<ArticleCompositionException>()),
      );

      await endpoints.articleComposition.create(
        setup.ownerSession,
        ArticleCompositionCreate(
          articleId: setup.article.id,
          ingredientId: setup.milk.id,
          quantity: 200,
        ),
      );

      final updated = await endpoints.articleComposition.update(
        setup.ownerSession,
        ArticleCompositionUpdate(id: line.id, quantity: 20),
      );
      expect(updated.quantity, 20);

      final listed = await endpoints.menuArticle.list(
        setup.ownerSession,
        setup.building.id,
      );
      expect(listed.first.compositionLineCount, 2);

      await expectLater(
        endpoints.ingredient.delete(setup.ownerSession, setup.beans.id),
        throwsA(isA<IngredientException>()),
      );

      await endpoints.articleComposition.delete(setup.ownerSession, line.id);
      final after = await endpoints.articleComposition.list(
        setup.ownerSession,
        setup.article.id,
      );
      expect(after, hasLength(1));
      expect(after.first.ingredientName, 'Milk');
    });
  });
}
