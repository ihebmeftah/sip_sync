import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_sync_client/sip_sync_client.dart';
import 'package:sip_sync_flutter/core/di/app_providers.dart';
import 'package:sip_sync_flutter/data/repositories/customer_discovery_repository.dart';
import 'package:sip_sync_flutter/features/venue/view_models/customer_order_view_model.dart';
import 'package:sip_sync_flutter/features/venue/view_models/seated_table_view_model.dart';
import 'package:sip_sync_flutter/features/venue/views/order_review_view.dart';
import 'package:sip_sync_flutter/features/venue/views/venue_menu_view.dart';
import 'package:sip_sync_flutter/l10n/generated/app_localizations.dart';

const _id = '01990000-0000-7000-8000-000000000099';
const _article = '01990000-0000-7000-8000-000000000021';
const _table = '01990000-0000-7000-8000-000000000022';

void main() {
  testWidgets('menu selection opens a review that asks for a table', (
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
          builder: (_, _) =>
              const VenueMenuView(buildingId: _id, venueName: 'House Menu'),
        ),
        GoRoute(
          path: '/venues/:id/order',
          builder: (_, state) => OrderReviewView(
            buildingId: state.pathParameters['id']!,
            venueName: state.uri.queryParameters['venue-name'],
            currencyCode: state.uri.queryParameters['currency-code'] ?? '',
          ),
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

    await tester.tap(find.byTooltip('Add'));
    await tester.pumpAndSettle();
    expect(find.text('1 dish · 5.50 TND'), findsOneWidget);

    await tester.tap(find.byTooltip('Add'));
    await tester.pumpAndSettle();
    expect(find.text('2 dishes · 11.00 TND'), findsOneWidget);

    await tester.tap(find.byTooltip('Remove'));
    await tester.pumpAndSettle();
    expect(find.text('1 dish · 5.50 TND'), findsOneWidget);

    await tester.tap(find.text('Pass order'));
    await tester.pumpAndSettle();
    expect(
      find.text('Scan the QR code on your table to send this order.'),
      findsOneWidget,
    );

    container
        .read(seatedTableProvider.notifier)
        .sit(
          CustomerSeatedTable(
            buildingId: UuidValue.fromString(_id),
            tableId: UuidValue.fromString(_table),
            number: 2,
            maxSeats: 4,
            venueName: 'House Menu',
          ),
          announce: false,
        );
    await tester.pumpAndSettle();
    expect(find.text("You're at table 2"), findsOneWidget);
    expect(find.text('Pass order'), findsWidgets);
  });
}

class _Repo extends CustomerDiscoveryRepository {
  _Repo() : super(Client('http://127.0.0.1:8080/'));

  final _buildingId = UuidValue.fromString(_id);
  final _articleId = UuidValue.fromString(_article);

  @override
  Future<CustomerMenu> venueMenu(
    UuidValue buildingId, {
    int? limit,
    int? offset,
  }) async {
    return CustomerMenu(
      currencyCode: 'TND',
      sections: [
        CustomerMenuSection(
          id: _buildingId,
          name: 'Tea',
          description: '',
          articles: [
            CustomerArticlePreview(
              id: _articleId,
              categoryId: _buildingId,
              categoryName: 'Tea',
              name: 'Mint tea',
              description: '',
              price: 5.5,
              ingredientNames: const ['Mint'],
            ),
          ],
        ),
      ],
      customerOrdering: true,
      categories: const [],
      articles: const [],
      totalArticles: 0,
      limit: limit ?? 20,
      offset: offset ?? 0,
    );
  }
}
