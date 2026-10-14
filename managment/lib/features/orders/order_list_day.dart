/// Day chips on the staff order list.
enum OrderListDayPreset { today, last3Days, lastWeek, day }

/// Selected day chip. [day] is set only for [OrderListDayPreset.day].
class OrderListDaySelection {
  const OrderListDaySelection.today()
    : preset = OrderListDayPreset.today,
      day = null;

  const OrderListDaySelection.last3Days()
    : preset = OrderListDayPreset.last3Days,
      day = null;

  const OrderListDaySelection.lastWeek()
    : preset = OrderListDayPreset.lastWeek,
      day = null;

  OrderListDaySelection.day(DateTime value)
    : preset = OrderListDayPreset.day,
      day = DateTime(value.year, value.month, value.day);

  final OrderListDayPreset preset;
  final DateTime? day;

  @override
  bool operator ==(Object other) =>
      other is OrderListDaySelection &&
      other.preset == preset &&
      other.day == day;

  @override
  int get hashCode => Object.hash(preset, day);
}

/// Inclusive [from] and exclusive [to], in local time.
class OrderListDayWindow {
  const OrderListDayWindow({required this.from, required this.to});

  final DateTime from;
  final DateTime to;
}

/// Today is the local calendar day. Last 3 days and last week end today.
///
/// A picked [OrderListDayPreset.day] is that local day only.
OrderListDayWindow orderListDayWindow(
  OrderListDaySelection selection,
  DateTime now,
) {
  final startOfToday = _dateOnly(now);
  final endOfToday = _addDays(startOfToday, 1);
  final from = switch (selection.preset) {
    OrderListDayPreset.today => startOfToday,
    OrderListDayPreset.last3Days => _addDays(startOfToday, -2),
    OrderListDayPreset.lastWeek => _addDays(startOfToday, -6),
    OrderListDayPreset.day => _dateOnly(selection.day ?? startOfToday),
  };
  final to = selection.preset == OrderListDayPreset.day
      ? _addDays(from, 1)
      : endOfToday;
  return OrderListDayWindow(from: from, to: to);
}

/// Local calendar date of [value], at midnight.
DateTime orderListDateOnly(DateTime value) => _dateOnly(value);

DateTime _dateOnly(DateTime value) {
  final local = value.toLocal();
  return DateTime(local.year, local.month, local.day);
}

DateTime _addDays(DateTime date, int days) {
  return DateTime(date.year, date.month, date.day + days);
}
