import 'dart:async';

import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:sip_sync_server/src/packs/pack_catalog.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given a cash register', (sessionBuilder, endpoints) {
    Future<
      ({
        dynamic ownerSession,
        BuildingView building,
        VenueTableView table,
        MenuArticleView article,
      })
    >
    seedVenue({String pack = 'floor'}) async {
      final auth = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'register-owner@example.com',
          password: 'password1',
          phoneNumber: '+21621118001',
          firstName: 'Register',
          lastName: 'Owner',
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          auth.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: UuidValue.fromString(
            '00000000-0000-7000-8000-0000000000c1',
          ).uuid,
        ),
      );
      final created = await endpoints.building.create(
        ownerSession,
        BuildingCreate(
          name: 'Register House',
          type: 'cafe',
          address: '1 Register St',
          latitude: 36.8,
          longitude: 10.1,
          openingMinutes: 480,
          closingMinutes: 1380,
          phoneNumber: '+21671118001',
          otherLinks: const [],
          currencyCode: 'TND',
          strictModeSteps: [],
        ),
      );
      await PackCatalog.assignCode(sessionBuilder.build(), created.id, pack);
      final building = await endpoints.building.get(ownerSession, created.id);
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
        MenuCategoryCreate(buildingId: building.id, name: 'Coffee'),
      );
      final article = await endpoints.menuArticle.create(
        ownerSession,
        MenuArticleCreate(
          buildingId: building.id,
          categoryId: category.id,
          name: 'Espresso',
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

    BuildingUpdate enable(BuildingView building, {required bool on}) {
      return BuildingUpdate(
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
        cashRegisterEnabled: on,
      );
    }

    Future<OrderView> place(
      dynamic ownerSession,
      BuildingView building,
      VenueTableView table,
      MenuArticleView article,
    ) {
      return endpoints.order.create(
        ownerSession,
        OrderCreate(
          buildingId: building.id,
          venueTableId: table.id,
          items: [OrderItemCreateLine(articleId: article.id)],
        ),
      );
    }

    test('free pack rejects turning the register on', () async {
      final fixture = await seedVenue(pack: 'free');
      await expectLater(
        endpoints.building.update(
          fixture.ownerSession,
          enable(fixture.building, on: true),
        ),
        throwsA(
          isA<PackException>().having(
            (error) => error.feature,
            'feature',
            PackFeature.cashRegister,
          ),
        ),
      );
    });

    test('a shut register blocks orders and zeros the dashboard', () async {
      final fixture = await seedVenue();
      final before = await place(
        fixture.ownerSession,
        fixture.building,
        fixture.table,
        fixture.article,
      );
      expect(before.cashRegisterSessionId, isNull);

      final venue = await endpoints.building.update(
        fixture.ownerSession,
        enable(fixture.building, on: true),
      );
      expect(venue.cashRegisterEnabled, isTrue);
      await expectLater(
        place(fixture.ownerSession, venue, fixture.table, fixture.article),
        throwsA(
          isA<OrderException>().having(
            (error) => error.code,
            'code',
            OrderErrorCode.registerRequired,
          ),
        ),
      );
      await expectLater(
        endpoints.order.updateItemStatus(
          fixture.ownerSession,
          OrderItemStatusUpdate(
            id: before.items.first.id,
            status: OrderItemStatus.payed,
          ),
        ),
        throwsA(
          isA<OrderException>().having(
            (error) => error.code,
            'code',
            OrderErrorCode.registerRequired,
          ),
        ),
      );

      final day = DateTime.utc(
        DateTime.now().toUtc().year,
        DateTime.now().toUtc().month,
        DateTime.now().toUtc().day,
      );
      final summary = await endpoints.dashboard.summary(
        fixture.ownerSession,
        venue.id,
        day,
      );
      expect(summary.orderTotal, 0);
      expect(summary.itemsProgress, 0);
    });

    test(
      'open stamps new tickets, scopes the board, and close waits for them',
      () async {
        final fixture = await seedVenue();
        final venue = await endpoints.building.update(
          fixture.ownerSession,
          enable(fixture.building, on: true),
        );
        final waiter = await endpoints.employeeAccess.create(
          fixture.ownerSession,
          EmployeeAccessCreate(
            buildingId: venue.id,
            name: 'Floor',
            orderCreation: true,
            orderPayment: true,
            cancelOrder: true,
            preparation: false,
            serving: false,
            consultAllOrders: false,
          ),
        );
        expect(waiter.cashRegister, isFalse);
        final staff = await endpoints.employee.add(
          fixture.ownerSession,
          EmployeeCreate(
            password: 'password1',
            phoneNumber: '+21621118002',
            firstName: 'No',
            lastName: 'Drawer',
            buildingId: venue.id,
            accessId: waiter.id,
          ),
        );
        final staffSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            staff.id.uuid,
            {Scope('sip.employee')},
            authId: UuidValue.fromString(
              '00000000-0000-7000-8000-0000000000c2',
            ).uuid,
          ),
        );
        await expectLater(
          endpoints.cashRegister.open(staffSession, venue.id),
          throwsA(
            isA<CashRegisterException>().having(
              (error) => error.code,
              'code',
              CashRegisterErrorCode.notAuthorized,
            ),
          ),
        );

        final opened = await endpoints.cashRegister.open(
          fixture.ownerSession,
          venue.id,
        );
        expect(opened.status, CashRegisterStatus.progress);
        expect(opened.openedBy.firstName, 'Register');
        expect(
          await endpoints.cashRegister.current(staffSession, venue.id),
          isNotNull,
        );
        await expectLater(
          endpoints.cashRegister.open(fixture.ownerSession, venue.id),
          throwsA(
            isA<CashRegisterException>().having(
              (error) => error.code,
              'code',
              CashRegisterErrorCode.registerAlreadyOpen,
            ),
          ),
        );

        final ticket = await place(
          fixture.ownerSession,
          venue,
          fixture.table,
          fixture.article,
        );
        expect(ticket.cashRegisterSessionId, opened.id);

        final day = DateTime.utc(
          DateTime.now().toUtc().year,
          DateTime.now().toUtc().month,
          DateTime.now().toUtc().day,
        );
        final summary = await endpoints.dashboard.summary(
          fixture.ownerSession,
          venue.id,
          day,
        );
        expect(summary.orderTotal, 1);
        expect(summary.ordersProgress, 1);

        final listed = await endpoints.order.list(
          fixture.ownerSession,
          venue.id,
          null,
          cashRegisterSessionId: opened.id,
        );
        expect(listed.items.map((row) => row.id), [ticket.id]);

        final updates = endpoints.order.watchBoard(
          fixture.ownerSession,
          venue.id,
          cashRegisterSessionId: opened.id,
        );
        final iterator = StreamIterator(updates);
        addTearDown(iterator.cancel);
        final seen = <UuidValue>[];
        while (true) {
          expect(
            await iterator.moveNext().timeout(const Duration(seconds: 10)),
            isTrue,
          );
          final event = iterator.current;
          if (event.kind == OrderBoardEventKind.snapshot &&
              event.order != null) {
            seen.add(event.order!.id);
          }
          if (event.kind == OrderBoardEventKind.synced) {
            break;
          }
        }
        expect(seen, contains(ticket.id));

        await expectLater(
          endpoints.cashRegister.close(fixture.ownerSession, opened.id),
          throwsA(
            isA<CashRegisterException>().having(
              (error) => error.code,
              'code',
              CashRegisterErrorCode.registerHasOpenOrders,
            ),
          ),
        );

        await endpoints.order.updateItemStatus(
          fixture.ownerSession,
          OrderItemStatusUpdate(
            id: ticket.items.first.id,
            status: OrderItemStatus.payed,
          ),
        );
        final closed = await endpoints.cashRegister.close(
          fixture.ownerSession,
          opened.id,
        );
        expect(closed.status, CashRegisterStatus.closed);
        expect(closed.orderCount, 1);
        expect(closed.closedBy?.firstName, 'Register');
        expect(
          await endpoints.cashRegister.current(fixture.ownerSession, venue.id),
          isNull,
        );

        final history = await endpoints.cashRegister.list(
          fixture.ownerSession,
          venue.id,
        );
        expect(history.total, 1);
        expect(history.items.single.id, opened.id);
      },
    );

    test('gerant can open the register', () async {
      final fixture = await seedVenue();
      final venue = await endpoints.building.update(
        fixture.ownerSession,
        enable(fixture.building, on: true),
      );
      final profiles = (await endpoints.employeeAccess.list(
        fixture.ownerSession,
        venue.id,
      )).items;
      final gerant = profiles.firstWhere((row) => row.name == 'Gerant');
      expect(gerant.cashRegister, isTrue);
      final staff = await endpoints.employee.add(
        fixture.ownerSession,
        EmployeeCreate(
          password: 'password1',
          phoneNumber: '+21621118003',
          firstName: 'Floor',
          lastName: 'Lead',
          buildingId: venue.id,
          accessId: gerant.id,
        ),
      );
      final staffSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          staff.id.uuid,
          {Scope('sip.employee')},
          authId: UuidValue.fromString(
            '00000000-0000-7000-8000-0000000000c3',
          ).uuid,
        ),
      );
      final opened = await endpoints.cashRegister.open(staffSession, venue.id);
      expect(opened.openedBy.lastName, 'Lead');
    });

    test('opening and closing cash can be left blank', () async {
      final fixture = await seedVenue();
      final venue = await endpoints.building.update(
        fixture.ownerSession,
        enable(fixture.building, on: true),
      );
      await expectLater(
        endpoints.cashRegister.open(
          fixture.ownerSession,
          venue.id,
          startCash: -1,
        ),
        throwsA(
          isA<CashRegisterException>().having(
            (error) => error.code,
            'code',
            CashRegisterErrorCode.invalidAmount,
          ),
        ),
      );

      final opened = await endpoints.cashRegister.open(
        fixture.ownerSession,
        venue.id,
        startCash: 40.5,
      );
      expect(opened.startCash, 40.5);
      expect(opened.endCash, isNull);
      expect(
        (await endpoints.cashRegister.current(
          fixture.ownerSession,
          venue.id,
        ))?.startCash,
        40.5,
      );

      await expectLater(
        endpoints.cashRegister.close(
          fixture.ownerSession,
          opened.id,
          endCash: -2,
        ),
        throwsA(
          isA<CashRegisterException>().having(
            (error) => error.code,
            'code',
            CashRegisterErrorCode.invalidAmount,
          ),
        ),
      );

      await expectLater(
        endpoints.cashRegister.close(fixture.ownerSession, opened.id),
        throwsA(
          isA<CashRegisterException>().having(
            (error) => error.code,
            'code',
            CashRegisterErrorCode.endCashRequired,
          ),
        ),
      );
      final closed = await endpoints.cashRegister.close(
        fixture.ownerSession,
        opened.id,
        endCash: 40.5,
      );
      expect(closed.startCash, 40.5);
      expect(closed.endCash, 40.5);

      final second = await endpoints.cashRegister.open(
        fixture.ownerSession,
        venue.id,
      );
      expect(second.startCash, isNull);
      final counted = await endpoints.cashRegister.close(
        fixture.ownerSession,
        second.id,
        endCash: 12,
      );
      expect(counted.startCash, isNull);
      expect(counted.endCash, 12);
    });

    test('closing cash is required after an opening count', () async {
      final fixture = await seedVenue();
      final venue = await endpoints.building.update(
        fixture.ownerSession,
        enable(fixture.building, on: true),
      );
      final opened = await endpoints.cashRegister.open(
        fixture.ownerSession,
        venue.id,
        startCash: 10,
      );
      final ticket = await place(
        fixture.ownerSession,
        venue,
        fixture.table,
        fixture.article,
      );
      await endpoints.order.updateItemStatus(
        fixture.ownerSession,
        OrderItemStatusUpdate(
          id: ticket.items.first.id,
          status: OrderItemStatus.payed,
        ),
      );

      await expectLater(
        endpoints.cashRegister.close(fixture.ownerSession, opened.id),
        throwsA(
          isA<CashRegisterException>().having(
            (error) => error.code,
            'code',
            CashRegisterErrorCode.endCashRequired,
          ),
        ),
      );

      final closed = await endpoints.cashRegister.close(
        fixture.ownerSession,
        opened.id,
        endCash: 13.5,
      );
      expect(closed.paidTotal, 3.5);
      expect(closed.startCash, 10);
      expect(closed.endCash, 13.5);

      final profiles = (await endpoints.employeeAccess.list(
        fixture.ownerSession,
        venue.id,
      )).items;
      final gerant = profiles.firstWhere((row) => row.name == 'Gerant');
      final staff = await endpoints.employee.add(
        fixture.ownerSession,
        EmployeeCreate(
          password: 'password1',
          phoneNumber: '+21621118004',
          firstName: 'Floor',
          lastName: 'Lead',
          buildingId: venue.id,
          accessId: gerant.id,
        ),
      );
      final staffSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          staff.id.uuid,
          {Scope('sip.employee')},
          authId: UuidValue.fromString(
            '00000000-0000-7000-8000-0000000000c4',
          ).uuid,
        ),
      );
      await expectLater(
        endpoints.cashRegister.correct(
          staffSession,
          closed.id,
          startCash: 11,
          endCash: 14.5,
        ),
        throwsA(
          isA<CashRegisterException>().having(
            (error) => error.code,
            'code',
            CashRegisterErrorCode.notAuthorized,
          ),
        ),
      );

      final fixed = await endpoints.cashRegister.correct(
        fixture.ownerSession,
        closed.id,
        startCash: 10,
        endCash: 15,
      );
      expect(fixed.endCash, 15);
      expect(fixed.paidTotal, 3.5);

      final now = DateTime.now();
      final start = DateTime(now.year, now.month, now.day);
      final today = await endpoints.cashRegister.list(
        fixture.ownerSession,
        venue.id,
        openedFrom: start,
        openedTo: DateTime(start.year, start.month, start.day + 1),
      );
      expect(today.items.map((row) => row.id), contains(opened.id));
      final yesterday = await endpoints.cashRegister.list(
        fixture.ownerSession,
        venue.id,
        openedFrom: start.subtract(const Duration(days: 1)),
        openedTo: start,
      );
      expect(yesterday.total, 0);
    });
  });
}
