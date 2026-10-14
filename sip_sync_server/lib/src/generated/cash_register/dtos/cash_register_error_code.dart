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

enum CashRegisterErrorCode implements _is.SerializableModel {
  notAuthorized,
  notFound,

  /// Venue switch is off, so a new session cannot be opened.
  disabled,
  registerAlreadyOpen,
  registerNotOpen,
  registerHasOpenOrders,

  /// Opening or closing cash was negative or not a real number.
  invalidAmount,

  /// The shift has an opening count, so closing cash cannot be left blank.
  endCashRequired;

  static CashRegisterErrorCode fromJson(String name) {
    switch (name) {
      case 'notAuthorized':
        return CashRegisterErrorCode.notAuthorized;
      case 'notFound':
        return CashRegisterErrorCode.notFound;
      case 'disabled':
        return CashRegisterErrorCode.disabled;
      case 'registerAlreadyOpen':
        return CashRegisterErrorCode.registerAlreadyOpen;
      case 'registerNotOpen':
        return CashRegisterErrorCode.registerNotOpen;
      case 'registerHasOpenOrders':
        return CashRegisterErrorCode.registerHasOpenOrders;
      case 'invalidAmount':
        return CashRegisterErrorCode.invalidAmount;
      case 'endCashRequired':
        return CashRegisterErrorCode.endCashRequired;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "CashRegisterErrorCode"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
