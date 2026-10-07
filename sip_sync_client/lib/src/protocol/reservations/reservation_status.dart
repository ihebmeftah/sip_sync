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

/// Lifecycle of a table booking.
enum ReservationStatus implements _isc.SerializableModel {
  booked,
  arrived,
  cancelled,
  noShow;

  static ReservationStatus fromJson(String name) {
    switch (name) {
      case 'booked':
        return ReservationStatus.booked;
      case 'arrived':
        return ReservationStatus.arrived;
      case 'cancelled':
        return ReservationStatus.cancelled;
      case 'noShow':
        return ReservationStatus.noShow;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "ReservationStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
