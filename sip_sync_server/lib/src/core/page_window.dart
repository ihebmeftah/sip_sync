import 'package:serverpod/serverpod.dart';

/// A clamped list window. Callers cannot ask for an unbounded read.
class PageWindow {
  const PageWindow({required this.limit, required this.offset});

  /// Rows per page when the client omits [limit].
  static const defaultLimit = 20;

  /// Hard cap so a client cannot pull a whole table in one call.
  static const maxLimit = 100;

  final int limit;
  final int offset;

  /// Uses [defaultLimit] when [limit] is missing or below 1, and [maxLimit]
  /// when the request is larger. Negative offsets become 0.
  factory PageWindow.from({int? limit, int? offset}) {
    final requested = limit ?? defaultLimit;
    final safeLimit = requested < 1
        ? defaultLimit
        : (requested > maxLimit ? maxLimit : requested);
    final requestedOffset = offset ?? 0;
    return PageWindow(
      limit: safeLimit,
      offset: requestedOffset < 0 ? 0 : requestedOffset,
    );
  }
}

/// First column of a raw SQL row as [int]. Postgres may return [BigInt].
int sqlInt(Object? value) {
  if (value is int) {
    return value;
  }
  if (value is BigInt) {
    return value.toInt();
  }
  if (value is double) {
    return value.round();
  }
  return int.parse(value.toString());
}

/// First column of a raw SQL row as [UuidValue].
UuidValue sqlUuid(Object? value) {
  if (value is UuidValue) {
    return value;
  }
  return UuidValue.fromString(value.toString());
}
