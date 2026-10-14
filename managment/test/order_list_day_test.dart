import 'package:flutter_test/flutter_test.dart';
import 'package:managment/features/orders/order_list_day.dart';

void main() {
  test('day windows are today, three days, seven days, and one picked day', () {
    final now = DateTime(2026, 10, 14, 15, 30);
    final today = orderListDayWindow(const OrderListDaySelection.today(), now);
    expect(today.from, DateTime(2026, 10, 14));
    expect(today.to, DateTime(2026, 10, 15));

    final three = orderListDayWindow(
      const OrderListDaySelection.last3Days(),
      now,
    );
    expect(three.from, DateTime(2026, 10, 12));
    expect(three.to, DateTime(2026, 10, 15));

    final week = orderListDayWindow(
      const OrderListDaySelection.lastWeek(),
      now,
    );
    expect(week.from, DateTime(2026, 10, 8));
    expect(week.to, DateTime(2026, 10, 15));

    final picked = orderListDayWindow(
      OrderListDaySelection.day(DateTime(2026, 10, 2, 18)),
      now,
    );
    expect(picked.from, DateTime(2026, 10, 2));
    expect(picked.to, DateTime(2026, 10, 3));
  });
}
