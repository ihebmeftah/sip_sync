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
    return Failure(_packFailureKey(error));
  }
  return const Failure('errorGeneric');
}

String _packFailureKey(PackException error) {
  return switch (error.code) {
    PackErrorCode.invalidInput => 'errorInvalidInput',
    PackErrorCode.notFound => 'errorNotFound',
    PackErrorCode.codeTaken => 'errorPackCodeTaken',
    PackErrorCode.cannotDeleteSystemPack => 'errorCannotDeleteSystemPack',
    PackErrorCode.packInUse => 'errorPackInUse',
    PackErrorCode.paidPlanActive => 'errorPackPaidActive',
    PackErrorCode.limitReached => switch (error.feature) {
      PackFeature.employees => 'errorPackLimitEmployees',
      PackFeature.tables => 'errorPackLimitTables',
      PackFeature.categories => 'errorPackLimitCategories',
      PackFeature.articles => 'errorPackLimitArticles',
      PackFeature.ingredients => 'errorPackLimitIngredients',
      _ => 'errorPackLimit',
    },
    PackErrorCode.featureOff => switch (error.feature) {
      PackFeature.customerOrdering => 'errorPackFeatureOrdering',
      PackFeature.inventory => 'errorPackFeatureInventory',
      PackFeature.appendingItems => 'errorPackFeatureAppend',
      PackFeature.tableMultiOrder => 'errorPackFeatureMultiOrder',
      PackFeature.strictMode => 'errorPackFeatureStrict',
      PackFeature.customAccessProfiles => 'errorPackFeatureAccess',
      PackFeature.tableQr => 'errorPackFeatureQr',
      _ => 'errorPackFeature',
    },
  };
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
    'errorPackLimitEmployees' => l10n.errorPackLimitEmployees,
    'errorPackLimitTables' => l10n.errorPackLimitTables,
    'errorPackLimitCategories' => l10n.errorPackLimitCategories,
    'errorPackLimitArticles' => l10n.errorPackLimitArticles,
    'errorPackLimitIngredients' => l10n.errorPackLimitIngredients,
    'errorPackFeature' => l10n.errorPackFeature,
    'errorPackFeatureOrdering' => l10n.errorPackFeatureOrdering,
    'errorPackFeatureInventory' => l10n.errorPackFeatureInventory,
    'errorPackFeatureAppend' => l10n.errorPackFeatureAppend,
    'errorPackFeatureMultiOrder' => l10n.errorPackFeatureMultiOrder,
    'errorPackFeatureStrict' => l10n.errorPackFeatureStrict,
    'errorPackFeatureAccess' => l10n.errorPackFeatureAccess,
    'errorPackFeatureQr' => l10n.errorPackFeatureQr,
    'errorPackPaidActive' => l10n.errorPackPaidActive,
    _ => l10n.errorGeneric,
  };
}
