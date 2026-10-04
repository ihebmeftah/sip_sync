import 'package:sip_sync_client/sip_sync_client.dart';

/// Longest daily term, counted in calendar days from today.
const packDailyMaxDays = 20;

/// Suggested end of a paid term, matching the server calendar rule.
///
/// The console shows this date and sends whatever the admin keeps or edits.
DateTime previewPackExpiry(PackBillingPeriod period, {DateTime? from}) {
  final start = (from ?? DateTime.now()).toUtc();
  return switch (period) {
    PackBillingPeriod.daily => start.add(const Duration(days: 1)),
    PackBillingPeriod.monthly => _addCalendarMonths(start, 1),
    PackBillingPeriod.yearly => _addCalendarMonths(start, 12),
  };
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

/// Calendar day of [value] in UTC.
DateTime packUtcDate(DateTime value) {
  final utc = value.toUtc();
  return DateTime.utc(utc.year, utc.month, utc.day);
}

/// End of the picked local calendar day, stored in UTC.
DateTime endOfLocalDay(DateTime day) {
  return DateTime(day.year, day.month, day.day, 23, 59, 59).toUtc();
}

/// Local calendar day, without a time component, for the date picker.
DateTime packLocalDate(DateTime value) {
  final local = value.toLocal();
  return DateTime(local.year, local.month, local.day);
}

/// Adjusts a chosen end so it matches the server term rules.
///
/// A daily date more than [packDailyMaxDays] calendar days out becomes
/// monthly. If that date is still before one month, the end is the local
/// end of the monthly minimum so the admin sees the date that will be stored.
/// [startedMonthly] is true when a daily choice was lengthened into a month.
({PackBillingPeriod period, DateTime expiresAt, bool startedMonthly})
normalizePackTerm({
  required PackBillingPeriod period,
  required DateTime expiresAt,
  DateTime? now,
}) {
  final clock = (now ?? DateTime.now()).toUtc();
  if (period != PackBillingPeriod.daily) {
    return (period: period, expiresAt: expiresAt, startedMonthly: false);
  }
  final latest = clock.add(const Duration(days: packDailyMaxDays));
  if (!packUtcDate(expiresAt).isAfter(packUtcDate(latest))) {
    return (period: period, expiresAt: expiresAt, startedMonthly: false);
  }
  final minimum = previewPackExpiry(PackBillingPeriod.monthly, from: clock);
  final end = packUtcDate(expiresAt).isBefore(packUtcDate(minimum))
      ? endOfLocalDay(minimum.toLocal())
      : expiresAt;
  return (
    period: PackBillingPeriod.monthly,
    expiresAt: end,
    startedMonthly: true,
  );
}
