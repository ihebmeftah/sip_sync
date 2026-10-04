import 'package:sip_sync_client/sip_sync_client.dart';

/// Suggested end of a monthly or yearly term, matching the server calendar rule.
///
/// The console shows this date and sends whatever the admin keeps or edits.
DateTime previewPackExpiry(PackBillingPeriod period, {DateTime? from}) {
  final start = (from ?? DateTime.now()).toUtc();
  final months = period == PackBillingPeriod.monthly ? 1 : 12;
  return _addCalendarMonths(start, months);
}

DateTime _addCalendarMonths(DateTime from, int months) {
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

/// End of the picked local calendar day, stored in UTC.
DateTime endOfLocalDay(DateTime day) {
  return DateTime(day.year, day.month, day.day, 23, 59, 59).toUtc();
}
