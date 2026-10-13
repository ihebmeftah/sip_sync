import 'package:sip_sync_client/sip_sync_client.dart';

import 'failure.dart';

Failure mapError(Object error) {
  if (error is NotificationException) {
    return Failure(switch (error.code) {
      NotificationErrorCode.invalidInput => 'errorInvalidInput',
      NotificationErrorCode.notFound => 'errorNotFound',
      NotificationErrorCode.notAuthorized => 'errorNotAuthorized',
    });
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
      AccountErrorCode.invalidResetCode => 'errorGeneric',
      AccountErrorCode.resetCodeExpired => 'errorGeneric',
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
      OrderErrorCode.reservationHeld => 'errorOrderReservationHeld',
      OrderErrorCode.customerOrderingDisabled =>
        'errorCustomerOrderingDisabled',
      OrderErrorCode.cancelLocked => 'errorGeneric',
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
  if (error is PlaceException) {
    return Failure(switch (error.code) {
      PlaceErrorCode.invalidInput => 'errorInvalidInput',
      PlaceErrorCode.lookupFailed => 'errorPlaceLookup',
      PlaceErrorCode.notFound => 'errorNotFound',
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
    'errorAccountDisabled' => l10n.errorGeneric,
    'errorPlaceLookup' => l10n.errorPlaceLookup,
    'errorTableOccupied' => l10n.errorTableOccupied,
    'errorInsufficientStock' => l10n.errorInsufficientStock,
    'errorAppendNotAllowed' => l10n.errorAppendNotAllowed,
    'errorLocationDenied' => l10n.errorLocationDenied,
    'errorLocationDisabled' => l10n.errorLocationDisabled,
    'errorLocationFailed' => l10n.errorLocationFailed,
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
    'errorPackPaidActive' => l10n.errorPackPaidActive,
    _ => l10n.errorGeneric,
  };
}
