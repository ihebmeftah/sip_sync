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
  /// **'Sip Sync'**
  String get appTitle;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Tables, tastes, and a seat that knows your name.'**
  String get tagline;

  /// No description provided for @atmosphereTitle.
  ///
  /// In en, this message translates to:
  /// **'A seat that knows your name'**
  String get atmosphereTitle;

  /// No description provided for @atmosphereBody.
  ///
  /// In en, this message translates to:
  /// **'Walk in, order, and pick up — the house already has your table.'**
  String get atmosphereBody;

  /// No description provided for @authLead.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authLead;

  /// No description provided for @registerLead.
  ///
  /// In en, this message translates to:
  /// **'Create your seat'**
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

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboardingStart;

  /// No description provided for @onboardingFindTitle.
  ///
  /// In en, this message translates to:
  /// **'Find a place nearby'**
  String get onboardingFindTitle;

  /// No description provided for @onboardingFindBody.
  ///
  /// In en, this message translates to:
  /// **'Cafés, restaurants, and lounges around you, with how far each one is.'**
  String get onboardingFindBody;

  /// No description provided for @onboardingPlaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Set where you are'**
  String get onboardingPlaceTitle;

  /// No description provided for @onboardingPlaceBody.
  ///
  /// In en, this message translates to:
  /// **'Type an address or use your current position. We only use it to rank venues.'**
  String get onboardingPlaceBody;

  /// No description provided for @onboardingWalkTitle.
  ///
  /// In en, this message translates to:
  /// **'See the walk'**
  String get onboardingWalkTitle;

  /// No description provided for @onboardingWalkBody.
  ///
  /// In en, this message translates to:
  /// **'Distance in kilometres and an approximate walk time, or open the map.'**
  String get onboardingWalkBody;

  /// No description provided for @discoverLead.
  ///
  /// In en, this message translates to:
  /// **'Places near you'**
  String get discoverLead;

  /// No description provided for @placeHint.
  ///
  /// In en, this message translates to:
  /// **'Address or neighbourhood'**
  String get placeHint;

  /// No description provided for @useMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Use my location'**
  String get useMyLocation;

  /// No description provided for @currentPosition.
  ///
  /// In en, this message translates to:
  /// **'Current position'**
  String get currentPosition;

  /// No description provided for @listMode.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get listMode;

  /// No description provided for @mapMode.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get mapMode;

  /// No description provided for @nearbyFilter.
  ///
  /// In en, this message translates to:
  /// **'Nearby · 15 km'**
  String get nearbyFilter;

  /// No description provided for @allVenues.
  ///
  /// In en, this message translates to:
  /// **'All venues'**
  String get allVenues;

  /// No description provided for @nearbyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing within 15 km. Show every venue instead.'**
  String get nearbyEmpty;

  /// No description provided for @showAllVenues.
  ///
  /// In en, this message translates to:
  /// **'Show all venues'**
  String get showAllVenues;

  /// No description provided for @setPlacePrompt.
  ///
  /// In en, this message translates to:
  /// **'Add your address or use your location to see distance and walk time.'**
  String get setPlacePrompt;

  /// No description provided for @walkAway.
  ///
  /// In en, this message translates to:
  /// **'~{minutes} min walk'**
  String walkAway(int minutes);

  /// No description provided for @distanceKm.
  ///
  /// In en, this message translates to:
  /// **'{distance} km'**
  String distanceKm(String distance);

  /// No description provided for @hoursRange.
  ///
  /// In en, this message translates to:
  /// **'{open}–{close}'**
  String hoursRange(String open, String close);

  /// No description provided for @errorPlaceLookup.
  ///
  /// In en, this message translates to:
  /// **'Could not look up that address.'**
  String get errorPlaceLookup;

  /// No description provided for @errorLocationDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission is off. Type an address instead.'**
  String get errorLocationDenied;

  /// No description provided for @errorLocationDisabled.
  ///
  /// In en, this message translates to:
  /// **'Location services are turned off.'**
  String get errorLocationDisabled;

  /// No description provided for @errorLocationFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not read your location.'**
  String get errorLocationFailed;

  /// No description provided for @osmAttribution.
  ///
  /// In en, this message translates to:
  /// **'© OpenStreetMap contributors'**
  String get osmAttribution;

  /// No description provided for @noVenues.
  ///
  /// In en, this message translates to:
  /// **'No venues yet.'**
  String get noVenues;

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

  /// No description provided for @validationPhoneCountry.
  ///
  /// In en, this message translates to:
  /// **'Unsupported country code. Choose a supported dial code.'**
  String get validationPhoneCountry;

  /// No description provided for @phoneCountryCode.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get phoneCountryCode;

  /// No description provided for @phoneCountryHint.
  ///
  /// In en, this message translates to:
  /// **'Country: {code}'**
  String phoneCountryHint(String code);

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @availableTables.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No tables free} =1{1 table free} other{{count} tables free}}'**
  String availableTables(int count);

  /// No description provided for @previewCategories.
  ///
  /// In en, this message translates to:
  /// **'Top categories'**
  String get previewCategories;

  /// No description provided for @previewArticles.
  ///
  /// In en, this message translates to:
  /// **'Top dishes'**
  String get previewArticles;

  /// No description provided for @articleCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No dishes} =1{1 dish} other{{count} dishes}}'**
  String articleCount(int count);

  /// No description provided for @emptyMenuPreview.
  ///
  /// In en, this message translates to:
  /// **'Nothing on the menu yet.'**
  String get emptyMenuPreview;

  /// No description provided for @emptyMenu.
  ///
  /// In en, this message translates to:
  /// **'This house has not published a menu yet.'**
  String get emptyMenu;

  /// No description provided for @emptyMenuSection.
  ///
  /// In en, this message translates to:
  /// **'Nothing in this section yet.'**
  String get emptyMenuSection;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @tableNumber.
  ///
  /// In en, this message translates to:
  /// **'Table {number}'**
  String tableNumber(int number);

  /// No description provided for @discoveryTab.
  ///
  /// In en, this message translates to:
  /// **'Discovery'**
  String get discoveryTab;

  /// No description provided for @ordersTab.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get ordersTab;

  /// No description provided for @filterToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get filterToday;

  /// No description provided for @filterLastWeek.
  ///
  /// In en, this message translates to:
  /// **'Last week'**
  String get filterLastWeek;

  /// No description provided for @filterLastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last month'**
  String get filterLastMonth;

  /// No description provided for @emptyOrders.
  ///
  /// In en, this message translates to:
  /// **'No orders in this period.'**
  String get emptyOrders;

  /// No description provided for @orderItemCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 dish} other{{count} dishes}}'**
  String orderItemCount(int count);

  /// No description provided for @orderStatusProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get orderStatusProgress;

  /// No description provided for @orderStatusPayed.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get orderStatusPayed;

  /// No description provided for @orderStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get orderStatusCancelled;

  /// No description provided for @openOrderNote.
  ///
  /// In en, this message translates to:
  /// **'Order in progress'**
  String get openOrderNote;

  /// No description provided for @itemStatusPicked.
  ///
  /// In en, this message translates to:
  /// **'In the kitchen'**
  String get itemStatusPicked;

  /// No description provided for @itemStatusReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get itemStatusReady;

  /// No description provided for @itemStatusServed.
  ///
  /// In en, this message translates to:
  /// **'Served'**
  String get itemStatusServed;

  /// No description provided for @scanTable.
  ///
  /// In en, this message translates to:
  /// **'Scan table'**
  String get scanTable;

  /// No description provided for @changeTable.
  ///
  /// In en, this message translates to:
  /// **'Change table'**
  String get changeTable;

  /// No description provided for @scanTableHint.
  ///
  /// In en, this message translates to:
  /// **'Point the camera at the QR code on your table.'**
  String get scanTableHint;

  /// No description provided for @tableScanInvalid.
  ///
  /// In en, this message translates to:
  /// **'This is not a Sip Sync table code.'**
  String get tableScanInvalid;

  /// No description provided for @tableScanUnknown.
  ///
  /// In en, this message translates to:
  /// **'This code is not an active table.'**
  String get tableScanUnknown;

  /// No description provided for @tableScanCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera is unavailable. Allow camera access and try again.'**
  String get tableScanCamera;

  /// No description provided for @yourTable.
  ///
  /// In en, this message translates to:
  /// **'Your table'**
  String get yourTable;

  /// No description provided for @seatedAt.
  ///
  /// In en, this message translates to:
  /// **'You\'re at table {number}'**
  String seatedAt(int number);

  /// No description provided for @tableChanged.
  ///
  /// In en, this message translates to:
  /// **'Table changed. You\'re now at table {number}.'**
  String tableChanged(int number);

  /// No description provided for @addArticle.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addArticle;

  /// No description provided for @removeArticle.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeArticle;

  /// No description provided for @passOrder.
  ///
  /// In en, this message translates to:
  /// **'Pass order'**
  String get passOrder;

  /// No description provided for @yourOrder.
  ///
  /// In en, this message translates to:
  /// **'Your order'**
  String get yourOrder;

  /// No description provided for @orderEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add a dish before sending the order.'**
  String get orderEmpty;

  /// No description provided for @scanTableToOrder.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR code on your table to send this order.'**
  String get scanTableToOrder;

  /// No description provided for @cartSummary.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 dish} other{{count} dishes}} · {total}'**
  String cartSummary(int count, String total);

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @orderSent.
  ///
  /// In en, this message translates to:
  /// **'Sent to the kitchen'**
  String get orderSent;

  /// No description provided for @orderRef.
  ///
  /// In en, this message translates to:
  /// **'Order #{ref}'**
  String orderRef(int ref);

  /// No description provided for @lineQuantity.
  ///
  /// In en, this message translates to:
  /// **'{count} × {name}'**
  String lineQuantity(int count, String name);

  /// No description provided for @errorTableOccupied.
  ///
  /// In en, this message translates to:
  /// **'This table already has an open order.'**
  String get errorTableOccupied;

  /// No description provided for @errorInsufficientStock.
  ///
  /// In en, this message translates to:
  /// **'Something on this order is no longer available.'**
  String get errorInsufficientStock;

  /// No description provided for @errorAppendNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'This house does not allow adding dishes to an open order.'**
  String get errorAppendNotAllowed;

  /// No description provided for @currentOrder.
  ///
  /// In en, this message translates to:
  /// **'Current order'**
  String get currentOrder;

  /// No description provided for @orderHistory.
  ///
  /// In en, this message translates to:
  /// **'Order history'**
  String get orderHistory;

  /// No description provided for @addToOrder.
  ///
  /// In en, this message translates to:
  /// **'Add to order'**
  String get addToOrder;

  /// No description provided for @scanDisabled.
  ///
  /// In en, this message translates to:
  /// **'Scan is unavailable while your order is open.'**
  String get scanDisabled;

  /// No description provided for @seatCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 seat} other{{count} seats}}'**
  String seatCount(int count);

  /// No description provided for @venueTypeCafe.
  ///
  /// In en, this message translates to:
  /// **'Café'**
  String get venueTypeCafe;

  /// No description provided for @venueTypeRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get venueTypeRestaurant;

  /// No description provided for @venueTypeLounge.
  ///
  /// In en, this message translates to:
  /// **'Lounge'**
  String get venueTypeLounge;

  /// No description provided for @venueTypeBar.
  ///
  /// In en, this message translates to:
  /// **'Bar'**
  String get venueTypeBar;

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

  /// No description provided for @errorPackPaidActive.
  ///
  /// In en, this message translates to:
  /// **'This venue already has a paid plan.'**
  String get errorPackPaidActive;

  /// No description provided for @orderingUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This venue\'s plan does not include ordering from the app. You can still browse the menu.'**
  String get orderingUnavailable;

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
