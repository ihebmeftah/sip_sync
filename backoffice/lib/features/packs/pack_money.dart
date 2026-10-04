/// Catalog money is stored as millimes (1 TND = 1000) and fees as basis points.
int? tryParseMillimes(String raw) {
  final text = raw.trim().replaceAll(',', '.');
  if (text.isEmpty) {
    return null;
  }
  final match = RegExp(r'^(\d+)(?:\.(\d{1,3}))?$').firstMatch(text);
  if (match == null) {
    return null;
  }
  final whole = int.parse(match.group(1)!);
  final fracRaw = match.group(2);
  final frac = fracRaw == null ? 0 : int.parse(fracRaw.padRight(3, '0'));
  return whole * 1000 + frac;
}

/// Empty input is unlimited. A bad token sets [invalid].
({int? value, bool invalid}) tryParseLimit(String raw) {
  final text = raw.trim();
  if (text.isEmpty) {
    return (value: null, invalid: false);
  }
  final value = int.tryParse(text);
  if (value == null || value < 0) {
    return (value: null, invalid: true);
  }
  return (value: value, invalid: false);
}

/// Percent text (`1.5`) to basis points (`150`). Empty or above 100% is null.
int? tryParsePercentToBps(String raw) {
  final text = raw.trim().replaceAll(',', '.');
  if (text.isEmpty) {
    return null;
  }
  final match = RegExp(r'^(\d+)(?:\.(\d{1,2}))?$').firstMatch(text);
  if (match == null) {
    return null;
  }
  final whole = int.parse(match.group(1)!);
  final fracRaw = match.group(2);
  final frac = fracRaw == null ? 0 : int.parse(fracRaw.padRight(2, '0'));
  final bps = whole * 100 + frac;
  if (bps > 10000) {
    return null;
  }
  return bps;
}

String formatMillimes(int millimes) {
  final whole = millimes ~/ 1000;
  final frac = millimes.abs() % 1000;
  if (frac == 0) {
    return '$whole';
  }
  final digits = frac.toString().padLeft(3, '0').replaceAll(RegExp(r'0+$'), '');
  return '$whole.$digits';
}

String formatBps(int bps) {
  final whole = bps ~/ 100;
  final frac = bps.abs() % 100;
  if (frac == 0) {
    return '$whole';
  }
  if (frac % 10 == 0) {
    return '$whole.${frac ~/ 10}';
  }
  return '$whole.${frac.toString().padLeft(2, '0')}';
}
