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

/// Lifecycle of a single order line (kitchen / floor / payment).
enum OrderItemStatus implements _is.SerializableModel {
  /// Line created; waiting to be picked up for prep.
  progress,

  /// Taken by kitchen / prep station.
  picked,

  /// Prepared and waiting to be served.
  ready,

  /// Delivered to the guest.
  served,

  /// Payment recorded for this line.
  payed,

  /// Line cancelled.
  cancelled;

  static OrderItemStatus fromJson(String name) {
    switch (name) {
      case 'progress':
        return OrderItemStatus.progress;
      case 'picked':
        return OrderItemStatus.picked;
      case 'ready':
        return OrderItemStatus.ready;
      case 'served':
        return OrderItemStatus.served;
      case 'payed':
        return OrderItemStatus.payed;
      case 'cancelled':
        return OrderItemStatus.cancelled;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "OrderItemStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
