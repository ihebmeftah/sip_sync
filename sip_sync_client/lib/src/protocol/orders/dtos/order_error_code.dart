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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

enum OrderErrorCode implements _isc.SerializableModel {
  invalidInput,
  notAuthorized,
  notFound,
  invalidStatus,

  /// Not enough ingredient stock for an ordered article's composition.
  insufficientStock,

  /// Table already has an open order and building.tableMultiOrder is false.
  tableOccupied,

  /// Building does not allow appending articles to an existing order.
  appendNotAllowed,

  /// Employee access profile does not allow this action.
  permissionDenied;

  static OrderErrorCode fromJson(String name) {
    switch (name) {
      case 'invalidInput':
        return OrderErrorCode.invalidInput;
      case 'notAuthorized':
        return OrderErrorCode.notAuthorized;
      case 'notFound':
        return OrderErrorCode.notFound;
      case 'invalidStatus':
        return OrderErrorCode.invalidStatus;
      case 'insufficientStock':
        return OrderErrorCode.insufficientStock;
      case 'tableOccupied':
        return OrderErrorCode.tableOccupied;
      case 'appendNotAllowed':
        return OrderErrorCode.appendNotAllowed;
      case 'permissionDenied':
        return OrderErrorCode.permissionDenied;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "OrderErrorCode"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
