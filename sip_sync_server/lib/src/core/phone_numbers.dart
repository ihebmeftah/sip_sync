import 'package:sealed_countries/sealed_countries.dart';

/// E.164 phone helpers backed by [WorldCountry] dial data.
abstract final class PhoneNumbers {
  static List<(String dial, WorldCountry country)>? _dialIndex;
  static List<WorldCountry>? _dialCountries;

  /// Countries with a usable IDD, sorted by English common name.
  static List<WorldCountry> get dialCountries {
    return _dialCountries ??=
        WorldCountry.list.where((c) => c.idd.root > 0).toList()..sort(
          (a, b) => a.name.common.toLowerCase().compareTo(
            b.name.common.toLowerCase(),
          ),
        );
  }

  /// Dial digits without `+` (e.g. `216` for Tunisia).
  static String dialDigits(WorldCountry country) =>
      country.idd.phoneCode(leading: '');

  static String digitsOnly(String raw) => raw.replaceAll(RegExp(r'\D'), '');

  static String normalize(String raw) {
    final digits = digitsOnly(raw);
    if (digits.isEmpty) {
      return '';
    }
    return '+$digits';
  }

  /// True when [raw] looks like E.164 (`+` + 8–15 digits).
  static bool isValid(String raw) {
    final normalized = normalize(raw);
    return RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(normalized);
  }

  /// ISO 3166-1 alpha-2 from the phone dial prefix, or `null`.
  static String? countryCodeFromPhone(String raw) =>
      countryFromPhone(raw)?.codeShort;

  /// Best-matching [WorldCountry] for an E.164 number (longest dial wins).
  static WorldCountry? countryFromPhone(String raw) {
    final digits = digitsOnly(raw);
    if (digits.isEmpty) {
      return null;
    }
    for (final entry in _index) {
      if (digits.startsWith(entry.$1)) {
        return entry.$2;
      }
    }
    return null;
  }

  static (WorldCountry country, String national)? split(String raw) {
    final digits = digitsOnly(raw);
    if (digits.isEmpty) {
      return null;
    }
    for (final entry in _index) {
      final dial = entry.$1;
      if (digits.startsWith(dial) && digits.length > dial.length) {
        return (entry.$2, digits.substring(dial.length));
      }
    }
    return null;
  }

  static String compose(WorldCountry country, String national) {
    return normalize('${dialDigits(country)}${digitsOnly(national)}');
  }

  static List<(String dial, WorldCountry country)> get _index {
    if (_dialIndex != null) {
      return _dialIndex!;
    }
    final entries = <(String dial, WorldCountry country)>[
      for (final country in WorldCountry.list)
        if (country.idd.root > 0) (dialDigits(country), country),
    ];
    entries.sort((a, b) {
      final byLen = b.$1.length.compareTo(a.$1.length);
      if (byLen != 0) {
        return byLen;
      }
      return b.$2.population.compareTo(a.$2.population);
    });
    return _dialIndex = entries;
  }
}

/// Fiat ISO 4217 helpers from [FiatCurrency].
abstract final class Currencies {
  static bool isValidCode(String raw) =>
      FiatCurrency.maybeFromCode(raw.trim().toUpperCase()) != null;
}
