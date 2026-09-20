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

/// Lifecycle of a venue order (open → payed / cancelled).
enum OrderStatus implements _is.SerializableModel {
  /// Open order; items may still be prepared or unpaid.
  progress,

  /// Every non-cancelled line is payed.
  payed,

  /// Order cancelled; no further prep or payment.
  cancelled;

  static OrderStatus fromJson(String name) {
    switch (name) {
      case 'progress':
        return OrderStatus.progress;
      case 'payed':
        return OrderStatus.payed;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "OrderStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
