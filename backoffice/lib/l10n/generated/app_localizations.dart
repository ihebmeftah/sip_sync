import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// Customer app title
  ///
  /// In en, this message translates to:
  /// **'Sip Sync Console'**
  String get appTitle;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Operators, tenants, and the platform admin.'**
  String get tagline;

  /// No description provided for @atmosphereTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep the platform honest'**
  String get atmosphereTitle;

  /// No description provided for @atmosphereBody.
  ///
  /// In en, this message translates to:
  /// **'Super admins and operators. Privileges never live in the client.'**
  String get atmosphereBody;

  /// No description provided for @authLead.
  ///
  /// In en, this message translates to:
  /// **'Console access'**
  String get authLead;

  /// No description provided for @registerLead.
  ///
  /// In en, this message translates to:
  /// **'Request console access'**
  String get registerLead;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get register;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'New here? Register'**
  String get noAccount;

  /// No description provided for @hasAccount.
  ///
  /// In en, this message translates to:
  /// **'Already with us? Sign in'**
  String get hasAccount;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String welcome(String name);

  /// No description provided for @rolesLabel.
  ///
  /// In en, this message translates to:
  /// **'Your roles'**
  String get rolesLabel;

  /// No description provided for @homeHint.
  ///
  /// In en, this message translates to:
  /// **'The same email works if you later run a café or join a team.'**
  String get homeHint;

  /// No description provided for @addEmployee.
  ///
  /// In en, this message translates to:
  /// **'Add employee'**
  String get addEmployee;

  /// No description provided for @employees.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get employees;

  /// No description provided for @staff.
  ///
  /// In en, this message translates to:
  /// **'Backoffice users'**
  String get staff;

  /// No description provided for @addStaff.
  ///
  /// In en, this message translates to:
  /// **'Add backoffice user'**
  String get addStaff;

  /// No description provided for @adminFlag.
  ///
  /// In en, this message translates to:
  /// **'admin'**
  String get adminFlag;

  /// No description provided for @defaultAdminFlag.
  ///
  /// In en, this message translates to:
  /// **'default'**
  String get defaultAdminFlag;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @empty.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get empty;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get errorGeneric;

  /// No description provided for @errorInvalidInput.
  ///
  /// In en, this message translates to:
  /// **'Check the form and try again.'**
  String get errorInvalidInput;

  /// No description provided for @errorEmailTaken.
  ///
  /// In en, this message translates to:
  /// **'This email is already used with a different password.'**
  String get errorEmailTaken;

  /// No description provided for @errorUsernameTaken.
  ///
  /// In en, this message translates to:
  /// **'That username is taken.'**
  String get errorUsernameTaken;

  /// No description provided for @errorPhoneTaken.
  ///
  /// In en, this message translates to:
  /// **'That phone number is taken.'**
  String get errorPhoneTaken;

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect.'**
  String get errorInvalidCredentials;

  /// No description provided for @errorAppAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'This account cannot use this app yet.'**
  String get errorAppAccessDenied;

  /// No description provided for @errorNotAuthorized.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission.'**
  String get errorNotAuthorized;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'Not found.'**
  String get errorNotFound;

  /// No description provided for @errorCannotDeleteDefaultAdmin.
  ///
  /// In en, this message translates to:
  /// **'The default admin cannot be deleted.'**
  String get errorCannotDeleteDefaultAdmin;

  /// No description provided for @errorPasswordTooWeak.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters, no leading or trailing spaces.'**
  String get errorPasswordTooWeak;

  /// No description provided for @errorProfileIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Finish registration with username and phone.'**
  String get errorProfileIncomplete;

  /// No description provided for @errorAccountDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account is disabled.'**
  String get errorAccountDisabled;

  /// No description provided for @errorCannotDisableDefaultAdmin.
  ///
  /// In en, this message translates to:
  /// **'The default admin cannot be disabled.'**
  String get errorCannotDisableDefaultAdmin;

  /// No description provided for @errorCannotDisableSelf.
  ///
  /// In en, this message translates to:
  /// **'You cannot disable your own account.'**
  String get errorCannotDisableSelf;

  /// No description provided for @navStats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get navStats;

  /// No description provided for @navUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get navUsers;

  /// No description provided for @navCustomers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get navCustomers;

  /// No description provided for @navBuildings.
  ///
  /// In en, this message translates to:
  /// **'Buildings'**
  String get navBuildings;

  /// No description provided for @navCountries.
  ///
  /// In en, this message translates to:
  /// **'Countries / Maps'**
  String get navCountries;

  /// No description provided for @navPacks.
  ///
  /// In en, this message translates to:
  /// **'Packs'**
  String get navPacks;

  /// No description provided for @navSection.
  ///
  /// In en, this message translates to:
  /// **'Platform'**
  String get navSection;

  /// No description provided for @statsTitle.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get statsTitle;

  /// No description provided for @customersTitle.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get customersTitle;

  /// No description provided for @customersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Owners and customers on the platform.'**
  String get customersSubtitle;

  /// No description provided for @tabOwners.
  ///
  /// In en, this message translates to:
  /// **'Owners'**
  String get tabOwners;

  /// No description provided for @tabCustomers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get tabCustomers;

  /// No description provided for @createdAt.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get createdAt;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Created {when}'**
  String accountCreated(String when);

  /// No description provided for @packsTitle.
  ///
  /// In en, this message translates to:
  /// **'Packs'**
  String get packsTitle;

  /// No description provided for @screenWorking.
  ///
  /// In en, this message translates to:
  /// **'This screen is working.'**
  String get screenWorking;

  /// No description provided for @usersTitle.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get usersTitle;

  /// No description provided for @usersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Backoffice accounts that can sign in to this console.'**
  String get usersSubtitle;

  /// No description provided for @buildingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Buildings'**
  String get buildingsTitle;

  /// No description provided for @buildingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Every venue on the platform. Search by name, owner, or address, and filter by pack.'**
  String get buildingsSubtitle;

  /// No description provided for @buildingSearchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get buildingSearchLabel;

  /// No description provided for @buildingSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Venue name, owner name, or address'**
  String get buildingSearchHint;

  /// No description provided for @buildingSearchAction.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get buildingSearchAction;

  /// No description provided for @buildingPackFilter.
  ///
  /// In en, this message translates to:
  /// **'Pack'**
  String get buildingPackFilter;

  /// No description provided for @buildingPackAll.
  ///
  /// In en, this message translates to:
  /// **'All packs'**
  String get buildingPackAll;

  /// No description provided for @buildingsFilterEmpty.
  ///
  /// In en, this message translates to:
  /// **'No venues match this search.'**
  String get buildingsFilterEmpty;

  /// No description provided for @createUser.
  ///
  /// In en, this message translates to:
  /// **'Create user'**
  String get createUser;

  /// No description provided for @editUser.
  ///
  /// In en, this message translates to:
  /// **'Update user'**
  String get editUser;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @buildingType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get buildingType;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @countryLabeled.
  ///
  /// In en, this message translates to:
  /// **'{name} ({code})'**
  String countryLabeled(String name, String code);

  /// No description provided for @countriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Countries / Maps'**
  String get countriesTitle;

  /// No description provided for @countriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How many venues sit in each country.'**
  String get countriesSubtitle;

  /// No description provided for @countryVenueCount.
  ///
  /// In en, this message translates to:
  /// **'{count} venues'**
  String countryVenueCount(int count);

  /// No description provided for @osmAttribution.
  ///
  /// In en, this message translates to:
  /// **'© OpenStreetMap contributors'**
  String get osmAttribution;

  /// Latitude and longitude pair
  ///
  /// In en, this message translates to:
  /// **'{lat}, {lng}'**
  String coordinates(String lat, String lng);

  /// No description provided for @passwordOptional.
  ///
  /// In en, this message translates to:
  /// **'New password (optional)'**
  String get passwordOptional;

  /// No description provided for @deleteUser.
  ///
  /// In en, this message translates to:
  /// **'Delete user'**
  String get deleteUser;

  /// No description provided for @deleteUserConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}? They will lose console access.'**
  String deleteUserConfirm(String name);

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get viewDetails;

  /// No description provided for @enabledLockedDefault.
  ///
  /// In en, this message translates to:
  /// **'The default admin stays enabled.'**
  String get enabledLockedDefault;

  /// No description provided for @enabledLockedSelf.
  ///
  /// In en, this message translates to:
  /// **'You cannot disable the account you are using.'**
  String get enabledLockedSelf;

  /// No description provided for @packsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Public packs show in the apps so an owner can upgrade. Private packs are granted to specific owners.'**
  String get packsSubtitle;

  /// No description provided for @createPack.
  ///
  /// In en, this message translates to:
  /// **'Create pack'**
  String get createPack;

  /// No description provided for @editPack.
  ///
  /// In en, this message translates to:
  /// **'Update pack'**
  String get editPack;

  /// No description provided for @packCode.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get packCode;

  /// No description provided for @packName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get packName;

  /// No description provided for @packMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly price (TND)'**
  String get packMonthly;

  /// No description provided for @packAnnual.
  ///
  /// In en, this message translates to:
  /// **'Annual price (TND)'**
  String get packAnnual;

  /// No description provided for @packAnnualHint.
  ///
  /// In en, this message translates to:
  /// **'Leave the annual price empty to offer monthly only.'**
  String get packAnnualHint;

  /// No description provided for @packFee.
  ///
  /// In en, this message translates to:
  /// **'Customer-app fee (%)'**
  String get packFee;

  /// No description provided for @packFeeHint.
  ///
  /// In en, this message translates to:
  /// **'Charged on customer-app orders. Staff tickets stay at 0%.'**
  String get packFeeHint;

  /// No description provided for @packPublic.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get packPublic;

  /// No description provided for @packPrivate.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get packPrivate;

  /// No description provided for @packPublicHint.
  ///
  /// In en, this message translates to:
  /// **'Owners can see this pack in the apps and upgrade to it.'**
  String get packPublicHint;

  /// No description provided for @packPrivateHint.
  ///
  /// In en, this message translates to:
  /// **'This pack stays off the apps.'**
  String get packPrivateHint;

  /// No description provided for @packEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get packEnabled;

  /// No description provided for @packEnabledHint.
  ///
  /// In en, this message translates to:
  /// **'A disabled pack stays off the public list. Venues already on it keep it.'**
  String get packEnabledHint;

  /// No description provided for @packSortOrder.
  ///
  /// In en, this message translates to:
  /// **'Sort order'**
  String get packSortOrder;

  /// No description provided for @packLimits.
  ///
  /// In en, this message translates to:
  /// **'Limits'**
  String get packLimits;

  /// No description provided for @packUnlimitedHint.
  ///
  /// In en, this message translates to:
  /// **'Leave a limit empty for no cap.'**
  String get packUnlimitedHint;

  /// No description provided for @packCapabilities.
  ///
  /// In en, this message translates to:
  /// **'Capabilities'**
  String get packCapabilities;

  /// No description provided for @capMaxEmployees.
  ///
  /// In en, this message translates to:
  /// **'Employees'**
  String get capMaxEmployees;

  /// No description provided for @capMaxEmployeesHint.
  ///
  /// In en, this message translates to:
  /// **'How many staff accounts this venue may have.'**
  String get capMaxEmployeesHint;

  /// No description provided for @capMaxTables.
  ///
  /// In en, this message translates to:
  /// **'Tables'**
  String get capMaxTables;

  /// No description provided for @capMaxTablesHint.
  ///
  /// In en, this message translates to:
  /// **'How many floor tables this venue may add.'**
  String get capMaxTablesHint;

  /// No description provided for @capMaxCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get capMaxCategories;

  /// No description provided for @capMaxCategoriesHint.
  ///
  /// In en, this message translates to:
  /// **'How many menu categories this venue may add.'**
  String get capMaxCategoriesHint;

  /// No description provided for @capMaxArticles.
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get capMaxArticles;

  /// No description provided for @capMaxArticlesHint.
  ///
  /// In en, this message translates to:
  /// **'How many sellable articles this venue may add.'**
  String get capMaxArticlesHint;

  /// No description provided for @capMaxIngredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get capMaxIngredients;

  /// No description provided for @capMaxIngredientsHint.
  ///
  /// In en, this message translates to:
  /// **'How many stock ingredients this venue may add.'**
  String get capMaxIngredientsHint;

  /// No description provided for @capCustomerDiscovery.
  ///
  /// In en, this message translates to:
  /// **'Customer map'**
  String get capCustomerDiscovery;

  /// No description provided for @capCustomerDiscoveryHint.
  ///
  /// In en, this message translates to:
  /// **'The venue appears on the customer map.'**
  String get capCustomerDiscoveryHint;

  /// No description provided for @capTableQr.
  ///
  /// In en, this message translates to:
  /// **'Table QR'**
  String get capTableQr;

  /// No description provided for @capTableQrHint.
  ///
  /// In en, this message translates to:
  /// **'Staff can print and scan table QR stickers.'**
  String get capTableQrHint;

  /// No description provided for @capCustomerOrdering.
  ///
  /// In en, this message translates to:
  /// **'Customer ordering'**
  String get capCustomerOrdering;

  /// No description provided for @capCustomerOrderingHint.
  ///
  /// In en, this message translates to:
  /// **'A customer can pass an order from the menu after scanning a table.'**
  String get capCustomerOrderingHint;

  /// No description provided for @capInventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory and recipes'**
  String get capInventory;

  /// No description provided for @capInventoryHint.
  ///
  /// In en, this message translates to:
  /// **'Recipes, stock levels, restock, and deduction when an order is placed.'**
  String get capInventoryHint;

  /// No description provided for @capAllowAppending.
  ///
  /// In en, this message translates to:
  /// **'Append items to an order'**
  String get capAllowAppending;

  /// No description provided for @capAllowAppendingHint.
  ///
  /// In en, this message translates to:
  /// **'The venue may allow adding articles to an open order.'**
  String get capAllowAppendingHint;

  /// No description provided for @capTableMultiOrder.
  ///
  /// In en, this message translates to:
  /// **'Several orders per table'**
  String get capTableMultiOrder;

  /// No description provided for @capTableMultiOrderHint.
  ///
  /// In en, this message translates to:
  /// **'The venue may allow more than one open order on the same table.'**
  String get capTableMultiOrderHint;

  /// No description provided for @capStrictMode.
  ///
  /// In en, this message translates to:
  /// **'Strict kitchen steps'**
  String get capStrictMode;

  /// No description provided for @capStrictModeHint.
  ///
  /// In en, this message translates to:
  /// **'The venue may require kitchen steps in order: picked, ready, served, then paid.'**
  String get capStrictModeHint;

  /// No description provided for @capCustomAccess.
  ///
  /// In en, this message translates to:
  /// **'Custom access profiles'**
  String get capCustomAccess;

  /// No description provided for @capCustomAccessHint.
  ///
  /// In en, this message translates to:
  /// **'The owner may add access profiles beyond Waiter, Gerant, and Barista.'**
  String get capCustomAccessHint;

  /// No description provided for @capReservations.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get capReservations;

  /// No description provided for @capReservationsHint.
  ///
  /// In en, this message translates to:
  /// **'Staff and customers can book tables. A daily cap still applies when it is set.'**
  String get capReservationsHint;

  /// No description provided for @capMaxReservations.
  ///
  /// In en, this message translates to:
  /// **'Reservations per day'**
  String get capMaxReservations;

  /// No description provided for @capMaxReservationsHint.
  ///
  /// In en, this message translates to:
  /// **'Leave empty for no daily cap. Counts non-cancelled bookings whose start falls on one UTC date.'**
  String get capMaxReservationsHint;

  /// No description provided for @packPriceMonth.
  ///
  /// In en, this message translates to:
  /// **'{price} TND / month'**
  String packPriceMonth(String price);

  /// No description provided for @packPriceYear.
  ///
  /// In en, this message translates to:
  /// **'{price} TND / year'**
  String packPriceYear(String price);

  /// No description provided for @packSystem.
  ///
  /// In en, this message translates to:
  /// **'system'**
  String get packSystem;

  /// No description provided for @deletePack.
  ///
  /// In en, this message translates to:
  /// **'Delete pack'**
  String get deletePack;

  /// No description provided for @deletePackConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}?'**
  String deletePackConfirm(String name);

  /// No description provided for @errorPackCodeTaken.
  ///
  /// In en, this message translates to:
  /// **'That code is already used.'**
  String get errorPackCodeTaken;

  /// No description provided for @errorCannotDeleteSystemPack.
  ///
  /// In en, this message translates to:
  /// **'The free pack cannot be deleted.'**
  String get errorCannotDeleteSystemPack;

  /// No description provided for @errorPackInUse.
  ///
  /// In en, this message translates to:
  /// **'A venue is still on this pack.'**
  String get errorPackInUse;

  /// No description provided for @errorPackLimit.
  ///
  /// In en, this message translates to:
  /// **'This plan has reached its limit.'**
  String get errorPackLimit;

  /// No description provided for @errorPackFeature.
  ///
  /// In en, this message translates to:
  /// **'This plan does not include that.'**
  String get errorPackFeature;

  /// No description provided for @errorPackLimitEmployees.
  ///
  /// In en, this message translates to:
  /// **'This plan has reached its employee limit.'**
  String get errorPackLimitEmployees;

  /// No description provided for @errorPackLimitTables.
  ///
  /// In en, this message translates to:
  /// **'This plan has reached its table limit.'**
  String get errorPackLimitTables;

  /// No description provided for @errorPackLimitCategories.
  ///
  /// In en, this message translates to:
  /// **'This plan has reached its category limit.'**
  String get errorPackLimitCategories;

  /// No description provided for @errorPackLimitArticles.
  ///
  /// In en, this message translates to:
  /// **'This plan has reached its article limit.'**
  String get errorPackLimitArticles;

  /// No description provided for @errorPackLimitIngredients.
  ///
  /// In en, this message translates to:
  /// **'This plan has reached its ingredient limit.'**
  String get errorPackLimitIngredients;

  /// No description provided for @errorPackFeatureOrdering.
  ///
  /// In en, this message translates to:
  /// **'This plan does not include customer ordering.'**
  String get errorPackFeatureOrdering;

  /// No description provided for @errorPackFeatureInventory.
  ///
  /// In en, this message translates to:
  /// **'This plan does not include inventory.'**
  String get errorPackFeatureInventory;

  /// No description provided for @errorPackFeatureAppend.
  ///
  /// In en, this message translates to:
  /// **'This plan does not include adding items to an open order.'**
  String get errorPackFeatureAppend;

  /// No description provided for @errorPackFeatureMultiOrder.
  ///
  /// In en, this message translates to:
  /// **'This plan does not include more than one order on a table.'**
  String get errorPackFeatureMultiOrder;

  /// No description provided for @errorPackFeatureStrict.
  ///
  /// In en, this message translates to:
  /// **'This plan does not include strict order steps.'**
  String get errorPackFeatureStrict;

  /// No description provided for @errorPackFeatureAccess.
  ///
  /// In en, this message translates to:
  /// **'This plan does not include custom access profiles.'**
  String get errorPackFeatureAccess;

  /// No description provided for @errorPackFeatureQr.
  ///
  /// In en, this message translates to:
  /// **'This plan does not include table QR codes.'**
  String get errorPackFeatureQr;

  /// No description provided for @errorPackFeatureReservations.
  ///
  /// In en, this message translates to:
  /// **'This plan does not include reservations.'**
  String get errorPackFeatureReservations;

  /// No description provided for @errorPackLimitReservations.
  ///
  /// In en, this message translates to:
  /// **'This plan has reached its reservation limit for the day.'**
  String get errorPackLimitReservations;

  /// No description provided for @errorPackPaidActive.
  ///
  /// In en, this message translates to:
  /// **'This venue already has a paid plan. Assign another plan after it ends.'**
  String get errorPackPaidActive;

  /// No description provided for @packHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan history'**
  String get packHistoryTitle;

  /// No description provided for @packHistoryCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get packHistoryCurrent;

  /// No description provided for @packEndReplaced.
  ///
  /// In en, this message translates to:
  /// **'Replaced'**
  String get packEndReplaced;

  /// No description provided for @packEndExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get packEndExpired;

  /// No description provided for @packPaidLocked.
  ///
  /// In en, this message translates to:
  /// **'This venue is on a paid plan. Another plan can be assigned after the term ends.'**
  String get packPaidLocked;

  /// No description provided for @buildingDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Building'**
  String get buildingDetailTitle;

  /// No description provided for @buildingDetailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Contact, pack, gain, and counts for this venue.'**
  String get buildingDetailSubtitle;

  /// No description provided for @buildingTabDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get buildingTabDetails;

  /// No description provided for @buildingTabPack.
  ///
  /// In en, this message translates to:
  /// **'Pack'**
  String get buildingTabPack;

  /// No description provided for @buildingTabGain.
  ///
  /// In en, this message translates to:
  /// **'Gain'**
  String get buildingTabGain;

  /// No description provided for @buildingTabStats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get buildingTabStats;

  /// No description provided for @assignPack.
  ///
  /// In en, this message translates to:
  /// **'Assign pack'**
  String get assignPack;

  /// No description provided for @packBillingDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get packBillingDaily;

  /// No description provided for @packBillingMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get packBillingMonthly;

  /// No description provided for @packBillingYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get packBillingYearly;

  /// No description provided for @packExpiresOn.
  ///
  /// In en, this message translates to:
  /// **'Returns to Free on {date}'**
  String packExpiresOn(String date);

  /// No description provided for @packExpiresNever.
  ///
  /// In en, this message translates to:
  /// **'Free pack. No end date.'**
  String get packExpiresNever;

  /// No description provided for @packTermHint.
  ///
  /// In en, this message translates to:
  /// **'A daily term lasts at most 20 days. A monthly term ends on or after one month. A yearly term ends on or after one year. You can move the date later.'**
  String get packTermHint;

  /// No description provided for @packChangeDate.
  ///
  /// In en, this message translates to:
  /// **'Change date'**
  String get packChangeDate;

  /// No description provided for @packAssignConfirm.
  ///
  /// In en, this message translates to:
  /// **'Assign'**
  String get packAssignConfirm;

  /// No description provided for @packDailyStartsMonthly.
  ///
  /// In en, this message translates to:
  /// **'More than 20 days starts a monthly term.'**
  String get packDailyStartsMonthly;

  /// No description provided for @validationPackExpiry.
  ///
  /// In en, this message translates to:
  /// **'Choose a date after today.'**
  String get validationPackExpiry;

  /// No description provided for @validationPackMonthlyMin.
  ///
  /// In en, this message translates to:
  /// **'A monthly term ends on or after one month from today.'**
  String get validationPackMonthlyMin;

  /// No description provided for @validationPackYearlyMin.
  ///
  /// In en, this message translates to:
  /// **'A yearly term ends on or after one year from today.'**
  String get validationPackYearlyMin;

  /// No description provided for @quickCreatePack.
  ///
  /// In en, this message translates to:
  /// **'Create private pack'**
  String get quickCreatePack;

  /// No description provided for @quickCreatePackHint.
  ///
  /// In en, this message translates to:
  /// **'A new pack starts private. It stays off the public list.'**
  String get quickCreatePackHint;

  /// No description provided for @packFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'{fee}% on customer-app orders'**
  String packFeeLabel(String fee);

  /// No description provided for @packNoLimit.
  ///
  /// In en, this message translates to:
  /// **'No limit'**
  String get packNoLimit;

  /// No description provided for @gainHint.
  ///
  /// In en, this message translates to:
  /// **'Monthly plan price, plus the customer-app fee on customer orders. Staff tickets are not included.'**
  String get gainHint;

  /// No description provided for @gainMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly plan'**
  String get gainMonthly;

  /// No description provided for @gainFeeRate.
  ///
  /// In en, this message translates to:
  /// **'Customer-app fee'**
  String get gainFeeRate;

  /// No description provided for @gainCustomerOrders.
  ///
  /// In en, this message translates to:
  /// **'Customer orders'**
  String get gainCustomerOrders;

  /// No description provided for @gainCustomerSales.
  ///
  /// In en, this message translates to:
  /// **'Customer-app sales'**
  String get gainCustomerSales;

  /// No description provided for @gainFeeEarned.
  ///
  /// In en, this message translates to:
  /// **'Fee earned'**
  String get gainFeeEarned;

  /// No description provided for @statCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get statCategories;

  /// No description provided for @statArticles.
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get statArticles;

  /// No description provided for @statTables.
  ///
  /// In en, this message translates to:
  /// **'Tables'**
  String get statTables;

  /// No description provided for @statOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get statOrders;

  /// No description provided for @statsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'People, venues, orders, and who is on each public pack.'**
  String get statsSubtitle;

  /// No description provided for @statOwners.
  ///
  /// In en, this message translates to:
  /// **'Owners'**
  String get statOwners;

  /// No description provided for @statCustomers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get statCustomers;

  /// No description provided for @statVenues.
  ///
  /// In en, this message translates to:
  /// **'Venues'**
  String get statVenues;

  /// No description provided for @statEmployees.
  ///
  /// In en, this message translates to:
  /// **'Employees'**
  String get statEmployees;

  /// No description provided for @statSubscription.
  ///
  /// In en, this message translates to:
  /// **'Monthly plans'**
  String get statSubscription;

  /// No description provided for @publicPacksTitle.
  ///
  /// In en, this message translates to:
  /// **'Public packs'**
  String get publicPacksTitle;

  /// No description provided for @publicPacksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Venues and owners currently on each public pack.'**
  String get publicPacksSubtitle;

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get validationRequired;

  /// No description provided for @validationEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email.'**
  String get validationEmail;

  /// No description provided for @validationPassword.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters, no leading or trailing spaces.'**
  String get validationPassword;

  /// No description provided for @validationPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a phone with country code, e.g. +216…'**
  String get validationPhone;

  /// No description provided for @validationPackCode.
  ///
  /// In en, this message translates to:
  /// **'Start with a letter, then letters, digits, or _.'**
  String get validationPackCode;

  /// No description provided for @validationPackMoney.
  ///
  /// In en, this message translates to:
  /// **'Enter a price in dinars, up to 3 decimals.'**
  String get validationPackMoney;

  /// No description provided for @validationPackFee.
  ///
  /// In en, this message translates to:
  /// **'Enter a percent from 0 to 100.'**
  String get validationPackFee;

  /// No description provided for @validationPackSort.
  ///
  /// In en, this message translates to:
  /// **'Enter a whole number.'**
  String get validationPackSort;

  /// No description provided for @validationPackLimit.
  ///
  /// In en, this message translates to:
  /// **'Enter a number, or leave empty for no limit.'**
  String get validationPackLimit;

  /// No description provided for @previousPage.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previousPage;

  /// No description provided for @nextPage.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextPage;

  /// No description provided for @pageOf.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String pageOf(int current, int total);

  /// No description provided for @loadingMore.
  ///
  /// In en, this message translates to:
  /// **'Loading more…'**
  String get loadingMore;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
