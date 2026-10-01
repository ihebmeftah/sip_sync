import '../../l10n/generated/app_localizations.dart';
import '../phone/phone_numbers.dart';

/// Client checks that match customer account rules on the server.
abstract final class FormValidators {
  static String? requiredName(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validationRequired;
    }
    return null;
  }

  static String? email(AppLocalizations l10n, String? value) {
    final text = (value ?? '').trim().toLowerCase();
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text)) {
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

  static String? phone(AppLocalizations l10n, String? value) {
    final text = (value ?? '').trim();
    if (!PhoneNumbers.isValid(text)) {
      return l10n.validationPhone;
    }
    if (PhoneNumbers.countryCodeFromPhone(text) == null) {
      return l10n.validationPhoneCountry;
    }
    return null;
  }
}
