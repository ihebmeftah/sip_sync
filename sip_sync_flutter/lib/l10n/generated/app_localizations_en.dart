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
}
