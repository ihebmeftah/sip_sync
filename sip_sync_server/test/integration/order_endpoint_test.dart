import 'dart:async';

import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:sip_sync_server/src/packs/pack_catalog.dart';
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
      await PackCatalog.assignCode(
        sessionBuilder.build(),
        building.id,
        'floor',
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

      final afterCreate = (await endpoints.ingredient.list(
        setup.ownerSession,
        setup.building.id,
      )).items;
      expect(
        afterCreate.firstWhere((i) => i.id == beans.id).currentStock,
        64,
      );

      final cancelled = await endpoints.order.cancel(
        setup.ownerSession,
        created.id,
        OrderCancellationReason.ingredientOutOfStock,
      );
      expect(
        cancelled.cancellationReason,
        OrderCancellationReason.ingredientOutOfStock,
      );

      final afterCancel = (await endpoints.ingredient.list(
        setup.ownerSession,
        setup.building.id,
      )).items;
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
      'names an out-of-stock ingredient and allows the order when configured',
      () async {
        final setup = await setupFixture();
        final beans = await endpoints.ingredient.create(
          setup.ownerSession,
          IngredientCreate(
            buildingId: setup.building.id,
            name: 'Scarce beans',
            unit: UnitsType.gram,
            currentStock: 0,
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

        final listed = await endpoints.menuArticle.list(
          setup.ownerSession,
          setup.building.id,
        );
        expect(
          listed
              .firstWhere((row) => row.id == setup.article.id)
              .outOfStockIngredientNames,
          ['Scarce beans'],
        );

        final building = setup.building;
        Future<void> save({required bool allowOutOfStockOrders}) {
          return endpoints.building.update(
            setup.ownerSession,
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
              allowAppendingItemsToOrder: building.allowAppendingItemsToOrder,
              strictMode: building.strictMode,
              strictModeSteps: building.strictModeSteps,
              reservationFee: building.reservationFee,
              allowOutOfStockOrders: allowOutOfStockOrders,
            ),
          );
        }

        await expectLater(
          endpoints.order.create(
            setup.ownerSession,
            OrderCreate(
              buildingId: building.id,
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

        await save(allowOutOfStockOrders: true);
        final created = await endpoints.order.create(
          setup.ownerSession,
          OrderCreate(
            buildingId: building.id,
            venueTableId: setup.table.id,
            items: [OrderItemCreateLine(articleId: setup.article.id)],
          ),
        );
        expect(created.items, hasLength(1));
        final after = (await endpoints.ingredient.list(
          setup.ownerSession,
          building.id,
        )).items;
        expect(
          after.firstWhere((row) => row.id == beans.id).currentStock,
          0,
        );
      },
    );

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
      'strict mode skips disabled steps; turning it off keeps only payed',
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

        final updated = await endpoints.building.update(
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
        expect(updated.strictMode, isFalse);
        expect(
          updated.strictModeSteps
              .where((step) => step.enabled)
              .map((step) => step.status),
          [OrderItemStatus.payed],
        );

        await expectLater(
          endpoints.order.updateItemStatus(
            setup.ownerSession,
            OrderItemStatusUpdate(id: itemId, status: OrderItemStatus.served),
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
          OrderItemStatusUpdate(id: itemId, status: OrderItemStatus.payed),
        );
        expect(order.items.first.status, OrderItemStatus.payed);

        order = await endpoints.order.create(
          setup.ownerSession,
          OrderCreate(
            buildingId: setup.building.id,
            venueTableId: null,
            items: [OrderItemCreateLine(articleId: setup.article.id)],
          ),
        );
        await expectLater(
          endpoints.order.updateItemStatus(
            setup.ownerSession,
            OrderItemStatusUpdate(
              id: order.items.first.id,
              status: OrderItemStatus.picked,
            ),
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

    test('board stream announces a new order then an added line', () async {
      final setup = await setupFixture();
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, now.day);
      final updates = endpoints.order.watchBoard(
        setup.ownerSession,
        setup.building.id,
        createdFrom: start,
        createdTo: start.add(const Duration(days: 1)),
      );
      final iterator = StreamIterator(updates);
      addTearDown(iterator.cancel);
      while (true) {
        expect(
          await iterator.moveNext().timeout(const Duration(seconds: 10)),
          isTrue,
        );
        if (iterator.current.kind == OrderBoardEventKind.synced) {
          break;
        }
      }

      final opened = iterator.moveNext();
      final created = await endpoints.order.create(
        setup.ownerSession,
        OrderCreate(
          buildingId: setup.building.id,
          venueTableId: setup.table.id,
          items: [OrderItemCreateLine(articleId: setup.article.id)],
        ),
      );
      expect(
        await opened.timeout(const Duration(seconds: 10)),
        isTrue,
      );
      expect(iterator.current.kind, OrderBoardEventKind.orderOpened);
      expect(iterator.current.order?.id, created.id);
      expect(iterator.current.itemIds, [created.items.single.id]);

      final added = iterator.moveNext();
      await endpoints.order.addItems(
        setup.ownerSession,
        OrderAddItems(
          orderId: created.id,
          items: [OrderItemCreateLine(articleId: setup.article.id)],
        ),
      );
      expect(
        await added.timeout(const Duration(seconds: 10)),
        isTrue,
      );
      expect(iterator.current.kind, OrderBoardEventKind.itemsAdded);
      expect(iterator.current.itemIds, hasLength(1));
      expect(iterator.current.order?.items, hasLength(2));
    });

    test('board snapshot keeps only tickets created today', () async {
      final setup = await setupFixture();
      final todayOrder = await endpoints.order.create(
        setup.ownerSession,
        OrderCreate(
          buildingId: setup.building.id,
          venueTableId: setup.table.id,
          items: [OrderItemCreateLine(articleId: setup.article.id)],
        ),
      );
      final olderOrder = await endpoints.order.create(
        setup.ownerSession,
        OrderCreate(
          buildingId: setup.building.id,
          venueTableId: null,
          items: [OrderItemCreateLine(articleId: setup.article.id)],
        ),
      );
      final db = sessionBuilder.build();
      final olderRow = await VenueOrder.db.findById(db, olderOrder.id);
      final start = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
      await VenueOrder.db.updateRow(
        db,
        olderRow!.copyWith(
          createdAt: DateTime(start.year, start.month, start.day - 1),
        ),
      );

      final updates = endpoints.order.watchBoard(
        setup.ownerSession,
        setup.building.id,
        createdFrom: start,
        createdTo: DateTime(start.year, start.month, start.day + 1),
      );
      final iterator = StreamIterator(updates);
      addTearDown(iterator.cancel);
      final seen = <UuidValue>[];
      while (true) {
        expect(
          await iterator.moveNext().timeout(const Duration(seconds: 10)),
          isTrue,
        );
        if (iterator.current.kind == OrderBoardEventKind.synced) {
          break;
        }
        final id = iterator.current.order?.id;
        if (id != null) {
          seen.add(id);
        }
      }
      expect(seen, [todayOrder.id]);
    });

    test(
      'day window applies for every caller',
      () async {
        final auth = await endpoints.ownerAuth.register(
          sessionBuilder,
          EmailRegisterCreate(
            email: 'order-day-owner@example.com',
            password: 'password1',
            phoneNumber: '+21621110991',
            firstName: 'Day',
            lastName: 'Owner',
          ),
        );
        final ownerSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            auth.owner!.id.uuid,
            {Scope('sip.owner')},
            authId: UuidValue.fromString(
              '00000000-0000-7000-8000-000000000091',
            ).uuid,
          ),
        );
        final building = await endpoints.building.create(
          ownerSession,
          BuildingCreate(
            name: 'Day House',
            type: 'cafe',
            address: '9 Day St',
            latitude: 36.8,
            longitude: 10.1,
            openingMinutes: 480,
            closingMinutes: 1380,
            phoneNumber: '+21671100091',
            otherLinks: const [],
            currencyCode: 'TND',
            strictModeSteps: [],
          ),
        );
        final db = sessionBuilder.build();
        await PackCatalog.assignCode(db, building.id, 'floor');
        final buildingRow = await Building.db.findById(db, building.id);
        await Building.db.updateRow(
          db,
          buildingRow!.copyWith(tableMultiOrder: true),
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
        final line = OrderItemCreateLine(articleId: article.id);
        final todayOrder = await endpoints.order.create(
          ownerSession,
          OrderCreate(
            buildingId: building.id,
            venueTableId: tables.first.id,
            items: [line],
          ),
        );
        final olderOrder = await endpoints.order.create(
          ownerSession,
          OrderCreate(
            buildingId: building.id,
            venueTableId: tables.first.id,
            items: [line],
          ),
        );
        final start = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        );
        DateTime addDays(int days) =>
            DateTime(start.year, start.month, start.day + days);
        final olderRow = await VenueOrder.db.findById(db, olderOrder.id);
        await VenueOrder.db.updateRow(
          db,
          olderRow!.copyWith(createdAt: addDays(-5)),
        );

        final todayPage = await endpoints.order.list(
          ownerSession,
          building.id,
          null,
          createdFrom: start,
          createdTo: addDays(1),
        );
        expect(todayPage.items.map((order) => order.id), [todayOrder.id]);

        final last3 = await endpoints.order.list(
          ownerSession,
          building.id,
          null,
          createdFrom: addDays(-2),
          createdTo: addDays(1),
        );
        expect(last3.items.map((order) => order.id), [todayOrder.id]);

        final lastWeek = await endpoints.order.list(
          ownerSession,
          building.id,
          null,
          createdFrom: addDays(-6),
          createdTo: addDays(1),
        );
        expect(
          lastWeek.items.map((order) => order.id).toSet(),
          {todayOrder.id, olderOrder.id},
        );

        final allDays = await endpoints.order.list(
          ownerSession,
          building.id,
          null,
        );
        expect(allDays.total, 2);

        await expectLater(
          endpoints.order.list(
            ownerSession,
            building.id,
            null,
            createdFrom: addDays(1),
            createdTo: start,
          ),
          throwsA(
            isA<OrderException>().having(
              (error) => error.code,
              'code',
              OrderErrorCode.invalidInput,
            ),
          ),
        );
        await expectLater(
          endpoints.order.list(
            ownerSession,
            building.id,
            null,
            createdFrom: addDays(-9),
            createdTo: addDays(1),
          ),
          throwsA(
            isA<OrderException>().having(
              (error) => error.code,
              'code',
              OrderErrorCode.invalidInput,
            ),
          ),
        );

        final restrictedAccess = await endpoints.employeeAccess.create(
          ownerSession,
          EmployeeAccessCreate(
            buildingId: building.id,
            name: 'Own tickets',
            orderCreation: true,
            orderPayment: false,
            cancelOrder: false,
            preparation: false,
            serving: false,
            consultAllOrders: false,
          ),
        );
        final restrictedEmployee = await endpoints.employee.add(
          ownerSession,
          EmployeeCreate(
            password: 'password1',
            phoneNumber: '+21621110992',
            firstName: 'Own',
            lastName: 'Tickets',
            buildingId: building.id,
            accessId: restrictedAccess.id,
          ),
        );
        final restrictedLogin = await endpoints.employeeAuth.login(
          sessionBuilder,
          UsernameLoginRequest(
            username: restrictedEmployee.username,
            password: 'password1',
          ),
        );
        final restrictedSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            restrictedLogin.employee!.id.uuid,
            {Scope('sip.employee')},
            authId: 'test-session-order-day-restricted',
          ),
        );
        final ownOrder = await endpoints.order.create(
          restrictedSession,
          OrderCreate(
            buildingId: building.id,
            venueTableId: tables.first.id,
            items: [line],
          ),
        );
        final ownRow = await VenueOrder.db.findById(db, ownOrder.id);
        await VenueOrder.db.updateRow(
          db,
          ownRow!.copyWith(createdAt: addDays(-5)),
        );
        final ownToday = await endpoints.order.list(
          restrictedSession,
          building.id,
          null,
          createdFrom: start,
          createdTo: addDays(1),
        );
        expect(ownToday.items, isEmpty);
        final ownWeek = await endpoints.order.list(
          restrictedSession,
          building.id,
          null,
          createdFrom: addDays(-6),
          createdTo: addDays(1),
        );
        expect(ownWeek.items.map((order) => order.id), [ownOrder.id]);

        final consultAccess = await endpoints.employeeAccess.create(
          ownerSession,
          EmployeeAccessCreate(
            buildingId: building.id,
            name: 'All tickets',
            orderCreation: true,
            orderPayment: false,
            cancelOrder: false,
            preparation: false,
            serving: false,
            consultAllOrders: true,
          ),
        );
        final consultEmployee = await endpoints.employee.add(
          ownerSession,
          EmployeeCreate(
            password: 'password1',
            phoneNumber: '+21621110993',
            firstName: 'All',
            lastName: 'Tickets',
            buildingId: building.id,
            accessId: consultAccess.id,
          ),
        );
        final consultLogin = await endpoints.employeeAuth.login(
          sessionBuilder,
          UsernameLoginRequest(
            username: consultEmployee.username,
            password: 'password1',
          ),
        );
        final consultSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            consultLogin.employee!.id.uuid,
            {Scope('sip.employee')},
            authId: 'test-session-order-day-consult',
          ),
        );
        final consultToday = await endpoints.order.list(
          consultSession,
          building.id,
          null,
          createdFrom: start,
          createdTo: addDays(1),
        );
        expect(consultToday.items.map((order) => order.id), [todayOrder.id]);
      },
    );
  });
}
