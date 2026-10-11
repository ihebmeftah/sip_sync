import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_sync_client/sip_sync_client.dart';
import 'package:sip_sync_flutter/core/di/app_providers.dart';
import 'package:sip_sync_flutter/core/theme/app_icons.dart';
import 'package:sip_sync_flutter/data/repositories/customer_discovery_repository.dart';
import 'package:sip_sync_flutter/features/venue/view_models/customer_order_view_model.dart';
import 'package:sip_sync_flutter/features/venue/view_models/seated_table_view_model.dart';
import 'package:sip_sync_flutter/features/venue/views/venue_detail_view.dart';
import 'package:sip_sync_flutter/features/venue/views/venue_menu_view.dart';
import 'package:sip_sync_flutter/l10n/generated/app_localizations.dart';

const _id = '01990000-0000-7000-8000-000000000099';
const _table2 = '01990000-0000-7000-8000-000000000002';

void main() {
  testWidgets('venue page shows free tables, previews, and opens the menu', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 700));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const VenueDetailView(buildingId: _id),
        ),
        GoRoute(
          path: '/venues/:id/menu',
          builder: (_, state) => VenueMenuView(
            buildingId: state.pathParameters['id']!,
            venueName: state.uri.queryParameters['venue-name'],
          ),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(_app(router));
    await tester.pumpAndSettle();

    expect(find.text('House Menu'), findsOneWidget);
    expect(find.text('3 tables free'), findsOneWidget);
    expect(find.text('Table 2'), findsOneWidget);
    expect(find.text('Scan table'), findsNothing);
    await tester.scrollUntilVisible(
      find.text('01 Course with a long name'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('01 Course with a long name'), findsOneWidget);
    final categoryRail = find.byWidgetPredicate(
      (widget) =>
          widget is ListView && widget.scrollDirection == Axis.horizontal,
    );
    await tester.scrollUntilVisible(
      find.text('See all'),
      160,
      scrollable: find.descendant(
        of: categoryRail.first,
        matching: find.byType(Scrollable),
      ),
    );
    await tester.scrollUntilVisible(
      find.text('01 Plate with a long name'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('5.50 TND'), findsOneWidget);
    expect(find.text('Mint . Lemon'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Reserve now'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Take your place now'), findsNothing);
    expect(find.text('Reserve now'), findsOneWidget);

    await tester.tap(find.text('Menu'));
    await tester.pumpAndSettle();

    expect(find.text('House Menu'), findsOneWidget);
    expect(
      tester.getRect(find.text('Nothing in this section yet.')).top,
      greaterThan(700),
    );
    final chip = find.byKey(const ValueKey('menu-chip-5'));
    final rail = find.byWidgetPredicate(
      (widget) =>
          widget is ListView && widget.scrollDirection == Axis.horizontal,
    );
    for (var attempt = 0; attempt < 8; attempt++) {
      if (chip.evaluate().isNotEmpty) {
        final rect = tester.getRect(chip);
        if (rect.left >= 0 && rect.right <= 390) {
          break;
        }
      }
      await tester.drag(rail, const Offset(-140, 0));
      await tester.pumpAndSettle();
    }
    final chipRect = tester.getRect(chip);
    expect(chipRect.left, greaterThanOrEqualTo(0));
    expect(chipRect.right, lessThanOrEqualTo(390));
    await tester.tap(chip);
    await tester.pumpAndSettle();
    expect(
      tester.getRect(find.text('Nothing in this section yet.')).top,
      inInclusiveRange(0, 700),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('venue page lays out on a wide short window', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1100, 500));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _app(
        GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (_, _) => const VenueDetailView(buildingId: _id),
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('3 tables free'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a confirmed seat is marked and a change announces', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final container = ProviderContainer(
      overrides: [
        customerDiscoveryRepositoryProvider.overrideWith((ref) => _Repo()),
        openCustomerOrderProvider.overrideWith((ref) async => null),
      ],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const VenueDetailView(buildingId: _id),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          locale: const Locale('en'),
          routerConfig: router,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('3 tables free'), findsOneWidget);

    container
        .read(seatedTableProvider.notifier)
        .sit(
          CustomerSeatedTable(
            buildingId: UuidValue.fromString(_id),
            tableId: UuidValue.fromString(_table2),
            number: 2,
            maxSeats: 4,
            venueName: 'House Menu',
          ),
          announce: true,
        );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text("You're at table 2"), findsOneWidget);
    expect(
      find.text("Table changed. You're now at table 2."),
      findsOneWidget,
    );
    expect(find.text('Reserve now'), findsOneWidget);
  });

  testWidgets('an open order is shown and scan is disabled', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          customerDiscoveryRepositoryProvider.overrideWith((ref) => _Repo()),
          openCustomerOrderProvider.overrideWith((ref) async => _openOrder()),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          home: const VenueDetailView(buildingId: _id),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('The kitchen has your order'), findsOneWidget);
    expect(
      find.text('Follow each dish, right up to the moment you pay.'),
      findsOneWidget,
    );
    expect(find.text('6.50 TND'), findsWidgets);
    expect(find.text('Mint tea'), findsNothing);
    expect(find.text('Details'), findsOneWidget);
    expect(find.text('Current order'), findsNothing);
    expect(find.text('Order history'), findsNothing);
    expect(find.text('Take your place now'), findsNothing);
    expect(find.byTooltip('Back'), findsNothing);
    await tester.tap(find.byIcon(AppIcons.qrScan));
    await tester.pump();
    expect(
      find.text('Scan is unavailable while your order is open.'),
      findsOneWidget,
    );
  });
}

Widget _app(GoRouter router) {
  return ProviderScope(
    overrides: [
      customerDiscoveryRepositoryProvider.overrideWith((ref) => _Repo()),
      openCustomerOrderProvider.overrideWith((ref) async => null),
    ],
    child: MaterialApp.router(
      locale: const Locale('en'),
      routerConfig: router,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    ),
  );
}

CustomerOrderView _openOrder() {
  return CustomerOrderView(
    id: UuidValue.fromString('01990000-0000-7000-8000-000000000041'),
    buildingId: UuidValue.fromString(_id),
    ref: 4,
    tableNumber: 2,
    currencyCode: 'TND',
    status: OrderStatus.progress,
    lines: [
      CustomerOrderLine(
        id: UuidValue.fromString('01990000-0000-7000-8000-000000000042'),
        articleId: UuidValue.fromString('01990000-0000-7000-8000-000000000043'),
        name: 'Mint tea',
        unitPrice: 6.5,
        status: OrderItemStatus.progress,
      ),
    ],
    totalAmount: 6.5,
  );
}

class _Repo extends CustomerDiscoveryRepository {
  _Repo() : super(Client('http://127.0.0.1:8080/'));

  final _buildingId = UuidValue.fromString(_id);

  @override
  Future<CustomerVenueDetail> venueDetail(UuidValue buildingId) async {
    return CustomerVenueDetail(
      venue: CustomerVenueCard(
        id: buildingId,
        name: 'House Menu',
        type: 'cafe',
        address:
            '1 Rue de la Paix, a long street name that should stay on two lines',
        latitude: 36.8,
        longitude: 10.18,
        openingMinutes: 480,
        closingMinutes: 1320,
        phoneNumber: '+21671111001',
      ),
      currencyCode: 'TND',
      availableTableCount: 3,
      availableTables: [
        CustomerTablePreview(id: _buildingId, number: 1, maxSeats: 2),
        CustomerTablePreview(
          id: UuidValue.fromString(_table2),
          number: 2,
          maxSeats: 4,
        ),
        CustomerTablePreview(id: _buildingId, number: 4, maxSeats: 2),
      ],
      bookableTables: [
        CustomerTablePreview(id: _buildingId, number: 1, maxSeats: 2),
      ],
      categories: [
        for (var n = 1; n <= 5; n++)
          CustomerCategoryPreview(
            id: _buildingId,
            name: '0$n Course with a long name',
            description:
                'A description long enough to wrap and then ellipsize cleanly',
            articleCount: n,
          ),
      ],
      articles: [
        for (var n = 1; n <= 5; n++)
          CustomerArticlePreview(
            id: _buildingId,
            categoryId: _buildingId,
            categoryName: '0$n Course',
            name: '0$n Plate with a long name',
            description:
                'Soft description that should not overflow the preview card',
            price: 4.5 + n,
            ingredientNames: n == 1
                ? const ['Mint', 'Lemon']
                : const <String>[],
            outOfStockIngredientNames: const [],
          ),
      ],
      customerOrdering: true,
      orderingClosedByVenue: false,
      reservationsEnabled: false,
      reservationsClosedByVenue: false,
      reservationFee: 0,
    );
  }

  @override
  Future<CustomerMenu> venueMenu(
    UuidValue buildingId, {
    int? limit,
    int? offset,
  }) async {
    return CustomerMenu(
      currencyCode: 'TND',
      sections: [
        for (var n = 1; n <= 6; n++)
          CustomerMenuSection(
            id: UuidValue.fromString(
              '01990000-0000-7000-8000-00000000020$n',
            ),
            name: '0$n Course',
            description: 'Section note',
            articles: n == 6
                ? const []
                : [
                    for (var dish = 1; dish <= 3; dish++)
                      CustomerArticlePreview(
                        id: UuidValue.fromString(
                          '01990000-0000-7000-8000-0000000003$n$dish',
                        ),
                        categoryId: UuidValue.fromString(
                          '01990000-0000-7000-8000-00000000020$n',
                        ),
                        categoryName: '0$n Course',
                        name: 'Plate $n-$dish',
                        description:
                            'A longer description for the dish that sits on two lines',
                        price: 12.5,
                        ingredientNames: const [],
                        outOfStockIngredientNames: const [],
                      ),
                  ],
          ),
      ],
      customerOrdering: true,
      orderingClosedByVenue: false,
      categories: const [],
      articles: const [],
      totalArticles: 0,
      limit: limit ?? 20,
      offset: offset ?? 0,
    );
  }
}
