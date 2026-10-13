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

/// Why a floor-board event was sent.
enum OrderBoardEventKind implements _is.SerializableModel {
  /// One open order already on the floor when the stream starts.
  snapshot,

  /// Snapshots are finished. Later events are live.
  synced,

  /// A ticket was just created.
  orderOpened,

  /// Lines were appended to a ticket that already existed.
  itemsAdded,

  /// A line moved, or the ticket was cancelled or paid.
  changed;

  static OrderBoardEventKind fromJson(String name) {
    switch (name) {
      case 'snapshot':
        return OrderBoardEventKind.snapshot;
      case 'synced':
        return OrderBoardEventKind.synced;
      case 'orderOpened':
        return OrderBoardEventKind.orderOpened;
      case 'itemsAdded':
        return OrderBoardEventKind.itemsAdded;
      case 'changed':
        return OrderBoardEventKind.changed;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "OrderBoardEventKind"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
