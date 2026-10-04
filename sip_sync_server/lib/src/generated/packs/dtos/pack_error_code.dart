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

enum PackErrorCode implements _is.SerializableModel {
  invalidInput,
  notFound,
  codeTaken,
  cannotDeleteSystemPack,
  packInUse,
  limitReached,
  featureOff,
  paidPlanActive;

  static PackErrorCode fromJson(int index) {
    switch (index) {
      case 0:
        return PackErrorCode.invalidInput;
      case 1:
        return PackErrorCode.notFound;
      case 2:
        return PackErrorCode.codeTaken;
      case 3:
        return PackErrorCode.cannotDeleteSystemPack;
      case 4:
        return PackErrorCode.packInUse;
      case 5:
        return PackErrorCode.limitReached;
      case 6:
        return PackErrorCode.featureOff;
      case 7:
        return PackErrorCode.paidPlanActive;
      default:
        throw ArgumentError(
          'Value "$index" cannot be converted to "PackErrorCode"',
        );
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
