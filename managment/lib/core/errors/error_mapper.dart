import 'package:sip_sync_client/sip_sync_client.dart';

import 'failure.dart';

Failure mapError(Object error) {
  if (error is ServerpodClientNetworkException) {
    return const Failure('errorCannotReachServer');
  }
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
      AccountErrorCode.invalidResetCode => 'errorInvalidResetCode',
      AccountErrorCode.resetCodeExpired => 'errorResetCodeExpired',
      AccountErrorCode.cannotDisableDefaultAdmin => 'errorGeneric',
      AccountErrorCode.cannotDisableSelf => 'errorGeneric',
    });
  }
  if (error is PackException) {
    return Failure(_packFailureKey(error));
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
      IngredientErrorCode.inUse => 'errorIngredientInUse',
    });
  }
  if (error is ArticleCompositionException) {
    return Failure(switch (error.code) {
      ArticleCompositionErrorCode.invalidInput => 'errorInvalidInput',
      ArticleCompositionErrorCode.notAuthorized => 'errorNotAuthorized',
      ArticleCompositionErrorCode.notFound => 'errorNotFound',
      ArticleCompositionErrorCode.ingredientTaken =>
        'errorCompositionIngredientTaken',
    });
  }
  if (error is OrderException) {
    return Failure(switch (error.code) {
      OrderErrorCode.invalidInput => 'errorInvalidInput',
      OrderErrorCode.notAuthorized => 'errorNotAuthorized',
      OrderErrorCode.notFound => 'errorNotFound',
      OrderErrorCode.invalidStatus => 'errorOrderInvalidStatus',
      OrderErrorCode.insufficientStock => 'errorOrderInsufficientStock',
      OrderErrorCode.tableOccupied => 'errorOrderTableOccupied',
      OrderErrorCode.appendNotAllowed => 'errorOrderAppendNotAllowed',
      OrderErrorCode.permissionDenied => 'errorOrderPermissionDenied',
      OrderErrorCode.reservationHeld => 'errorOrderReservationHeld',
      OrderErrorCode.customerOrderingDisabled =>
        'errorCustomerOrderingDisabled',
    });
  }
  if (error is ReservationException) {
    return Failure(switch (error.code) {
      ReservationErrorCode.invalidInput => 'errorInvalidInput',
      ReservationErrorCode.notAuthorized => 'errorNotAuthorized',
      ReservationErrorCode.notFound => 'errorReservationNotFound',
      ReservationErrorCode.overlap => 'errorReservationOverlap',
      ReservationErrorCode.disabled => 'errorReservationsDisabled',
    });
  }
  if (error is EmployeeAccessException) {
    return Failure(switch (error.code) {
      EmployeeAccessErrorCode.invalidInput => 'errorInvalidInput',
      EmployeeAccessErrorCode.notAuthorized => 'errorNotAuthorized',
      EmployeeAccessErrorCode.notFound => 'errorNotFound',
      EmployeeAccessErrorCode.nameTaken => 'errorAccessNameTaken',
      EmployeeAccessErrorCode.inUse => 'errorAccessInUse',
    });
  }
  return const Failure('errorGeneric');
}

String _packFailureKey(PackException error) {
  return switch (error.code) {
    PackErrorCode.invalidInput => 'errorInvalidInput',
    PackErrorCode.notFound => 'errorNotFound',
    PackErrorCode.codeTaken => 'errorGeneric',
    PackErrorCode.cannotDeleteSystemPack => 'errorGeneric',
    PackErrorCode.packInUse => 'errorGeneric',
    PackErrorCode.paidPlanActive => 'errorPackPaidActive',
    PackErrorCode.limitReached => switch (error.feature) {
      PackFeature.employees => 'errorPackLimitEmployees',
      PackFeature.tables => 'errorPackLimitTables',
      PackFeature.categories => 'errorPackLimitCategories',
      PackFeature.articles => 'errorPackLimitArticles',
      PackFeature.ingredients => 'errorPackLimitIngredients',
      PackFeature.reservations => 'errorPackLimitReservations',
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
      PackFeature.reservations => 'errorPackFeatureReservations',
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
    'errorInvalidResetCode' => l10n.errorInvalidResetCode,
    'errorResetCodeExpired' => l10n.errorResetCodeExpired,
    'errorLocationDenied' => l10n.errorLocationDenied,
    'errorLocationDisabled' => l10n.errorLocationDisabled,
    'errorLocationFailed' => l10n.errorLocationFailed,
    'errorTableNumberTaken' => l10n.errorTableNumberTaken,
    'errorCategoryNameTaken' => l10n.errorCategoryNameTaken,
    'errorArticleNameTaken' => l10n.errorArticleNameTaken,
    'errorIngredientNameTaken' => l10n.errorIngredientNameTaken,
    'errorIngredientInUse' => l10n.errorIngredientInUse,
    'errorCompositionIngredientTaken' => l10n.errorCompositionIngredientTaken,
    'errorOrderInvalidStatus' => l10n.errorOrderInvalidStatus,
    'errorOrderInsufficientStock' => l10n.errorOrderInsufficientStock,
    'errorOrderTableOccupied' => l10n.errorOrderTableOccupied,
    'errorOrderAppendNotAllowed' => l10n.errorOrderAppendNotAllowed,
    'errorOrderPermissionDenied' => l10n.errorOrderPermissionDenied,
    'errorAccessNameTaken' => l10n.errorAccessNameTaken,
    'errorAccessInUse' => l10n.errorAccessInUse,
    'errorCannotReachServer' => l10n.errorCannotReachServer,
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
    'errorPackFeatureReservations' => l10n.errorPackFeatureReservations,
    'errorPackLimitReservations' => l10n.errorPackLimitReservations,
    'errorOrderReservationHeld' => l10n.errorOrderReservationHeld,
    'errorCustomerOrderingDisabled' => l10n.errorCustomerOrderingDisabled,
    'errorReservationsDisabled' => l10n.errorReservationsDisabled,
    'errorReservationOverlap' => l10n.errorReservationOverlap,
    'errorReservationNotFound' => l10n.errorReservationNotFound,
    'reservationWindow' => l10n.reservationWindow,
    'reservationSelectTables' => l10n.reservationSelectTables,
    'errorPackPaidActive' => l10n.errorPackPaidActive,
    _ => l10n.errorGeneric,
  };
}
