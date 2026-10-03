import 'package:sip_sync_client/sip_sync_client.dart';

import 'failure.dart';

Failure mapError(Object error) {
  if (error is AccountException) {
    return Failure(switch (error.code) {
      AccountErrorCode.invalidInput => 'errorInvalidInput',
      AccountErrorCode.emailTaken => 'errorEmailTaken',
      AccountErrorCode.usernameTaken => 'errorUsernameTaken',
      AccountErrorCode.phoneTaken => 'errorPhoneTaken',
      AccountErrorCode.invalidCredentials => 'errorInvalidCredentials',
      AccountErrorCode.appAccessDenied => 'errorAppAccessDenied',
      AccountErrorCode.notAuthorized => 'errorNotAuthorized',
      AccountErrorCode.notFound => 'errorNotFound',
      AccountErrorCode.cannotDeleteDefaultAdmin =>
        'errorCannotDeleteDefaultAdmin',
      AccountErrorCode.passwordTooWeak => 'errorPasswordTooWeak',
      AccountErrorCode.profileIncomplete => 'errorProfileIncomplete',
      AccountErrorCode.accountDisabled => 'errorAccountDisabled',
      AccountErrorCode.invalidResetCode => 'errorGeneric',
      AccountErrorCode.resetCodeExpired => 'errorGeneric',
      AccountErrorCode.cannotDisableDefaultAdmin => 'errorGeneric',
      AccountErrorCode.cannotDisableSelf => 'errorGeneric',
    });
  }
  if (error is BuildingException) {
    return Failure(switch (error.code) {
      BuildingErrorCode.invalidInput => 'errorInvalidInput',
      BuildingErrorCode.notAuthorized => 'errorNotAuthorized',
      BuildingErrorCode.notFound => 'errorNotFound',
    });
  }
  if (error is OrderException) {
    return Failure(switch (error.code) {
      OrderErrorCode.invalidInput => 'errorInvalidInput',
      OrderErrorCode.notAuthorized => 'errorNotAuthorized',
      OrderErrorCode.notFound => 'errorNotFound',
      OrderErrorCode.insufficientStock => 'errorInsufficientStock',
      OrderErrorCode.tableOccupied => 'errorTableOccupied',
      OrderErrorCode.invalidStatus => 'errorGeneric',
      OrderErrorCode.appendNotAllowed => 'errorAppendNotAllowed',
      OrderErrorCode.permissionDenied => 'errorNotAuthorized',
    });
  }
  if (error is PlaceException) {
    return Failure(switch (error.code) {
      PlaceErrorCode.invalidInput => 'errorInvalidInput',
      PlaceErrorCode.lookupFailed => 'errorPlaceLookup',
      PlaceErrorCode.notFound => 'errorNotFound',
    });
  }
  return const Failure('errorGeneric');
}

String lookupError(dynamic l10n, String key) {
  return switch (key) {
    'errorInvalidInput' => l10n.errorInvalidInput,
    'errorEmailTaken' => l10n.errorEmailTaken,
    'errorUsernameTaken' => l10n.errorUsernameTaken,
    'errorPhoneTaken' => l10n.errorPhoneTaken,
    'errorInvalidCredentials' => l10n.errorInvalidCredentials,
    'errorAppAccessDenied' => l10n.errorAppAccessDenied,
    'errorNotAuthorized' => l10n.errorNotAuthorized,
    'errorNotFound' => l10n.errorNotFound,
    'errorCannotDeleteDefaultAdmin' => l10n.errorCannotDeleteDefaultAdmin,
    'errorPasswordTooWeak' => l10n.errorPasswordTooWeak,
    'errorProfileIncomplete' => l10n.errorProfileIncomplete,
    'errorAccountDisabled' => l10n.errorGeneric,
    'errorPlaceLookup' => l10n.errorPlaceLookup,
    'errorTableOccupied' => l10n.errorTableOccupied,
    'errorInsufficientStock' => l10n.errorInsufficientStock,
    'errorAppendNotAllowed' => l10n.errorAppendNotAllowed,
    'errorLocationDenied' => l10n.errorLocationDenied,
    'errorLocationDisabled' => l10n.errorLocationDisabled,
    'errorLocationFailed' => l10n.errorLocationFailed,
    _ => l10n.errorGeneric,
  };
}
