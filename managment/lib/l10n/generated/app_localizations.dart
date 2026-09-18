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
  /// **'Sip Sync Ops'**
  String get appTitle;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Floor, kitchen, and till — one login for the house.'**
  String get tagline;

  /// No description provided for @atmosphereTitle.
  ///
  /// In en, this message translates to:
  /// **'Run the house from one screen'**
  String get atmosphereTitle;

  /// No description provided for @atmosphereBody.
  ///
  /// In en, this message translates to:
  /// **'Owners and staff share a login. What you can do is decided on the server.'**
  String get atmosphereBody;

  /// No description provided for @authLead.
  ///
  /// In en, this message translates to:
  /// **'Staff sign in'**
  String get authLead;

  /// No description provided for @registerLead.
  ///
  /// In en, this message translates to:
  /// **'Open an owner account'**
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

  /// No description provided for @loginAsOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get loginAsOwner;

  /// No description provided for @loginAsEmployee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get loginAsEmployee;

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

  /// No description provided for @loginIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Email or username'**
  String get loginIdentifier;

  /// No description provided for @loginIdentifierHint.
  ///
  /// In en, this message translates to:
  /// **'Owners use email. Staff use their username.'**
  String get loginIdentifierHint;

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

  /// No description provided for @usernameLocked.
  ///
  /// In en, this message translates to:
  /// **'Username is assigned by the system and cannot be changed.'**
  String get usernameLocked;

  /// No description provided for @employeeUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'A username is generated from the name after you save.'**
  String get employeeUsernameHint;

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
  /// **'This staff account is disabled.'**
  String get errorAccountDisabled;

  /// No description provided for @navEmployees.
  ///
  /// In en, this message translates to:
  /// **'Employees'**
  String get navEmployees;

  /// No description provided for @editEmployee.
  ///
  /// In en, this message translates to:
  /// **'Edit employee'**
  String get editEmployee;

  /// No description provided for @saveEmployee.
  ///
  /// In en, this message translates to:
  /// **'Save employee'**
  String get saveEmployee;

  /// No description provided for @employeesOwnerOnly.
  ///
  /// In en, this message translates to:
  /// **'Only owners can manage staff.'**
  String get employeesOwnerOnly;

  /// No description provided for @accountEnabled.
  ///
  /// In en, this message translates to:
  /// **'Account enabled'**
  String get accountEnabled;

  /// No description provided for @accountDisabled.
  ///
  /// In en, this message translates to:
  /// **'Account disabled'**
  String get accountDisabled;

  /// No description provided for @accountEnabledHint.
  ///
  /// In en, this message translates to:
  /// **'This person can sign in to operations.'**
  String get accountEnabledHint;

  /// No description provided for @accountDisabledHint.
  ///
  /// In en, this message translates to:
  /// **'This person cannot sign in to operations.'**
  String get accountDisabledHint;

  /// No description provided for @dashboardEmployeesCue.
  ///
  /// In en, this message translates to:
  /// **'Add staff, edit details, and enable or disable access.'**
  String get dashboardEmployeesCue;

  /// No description provided for @opsRailTagline.
  ///
  /// In en, this message translates to:
  /// **'Floor command'**
  String get opsRailTagline;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get navProducts;

  /// No description provided for @navCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get navCategories;

  /// No description provided for @navArticles.
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get navArticles;

  /// No description provided for @navIngredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get navIngredients;

  /// No description provided for @navPos.
  ///
  /// In en, this message translates to:
  /// **'POS'**
  String get navPos;

  /// No description provided for @navTables.
  ///
  /// In en, this message translates to:
  /// **'Tables'**
  String get navTables;

  /// No description provided for @helloScreen.
  ///
  /// In en, this message translates to:
  /// **'Hello, {screen}'**
  String helloScreen(String screen);

  /// No description provided for @placeholderBody.
  ///
  /// In en, this message translates to:
  /// **'This screen is not connected to the server yet.'**
  String get placeholderBody;

  /// No description provided for @saveProfile.
  ///
  /// In en, this message translates to:
  /// **'Save profile'**
  String get saveProfile;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile updated.'**
  String get profileSaved;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'Your profile'**
  String get myProfile;

  /// No description provided for @teamProfiles.
  ///
  /// In en, this message translates to:
  /// **'Added staff'**
  String get teamProfiles;

  /// No description provided for @viewProfile.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get viewProfile;

  /// No description provided for @employeeProfile.
  ///
  /// In en, this message translates to:
  /// **'Staff profile'**
  String get employeeProfile;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light theme'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get themeDark;

  /// No description provided for @dashboardEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Tonight’s house'**
  String get dashboardEyebrow;

  /// No description provided for @dashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'POS, floor, and catalog sit one tap away. Live counts arrive with the next server slice.'**
  String get dashboardSubtitle;

  /// No description provided for @dashboardShift.
  ///
  /// In en, this message translates to:
  /// **'Shift board'**
  String get dashboardShift;

  /// No description provided for @dashboardPosCue.
  ///
  /// In en, this message translates to:
  /// **'Till and tickets — coming next.'**
  String get dashboardPosCue;

  /// No description provided for @dashboardTablesCue.
  ///
  /// In en, this message translates to:
  /// **'Floor map with seat previews and status filters.'**
  String get dashboardTablesCue;

  /// No description provided for @dashboardCatalogCue.
  ///
  /// In en, this message translates to:
  /// **'Categories and articles for this venue.'**
  String get dashboardCatalogCue;

  /// No description provided for @dashboardProfileCue.
  ///
  /// In en, this message translates to:
  /// **'Your name and phone.'**
  String get dashboardProfileCue;

  /// No description provided for @emailLocked.
  ///
  /// In en, this message translates to:
  /// **'Email is tied to sign-in and cannot be changed here.'**
  String get emailLocked;

  /// No description provided for @profileHint.
  ///
  /// In en, this message translates to:
  /// **'Update the name the floor sees. Sign-in identity stays locked.'**
  String get profileHint;

  /// No description provided for @navBuildings.
  ///
  /// In en, this message translates to:
  /// **'Buildings'**
  String get navBuildings;

  /// No description provided for @addBuilding.
  ///
  /// In en, this message translates to:
  /// **'Add building'**
  String get addBuilding;

  /// No description provided for @editBuilding.
  ///
  /// In en, this message translates to:
  /// **'Edit building'**
  String get editBuilding;

  /// No description provided for @saveBuilding.
  ///
  /// In en, this message translates to:
  /// **'Save building'**
  String get saveBuilding;

  /// No description provided for @buildingName.
  ///
  /// In en, this message translates to:
  /// **'Venue name'**
  String get buildingName;

  /// No description provided for @buildingType.
  ///
  /// In en, this message translates to:
  /// **'Venue type'**
  String get buildingType;

  /// No description provided for @buildingTypeRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get buildingTypeRestaurant;

  /// No description provided for @buildingTypeLounge.
  ///
  /// In en, this message translates to:
  /// **'Lounge'**
  String get buildingTypeLounge;

  /// No description provided for @buildingTypeBar.
  ///
  /// In en, this message translates to:
  /// **'Bar'**
  String get buildingTypeBar;

  /// No description provided for @buildingTypeCafe.
  ///
  /// In en, this message translates to:
  /// **'Café'**
  String get buildingTypeCafe;

  /// No description provided for @buildingTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get buildingTypeOther;

  /// No description provided for @buildingTypeCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom type'**
  String get buildingTypeCustom;

  /// No description provided for @buildingAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get buildingAddress;

  /// No description provided for @latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitude;

  /// No description provided for @longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitude;

  /// No description provided for @openingTime.
  ///
  /// In en, this message translates to:
  /// **'Opens'**
  String get openingTime;

  /// No description provided for @closingTime.
  ///
  /// In en, this message translates to:
  /// **'Closes'**
  String get closingTime;

  /// No description provided for @currencyCode.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currencyCode;

  /// No description provided for @buildingStaff.
  ///
  /// In en, this message translates to:
  /// **'Staff at this venue'**
  String get buildingStaff;

  /// No description provided for @buildingStaffEmpty.
  ///
  /// In en, this message translates to:
  /// **'No employees yet. Add staff after you save this venue.'**
  String get buildingStaffEmpty;

  /// No description provided for @buildingsOwnerHint.
  ///
  /// In en, this message translates to:
  /// **'Create a venue, then open it to run the floor. Other tools stay locked until you pick one.'**
  String get buildingsOwnerHint;

  /// No description provided for @buildingsStaffHint.
  ///
  /// In en, this message translates to:
  /// **'Pick a venue you are assigned to.'**
  String get buildingsStaffHint;

  /// No description provided for @buildingsEmptyOwner.
  ///
  /// In en, this message translates to:
  /// **'Add your first café, restaurant, lounge, or bar to continue.'**
  String get buildingsEmptyOwner;

  /// No description provided for @employeesEmptyBuilding.
  ///
  /// In en, this message translates to:
  /// **'No staff assigned to this venue yet.'**
  String get employeesEmptyBuilding;

  /// No description provided for @dashboardBuildingMeta.
  ///
  /// In en, this message translates to:
  /// **'{type} · {address} · {opens}–{closes} · {currency}'**
  String dashboardBuildingMeta(
    String type,
    String address,
    String opens,
    String closes,
    String currency,
  );

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get validationRequired;

  /// No description provided for @validationLoginIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Enter an email or a username (at least 3 characters).'**
  String get validationLoginIdentifier;

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
  /// **'Enter a valid phone number.'**
  String get validationPhone;

  /// No description provided for @validationVenueName.
  ///
  /// In en, this message translates to:
  /// **'Name must be 1–80 characters.'**
  String get validationVenueName;

  /// No description provided for @validationVenueType.
  ///
  /// In en, this message translates to:
  /// **'Use 2–40 letters, numbers, spaces, or hyphens.'**
  String get validationVenueType;

  /// No description provided for @validationAddress.
  ///
  /// In en, this message translates to:
  /// **'Address must be 3–200 characters.'**
  String get validationAddress;

  /// No description provided for @validationLatitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude must be between -90 and 90.'**
  String get validationLatitude;

  /// No description provided for @validationLongitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude must be between -180 and 180.'**
  String get validationLongitude;

  /// No description provided for @validationCurrency.
  ///
  /// In en, this message translates to:
  /// **'Use a 3-letter currency code.'**
  String get validationCurrency;

  /// No description provided for @pickCurrentPosition.
  ///
  /// In en, this message translates to:
  /// **'Pick current position'**
  String get pickCurrentPosition;

  /// No description provided for @errorLocationDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required to fill the address.'**
  String get errorLocationDenied;

  /// No description provided for @errorLocationDisabled.
  ///
  /// In en, this message translates to:
  /// **'Turn on location services and try again.'**
  String get errorLocationDisabled;

  /// No description provided for @errorLocationFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not read the current position.'**
  String get errorLocationFailed;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @addTable.
  ///
  /// In en, this message translates to:
  /// **'Add table'**
  String get addTable;

  /// No description provided for @editTable.
  ///
  /// In en, this message translates to:
  /// **'Edit table'**
  String get editTable;

  /// No description provided for @saveTable.
  ///
  /// In en, this message translates to:
  /// **'Save table'**
  String get saveTable;

  /// No description provided for @tablesHint.
  ///
  /// In en, this message translates to:
  /// **'Floor plan by seats. Status comes from orders and reservations later.'**
  String get tablesHint;

  /// No description provided for @tablesEmptyOwner.
  ///
  /// In en, this message translates to:
  /// **'Add your first table to sketch the floor.'**
  String get tablesEmptyOwner;

  /// No description provided for @tablesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No tables on this floor yet.'**
  String get tablesEmpty;

  /// No description provided for @tablesFilterEmpty.
  ///
  /// In en, this message translates to:
  /// **'No tables match this filter.'**
  String get tablesFilterEmpty;

  /// No description provided for @tableFormHint.
  ///
  /// In en, this message translates to:
  /// **'Choose how many tables to add. Numbers are assigned in order automatically.'**
  String get tableFormHint;

  /// No description provided for @tableEditHint.
  ///
  /// In en, this message translates to:
  /// **'You can change seats and whether the table is active. The number stays fixed.'**
  String get tableEditHint;

  /// No description provided for @tableNumber.
  ///
  /// In en, this message translates to:
  /// **'Table number'**
  String get tableNumber;

  /// No description provided for @tableNumberLocked.
  ///
  /// In en, this message translates to:
  /// **'Table number cannot be changed.'**
  String get tableNumberLocked;

  /// No description provided for @tableCountToAdd.
  ///
  /// In en, this message translates to:
  /// **'How many tables'**
  String get tableCountToAdd;

  /// No description provided for @tableNumberRange.
  ///
  /// In en, this message translates to:
  /// **'Will create numbers {from}–{to}'**
  String tableNumberRange(int from, int to);

  /// No description provided for @tableMaxSeats.
  ///
  /// In en, this message translates to:
  /// **'Max seats'**
  String get tableMaxSeats;

  /// No description provided for @tableActive.
  ///
  /// In en, this message translates to:
  /// **'Active on floor'**
  String get tableActive;

  /// No description provided for @tableActiveHint.
  ///
  /// In en, this message translates to:
  /// **'Inactive tables stay in the list but drop out of Available.'**
  String get tableActiveHint;

  /// No description provided for @tableSeatsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} seats'**
  String tableSeatsCount(int count);

  /// No description provided for @tableFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get tableFilterAll;

  /// No description provided for @tableFilterInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get tableFilterInactive;

  /// No description provided for @tableStatusAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get tableStatusAvailable;

  /// No description provided for @tableStatusOccupied.
  ///
  /// In en, this message translates to:
  /// **'Occupied'**
  String get tableStatusOccupied;

  /// No description provided for @tableStatusReserved.
  ///
  /// In en, this message translates to:
  /// **'Reserved'**
  String get tableStatusReserved;

  /// No description provided for @validationTableNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a number from 1 to 9999.'**
  String get validationTableNumber;

  /// No description provided for @validationTableCount.
  ///
  /// In en, this message translates to:
  /// **'Enter a count from 1 to 100.'**
  String get validationTableCount;

  /// No description provided for @validationTableSeats.
  ///
  /// In en, this message translates to:
  /// **'Enter seats from 1 to 50.'**
  String get validationTableSeats;

  /// No description provided for @errorTableNumberTaken.
  ///
  /// In en, this message translates to:
  /// **'That table number is already used here.'**
  String get errorTableNumberTaken;

  /// No description provided for @optionalFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optionalFieldHint;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get noDescription;

  /// No description provided for @categoriesHint.
  ///
  /// In en, this message translates to:
  /// **'Group the menu for this venue. Names must be unique here.'**
  String get categoriesHint;

  /// No description provided for @categoriesEmptyOwner.
  ///
  /// In en, this message translates to:
  /// **'Add your first category, then attach articles.'**
  String get categoriesEmptyOwner;

  /// No description provided for @categoriesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No categories in this venue yet.'**
  String get categoriesEmpty;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get addCategory;

  /// No description provided for @editCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit category'**
  String get editCategory;

  /// No description provided for @saveCategory.
  ///
  /// In en, this message translates to:
  /// **'Save category'**
  String get saveCategory;

  /// No description provided for @categoryFormHint.
  ///
  /// In en, this message translates to:
  /// **'Name is unique in this building. Description is optional.'**
  String get categoryFormHint;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category name'**
  String get categoryName;

  /// No description provided for @categoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get categoryDescription;

  /// No description provided for @validationCategoryName.
  ///
  /// In en, this message translates to:
  /// **'Enter a name up to 80 characters.'**
  String get validationCategoryName;

  /// No description provided for @validationDescription.
  ///
  /// In en, this message translates to:
  /// **'Description must be at most 500 characters.'**
  String get validationDescription;

  /// No description provided for @errorCategoryNameTaken.
  ///
  /// In en, this message translates to:
  /// **'That category name is already used here.'**
  String get errorCategoryNameTaken;

  /// No description provided for @articlesHint.
  ///
  /// In en, this message translates to:
  /// **'Sellable items with a price and category. Names must be unique here.'**
  String get articlesHint;

  /// No description provided for @articlesEmptyOwner.
  ///
  /// In en, this message translates to:
  /// **'Add your first article once a category exists.'**
  String get articlesEmptyOwner;

  /// No description provided for @articlesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No articles in this venue yet.'**
  String get articlesEmpty;

  /// No description provided for @articlesNeedCategory.
  ///
  /// In en, this message translates to:
  /// **'Create a category before adding articles.'**
  String get articlesNeedCategory;

  /// No description provided for @addArticle.
  ///
  /// In en, this message translates to:
  /// **'Add article'**
  String get addArticle;

  /// No description provided for @editArticle.
  ///
  /// In en, this message translates to:
  /// **'Edit article'**
  String get editArticle;

  /// No description provided for @saveArticle.
  ///
  /// In en, this message translates to:
  /// **'Save article'**
  String get saveArticle;

  /// No description provided for @articleFormHint.
  ///
  /// In en, this message translates to:
  /// **'Pick a category, set the price, and keep the name unique in this building.'**
  String get articleFormHint;

  /// No description provided for @articleName.
  ///
  /// In en, this message translates to:
  /// **'Article name'**
  String get articleName;

  /// No description provided for @articleDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get articleDescription;

  /// No description provided for @articlePrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get articlePrice;

  /// No description provided for @articleCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get articleCategory;

  /// No description provided for @validationArticleName.
  ///
  /// In en, this message translates to:
  /// **'Enter a name up to 80 characters.'**
  String get validationArticleName;

  /// No description provided for @validationArticlePrice.
  ///
  /// In en, this message translates to:
  /// **'Enter a price greater than 0.'**
  String get validationArticlePrice;

  /// No description provided for @validationArticleCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose a category.'**
  String get validationArticleCategory;

  /// No description provided for @errorArticleNameTaken.
  ///
  /// In en, this message translates to:
  /// **'That article name is already used here.'**
  String get errorArticleNameTaken;
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
