/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

enum AccountErrorCode implements _is.SerializableModel {
  invalidInput,
  emailTaken,
  usernameTaken,
  phoneTaken,
  invalidCredentials,
  appAccessDenied,
  notAuthorized,
  notFound,
  cannotDeleteDefaultAdmin,
  passwordTooWeak,
  profileIncomplete,
  accountDisabled,
  invalidResetCode,
  resetCodeExpired;

  static AccountErrorCode fromJson(int index) {
    switch (index) {
      case 0:
        return AccountErrorCode.invalidInput;
      case 1:
        return AccountErrorCode.emailTaken;
      case 2:
        return AccountErrorCode.usernameTaken;
      case 3:
        return AccountErrorCode.phoneTaken;
      case 4:
        return AccountErrorCode.invalidCredentials;
      case 5:
        return AccountErrorCode.appAccessDenied;
      case 6:
        return AccountErrorCode.notAuthorized;
      case 7:
        return AccountErrorCode.notFound;
      case 8:
        return AccountErrorCode.cannotDeleteDefaultAdmin;
      case 9:
        return AccountErrorCode.passwordTooWeak;
      case 10:
        return AccountErrorCode.profileIncomplete;
      case 11:
        return AccountErrorCode.accountDisabled;
      case 12:
        return AccountErrorCode.invalidResetCode;
      case 13:
        return AccountErrorCode.resetCodeExpired;
      default:
        throw ArgumentError(
          'Value "$index" cannot be converted to "AccountErrorCode"',
        );
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
