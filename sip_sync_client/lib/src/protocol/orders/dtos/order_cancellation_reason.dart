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

/// Why staff cancelled an order or one of its lines.
enum OrderCancellationReason implements _isc.SerializableModel {
  ingredientOutOfStock,
  closingSoon,
  workBreakdown,
  customerRequest;

  static OrderCancellationReason fromJson(String name) {
    switch (name) {
      case 'ingredientOutOfStock':
        return OrderCancellationReason.ingredientOutOfStock;
      case 'closingSoon':
        return OrderCancellationReason.closingSoon;
      case 'workBreakdown':
        return OrderCancellationReason.workBreakdown;
      case 'customerRequest':
        return OrderCancellationReason.customerRequest;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "OrderCancellationReason"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
