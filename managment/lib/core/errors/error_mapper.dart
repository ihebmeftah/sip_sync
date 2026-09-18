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
    });
  }
  if (error is BuildingException) {
    return Failure(switch (error.code) {
      BuildingErrorCode.invalidInput => 'errorInvalidInput',
      BuildingErrorCode.notAuthorized => 'errorNotAuthorized',
      BuildingErrorCode.notFound => 'errorNotFound',
    });
  }
  if (error is VenueTableException) {
    return Failure(switch (error.code) {
      VenueTableErrorCode.invalidInput => 'errorInvalidInput',
      VenueTableErrorCode.notAuthorized => 'errorNotAuthorized',
      VenueTableErrorCode.notFound => 'errorNotFound',
      VenueTableErrorCode.numberTaken => 'errorTableNumberTaken',
    });
  }
  if (error is MenuCategoryException) {
    return Failure(switch (error.code) {
      MenuCategoryErrorCode.invalidInput => 'errorInvalidInput',
      MenuCategoryErrorCode.notAuthorized => 'errorNotAuthorized',
      MenuCategoryErrorCode.notFound => 'errorNotFound',
      MenuCategoryErrorCode.nameTaken => 'errorCategoryNameTaken',
    });
  }
  if (error is MenuArticleException) {
    return Failure(switch (error.code) {
      MenuArticleErrorCode.invalidInput => 'errorInvalidInput',
      MenuArticleErrorCode.notAuthorized => 'errorNotAuthorized',
      MenuArticleErrorCode.notFound => 'errorNotFound',
      MenuArticleErrorCode.nameTaken => 'errorArticleNameTaken',
    });
  }
  if (error is IngredientException) {
    return Failure(switch (error.code) {
      IngredientErrorCode.invalidInput => 'errorInvalidInput',
      IngredientErrorCode.notAuthorized => 'errorNotAuthorized',
      IngredientErrorCode.notFound => 'errorNotFound',
      IngredientErrorCode.nameTaken => 'errorIngredientNameTaken',
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
    'errorLocationDenied' => l10n.errorLocationDenied,
    'errorLocationDisabled' => l10n.errorLocationDisabled,
    'errorLocationFailed' => l10n.errorLocationFailed,
    'errorTableNumberTaken' => l10n.errorTableNumberTaken,
    'errorCategoryNameTaken' => l10n.errorCategoryNameTaken,
    'errorArticleNameTaken' => l10n.errorArticleNameTaken,
    'errorIngredientNameTaken' => l10n.errorIngredientNameTaken,
    _ => l10n.errorGeneric,
  };
}
