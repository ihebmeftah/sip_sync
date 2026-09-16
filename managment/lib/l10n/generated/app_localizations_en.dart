// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sip Sync Ops';

  @override
  String get tagline => 'Floor, kitchen, and till — one login for the house.';

  @override
  String get atmosphereTitle => 'Run the house from one screen';

  @override
  String get atmosphereBody =>
      'Owners and staff share a login. What you can do is decided on the server.';

  @override
  String get authLead => 'Staff sign in';

  @override
  String get registerLead => 'Open an owner account';

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
  String get opsRailTagline => 'Floor command';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navProfile => 'Profile';

  @override
  String get navProducts => 'Products';

  @override
  String get navArticles => 'Articles';

  @override
  String get navIngredients => 'Ingredients';

  @override
  String get navPos => 'POS';

  @override
  String get navTables => 'Tables';

  @override
  String helloScreen(String screen) {
    return 'Hello, $screen';
  }

  @override
  String get placeholderBody =>
      'This screen is not connected to the server yet.';

  @override
  String get saveProfile => 'Save profile';

  @override
  String get profileSaved => 'Profile updated.';

  @override
  String get myProfile => 'Your profile';

  @override
  String get teamProfiles => 'Added staff';

  @override
  String get viewProfile => 'View';

  @override
  String get employeeProfile => 'Staff profile';

  @override
  String get themeLight => 'Light theme';

  @override
  String get themeDark => 'Dark theme';

  @override
  String get dashboardEyebrow => 'Tonight’s house';

  @override
  String get dashboardSubtitle =>
      'POS, floor, and catalog sit one tap away. Live counts arrive with the next server slice.';

  @override
  String get dashboardShift => 'Shift board';

  @override
  String get dashboardPosCue => 'Till and tickets — coming next.';

  @override
  String get dashboardTablesCue => 'Floor map without a backend yet.';

  @override
  String get dashboardCatalogCue => 'Articles and ingredients, UI only.';

  @override
  String get dashboardProfileCue => 'Your details and the team you added.';

  @override
  String get emailLocked =>
      'Email is tied to sign-in and cannot be changed here.';

  @override
  String get profileHint =>
      'Update the name the floor sees. Owners can open staff profiles below.';
}
