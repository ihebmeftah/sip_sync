import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given a customer order', (sessionBuilder, endpoints) {
    test(
      'when the customer has a table then the order stores prices and that table',
      () async {
        final ownerSession = await _owner(
          sessionBuilder,
          endpoints,
          'order-a',
          '+21622112001',
        );
        final building = await endpoints.building.create(
          ownerSession,
          _building('Order House', '+21671112001'),
        );
        final category = await endpoints.menuCategory.create(
          ownerSession,
          MenuCategoryCreate(buildingId: building.id, name: 'Plates'),
        );
        final article = await endpoints.menuArticle.create(
          ownerSession,
          MenuArticleCreate(
            buildingId: building.id,
            categoryId: category.id,
            name: 'Mint tea',
            price: 6.5,
          ),
        );
        final mint = await endpoints.ingredient.create(
          ownerSession,
          IngredientCreate(
            buildingId: building.id,
            name: 'Mint',
            unit: UnitsType.bunch,
            currentStock: 5,
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
        final tables = await endpoints.venueTable.create(
          ownerSession,
          VenueTableCreate(
            buildingId: building.id,
            count: 2,
            maxSeats: 2,
            isActive: true,
          ),
        );
        await endpoints.venueTable.update(
          ownerSession,
          VenueTableUpdate(id: tables.last.id, maxSeats: 2, isActive: false),
        );

        final customerSession = await _customer(
          sessionBuilder,
          endpoints,
          'order-a',
          '+21622112002',
        );
        final placed = await endpoints.customerOrder.place(
          customerSession,
          CustomerOrderPlace(
            buildingId: building.id,
            tableId: tables.first.id,
            items: [
              CustomerOrderItem(articleId: article.id),
              CustomerOrderItem(articleId: article.id),
            ],
          ),
        );
        expect(placed.ref, 1);
        expect(placed.tableNumber, 1);
        expect(placed.currencyCode, 'TND');
        expect(placed.status, OrderStatus.progress);
        expect(placed.lines, hasLength(2));
        expect(placed.lines.map((line) => line.name), ['Mint tea', 'Mint tea']);
        expect(placed.lines.map((line) => line.unitPrice), [6.5, 6.5]);
        expect(
          placed.lines.map((line) => line.status),
          [OrderItemStatus.progress, OrderItemStatus.progress],
        );
        expect(placed.lines[0].id, isNot(placed.lines[1].id));
        expect(placed.totalAmount, 13);

        final now = DateTime.now().toUtc();
        final history = await endpoints.customerOrder.list(
          customerSession,
          now.subtract(const Duration(hours: 1)),
          now.add(const Duration(hours: 1)),
        );
        expect(history, hasLength(1));
        expect(history.single.id, placed.id);
        expect(history.single.venueName, 'Order House');
        expect(history.single.tableNumber, 1);
        expect(history.single.itemCount, 2);
        expect(history.single.totalAmount, 13);
        expect(history.single.currencyCode, 'TND');

        final earlier = await endpoints.customerOrder.list(
          customerSession,
          now.subtract(const Duration(days: 3)),
          now.subtract(const Duration(days: 2)),
        );
        expect(earlier, isEmpty);
        await expectLater(
          endpoints.customerOrder.list(customerSession, now, now),
          throwsA(
            isA<OrderException>().having(
              (error) => error.code,
              'code',
              OrderErrorCode.invalidInput,
            ),
          ),
        );

        final loaded = await endpoints.customerOrder.get(
          customerSession,
          placed.id,
        );
        expect(loaded.id, placed.id);
        expect(loaded.totalAmount, 13);

        final open = await endpoints.customerOrder.current(customerSession);
        expect(open?.id, placed.id);
        expect(open?.status, OrderStatus.progress);

        final appended = await endpoints.customerOrder.append(
          customerSession,
          CustomerOrderAppend(
            orderId: placed.id,
            items: [CustomerOrderItem(articleId: article.id)],
          ),
        );
        expect(appended.lines, hasLength(3));
        expect(appended.totalAmount, 19.5);
        expect(appended.ref, placed.ref);

        final stock = await endpoints.ingredient.list(
          ownerSession,
          building.id,
        );
        expect(stock.single.currentStock, 2);

        await expectLater(
          endpoints.customerOrder.place(
            customerSession,
            CustomerOrderPlace(
              buildingId: building.id,
              tableId: tables.first.id,
              items: [
                CustomerOrderItem(articleId: article.id),
              ],
            ),
          ),
          throwsA(
            isA<OrderException>().having(
              (error) => error.code,
              'code',
              OrderErrorCode.tableOccupied,
            ),
          ),
        );

        await expectLater(
          endpoints.customerOrder.place(
            customerSession,
            CustomerOrderPlace(
              buildingId: building.id,
              tableId: tables.last.id,
              items: [
                CustomerOrderItem(articleId: article.id),
              ],
            ),
          ),
          throwsA(
            isA<OrderException>().having(
              (error) => error.code,
              'code',
              OrderErrorCode.notFound,
            ),
          ),
        );
      },
    );

    test(
      'when appending is off or the order is closed then it is refused',
      () async {
        final ownerSession = await _owner(
          sessionBuilder,
          endpoints,
          'order-append',
          '+21622112008',
        );
        final building = await endpoints.building.create(
          ownerSession,
          _building('Append House', '+21671112004'),
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
            price: 6.5,
          ),
        );
        final tables = await endpoints.venueTable.create(
          ownerSession,
          VenueTableCreate(
            buildingId: building.id,
            count: 1,
            maxSeats: 2,
            isActive: true,
          ),
        );
        final customerSession = await _customer(
          sessionBuilder,
          endpoints,
          'order-append',
          '+21622112009',
        );
        final placed = await endpoints.customerOrder.place(
          customerSession,
          CustomerOrderPlace(
            buildingId: building.id,
            tableId: tables.single.id,
            items: [CustomerOrderItem(articleId: article.id)],
          ),
        );
        await endpoints.order.cancel(ownerSession, placed.id);
        expect(await endpoints.customerOrder.current(customerSession), isNull);
        await expectLater(
          endpoints.customerOrder.append(
            customerSession,
            CustomerOrderAppend(
              orderId: placed.id,
              items: [CustomerOrderItem(articleId: article.id)],
            ),
          ),
          throwsA(
            isA<OrderException>().having(
              (error) => error.code,
              'code',
              OrderErrorCode.invalidStatus,
            ),
          ),
        );

        final again = await endpoints.customerOrder.place(
          customerSession,
          CustomerOrderPlace(
            buildingId: building.id,
            tableId: tables.single.id,
            items: [CustomerOrderItem(articleId: article.id)],
          ),
        );
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
            whatsapp: building.whatsapp,
            instagram: building.instagram,
            facebook: building.facebook,
            otherLinks: building.otherLinks,
            tableMultiOrder: building.tableMultiOrder,
            allowAppendingItemsToOrder: false,
            strictMode: building.strictMode,
            strictModeSteps: building.strictModeSteps,
          ),
        );
        await expectLater(
          endpoints.customerOrder.append(
            customerSession,
            CustomerOrderAppend(
              orderId: again.id,
              items: [CustomerOrderItem(articleId: article.id)],
            ),
          ),
          throwsA(
            isA<OrderException>().having(
              (error) => error.code,
              'code',
              OrderErrorCode.appendNotAllowed,
            ),
          ),
        );
      },
    );

    test('when stock is short then the order is not placed', () async {
      final ownerSession = await _owner(
        sessionBuilder,
        endpoints,
        'order-stock',
        '+21622112003',
      );
      final building = await endpoints.building.create(
        ownerSession,
        _building('Stock House', '+21671112002'),
      );
      final category = await endpoints.menuCategory.create(
        ownerSession,
        MenuCategoryCreate(buildingId: building.id, name: 'Drinks'),
      );
      final article = await endpoints.menuArticle.create(
        ownerSession,
        MenuArticleCreate(
          buildingId: building.id,
          categoryId: category.id,
          name: 'Lemonade',
          price: 4,
        ),
      );
      final lemon = await endpoints.ingredient.create(
        ownerSession,
        IngredientCreate(
          buildingId: building.id,
          name: 'Lemon',
          unit: UnitsType.piece,
          currentStock: 1,
          thresholdStock: 0,
        ),
      );
      await endpoints.articleComposition.create(
        ownerSession,
        ArticleCompositionCreate(
          articleId: article.id,
          ingredientId: lemon.id,
          quantity: 1,
        ),
      );
      final tables = await endpoints.venueTable.create(
        ownerSession,
        VenueTableCreate(
          buildingId: building.id,
          count: 1,
          maxSeats: 2,
          isActive: true,
        ),
      );
      final customerSession = await _customer(
        sessionBuilder,
        endpoints,
        'order-stock',
        '+21622112004',
      );
      await expectLater(
        endpoints.customerOrder.place(
          customerSession,
          CustomerOrderPlace(
            buildingId: building.id,
            tableId: tables.single.id,
            items: [
              CustomerOrderItem(articleId: article.id),
              CustomerOrderItem(articleId: article.id),
            ],
          ),
        ),
        throwsA(
          isA<OrderException>().having(
            (error) => error.code,
            'code',
            OrderErrorCode.insufficientStock,
          ),
        ),
      );
      final stock = await endpoints.ingredient.list(ownerSession, building.id);
      expect(stock.single.currentStock, 1);
    });

    test('when another customer asks then the order is hidden', () async {
      final ownerSession = await _owner(
        sessionBuilder,
        endpoints,
        'order-hide',
        '+21622112005',
      );
      final building = await endpoints.building.create(
        ownerSession,
        _building('Private House', '+21671112003'),
      );
      final category = await endpoints.menuCategory.create(
        ownerSession,
        MenuCategoryCreate(buildingId: building.id, name: 'Bites'),
      );
      final article = await endpoints.menuArticle.create(
        ownerSession,
        MenuArticleCreate(
          buildingId: building.id,
          categoryId: category.id,
          name: 'Olive',
          price: 3,
        ),
      );
      final tables = await endpoints.venueTable.create(
        ownerSession,
        VenueTableCreate(
          buildingId: building.id,
          count: 1,
          maxSeats: 2,
          isActive: true,
        ),
      );
      final customerSession = await _customer(
        sessionBuilder,
        endpoints,
        'order-hide',
        '+21622112006',
      );
      final otherSession = await _customer(
        sessionBuilder,
        endpoints,
        'order-other',
        '+21622112007',
      );
      final placed = await endpoints.customerOrder.place(
        customerSession,
        CustomerOrderPlace(
          buildingId: building.id,
          tableId: tables.single.id,
          items: [
            CustomerOrderItem(articleId: article.id),
          ],
        ),
      );
      await expectLater(
        endpoints.customerOrder.get(otherSession, placed.id),
        throwsA(
          isA<OrderException>().having(
            (error) => error.code,
            'code',
            OrderErrorCode.notFound,
          ),
        ),
      );
      await expectLater(
        endpoints.customerOrder.list(
          ownerSession,
          DateTime.now().toUtc().subtract(const Duration(days: 1)),
          DateTime.now().toUtc().add(const Duration(days: 1)),
        ),
        throwsA(
          isA<AccountException>().having(
            (error) => error.code,
            'code',
            AccountErrorCode.notAuthorized,
          ),
        ),
      );
      await expectLater(
        endpoints.customerOrder.current(ownerSession),
        throwsA(
          isA<AccountException>().having(
            (error) => error.code,
            'code',
            AccountErrorCode.notAuthorized,
          ),
        ),
      );
      await expectLater(
        endpoints.customerOrder.append(
          otherSession,
          CustomerOrderAppend(
            orderId: placed.id,
            items: [CustomerOrderItem(articleId: article.id)],
          ),
        ),
        throwsA(
          isA<OrderException>().having(
            (error) => error.code,
            'code',
            OrderErrorCode.notFound,
          ),
        ),
      );
      await expectLater(
        endpoints.customerOrder.place(
          ownerSession,
          CustomerOrderPlace(
            buildingId: building.id,
            tableId: tables.single.id,
            items: [
              CustomerOrderItem(articleId: article.id),
            ],
          ),
        ),
        throwsA(
          isA<AccountException>().having(
            (error) => error.code,
            'code',
            AccountErrorCode.notAuthorized,
          ),
        ),
      );
    });
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
