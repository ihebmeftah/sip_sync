import '../../l10n/generated/app_localizations.dart';
import 'error_mapper.dart';

/// Server failures that belong under one input.
///
/// Field-scoped keys render on that control. Everything else stays on the
/// form banner so a credential or network failure is not pinned to the
/// wrong box.
abstract final class FormServerError {
  static const email = {'errorEmailTaken'};
  static const phone = {'errorPhoneTaken'};
  static const password = {'errorPasswordTooWeak'};

  static bool isFieldScoped(String? errorKey) {
    return email.contains(errorKey) ||
        phone.contains(errorKey) ||
        password.contains(errorKey);
  }

  /// Localized message when [errorKey] is one of [keys].
  static String? message(
    AppLocalizations l10n,
    String? errorKey,
    Set<String> keys,
  ) {
    if (errorKey == null || !keys.contains(errorKey)) {
      return null;
    }
    return lookupError(l10n, errorKey);
  }
}
