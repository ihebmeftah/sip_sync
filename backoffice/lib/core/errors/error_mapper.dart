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
      AccountErrorCode.cannotDisableDefaultAdmin =>
        'errorCannotDisableDefaultAdmin',
      AccountErrorCode.cannotDisableSelf => 'errorCannotDisableSelf',
    });
  }
  if (error is BuildingException) {
    return Failure(switch (error.code) {
      BuildingErrorCode.invalidInput => 'errorInvalidInput',
      BuildingErrorCode.notAuthorized => 'errorNotAuthorized',
      BuildingErrorCode.notFound => 'errorNotFound',
    });
  }
  if (error is PackException) {
    return Failure(switch (error.code) {
      PackErrorCode.invalidInput => 'errorInvalidInput',
      PackErrorCode.notFound => 'errorNotFound',
      PackErrorCode.codeTaken => 'errorPackCodeTaken',
      PackErrorCode.cannotDeleteSystemPack => 'errorCannotDeleteSystemPack',
      PackErrorCode.packInUse => 'errorPackInUse',
      PackErrorCode.limitReached => 'errorPackLimit',
      PackErrorCode.featureOff => 'errorPackFeature',
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
    'errorAccountDisabled' => l10n.errorAccountDisabled,
    'errorCannotDisableDefaultAdmin' => l10n.errorCannotDisableDefaultAdmin,
    'errorCannotDisableSelf' => l10n.errorCannotDisableSelf,
    'errorPackCodeTaken' => l10n.errorPackCodeTaken,
    'errorCannotDeleteSystemPack' => l10n.errorCannotDeleteSystemPack,
    'errorPackInUse' => l10n.errorPackInUse,
    'errorPackLimit' => l10n.errorPackLimit,
    'errorPackFeature' => l10n.errorPackFeature,
    _ => l10n.errorGeneric,
  };
}
