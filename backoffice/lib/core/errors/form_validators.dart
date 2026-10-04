import 'package:sip_sync_client/sip_sync_client.dart';

import '../../features/buildings/pack_term_preview.dart';
import '../../l10n/generated/app_localizations.dart';

/// Client checks that match backoffice account and pack rules on the server.
abstract final class FormValidators {
  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final _phone = RegExp(r'^\+[1-9]\d{7,14}$');
  static final _packCode = RegExp(r'^[a-z][a-z0-9_]{0,31}$');

  static String? requiredText(AppLocalizations l10n, String? value) {
    if ((value ?? '').trim().isEmpty) {
      return l10n.validationRequired;
    }
    return null;
  }

  static String? email(AppLocalizations l10n, String? value) {
    final text = (value ?? '').trim().toLowerCase();
    if (!_email.hasMatch(text)) {
      return l10n.validationEmail;
    }
    return null;
  }

  static String? password(AppLocalizations l10n, String? value) {
    final text = value ?? '';
    if (text.trim() != text || text.length < 8) {
      return l10n.validationPassword;
    }
    return null;
  }

  /// Empty is allowed. A typed password still has to meet [password].
  static String? optionalPassword(AppLocalizations l10n, String? value) {
    if ((value ?? '').isEmpty) {
      return null;
    }
    return password(l10n, value);
  }

  static String? phone(AppLocalizations l10n, String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
    if (!_phone.hasMatch(digits.isEmpty ? '' : '+$digits')) {
      return l10n.validationPhone;
    }
    return null;
  }

  static String? packCode(AppLocalizations l10n, String? value) {
    final text = (value ?? '').trim().toLowerCase();
    if (!_packCode.hasMatch(text)) {
      return l10n.validationPackCode;
    }
    return null;
  }

  /// A paid term must end after now, and on or after the period minimum.
  ///
  /// Monthly is at least one month out and yearly at least one year. A later
  /// date is allowed. Daily is at most 20 days; a longer daily date is not
  /// valid here because the dialog turns it into a monthly term first.
  static String? packExpiry(
    AppLocalizations l10n,
    DateTime? value,
    PackBillingPeriod period,
  ) {
    if (value == null || !value.isAfter(DateTime.now())) {
      return l10n.validationPackExpiry;
    }
    if (period == PackBillingPeriod.daily) {
      final latest = DateTime.now().toUtc().add(
        const Duration(days: packDailyMaxDays),
      );
      if (packUtcDate(value).isAfter(packUtcDate(latest))) {
        return l10n.packDailyStartsMonthly;
      }
      return null;
    }
    final minimum = previewPackExpiry(period);
    if (packUtcDate(value).isBefore(packUtcDate(minimum))) {
      return period == PackBillingPeriod.monthly
          ? l10n.validationPackMonthlyMin
          : l10n.validationPackYearlyMin;
    }
    return null;
  }

  static String? packName(AppLocalizations l10n, String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty || text.length > 80) {
      return l10n.validationRequired;
    }
    return null;
  }
}
