import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given orders', (sessionBuilder, endpoints) {
    Future<
      ({
        dynamic ownerSession,
        BuildingView building,
        VenueTableView table,
        MenuArticleView article,
      })
    >
    setupFixture() async {
      final auth = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'order-owner@example.com',
          password: 'password1',
          phoneNumber: '+21621110005',
          firstName: 'Order',
          lastName: 'Owner',
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          auth.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: UuidValue.fromString(
            '00000000-0000-7000-8000-000000000005',
          ).uuid,
        ),
      );
      final building = await endpoints.building.create(
        ownerSession,
        BuildingCreate(
          name: 'Order House',
          type: 'cafe',
          address: '5 Main St',
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
      final tables = await endpoints.venueTable.create(
        ownerSession,
        VenueTableCreate(
          buildingId: building.id,
          count: 1,
          maxSeats: 4,
          isActive: true,
        ),
      );
      final category = await endpoints.menuCategory.create(
        ownerSession,
        MenuCategoryCreate(
          buildingId: building.id,
          name: 'Coffee',
          description: null,
        ),
      );
      final article = await endpoints.menuArticle.create(
        ownerSession,
        MenuArticleCreate(
          buildingId: building.id,
          categoryId: category.id,
          name: 'Espresso',
          description: null,
          price: 3.5,
        ),
      );
      return (
        ownerSession: ownerSession,
        building: building,
        table: tables.first,
        article: article,
      );
    }

    test('owner creates order and advances item to payed', () async {
      final setup = await setupFixture();
      final created = await endpoints.order.create(
        setup.ownerSession,
        OrderCreate(
          buildingId: setup.building.id,
          venueTableId: setup.table.id,
          items: [
            OrderItemCreateLine(articleId: setup.article.id),
            OrderItemCreateLine(articleId: setup.article.id),
          ],
        ),
      );
      expect(created.status, OrderStatus.progress);
      expect(created.launchedBy.type, ActorType.owner);
      expect(created.launchedBy.firstName, 'Order');
      expect(created.launchedBy.lastName, 'Owner');
      expect(created.tableNumber, 1);
      expect(created.items, hasLength(2));
      expect(created.items.first.status, OrderItemStatus.progress);
      expect(created.totalAmount, 7);

      final tablesWhileOpen = await endpoints.venueTable.list(
        setup.ownerSession,
        setup.building.id,
        TableListFilter.all,
      );
      expect(
        tablesWhileOpen.firstWhere((t) => t.id == setup.table.id).status,
        TableFloorStatus.occupied,
      );

      var order = created;
      for (final item in List<OrderItemView>.from(order.items)) {
        var current = item;
        for (final status in [
          OrderItemStatus.picked,
          OrderItemStatus.ready,
          OrderItemStatus.served,
          OrderItemStatus.payed,
        ]) {
          order = await endpoints.order.updateItemStatus(
            setup.ownerSession,
            OrderItemStatusUpdate(id: current.id, status: status),
          );
          current = order.items.firstWhere((i) => i.id == item.id);
        }
      }

      expect(
        order.items.every((i) => i.status == OrderItemStatus.payed),
        isTrue,
      );
      expect(order.items.first.passedBy?.id, isNotNull);
      expect(order.items.first.preparedBy?.id, isNotNull);
      expect(order.items.first.preparedAt, isNotNull);
      expect(order.items.first.servedBy?.id, isNotNull);
      expect(order.items.first.servedAt, isNotNull);
      expect(order.items.first.paidTo?.id, isNotNull);
      expect(order.items.first.paidAt, isNotNull);
      expect(order.status, OrderStatus.payed);
      expect(order.lastPaidBy?.type, ActorType.owner);
      expect(order.lastPaidAt, isNotNull);

      final tablesAfterPay = await endpoints.venueTable.list(
        setup.ownerSession,
        setup.building.id,
        TableListFilter.all,
      );
      expect(
        tablesAfterPay.firstWhere((t) => t.id == setup.table.id).status,
        TableFloorStatus.available,
      );
    });

    test('create deducts composition stock; cancel restores it', () async {
      final setup = await setupFixture();
      final beans = await endpoints.ingredient.create(
        setup.ownerSession,
        IngredientCreate(
          buildingId: setup.building.id,
          name: 'Beans',
          unit: UnitsType.gram,
          currentStock: 100,
          thresholdStock: 10,
        ),
      );
      await endpoints.articleComposition.create(
        setup.ownerSession,
        ArticleCompositionCreate(
          articleId: setup.article.id,
          ingredientId: beans.id,
          quantity: 18,
        ),
      );

      final created = await endpoints.order.create(
        setup.ownerSession,
        OrderCreate(
          buildingId: setup.building.id,
          venueTableId: setup.table.id,
          items: [
            OrderItemCreateLine(articleId: setup.article.id),
            OrderItemCreateLine(articleId: setup.article.id),
          ],
        ),
      );

      final afterCreate = await endpoints.ingredient.list(
        setup.ownerSession,
        setup.building.id,
      );
      expect(
        afterCreate.firstWhere((i) => i.id == beans.id).currentStock,
        64,
      );

      await endpoints.order.cancel(setup.ownerSession, created.id);

      final afterCancel = await endpoints.ingredient.list(
        setup.ownerSession,
        setup.building.id,
      );
      expect(
        afterCancel.firstWhere((i) => i.id == beans.id).currentStock,
        100,
      );
    });

    test('create fails when composition stock is insufficient', () async {
      final setup = await setupFixture();
      final beans = await endpoints.ingredient.create(
        setup.ownerSession,
        IngredientCreate(
          buildingId: setup.building.id,
          name: 'Scarce beans',
          unit: UnitsType.gram,
          currentStock: 10,
          thresholdStock: 5,
        ),
      );
      await endpoints.articleComposition.create(
        setup.ownerSession,
        ArticleCompositionCreate(
          articleId: setup.article.id,
          ingredientId: beans.id,
          quantity: 18,
        ),
      );

      await expectLater(
        endpoints.order.create(
          setup.ownerSession,
          OrderCreate(
            buildingId: setup.building.id,
            venueTableId: setup.table.id,
            items: [OrderItemCreateLine(articleId: setup.article.id)],
          ),
        ),
        throwsA(
          isA<OrderException>().having(
            (e) => e.code,
            'code',
            OrderErrorCode.insufficientStock,
          ),
        ),
      );
    });

    test(
      'blocks second order on occupied table when multi-order is off',
      () async {
        final setup = await setupFixture();
        expect(setup.building.tableMultiOrder, isFalse);

        await endpoints.order.create(
          setup.ownerSession,
          OrderCreate(
            buildingId: setup.building.id,
            venueTableId: setup.table.id,
            items: [OrderItemCreateLine(articleId: setup.article.id)],
          ),
        );

        await expectLater(
          endpoints.order.create(
            setup.ownerSession,
            OrderCreate(
              buildingId: setup.building.id,
              venueTableId: setup.table.id,
              items: [OrderItemCreateLine(articleId: setup.article.id)],
            ),
          ),
          throwsA(
            isA<OrderException>().having(
              (e) => e.code,
              'code',
              OrderErrorCode.tableOccupied,
            ),
          ),
        );

        await endpoints.building.update(
          setup.ownerSession,
          BuildingUpdate(
            id: setup.building.id,
            name: setup.building.name,
            type: setup.building.type,
            address: setup.building.address,
            latitude: setup.building.latitude,
            longitude: setup.building.longitude,
            openingMinutes: setup.building.openingMinutes,
            closingMinutes: setup.building.closingMinutes,
            currencyCode: setup.building.currencyCode,
            phoneNumber: setup.building.phoneNumber,
            whatsapp: setup.building.whatsapp,
            instagram: setup.building.instagram,
            facebook: setup.building.facebook,
            otherLinks: setup.building.otherLinks,
            tableMultiOrder: true,
            allowAppendingItemsToOrder: true,
            strictMode: false,
            strictModeSteps: [],
          ),
        );

        final second = await endpoints.order.create(
          setup.ownerSession,
          OrderCreate(
            buildingId: setup.building.id,
            venueTableId: setup.table.id,
            items: [OrderItemCreateLine(articleId: setup.article.id)],
          ),
        );
        expect(second.status, OrderStatus.progress);
      },
    );

    test(
      'strict mode skips disabled steps; non-strict allows pay jump',
      () async {
        final setup = await setupFixture();
        final steps = [
          StrictModeStep(
            rank: 1,
            status: OrderItemStatus.picked,
            enabled: false,
          ),
          StrictModeStep(rank: 2, status: OrderItemStatus.ready, enabled: true),
          StrictModeStep(
            rank: 3,
            status: OrderItemStatus.served,
            enabled: true,
          ),
          StrictModeStep(rank: 4, status: OrderItemStatus.payed, enabled: true),
        ];
        await endpoints.building.update(
          setup.ownerSession,
          BuildingUpdate(
            id: setup.building.id,
            name: setup.building.name,
            type: setup.building.type,
            address: setup.building.address,
            latitude: setup.building.latitude,
            longitude: setup.building.longitude,
            openingMinutes: setup.building.openingMinutes,
            closingMinutes: setup.building.closingMinutes,
            currencyCode: setup.building.currencyCode,
            phoneNumber: setup.building.phoneNumber,
            whatsapp: setup.building.whatsapp,
            instagram: setup.building.instagram,
            facebook: setup.building.facebook,
            otherLinks: setup.building.otherLinks,
            tableMultiOrder: false,
            allowAppendingItemsToOrder: true,
            strictMode: true,
            strictModeSteps: steps,
          ),
        );

        var order = await endpoints.order.create(
          setup.ownerSession,
          OrderCreate(
            buildingId: setup.building.id,
            venueTableId: setup.table.id,
            items: [OrderItemCreateLine(articleId: setup.article.id)],
          ),
        );
        final itemId = order.items.first.id;

        await expectLater(
          endpoints.order.updateItemStatus(
            setup.ownerSession,
            OrderItemStatusUpdate(id: itemId, status: OrderItemStatus.picked),
          ),
          throwsA(
            isA<OrderException>().having(
              (e) => e.code,
              'code',
              OrderErrorCode.invalidStatus,
            ),
          ),
        );

        order = await endpoints.order.updateItemStatus(
          setup.ownerSession,
          OrderItemStatusUpdate(id: itemId, status: OrderItemStatus.ready),
        );
        expect(order.items.first.status, OrderItemStatus.ready);

        await endpoints.building.update(
          setup.ownerSession,
          BuildingUpdate(
            id: setup.building.id,
            name: setup.building.name,
            type: setup.building.type,
            address: setup.building.address,
            latitude: setup.building.latitude,
            longitude: setup.building.longitude,
            openingMinutes: setup.building.openingMinutes,
            closingMinutes: setup.building.closingMinutes,
            currencyCode: setup.building.currencyCode,
            phoneNumber: setup.building.phoneNumber,
            whatsapp: setup.building.whatsapp,
            instagram: setup.building.instagram,
            facebook: setup.building.facebook,
            otherLinks: setup.building.otherLinks,
            tableMultiOrder: false,
            allowAppendingItemsToOrder: true,
            strictMode: false,
            strictModeSteps: steps,
          ),
        );

        order = await endpoints.order.create(
          setup.ownerSession,
          OrderCreate(
            buildingId: setup.building.id,
            venueTableId: null,
            items: [OrderItemCreateLine(articleId: setup.article.id)],
          ),
        );
        order = await endpoints.order.updateItemStatus(
          setup.ownerSession,
          OrderItemStatusUpdate(
            id: order.items.first.id,
            status: OrderItemStatus.payed,
          ),
        );
        expect(order.items.first.status, OrderItemStatus.payed);
      },
    );

    test('rejects addItems when appending is disabled', () async {
      final setup = await setupFixture();
      await endpoints.building.update(
        setup.ownerSession,
        BuildingUpdate(
          id: setup.building.id,
          name: setup.building.name,
          type: setup.building.type,
          address: setup.building.address,
          latitude: setup.building.latitude,
          longitude: setup.building.longitude,
          openingMinutes: setup.building.openingMinutes,
          closingMinutes: setup.building.closingMinutes,
          currencyCode: setup.building.currencyCode,
          phoneNumber: setup.building.phoneNumber,
          whatsapp: setup.building.whatsapp,
          instagram: setup.building.instagram,
          facebook: setup.building.facebook,
          otherLinks: setup.building.otherLinks,
          tableMultiOrder: false,
          allowAppendingItemsToOrder: false,
          strictMode: false,
          strictModeSteps: [],
        ),
      );
      final order = await endpoints.order.create(
        setup.ownerSession,
        OrderCreate(
          buildingId: setup.building.id,
          venueTableId: setup.table.id,
          items: [OrderItemCreateLine(articleId: setup.article.id)],
        ),
      );
      await expectLater(
        endpoints.order.addItems(
          setup.ownerSession,
          OrderAddItems(
            orderId: order.id,
            items: [OrderItemCreateLine(articleId: setup.article.id)],
          ),
        ),
        throwsA(
          isA<OrderException>().having(
            (e) => e.code,
            'code',
            OrderErrorCode.appendNotAllowed,
          ),
        ),
      );
    });
  });
}
