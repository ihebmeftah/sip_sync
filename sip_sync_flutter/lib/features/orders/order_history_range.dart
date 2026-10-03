/// History tabs on the customer orders screen.
enum OrderHistoryFilter { today, week, month }

/// Inclusive [from] and exclusive [to], in local time.
class OrderHistoryWindow {
  const OrderHistoryWindow({required this.from, required this.to});

  final DateTime from;
  final DateTime to;
}

/// [OrderHistoryFilter.today] is the local calendar day.
///
/// Week is the seven local days ending today. Month runs from the same
/// local date one month ago through the end of today.
OrderHistoryWindow orderHistoryWindow(OrderHistoryFilter filter, DateTime now) {
  final local = now.toLocal();
  final startOfToday = DateTime(local.year, local.month, local.day);
  final end = startOfToday.add(const Duration(days: 1));
  final from = switch (filter) {
    OrderHistoryFilter.today => startOfToday,
    OrderHistoryFilter.week => startOfToday.subtract(const Duration(days: 6)),
    OrderHistoryFilter.month => _monthsBefore(startOfToday, 1),
  };
  return OrderHistoryWindow(from: from, to: end);
}

DateTime _monthsBefore(DateTime date, int months) {
  var year = date.year;
  var month = date.month - months;
  while (month < 1) {
    month += 12;
    year -= 1;
  }
  final lastDay = DateTime(year, month + 1, 0).day;
  final day = date.day > lastDay ? lastDay : date.day;
  return DateTime(year, month, day);
}
