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
import 'package:sip_sync_client/src/protocol/protocol.dart' as _iozg9o5r;
import '../../stats/dtos/public_pack_usage.dart' as _i91chiq8;

/// Platform totals for the backoffice stats screen. Super admin only.
abstract class PlatformStats
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PlatformStats._({
    required this.ownerCount,
    required this.customerCount,
    required this.employeeCount,
    required this.venueCount,
    required this.orderCount,
    required this.customerOrderCount,
    required this.subscriptionMillimes,
    required this.publicPacks,
  });

  factory PlatformStats({
    required int ownerCount,
    required int customerCount,
    required int employeeCount,
    required int venueCount,
    required int orderCount,
    required int customerOrderCount,
    required int subscriptionMillimes,
    required List<_i91chiq8.PublicPackUsage> publicPacks,
  }) = _PlatformStatsImpl;

  factory PlatformStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlatformStats(
      ownerCount: jsonSerialization['ownerCount'] as int,
      customerCount: jsonSerialization['customerCount'] as int,
      employeeCount: jsonSerialization['employeeCount'] as int,
      venueCount: jsonSerialization['venueCount'] as int,
      orderCount: jsonSerialization['orderCount'] as int,
      customerOrderCount: jsonSerialization['customerOrderCount'] as int,
      subscriptionMillimes: jsonSerialization['subscriptionMillimes'] as int,
      publicPacks: _iozg9o5r.Protocol()
          .deserialize<List<_i91chiq8.PublicPackUsage>>(
            jsonSerialization['publicPacks'],
          ),
    );
  }

  int ownerCount;

  int customerCount;

  int employeeCount;

  int venueCount;

  int orderCount;

  /// Customer-placed orders that were not cancelled.
  int customerOrderCount;

  /// Sum of each venue's monthly pack price, in millimes. Catalog currency is TND.
  int subscriptionMillimes;

  List<_i91chiq8.PublicPackUsage> publicPacks;

  /// Returns a shallow copy of this [PlatformStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PlatformStats copyWith({
    int? ownerCount,
    int? customerCount,
    int? employeeCount,
    int? venueCount,
    int? orderCount,
    int? customerOrderCount,
    int? subscriptionMillimes,
    List<_i91chiq8.PublicPackUsage>? publicPacks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlatformStats',
      'ownerCount': ownerCount,
      'customerCount': customerCount,
      'employeeCount': employeeCount,
      'venueCount': venueCount,
      'orderCount': orderCount,
      'customerOrderCount': customerOrderCount,
      'subscriptionMillimes': subscriptionMillimes,
      'publicPacks': publicPacks.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlatformStats',
      'ownerCount': ownerCount,
      'customerCount': customerCount,
      'employeeCount': employeeCount,
      'venueCount': venueCount,
      'orderCount': orderCount,
      'customerOrderCount': customerOrderCount,
      'subscriptionMillimes': subscriptionMillimes,
      'publicPacks': publicPacks.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _PlatformStatsImpl extends PlatformStats {
  _PlatformStatsImpl({
    required int ownerCount,
    required int customerCount,
    required int employeeCount,
    required int venueCount,
    required int orderCount,
    required int customerOrderCount,
    required int subscriptionMillimes,
    required List<_i91chiq8.PublicPackUsage> publicPacks,
  }) : super._(
         ownerCount: ownerCount,
         customerCount: customerCount,
         employeeCount: employeeCount,
         venueCount: venueCount,
         orderCount: orderCount,
         customerOrderCount: customerOrderCount,
         subscriptionMillimes: subscriptionMillimes,
         publicPacks: publicPacks,
       );

  /// Returns a shallow copy of this [PlatformStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PlatformStats copyWith({
    int? ownerCount,
    int? customerCount,
    int? employeeCount,
    int? venueCount,
    int? orderCount,
    int? customerOrderCount,
    int? subscriptionMillimes,
    List<_i91chiq8.PublicPackUsage>? publicPacks,
  }) {
    return PlatformStats(
      ownerCount: ownerCount ?? this.ownerCount,
      customerCount: customerCount ?? this.customerCount,
      employeeCount: employeeCount ?? this.employeeCount,
      venueCount: venueCount ?? this.venueCount,
      orderCount: orderCount ?? this.orderCount,
      customerOrderCount: customerOrderCount ?? this.customerOrderCount,
      subscriptionMillimes: subscriptionMillimes ?? this.subscriptionMillimes,
      publicPacks:
          publicPacks ?? this.publicPacks.map((e0) => e0.copyWith()).toList(),
    );
  }
}
