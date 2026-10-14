import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:sip_sync_server/src/packs/pack_catalog.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given the management dashboard', (sessionBuilder, endpoints) {
    test(
      'counts today, pending requests, and ingredients out of stock',
      () async {
        final auth = await endpoints.ownerAuth.register(
          sessionBuilder,
          EmailRegisterCreate(
            email: 'dash-owner@example.com',
            password: 'password1',
            phoneNumber: '+21621114001',
            firstName: 'Dash',
            lastName: 'Owner',
          ),
        );
        final ownerSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            auth.owner!.id.uuid,
            {Scope('sip.owner')},
            authId: 'dashboard-owner',
          ),
        );
        final building = await endpoints.building.create(
          ownerSession,
          BuildingCreate(
            name: 'Dash House',
            type: 'cafe',
            address: '1 Dash St',
            latitude: 36.8,
            longitude: 10.1,
            openingMinutes: 480,
            closingMinutes: 1380,
            phoneNumber: '+21671114001',
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
            count: 3,
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
            price: 3,
          ),
        );

        final open = await endpoints.order.create(
          ownerSession,
          OrderCreate(
            buildingId: building.id,
            venueTableId: tables[0].id,
            items: [
              OrderItemCreateLine(articleId: article.id),
              OrderItemCreateLine(articleId: article.id),
            ],
          ),
        );
        final cancelled = await endpoints.order.create(
          ownerSession,
          OrderCreate(
            buildingId: building.id,
            venueTableId: tables[1].id,
            items: [OrderItemCreateLine(articleId: article.id)],
          ),
        );
        await endpoints.order.cancel(
          ownerSession,
          cancelled.id,
          OrderCancellationReason.customerRequest,
        );

        final customerAuth = await endpoints.customerAuth.register(
          sessionBuilder,
          EmailRegisterCreate(
            email: 'dash-guest@example.com',
            password: 'password1',
            phoneNumber: '+21621114002',
            firstName: 'Dash',
            lastName: 'Guest',
          ),
        );
        final customerSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            customerAuth.customer!.id.uuid,
            {Scope('sip.customer')},
            authId: 'dashboard-guest',
          ),
        );
        await endpoints.customerOrder.place(
          customerSession,
          CustomerOrderPlace(
            buildingId: building.id,
            tableId: tables[2].id,
            items: [CustomerOrderItem(articleId: article.id)],
          ),
        );

        final yesterday = DateTime.now().toUtc().subtract(
          const Duration(days: 2),
        );
        await VenueOrder.db.insertRow(
          sessionBuilder.build(),
          VenueOrder(
            buildingId: building.id,
            venueTableId: tables[0].id,
            ref: 90,
            status: OrderStatus.payed,
            launchedByType: ActorType.customer,
            launchedById: customerAuth.customer!.id,
            createdAt: yesterday,
            updatedAt: yesterday,
          ),
        );

        final slot = _slotToday();
        await endpoints.reservation.create(
          ownerSession,
          ReservationCreate(
            buildingId: building.id,
            startsAt: slot.starts,
            endsAt: slot.ends,
            guestName: 'Walk in',
            guestPhone: '+21620000011',
            paidAmount: 0,
          ),
        );
        await endpoints.reservation.createForCustomer(
          customerSession,
          CustomerReservationCreate(
            buildingId: building.id,
            startsAt: slot.starts,
            endsAt: slot.ends,
          ),
        );

        final low = await endpoints.ingredient.create(
          ownerSession,
          IngredientCreate(
            buildingId: building.id,
            name: 'Milk',
            unit: UnitsType.liter,
            currentStock: 100,
            thresholdStock: 5,
          ),
        );
        final exact = await endpoints.ingredient.create(
          ownerSession,
          IngredientCreate(
            buildingId: building.id,
            name: 'Sugar',
            unit: UnitsType.kilogram,
            currentStock: 100,
            thresholdStock: 5,
          ),
        );
        await endpoints.ingredient.create(
          ownerSession,
          IngredientCreate(
            buildingId: building.id,
            name: 'Water',
            unit: UnitsType.liter,
            currentStock: 50,
            thresholdStock: 5,
          ),
        );
        final db = sessionBuilder.build();
        final lowRow = await Ingredient.db.findById(db, low.id);
        final exactRow = await Ingredient.db.findById(db, exact.id);
        await Ingredient.db.updateRow(db, lowRow!.copyWith(currentStock: 0));
        await Ingredient.db.updateRow(db, exactRow!.copyWith(currentStock: 10));

        final summary = await endpoints.dashboard.summary(
          ownerSession,
          building.id,
          slot.day,
        );
        expect(summary.orderTotal, 3);
        expect(summary.ordersProgress, 2);
        expect(summary.ordersPayed, 0);
        expect(summary.ordersCancelled, 1);
        expect(summary.customerOrders, 1);
        expect(summary.itemsProgress, 3);
        expect(summary.itemsPicked, 0);
        expect(summary.itemsReady, 0);
        expect(summary.itemsServed, 0);
        expect(summary.itemsPayed, 0);
        expect(summary.itemsCancelled, 1);
        expect(summary.pendingReservations, 1);
        expect(summary.reservationsToday, 1);
        expect(summary.ingredientsToRestock, 1);
        expect(open.status, OrderStatus.progress);

        expect(
          () => endpoints.dashboard.summary(
            customerSession,
            building.id,
            slot.day,
          ),
          throwsA(isA<AccountException>()),
        );
      },
    );
  });
}

/// A start and end that stay on the current UTC day so settle does not close them.
({DateTime day, DateTime starts, DateTime ends}) _slotToday() {
  final now = DateTime.now().toUtc();
  final day = DateTime.utc(now.year, now.month, now.day);
  final endOfDay = day.add(const Duration(days: 1));
  var starts = now.add(const Duration(minutes: 10));
  if (!starts.isBefore(endOfDay.subtract(const Duration(minutes: 1)))) {
    starts = now;
  }
  var ends = starts.add(const Duration(minutes: 30));
  if (!ends.isBefore(endOfDay)) {
    ends = endOfDay.subtract(const Duration(seconds: 1));
  }
  if (!ends.isAfter(starts)) {
    ends = starts.add(const Duration(seconds: 30));
  }
  return (day: day, starts: starts, ends: ends);
}
