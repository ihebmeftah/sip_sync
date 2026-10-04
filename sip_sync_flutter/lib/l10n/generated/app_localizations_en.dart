// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sip Sync';

  @override
  String get tagline => 'Tables, tastes, and a seat that knows your name.';

  @override
  String get atmosphereTitle => 'A seat that knows your name';

  @override
  String get atmosphereBody =>
      'Walk in, order, and pick up — the house already has your table.';

  @override
  String get authLead => 'Welcome back';

  @override
  String get registerLead => 'Create your seat';

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
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingStart => 'Get started';

  @override
  String get onboardingFindTitle => 'Find a place nearby';

  @override
  String get onboardingFindBody =>
      'Cafés, restaurants, and lounges around you, with how far each one is.';

  @override
  String get onboardingPlaceTitle => 'Set where you are';

  @override
  String get onboardingPlaceBody =>
      'Type an address or use your current position. We only use it to rank venues.';

  @override
  String get onboardingWalkTitle => 'See the walk';

  @override
  String get onboardingWalkBody =>
      'Distance in kilometres and an approximate walk time, or open the map.';

  @override
  String get discoverLead => 'Places near you';

  @override
  String get placeHint => 'Address or neighbourhood';

  @override
  String get useMyLocation => 'Use my location';

  @override
  String get currentPosition => 'Current position';

  @override
  String get listMode => 'List';

  @override
  String get mapMode => 'Map';

  @override
  String get nearbyFilter => 'Nearby · 15 km';

  @override
  String get allVenues => 'All venues';

  @override
  String get nearbyEmpty => 'Nothing within 15 km. Show every venue instead.';

  @override
  String get showAllVenues => 'Show all venues';

  @override
  String get setPlacePrompt =>
      'Add your address or use your location to see distance and walk time.';

  @override
  String walkAway(int minutes) {
    return '~$minutes min walk';
  }

  @override
  String distanceKm(String distance) {
    return '$distance km';
  }

  @override
  String hoursRange(String open, String close) {
    return '$open–$close';
  }

  @override
  String get errorPlaceLookup => 'Could not look up that address.';

  @override
  String get errorLocationDenied =>
      'Location permission is off. Type an address instead.';

  @override
  String get errorLocationDisabled => 'Location services are turned off.';

  @override
  String get errorLocationFailed => 'Could not read your location.';

  @override
  String get osmAttribution => '© OpenStreetMap contributors';

  @override
  String get noVenues => 'No venues yet.';

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
  String get validationPhoneCountry =>
      'Unsupported country code. Choose a supported dial code.';

  @override
  String get phoneCountryCode => 'Code';

  @override
  String phoneCountryHint(String code) {
    return 'Country: $code';
  }

  @override
  String get close => 'Close';

  @override
  String get back => 'Back';

  @override
  String get menu => 'Menu';

  @override
  String availableTables(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tables free',
      one: '1 table free',
      zero: 'No tables free',
    );
    return '$_temp0';
  }

  @override
  String get previewCategories => 'Top categories';

  @override
  String get previewArticles => 'Top dishes';

  @override
  String articleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dishes',
      one: '1 dish',
      zero: 'No dishes',
    );
    return '$_temp0';
  }

  @override
  String get emptyMenuPreview => 'Nothing on the menu yet.';

  @override
  String get emptyMenu => 'This house has not published a menu yet.';

  @override
  String get emptyMenuSection => 'Nothing in this section yet.';

  @override
  String get seeAll => 'See all';

  @override
  String tableNumber(int number) {
    return 'Table $number';
  }

  @override
  String get discoveryTab => 'Discovery';

  @override
  String get ordersTab => 'Orders';

  @override
  String get filterToday => 'Today';

  @override
  String get filterLastWeek => 'Last week';

  @override
  String get filterLastMonth => 'Last month';

  @override
  String get emptyOrders => 'No orders in this period.';

  @override
  String orderItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dishes',
      one: '1 dish',
    );
    return '$_temp0';
  }

  @override
  String get orderStatusProgress => 'In progress';

  @override
  String get orderStatusPayed => 'Paid';

  @override
  String get orderStatusCancelled => 'Cancelled';

  @override
  String get openOrderNote => 'Order in progress';

  @override
  String get itemStatusPicked => 'In the kitchen';

  @override
  String get itemStatusReady => 'Ready';

  @override
  String get itemStatusServed => 'Served';

  @override
  String get scanTable => 'Scan table';

  @override
  String get changeTable => 'Change table';

  @override
  String get scanTableHint => 'Point the camera at the QR code on your table.';

  @override
  String get tableScanInvalid => 'This is not a Sip Sync table code.';

  @override
  String get tableScanUnknown => 'This code is not an active table.';

  @override
  String get tableScanCamera =>
      'Camera is unavailable. Allow camera access and try again.';

  @override
  String get yourTable => 'Your table';

  @override
  String seatedAt(int number) {
    return 'You\'re at table $number';
  }

  @override
  String tableChanged(int number) {
    return 'Table changed. You\'re now at table $number.';
  }

  @override
  String get addArticle => 'Add';

  @override
  String get removeArticle => 'Remove';

  @override
  String get passOrder => 'Pass order';

  @override
  String get yourOrder => 'Your order';

  @override
  String get orderEmpty => 'Add a dish before sending the order.';

  @override
  String get scanTableToOrder =>
      'Scan the QR code on your table to send this order.';

  @override
  String cartSummary(int count, String total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dishes',
      one: '1 dish',
    );
    return '$_temp0 · $total';
  }

  @override
  String get total => 'Total';

  @override
  String get orderSent => 'Sent to the kitchen';

  @override
  String orderRef(int ref) {
    return 'Order #$ref';
  }

  @override
  String lineQuantity(int count, String name) {
    return '$count × $name';
  }

  @override
  String get errorTableOccupied => 'This table already has an open order.';

  @override
  String get errorInsufficientStock =>
      'Something on this order is no longer available.';

  @override
  String get errorAppendNotAllowed =>
      'This house does not allow adding dishes to an open order.';

  @override
  String get currentOrder => 'Current order';

  @override
  String get orderHistory => 'Order history';

  @override
  String get addToOrder => 'Add to order';

  @override
  String get scanDisabled => 'Scan is unavailable while your order is open.';

  @override
  String seatCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seats',
      one: '1 seat',
    );
    return '$_temp0';
  }

  @override
  String get venueTypeCafe => 'Café';

  @override
  String get venueTypeRestaurant => 'Restaurant';

  @override
  String get venueTypeLounge => 'Lounge';

  @override
  String get venueTypeBar => 'Bar';

  @override
  String get errorPackLimit => 'This plan has reached its limit.';

  @override
  String get errorPackFeature => 'This plan does not include that.';
}
