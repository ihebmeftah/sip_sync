import '../generated/protocol.dart';

/// Adds [months] to [from], clamping the day when the target month is shorter.
DateTime addCalendarMonths(DateTime from, int months) {
  final base = from.toUtc();
  final shifted = base.month - 1 + months;
  final year = base.year + shifted ~/ 12;
  final month = shifted % 12 + 1;
  final lastDay = DateTime.utc(year, month + 1, 0).day;
  final day = base.day > lastDay ? lastDay : base.day;
  return DateTime.utc(
    year,
    month,
    day,
    base.hour,
    base.minute,
    base.second,
    base.millisecond,
  );
}

/// Suggested UTC end of a monthly or yearly pack term.
DateTime packTermEnd(PackBillingPeriod period, {DateTime? from}) {
  final start = (from ?? DateTime.now()).toUtc();
  final months = period == PackBillingPeriod.monthly ? 1 : 12;
  return addCalendarMonths(start, months);
}
