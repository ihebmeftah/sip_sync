import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:sip_sync_server/src/packs/pack_catalog.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given reservations', (sessionBuilder, endpoints) {
    Future<
      ({
        dynamic ownerSession,
        BuildingView building,
        List<VenueTableView> tables,
        MenuArticleView article,
      })
    >
    openHouse({
      required String tag,
      required String pack,
      required String ownerPhone,
      required String venuePhone,
    }) async {
      final auth = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: '$tag-owner@example.com',
          password: 'password1',
          phoneNumber: ownerPhone,
          firstName: 'Owner',
          lastName: tag,
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          auth.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: 'reservation-$tag-owner',
        ),
      );
      final building = await endpoints.building.create(
        ownerSession,
        BuildingCreate(
          name: '$tag House',
          type: 'cafe',
          address: '1 Reserve St',
          latitude: 36.8,
          longitude: 10.1,
          openingMinutes: 480,
          closingMinutes: 1380,
          phoneNumber: venuePhone,
          otherLinks: const [],
          currencyCode: 'TND',
          strictModeSteps: [],
          reservationFee: 15,
        ),
      );
      if (pack != 'free') {
        await PackCatalog.assignCode(
          sessionBuilder.build(),
          building.id,
          pack,
        );
      }
      final tables = await endpoints.venueTable.create(
        ownerSession,
        VenueTableCreate(
          buildingId: building.id,
          count: 2,
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
        tables: tables,
        article: article,
      );
    }

    ReservationCreate booking({
      required UuidValue buildingId,
      required UuidValue tableId,
      required DateTime start,
      String guestName = 'Ada',
      double paidAmount = 15,
      Duration length = const Duration(hours: 1),
    }) {
      return ReservationCreate(
        buildingId: buildingId,
        tableIds: [tableId],
        startsAt: start,
        endsAt: start.add(length),
        guestName: guestName,
        guestPhone: '+21620000001',
        paidAmount: paidAmount,
      );
    }

    test('free pack rejects a booking', () async {
      final setup = await openHouse(
        tag: 'free',
        pack: 'free',
        ownerPhone: '+21622111001',
        venuePhone: '+21671111011',
      );
      final start = DateTime.now().toUtc().add(const Duration(hours: 2));
      await expectLater(
        endpoints.reservation.create(
          setup.ownerSession,
          booking(
            buildingId: setup.building.id,
            tableId: setup.tables.first.id,
            start: start,
          ),
        ),
        throwsA(
          isA<PackException>().having(
            (error) => error.code,
            'code',
            PackErrorCode.featureOff,
          ),
        ),
      );
    });

    test(
      'owner books a guest, overlap is rejected, and soon does not hold orders',
      () async {
        final setup = await openHouse(
          tag: 'floor',
          pack: 'floor',
          ownerPhone: '+21622111002',
          venuePhone: '+21671111012',
        );
        final start = DateTime.now().toUtc().add(const Duration(minutes: 10));
        final created = await endpoints.reservation.create(
          setup.ownerSession,
          booking(
            buildingId: setup.building.id,
            tableId: setup.tables.first.id,
            start: start,
          ),
        );
        expect(created.status, ReservationStatus.booked);
        expect(created.guestName, 'Ada');
        expect(created.paidAmount, 15);
        expect(created.tableNumbers, [setup.tables.first.number]);

        final listed = await endpoints.reservation.listForDay(
          setup.ownerSession,
          setup.building.id,
          start,
        );
        expect(listed.map((row) => row.id), contains(created.id));

        final tables = await endpoints.venueTable.list(
          setup.ownerSession,
          setup.building.id,
          TableListFilter.all,
        );
        final marked = tables.firstWhere(
          (row) => row.id == setup.tables.first.id,
        );
        expect(marked.status, TableFloorStatus.reserved);
        expect(marked.reservationPhase, ReservationPhase.soon);
        expect(marked.reservationGuest, 'Ada');

        final order = await endpoints.order.create(
          setup.ownerSession,
          OrderCreate(
            buildingId: setup.building.id,
            venueTableId: setup.tables.first.id,
            items: [OrderItemCreateLine(articleId: setup.article.id)],
          ),
        );
        expect(order.status, OrderStatus.progress);

        await expectLater(
          endpoints.reservation.create(
            setup.ownerSession,
            booking(
              buildingId: setup.building.id,
              tableId: setup.tables.first.id,
              start: start.add(const Duration(minutes: 15)),
              guestName: 'Bea',
            ),
          ),
          throwsA(
            isA<ReservationException>().having(
              (error) => error.code,
              'code',
              ReservationErrorCode.overlap,
            ),
          ),
        );
      },
    );

    test(
      'a started booking blocks orders until staff scan confirms arrival',
      () async {
        final setup = await openHouse(
          tag: 'hold',
          pack: 'floor',
          ownerPhone: '+21622111003',
          venuePhone: '+21671111013',
        );
        final start = DateTime.now().toUtc().subtract(
          const Duration(minutes: 5),
        );
        await endpoints.reservation.create(
          setup.ownerSession,
          booking(
            buildingId: setup.building.id,
            tableId: setup.tables.first.id,
            start: start,
          ),
        );
        await expectLater(
          endpoints.order.create(
            setup.ownerSession,
            OrderCreate(
              buildingId: setup.building.id,
              venueTableId: setup.tables.first.id,
              items: [OrderItemCreateLine(articleId: setup.article.id)],
            ),
          ),
          throwsA(
            isA<OrderException>().having(
              (error) => error.code,
              'code',
              OrderErrorCode.reservationHeld,
            ),
          ),
        );

        final confirmed = await endpoints.reservation.confirmByTable(
          setup.ownerSession,
          setup.building.id,
          setup.tables.first.id,
        );
        expect(confirmed.status, ReservationStatus.arrived);

        final order = await endpoints.order.create(
          setup.ownerSession,
          OrderCreate(
            buildingId: setup.building.id,
            venueTableId: setup.tables.first.id,
            items: [OrderItemCreateLine(articleId: setup.article.id)],
          ),
        );
        expect(order.status, OrderStatus.progress);
      },
    );

    test('customer books and cancels their own future row', () async {
      final setup = await openHouse(
        tag: 'guest',
        pack: 'floor',
        ownerPhone: '+21622111004',
        venuePhone: '+21671111014',
      );
      final auth = await endpoints.customerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'guest-book@example.com',
          password: 'password1',
          phoneNumber: '+21623330001',
          firstName: 'Guest',
          lastName: 'Book',
        ),
      );
      final customerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          auth.customer!.id.uuid,
          {Scope('sip.customer')},
          authId: 'reservation-guest-customer',
        ),
      );
      final start = DateTime.now().toUtc().add(const Duration(hours: 3));
      final created = await endpoints.reservation.createForCustomer(
        customerSession,
        CustomerReservationCreate(
          buildingId: setup.building.id,
          tableIds: [setup.tables.last.id],
          startsAt: start,
          endsAt: start.add(const Duration(hours: 1)),
        ),
      );
      expect(created.paidAmount, 0);
      expect(created.guestName, 'Guest Book');
      expect(created.customerId, auth.customer!.id);

      await expectLater(
        endpoints.reservation.confirmByTable(
          customerSession,
          setup.building.id,
          setup.tables.last.id,
        ),
        throwsA(isA<ReservationException>()),
      );

      final cancelled = await endpoints.reservation.cancel(
        customerSession,
        created.id,
      );
      expect(cancelled.status, ReservationStatus.cancelled);
    });

    test('employee without the flag cannot book', () async {
      final setup = await openHouse(
        tag: 'staff',
        pack: 'floor',
        ownerPhone: '+21622111005',
        venuePhone: '+21671111015',
      );
      final access = await endpoints.employeeAccess.create(
        setup.ownerSession,
        EmployeeAccessCreate(
          buildingId: setup.building.id,
          name: 'Viewer',
          orderCreation: true,
          orderPayment: false,
          cancelOrder: false,
          preparation: false,
          serving: false,
          consultAllOrders: false,
        ),
      );
      expect(access.reservations, isFalse);
      final employee = await endpoints.employee.add(
        setup.ownerSession,
        EmployeeCreate(
          password: 'password1',
          phoneNumber: '+21624440001',
          firstName: 'View',
          lastName: 'Only',
          buildingId: setup.building.id,
          accessId: access.id,
        ),
      );
      final staffSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          employee.id.uuid,
          {Scope('sip.employee')},
          authId: 'reservation-staff',
        ),
      );
      final start = DateTime.now().toUtc().add(const Duration(hours: 4));
      await expectLater(
        endpoints.reservation.create(
          staffSession,
          booking(
            buildingId: setup.building.id,
            tableId: setup.tables.first.id,
            start: start,
          ),
        ),
        throwsA(
          isA<ReservationException>().having(
            (error) => error.code,
            'code',
            ReservationErrorCode.notAuthorized,
          ),
        ),
      );
    });

    test(
      'counter cap counts the UTC day and a passed end becomes no-show',
      () async {
        final setup = await openHouse(
          tag: 'cap',
          pack: 'counter',
          ownerPhone: '+21622111006',
          venuePhone: '+21671111016',
        );
        final tomorrow = DateTime.now().toUtc().add(const Duration(days: 1));
        final origin = DateTime.utc(
          tomorrow.year,
          tomorrow.month,
          tomorrow.day,
          8,
        );
        for (var index = 0; index < 8; index++) {
          final start = origin.add(Duration(minutes: 30 * index));
          await endpoints.reservation.create(
            setup.ownerSession,
            booking(
              buildingId: setup.building.id,
              tableId: setup.tables.first.id,
              start: start,
              guestName: 'Guest $index',
              length: const Duration(minutes: 30),
            ),
          );
        }
        await expectLater(
          endpoints.reservation.create(
            setup.ownerSession,
            booking(
              buildingId: setup.building.id,
              tableId: setup.tables.last.id,
              start: origin,
              guestName: 'Extra',
              length: const Duration(minutes: 30),
            ),
          ),
          throwsA(
            isA<PackException>().having(
              (error) => error.code,
              'code',
              PackErrorCode.limitReached,
            ),
          ),
        );

        final session = sessionBuilder.build();
        final rows = await Reservation.db.find(
          session,
          where: (table) => table.buildingId.equals(setup.building.id),
        );
        final first = rows.first;
        await Reservation.db.updateRow(
          session,
          first.copyWith(
            endsAt: DateTime.now().toUtc().subtract(const Duration(minutes: 1)),
          ),
        );
        final listed = await endpoints.reservation.listForDay(
          setup.ownerSession,
          setup.building.id,
          origin,
        );
        expect(
          listed.firstWhere((row) => row.id == first.id).status,
          ReservationStatus.noShow,
        );
      },
    );
  });
}
