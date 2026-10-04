import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sip_sync_client/sip_sync_client.dart';
import 'package:sip_sync_flutter/core/di/app_providers.dart';
import 'package:sip_sync_flutter/data/repositories/customer_order_repository.dart';
import 'package:sip_sync_flutter/features/orders/order_history_range.dart';
import 'package:sip_sync_flutter/features/orders/views/customer_orders_view.dart';
import 'package:sip_sync_flutter/l10n/generated/app_localizations.dart';

void main() {
  test('history windows are today, seven days, and one month', () {
    final now = DateTime(2026, 3, 31, 15);
    expect(
      orderHistoryWindow(OrderHistoryFilter.today, now).from,
      DateTime(2026, 3, 31),
    );
    expect(
      orderHistoryWindow(OrderHistoryFilter.today, now).to,
      DateTime(2026, 4, 1),
    );
    final week = orderHistoryWindow(
      OrderHistoryFilter.week,
      DateTime(2026, 10, 2, 8),
    );
    expect(week.from, DateTime(2026, 9, 26));
    expect(week.to, DateTime(2026, 10, 3));
    expect(
      orderHistoryWindow(OrderHistoryFilter.month, now).from,
      DateTime(2026, 2, 28),
    );
  });

  testWidgets('orders tab lists this customer and switches the window', (
    tester,
  ) async {
    final repo = _Repo();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          customerOrderRepositoryProvider.overrideWith((ref) => repo),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Scaffold(body: CustomerOrdersView()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Last month'), findsOneWidget);
    expect(find.text('House Menu'), findsOneWidget);
    expect(find.textContaining('Order #4'), findsOneWidget);
    expect(find.textContaining('Table 2'), findsOneWidget);
    expect(find.text('13.00 TND'), findsOneWidget);
    expect(find.text('In progress'), findsOneWidget);
    expect(repo.calls, 1);

    await tester.tap(find.text('Today'));
    await tester.pumpAndSettle();
    expect(repo.calls, 2);
    final today = orderHistoryWindow(OrderHistoryFilter.today, DateTime.now());
    expect(repo.lastFrom, today.from);
    expect(repo.lastTo, today.to);
  });
}

class _Repo extends CustomerOrderRepository {
  _Repo() : super(Client('http://127.0.0.1:8080/'));

  var calls = 0;
  DateTime? lastFrom;
  DateTime? lastTo;

  @override
  Future<CustomerOrderView?> current() async => null;

  @override
  Future<CustomerOrderPage> list({
    required DateTime from,
    required DateTime to,
    int? limit,
    int? offset,
  }) async {
    calls += 1;
    lastFrom = from;
    lastTo = to;
    return CustomerOrderPage(
      items: [
        CustomerOrderSummary(
          id: UuidValue.fromString('01990000-0000-7000-8000-000000000031'),
          buildingId: UuidValue.fromString(
            '01990000-0000-7000-8000-000000000032',
          ),
          venueName: 'House Menu',
          ref: 4,
          tableNumber: 2,
          currencyCode: 'TND',
          status: OrderStatus.progress,
          itemCount: 2,
          totalAmount: 13,
          createdAt: DateTime.utc(2026, 10, 1, 18, 30),
        ),
      ],
      total: 1,
      limit: limit ?? 20,
      offset: offset ?? 0,
    );
  }
}
