import '../generated/protocol.dart';

/// Longest daily term, counted in calendar days from today.
const packDailyMaxDays = 20;

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

/// Suggested UTC end of a paid term: one day, one month, or one year.
DateTime packTermEnd(PackBillingPeriod period, {DateTime? from}) {
  final start = (from ?? DateTime.now()).toUtc();
  return switch (period) {
    PackBillingPeriod.daily => start.add(const Duration(days: 1)),
    PackBillingPeriod.monthly => addCalendarMonths(start, 1),
    PackBillingPeriod.yearly => addCalendarMonths(start, 12),
  };
}

/// Calendar day of [value] in UTC, so a later clock time on that day still counts.
DateTime packUtcDate(DateTime value) {
  final utc = value.toUtc();
  return DateTime.utc(utc.year, utc.month, utc.day);
}

/// The term stored for a paid assignment.
///
/// Monthly and yearly dates must fall on or after that period's natural end,
/// and may be later. A daily date more than [packDailyMaxDays] calendar days
/// out starts a monthly term. If that date is still before one month, the
/// monthly end is used.
({PackBillingPeriod period, DateTime expiresAt}) resolvePackTerm({
  required PackBillingPeriod period,
  required DateTime expiresAt,
  DateTime? now,
}) {
  final clock = (now ?? DateTime.now()).toUtc();
  final end = expiresAt.toUtc();
  if (!end.isAfter(clock) ||
      end.isAfter(clock.add(const Duration(days: 366 * 6)))) {
    throw PackException(
      message: 'Choose an end date in the future.',
      code: PackErrorCode.invalidInput,
    );
  }
  if (period == PackBillingPeriod.daily) {
    final latest = clock.add(const Duration(days: packDailyMaxDays));
    if (!packUtcDate(end).isAfter(packUtcDate(latest))) {
      return (period: period, expiresAt: end);
    }
    final minimum = packTermEnd(PackBillingPeriod.monthly, from: clock);
    if (packUtcDate(end).isBefore(packUtcDate(minimum))) {
      return (period: PackBillingPeriod.monthly, expiresAt: minimum);
    }
    return (period: PackBillingPeriod.monthly, expiresAt: end);
  }
  final minimum = packTermEnd(period, from: clock);
  if (packUtcDate(end).isBefore(packUtcDate(minimum))) {
    throw PackException(
      message: period == PackBillingPeriod.monthly
          ? 'A monthly term ends on or after one month from today.'
          : 'A yearly term ends on or after one year from today.',
      code: PackErrorCode.invalidInput,
    );
  }
  return (period: period, expiresAt: end);
}
