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
  String get navUsers => 'Users';

  @override
  String get navBuildings => 'Buildings';

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
}
