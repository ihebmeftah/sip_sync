import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:sip_sync_server/src/packs/pack_catalog.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given a customer venue page', (sessionBuilder, endpoints) {
    test(
      'when the venue has no orders then the preview is the first five and free tables exclude inactive and occupied',
      () async {
        final ownerSession = await _owner(
          sessionBuilder,
          endpoints,
          'detail-a',
          '+21622111001',
        );
        final building = await endpoints.building.create(
          ownerSession,
          _building('House Menu', '+21671111001'),
        );
        await PackCatalog.assignCode(
          sessionBuilder.build(),
          building.id,
          'floor',
        );
        final categories = <MenuCategoryView>[];
        for (var n = 1; n <= 6; n++) {
          categories.add(
            await endpoints.menuCategory.create(
              ownerSession,
              MenuCategoryCreate(
                buildingId: building.id,
                name: '0$n Course',
              ),
            ),
          );
        }
        final articles = <MenuArticleView>[];
        for (var n = 1; n <= 7; n++) {
          final category = n <= 6 ? categories[n - 1] : categories.last;
          articles.add(
            await endpoints.menuArticle.create(
              ownerSession,
              MenuArticleCreate(
                buildingId: building.id,
                categoryId: category.id,
                name: '0$n Plate',
                price: 4.5 + n,
              ),
            ),
          );
        }
        final tables = await endpoints.venueTable.create(
          ownerSession,
          VenueTableCreate(
            buildingId: building.id,
            count: 4,
            maxSeats: 2,
            isActive: true,
          ),
        );
        await endpoints.venueTable.update(
          ownerSession,
          VenueTableUpdate(
            id: tables.last.id,
            maxSeats: 2,
            isActive: false,
          ),
        );
        final mint = await endpoints.ingredient.create(
          ownerSession,
          IngredientCreate(
            buildingId: building.id,
            name: 'Mint',
            unit: UnitsType.bunch,
            currentStock: 10,
            thresholdStock: 2,
          ),
        );
        final lemon = await endpoints.ingredient.create(
          ownerSession,
          IngredientCreate(
            buildingId: building.id,
            name: 'Lemon',
            unit: UnitsType.piece,
            currentStock: 20,
            thresholdStock: 4,
          ),
        );
        await endpoints.articleComposition.create(
          ownerSession,
          ArticleCompositionCreate(
            articleId: articles.first.id,
            ingredientId: mint.id,
            quantity: 1,
          ),
        );
        await endpoints.articleComposition.create(
          ownerSession,
          ArticleCompositionCreate(
            articleId: articles.first.id,
            ingredientId: lemon.id,
            quantity: 1,
          ),
        );

        final customerSession = await _customer(
          sessionBuilder,
          endpoints,
          'detail-a',
          '+21622111002',
        );
        final detail = await endpoints.customerVenue.detail(
          customerSession,
          building.id,
        );

        expect(detail.venue.name, 'House Menu');
        expect(detail.currencyCode, 'TND');
        expect(detail.availableTableCount, 3);
        expect(
          detail.availableTables.map((row) => row.number).toList(),
          [1, 2, 3],
        );
        expect(detail.availableTables.first.maxSeats, 2);

        final seated = await endpoints.customerVenue.resolveTable(
          customerSession,
          building.id,
          tables[1].id,
          2,
        );
        expect(seated.venueName, 'House Menu');
        expect(seated.tableId, tables[1].id);
        expect(seated.number, 2);
        expect(seated.maxSeats, 2);
        await expectLater(
          endpoints.customerVenue.resolveTable(
            customerSession,
            building.id,
            tables.last.id,
            tables.last.number,
          ),
          throwsA(
            isA<BuildingException>().having(
              (error) => error.code,
              'code',
              BuildingErrorCode.notFound,
            ),
          ),
        );
        await expectLater(
          endpoints.customerVenue.resolveTable(
            customerSession,
            building.id,
            tables.first.id,
            99,
          ),
          throwsA(
            isA<BuildingException>().having(
              (error) => error.code,
              'code',
              BuildingErrorCode.notFound,
            ),
          ),
        );
        await expectLater(
          endpoints.customerVenue.resolveTable(
            customerSession,
            building.id,
            tables.first.id,
            0,
          ),
          throwsA(
            isA<BuildingException>().having(
              (error) => error.code,
              'code',
              BuildingErrorCode.invalidInput,
            ),
          ),
        );
        expect(
          detail.categories.map((row) => row.name).toList(),
          ['01 Course', '02 Course', '03 Course', '04 Course', '05 Course'],
        );
        expect(detail.categories.first.articleCount, 1);
        expect(
          detail.articles.map((row) => row.name).toList(),
          ['01 Plate', '02 Plate', '03 Plate', '04 Plate', '05 Plate'],
        );
        expect(detail.articles.first.ingredientNames, ['Mint', 'Lemon']);
        expect(detail.articles[1].ingredientNames, isEmpty);

        final menu = await endpoints.customerVenue.menu(
          customerSession,
          building.id,
        );
        expect(menu.sections, hasLength(6));
        expect(menu.sections.first.articles, hasLength(1));
        expect(menu.sections.first.articles.first.ingredientNames, [
          'Mint',
          'Lemon',
        ]);
        expect(menu.sections.last.articles, hasLength(2));
        expect(menu.currencyCode, 'TND');

        await endpoints.order.create(
          ownerSession,
          OrderCreate(
            buildingId: building.id,
            venueTableId: tables.first.id,
            items: [
              OrderItemCreateLine(articleId: articles.last.id),
              OrderItemCreateLine(articleId: articles.last.id),
              OrderItemCreateLine(articleId: articles.last.id),
            ],
          ),
        );
        final ranked = await endpoints.customerVenue.detail(
          customerSession,
          building.id,
        );
        expect(ranked.availableTableCount, 2);
        expect(
          ranked.availableTables.map((row) => row.number).toList(),
          [2, 3],
        );
        expect(ranked.articles.first.name, '07 Plate');
        expect(ranked.categories.first.name, '06 Course');
      },
    );

    test(
      'menu names an ingredient that cannot cover one more dish',
      () async {
        final ownerSession = await _owner(
          sessionBuilder,
          endpoints,
          'detail-stock',
          '+21622111031',
        );
        final building = await endpoints.building.create(
          ownerSession,
          _building('Stock House', '+21671111031'),
        );
        await PackCatalog.assignCode(
          sessionBuilder.build(),
          building.id,
          'floor',
        );
        final category = await endpoints.menuCategory.create(
          ownerSession,
          MenuCategoryCreate(buildingId: building.id, name: 'Tea'),
        );
        final article = await endpoints.menuArticle.create(
          ownerSession,
          MenuArticleCreate(
            buildingId: building.id,
            categoryId: category.id,
            name: 'Mint tea',
            price: 4,
          ),
        );
        final mint = await endpoints.ingredient.create(
          ownerSession,
          IngredientCreate(
            buildingId: building.id,
            name: 'Mint',
            unit: UnitsType.bunch,
            currentStock: 0,
            thresholdStock: 1,
          ),
        );
        await endpoints.articleComposition.create(
          ownerSession,
          ArticleCompositionCreate(
            articleId: article.id,
            ingredientId: mint.id,
            quantity: 1,
          ),
        );
        final customerSession = await _customer(
          sessionBuilder,
          endpoints,
          'detail-stock',
          '+21622111032',
        );
        final menu = await endpoints.customerVenue.menu(
          customerSession,
          building.id,
        );
        expect(menu.allowOutOfStockOrders, isFalse);
        expect(menu.customerOrdering, isTrue);
        expect(menu.orderingClosedByVenue, isFalse);
        expect(menu.articles.single.ingredientNames, ['Mint']);
        expect(menu.articles.single.outOfStockIngredientNames, ['Mint']);

        await endpoints.building.update(
          ownerSession,
          BuildingUpdate(
            id: building.id,
            name: building.name,
            type: building.type,
            address: building.address,
            latitude: building.latitude,
            longitude: building.longitude,
            openingMinutes: building.openingMinutes,
            closingMinutes: building.closingMinutes,
            currencyCode: building.currencyCode,
            phoneNumber: building.phoneNumber,
            otherLinks: building.otherLinks,
            tableMultiOrder: building.tableMultiOrder,
            allowAppendingItemsToOrder: building.allowAppendingItemsToOrder,
            strictMode: building.strictMode,
            strictModeSteps: building.strictModeSteps,
            customerOrderingEnabled: false,
            reservationsEnabled: false,
            allowOutOfStockOrders: true,
          ),
        );
        final after = await endpoints.customerVenue.menu(
          customerSession,
          building.id,
        );
        expect(after.customerOrdering, isFalse);
        expect(after.orderingClosedByVenue, isTrue);
        expect(after.allowOutOfStockOrders, isTrue);
        final page = await endpoints.customerVenue.detail(
          customerSession,
          building.id,
        );
        expect(page.customerOrdering, isFalse);
        expect(page.orderingClosedByVenue, isTrue);
        expect(page.reservationsEnabled, isFalse);
        expect(page.reservationsClosedByVenue, isTrue);
        expect(page.allowOutOfStockOrders, isTrue);
      },
    );

    test('when the venue is missing then detail is not found', () async {
      final customerSession = await _customer(
        sessionBuilder,
        endpoints,
        'detail-missing',
        '+21622111003',
      );
      await expectLater(
        endpoints.customerVenue.detail(
          customerSession,
          UuidValue.fromString('01990000-0000-7000-8000-000000000001'),
        ),
        throwsA(
          isA<BuildingException>().having(
            (error) => error.code,
            'code',
            BuildingErrorCode.notFound,
          ),
        ),
      );
    });

    test(
      'when the caller is an owner then the venue page is rejected',
      () async {
        final ownerSession = await _owner(
          sessionBuilder,
          endpoints,
          'detail-b',
          '+21622111004',
        );
        final building = await endpoints.building.create(
          ownerSession,
          _building('Closed Door', '+21671111002'),
        );
        await expectLater(
          endpoints.customerVenue.detail(ownerSession, building.id),
          throwsA(
            isA<AccountException>().having(
              (error) => error.code,
              'code',
              AccountErrorCode.notAuthorized,
            ),
          ),
        );
        await expectLater(
          endpoints.customerVenue.resolveTable(
            ownerSession,
            building.id,
            UuidValue.fromString('01990000-0000-7000-8000-000000000002'),
            1,
          ),
          throwsA(
            isA<AccountException>().having(
              (error) => error.code,
              'code',
              AccountErrorCode.notAuthorized,
            ),
          ),
        );
      },
    );
  });
}

BuildingCreate _building(String name, String phone) {
  return BuildingCreate(
    name: name,
    type: 'cafe',
    address: '1 Rue de la Paix',
    latitude: 36.8,
    longitude: 10.18,
    openingMinutes: 480,
    closingMinutes: 1320,
    phoneNumber: phone,
    otherLinks: const [],
    currencyCode: 'TND',
    strictModeSteps: [],
  );
}

Future<TestSessionBuilder> _owner(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints,
  String tag,
  String phone,
) async {
  final auth = await endpoints.ownerAuth.register(
    sessionBuilder,
    EmailRegisterCreate(
      email: '$tag-owner@example.com',
      password: 'password1',
      phoneNumber: phone,
      firstName: 'Owner',
      lastName: tag,
    ),
  );
  return sessionBuilder.copyWith(
    authentication: AuthenticationOverride.authenticationInfo(
      auth.owner!.id.uuid,
      {Scope('sip.owner')},
      authId: 'test-session-$tag-owner',
    ),
  );
}

Future<TestSessionBuilder> _customer(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints,
  String tag,
  String phone,
) async {
  final auth = await endpoints.customerAuth.register(
    sessionBuilder,
    EmailRegisterCreate(
      email: '$tag-guest@example.com',
      password: 'password1',
      phoneNumber: phone,
      firstName: 'Guest',
      lastName: tag,
    ),
  );
  return sessionBuilder.copyWith(
    authentication: AuthenticationOverride.authenticationInfo(
      auth.customer!.id.uuid,
      {Scope('sip.customer')},
      authId: 'test-session-$tag-customer',
    ),
  );
}
