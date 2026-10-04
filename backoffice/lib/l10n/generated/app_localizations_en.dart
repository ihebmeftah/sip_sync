// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sip Sync Console';

  @override
  String get tagline => 'Operators, tenants, and the platform admin.';

  @override
  String get atmosphereTitle => 'Keep the platform honest';

  @override
  String get atmosphereBody =>
      'Super admins and operators. Privileges never live in the client.';

  @override
  String get authLead => 'Console access';

  @override
  String get registerLead => 'Request console access';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get signIn => 'Sign in';

  @override
  String get register => 'Create account';

  @override
  String get signOut => 'Sign out';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get username => 'Username';

  @override
  String get phone => 'Phone number';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get noAccount => 'New here? Register';

  @override
  String get hasAccount => 'Already with us? Sign in';

  @override
  String welcome(String name) {
    return 'Welcome, $name';
  }

  @override
  String get rolesLabel => 'Your roles';

  @override
  String get homeHint =>
      'The same email works if you later run a café or join a team.';

  @override
  String get addEmployee => 'Add employee';

  @override
  String get employees => 'Team';

  @override
  String get staff => 'Backoffice users';

  @override
  String get addStaff => 'Add backoffice user';

  @override
  String get adminFlag => 'admin';

  @override
  String get defaultAdminFlag => 'default';

  @override
  String get loading => 'Loading';

  @override
  String get retry => 'Retry';

  @override
  String get empty => 'Nothing here yet';

  @override
  String get language => 'Language';

  @override
  String get errorGeneric => 'Something went wrong. Try again.';

  @override
  String get errorInvalidInput => 'Check the form and try again.';

  @override
  String get errorEmailTaken =>
      'This email is already used with a different password.';

  @override
  String get errorUsernameTaken => 'That username is taken.';

  @override
  String get errorPhoneTaken => 'That phone number is taken.';

  @override
  String get errorInvalidCredentials => 'Email or password is incorrect.';

  @override
  String get errorAppAccessDenied => 'This account cannot use this app yet.';

  @override
  String get errorNotAuthorized => 'You do not have permission.';

  @override
  String get errorNotFound => 'Not found.';

  @override
  String get errorCannotDeleteDefaultAdmin =>
      'The default admin cannot be deleted.';

  @override
  String get errorPasswordTooWeak =>
      'Use at least 8 characters, no leading or trailing spaces.';

  @override
  String get errorProfileIncomplete =>
      'Finish registration with username and phone.';

  @override
  String get errorAccountDisabled => 'This account is disabled.';

  @override
  String get errorCannotDisableDefaultAdmin =>
      'The default admin cannot be disabled.';

  @override
  String get errorCannotDisableSelf => 'You cannot disable your own account.';

  @override
  String get navStats => 'Stats';

  @override
  String get navUsers => 'Users';

  @override
  String get navCustomers => 'Customers';

  @override
  String get navBuildings => 'Buildings';

  @override
  String get navPacks => 'Packs';

  @override
  String get navSection => 'Platform';

  @override
  String get statsTitle => 'Stats';

  @override
  String get customersTitle => 'Customers';

  @override
  String get customersSubtitle => 'Owners and customers on the platform.';

  @override
  String get tabOwners => 'Owners';

  @override
  String get tabCustomers => 'Customers';

  @override
  String get createdAt => 'Created';

  @override
  String accountCreated(String when) {
    return 'Created $when';
  }

  @override
  String get packsTitle => 'Packs';

  @override
  String get screenWorking => 'This screen is working.';

  @override
  String get usersTitle => 'Users';

  @override
  String get usersSubtitle =>
      'Backoffice accounts that can sign in to this console.';

  @override
  String get buildingsTitle => 'Buildings';

  @override
  String get buildingsSubtitle =>
      'Every venue on the platform, with its owner and contact.';

  @override
  String get createUser => 'Create user';

  @override
  String get editUser => 'Update user';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get status => 'Status';

  @override
  String get owner => 'Owner';

  @override
  String get contact => 'Contact';

  @override
  String get buildingType => 'Type';

  @override
  String get address => 'Address';

  @override
  String get location => 'Location';

  @override
  String get currency => 'Currency';

  @override
  String get country => 'Country';

  @override
  String coordinates(String lat, String lng) {
    return '$lat, $lng';
  }

  @override
  String get passwordOptional => 'New password (optional)';

  @override
  String get deleteUser => 'Delete user';

  @override
  String deleteUserConfirm(String name) {
    return 'Delete $name? They will lose console access.';
  }

  @override
  String get viewDetails => 'Details';

  @override
  String get enabledLockedDefault => 'The default admin stays enabled.';

  @override
  String get enabledLockedSelf =>
      'You cannot disable the account you are using.';

  @override
  String get packsSubtitle =>
      'Public packs show in the apps so an owner can upgrade. Private packs are granted to specific owners.';

  @override
  String get createPack => 'Create pack';

  @override
  String get editPack => 'Update pack';

  @override
  String get packCode => 'Code';

  @override
  String get packName => 'Name';

  @override
  String get packMonthly => 'Monthly price (TND)';

  @override
  String get packAnnual => 'Annual price (TND)';

  @override
  String get packAnnualHint =>
      'Leave the annual price empty to offer monthly only.';

  @override
  String get packFee => 'Customer-app fee (%)';

  @override
  String get packFeeHint =>
      'Charged on customer-app orders. Staff tickets stay at 0%.';

  @override
  String get packPublic => 'Public';

  @override
  String get packPrivate => 'Private';

  @override
  String get packPublicHint =>
      'Owners can see this pack in the apps and upgrade to it.';

  @override
  String get packPrivateHint => 'This pack stays off the apps.';

  @override
  String get packEnabled => 'Enabled';

  @override
  String get packEnabledHint =>
      'A disabled pack stays off the public list. Venues already on it keep it.';

  @override
  String get packSortOrder => 'Sort order';

  @override
  String get packLimits => 'Limits';

  @override
  String get packUnlimitedHint => 'Leave a limit empty for no cap.';

  @override
  String get packCapabilities => 'Capabilities';

  @override
  String get capMaxEmployees => 'Employees';

  @override
  String get capMaxEmployeesHint =>
      'How many staff accounts this venue may have.';

  @override
  String get capMaxTables => 'Tables';

  @override
  String get capMaxTablesHint => 'How many floor tables this venue may add.';

  @override
  String get capMaxCategories => 'Categories';

  @override
  String get capMaxCategoriesHint =>
      'How many menu categories this venue may add.';

  @override
  String get capMaxArticles => 'Articles';

  @override
  String get capMaxArticlesHint =>
      'How many sellable articles this venue may add.';

  @override
  String get capMaxIngredients => 'Ingredients';

  @override
  String get capMaxIngredientsHint =>
      'How many stock ingredients this venue may add.';

  @override
  String get capCustomerDiscovery => 'Customer map';

  @override
  String get capCustomerDiscoveryHint =>
      'The venue appears on the customer map.';

  @override
  String get capTableQr => 'Table QR';

  @override
  String get capTableQrHint => 'Staff can print and scan table QR stickers.';

  @override
  String get capCustomerOrdering => 'Customer ordering';

  @override
  String get capCustomerOrderingHint =>
      'A customer can pass an order from the menu after scanning a table.';

  @override
  String get capInventory => 'Inventory and recipes';

  @override
  String get capInventoryHint =>
      'Recipes, stock levels, restock, and deduction when an order is placed.';

  @override
  String get capAllowAppending => 'Append items to an order';

  @override
  String get capAllowAppendingHint =>
      'The venue may allow adding articles to an open order.';

  @override
  String get capTableMultiOrder => 'Several orders per table';

  @override
  String get capTableMultiOrderHint =>
      'The venue may allow more than one open order on the same table.';

  @override
  String get capStrictMode => 'Strict kitchen steps';

  @override
  String get capStrictModeHint =>
      'The venue may require kitchen steps in order: picked, ready, served, then paid.';

  @override
  String get capCustomAccess => 'Custom access profiles';

  @override
  String get capCustomAccessHint =>
      'The owner may add access profiles beyond Waiter, Gerant, and Barista.';

  @override
  String packPriceMonth(String price) {
    return '$price TND / month';
  }

  @override
  String packPriceYear(String price) {
    return '$price TND / year';
  }

  @override
  String get packSystem => 'system';

  @override
  String get deletePack => 'Delete pack';

  @override
  String deletePackConfirm(String name) {
    return 'Delete $name?';
  }

  @override
  String get errorPackCodeTaken => 'That code is already used.';

  @override
  String get errorCannotDeleteSystemPack => 'The free pack cannot be deleted.';

  @override
  String get errorPackInUse => 'A venue is still on this pack.';

  @override
  String get errorPackLimit => 'This plan has reached its limit.';

  @override
  String get errorPackFeature => 'This plan does not include that.';

  @override
  String get errorPackLimitEmployees =>
      'This plan has reached its employee limit.';

  @override
  String get errorPackLimitTables => 'This plan has reached its table limit.';

  @override
  String get errorPackLimitCategories =>
      'This plan has reached its category limit.';

  @override
  String get errorPackLimitArticles =>
      'This plan has reached its article limit.';

  @override
  String get errorPackLimitIngredients =>
      'This plan has reached its ingredient limit.';

  @override
  String get errorPackFeatureOrdering =>
      'This plan does not include customer ordering.';

  @override
  String get errorPackFeatureInventory =>
      'This plan does not include inventory.';

  @override
  String get errorPackFeatureAppend =>
      'This plan does not include adding items to an open order.';

  @override
  String get errorPackFeatureMultiOrder =>
      'This plan does not include more than one order on a table.';

  @override
  String get errorPackFeatureStrict =>
      'This plan does not include strict order steps.';

  @override
  String get errorPackFeatureAccess =>
      'This plan does not include custom access profiles.';

  @override
  String get errorPackFeatureQr => 'This plan does not include table QR codes.';

  @override
  String get errorPackPaidActive =>
      'This venue already has a paid plan. Assign another plan after it ends.';

  @override
  String get packHistoryTitle => 'Plan history';

  @override
  String get packHistoryCurrent => 'Current';

  @override
  String get packEndReplaced => 'Replaced';

  @override
  String get packEndExpired => 'Expired';

  @override
  String get packPaidLocked =>
      'This venue is on a paid plan. Another plan can be assigned after the term ends.';

  @override
  String get buildingDetailTitle => 'Building';

  @override
  String get buildingDetailSubtitle =>
      'Contact, pack, gain, and counts for this venue.';

  @override
  String get buildingTabDetails => 'Details';

  @override
  String get buildingTabPack => 'Pack';

  @override
  String get buildingTabGain => 'Gain';

  @override
  String get buildingTabStats => 'Stats';

  @override
  String get assignPack => 'Assign pack';

  @override
  String get packBillingDaily => 'Daily';

  @override
  String get packBillingMonthly => 'Monthly';

  @override
  String get packBillingYearly => 'Yearly';

  @override
  String packExpiresOn(String date) {
    return 'Returns to Free on $date';
  }

  @override
  String get packExpiresNever => 'Free pack. No end date.';

  @override
  String get packTermHint =>
      'A daily term lasts at most 20 days. A monthly term ends on or after one month. A yearly term ends on or after one year. You can move the date later.';

  @override
  String get packChangeDate => 'Change date';

  @override
  String get packAssignConfirm => 'Assign';

  @override
  String get packDailyStartsMonthly =>
      'More than 20 days starts a monthly term.';

  @override
  String get validationPackExpiry => 'Choose a date after today.';

  @override
  String get validationPackMonthlyMin =>
      'A monthly term ends on or after one month from today.';

  @override
  String get validationPackYearlyMin =>
      'A yearly term ends on or after one year from today.';

  @override
  String get quickCreatePack => 'Create private pack';

  @override
  String get quickCreatePackHint =>
      'A new pack starts private. It stays off the public list.';

  @override
  String packFeeLabel(String fee) {
    return '$fee% on customer-app orders';
  }

  @override
  String get packNoLimit => 'No limit';

  @override
  String get gainHint =>
      'Monthly plan price, plus the customer-app fee on customer orders. Staff tickets are not included.';

  @override
  String get gainMonthly => 'Monthly plan';

  @override
  String get gainFeeRate => 'Customer-app fee';

  @override
  String get gainCustomerOrders => 'Customer orders';

  @override
  String get gainCustomerSales => 'Customer-app sales';

  @override
  String get gainFeeEarned => 'Fee earned';

  @override
  String get statCategories => 'Categories';

  @override
  String get statArticles => 'Articles';

  @override
  String get statTables => 'Tables';

  @override
  String get statOrders => 'Orders';

  @override
  String get statsSubtitle =>
      'People, venues, orders, and who is on each public pack.';

  @override
  String get statOwners => 'Owners';

  @override
  String get statCustomers => 'Customers';

  @override
  String get statVenues => 'Venues';

  @override
  String get statEmployees => 'Employees';

  @override
  String get statSubscription => 'Monthly plans';

  @override
  String get publicPacksTitle => 'Public packs';

  @override
  String get publicPacksSubtitle =>
      'Venues and owners currently on each public pack.';

  @override
  String get validationRequired => 'This field is required.';

  @override
  String get validationEmail => 'Enter a valid email.';

  @override
  String get validationPassword =>
      'Use at least 8 characters, no leading or trailing spaces.';

  @override
  String get validationPhone => 'Enter a phone with country code, e.g. +216…';

  @override
  String get validationPackCode =>
      'Start with a letter, then letters, digits, or _.';

  @override
  String get validationPackMoney =>
      'Enter a price in dinars, up to 3 decimals.';

  @override
  String get validationPackFee => 'Enter a percent from 0 to 100.';

  @override
  String get validationPackSort => 'Enter a whole number.';

  @override
  String get validationPackLimit =>
      'Enter a number, or leave empty for no limit.';

  @override
  String get previousPage => 'Previous';

  @override
  String get nextPage => 'Next';

  @override
  String pageOf(int current, int total) {
    return '$current / $total';
  }

  @override
  String get loadingMore => 'Loading more…';
}
