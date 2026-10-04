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
import 'package:sip_sync_server/src/generated/protocol.dart' as _iaib1p48;
import '../../buildings/dtos/admin_building_view.dart' as _i991oo14;
import '../../packs/dtos/building_pack_assignment_view.dart' as _ijuhp44c;
import '../../packs/dtos/pack_billing_period.dart' as _iohcjejn;
import '../../packs/dtos/pack_view.dart' as _i9ywrq0m;

/// One venue for the backoffice detail screen: contact, pack, counts, and platform gain.
abstract class AdminBuildingDetail
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AdminBuildingDetail._({
    required this.building,
    required this.pack,
    required this.categoryCount,
    required this.articleCount,
    required this.tableCount,
    required this.orderCount,
    required this.customerOrderCount,
    required this.customerSales,
    required this.feeEarned,
    this.packBillingPeriod,
    this.packExpiresAt,
    required this.packHistory,
  });

  factory AdminBuildingDetail({
    required _i991oo14.AdminBuildingView building,
    required _i9ywrq0m.PackView pack,
    required int categoryCount,
    required int articleCount,
    required int tableCount,
    required int orderCount,
    required int customerOrderCount,
    required double customerSales,
    required double feeEarned,
    _iohcjejn.PackBillingPeriod? packBillingPeriod,
    DateTime? packExpiresAt,
    required List<_ijuhp44c.BuildingPackAssignmentView> packHistory,
  }) = _AdminBuildingDetailImpl;

  factory AdminBuildingDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminBuildingDetail(
      building: _iaib1p48.Protocol().deserialize<_i991oo14.AdminBuildingView>(
        jsonSerialization['building'],
      ),
      pack: _iaib1p48.Protocol().deserialize<_i9ywrq0m.PackView>(
        jsonSerialization['pack'],
      ),
      categoryCount: jsonSerialization['categoryCount'] as int,
      articleCount: jsonSerialization['articleCount'] as int,
      tableCount: jsonSerialization['tableCount'] as int,
      orderCount: jsonSerialization['orderCount'] as int,
      customerOrderCount: jsonSerialization['customerOrderCount'] as int,
      customerSales: (jsonSerialization['customerSales'] as num).toDouble(),
      feeEarned: (jsonSerialization['feeEarned'] as num).toDouble(),
      packBillingPeriod: jsonSerialization['packBillingPeriod'] == null
          ? null
          : _iohcjejn.PackBillingPeriod.fromJson(
              (jsonSerialization['packBillingPeriod'] as String),
            ),
      packExpiresAt: jsonSerialization['packExpiresAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['packExpiresAt'],
            ),
      packHistory: _iaib1p48.Protocol()
          .deserialize<List<_ijuhp44c.BuildingPackAssignmentView>>(
            jsonSerialization['packHistory'],
          ),
    );
  }

  _i991oo14.AdminBuildingView building;

  _i9ywrq0m.PackView pack;

  int categoryCount;

  int articleCount;

  int tableCount;

  int orderCount;

  int customerOrderCount;

  /// Sum of non-cancelled customer-order lines, in the venue currency.
  double customerSales;

  /// [customerSales] times the pack fee. Staff tickets are not included.
  double feeEarned;

  /// monthly or yearly while a paid pack is assigned. Null on the free pack.
  _iohcjejn.PackBillingPeriod? packBillingPeriod;

  /// When the paid term ends. Null on the free pack.
  DateTime? packExpiresAt;

  /// Newest first. The open row is the plan the venue is on now.
  List<_ijuhp44c.BuildingPackAssignmentView> packHistory;

  /// Returns a shallow copy of this [AdminBuildingDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminBuildingDetail copyWith({
    _i991oo14.AdminBuildingView? building,
    _i9ywrq0m.PackView? pack,
    int? categoryCount,
    int? articleCount,
    int? tableCount,
    int? orderCount,
    int? customerOrderCount,
    double? customerSales,
    double? feeEarned,
    _iohcjejn.PackBillingPeriod? packBillingPeriod,
    DateTime? packExpiresAt,
    List<_ijuhp44c.BuildingPackAssignmentView>? packHistory,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminBuildingDetail',
      'building': building.toJson(),
      'pack': pack.toJson(),
      'categoryCount': categoryCount,
      'articleCount': articleCount,
      'tableCount': tableCount,
      'orderCount': orderCount,
      'customerOrderCount': customerOrderCount,
      'customerSales': customerSales,
      'feeEarned': feeEarned,
      if (packBillingPeriod != null)
        'packBillingPeriod': packBillingPeriod?.toJson(),
      if (packExpiresAt != null) 'packExpiresAt': packExpiresAt?.toJson(),
      'packHistory': packHistory.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminBuildingDetail',
      'building': building.toJsonForProtocol(),
      'pack': pack.toJsonForProtocol(),
      'categoryCount': categoryCount,
      'articleCount': articleCount,
      'tableCount': tableCount,
      'orderCount': orderCount,
      'customerOrderCount': customerOrderCount,
      'customerSales': customerSales,
      'feeEarned': feeEarned,
      if (packBillingPeriod != null)
        'packBillingPeriod': packBillingPeriod?.toJson(),
      if (packExpiresAt != null) 'packExpiresAt': packExpiresAt?.toJson(),
      'packHistory': packHistory.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminBuildingDetailImpl extends AdminBuildingDetail {
  _AdminBuildingDetailImpl({
    required _i991oo14.AdminBuildingView building,
    required _i9ywrq0m.PackView pack,
    required int categoryCount,
    required int articleCount,
    required int tableCount,
    required int orderCount,
    required int customerOrderCount,
    required double customerSales,
    required double feeEarned,
    _iohcjejn.PackBillingPeriod? packBillingPeriod,
    DateTime? packExpiresAt,
    required List<_ijuhp44c.BuildingPackAssignmentView> packHistory,
  }) : super._(
         building: building,
         pack: pack,
         categoryCount: categoryCount,
         articleCount: articleCount,
         tableCount: tableCount,
         orderCount: orderCount,
         customerOrderCount: customerOrderCount,
         customerSales: customerSales,
         feeEarned: feeEarned,
         packBillingPeriod: packBillingPeriod,
         packExpiresAt: packExpiresAt,
         packHistory: packHistory,
       );

  /// Returns a shallow copy of this [AdminBuildingDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminBuildingDetail copyWith({
    _i991oo14.AdminBuildingView? building,
    _i9ywrq0m.PackView? pack,
    int? categoryCount,
    int? articleCount,
    int? tableCount,
    int? orderCount,
    int? customerOrderCount,
    double? customerSales,
    double? feeEarned,
    Object? packBillingPeriod = _Undefined,
    Object? packExpiresAt = _Undefined,
    List<_ijuhp44c.BuildingPackAssignmentView>? packHistory,
  }) {
    return AdminBuildingDetail(
      building: building ?? this.building.copyWith(),
      pack: pack ?? this.pack.copyWith(),
      categoryCount: categoryCount ?? this.categoryCount,
      articleCount: articleCount ?? this.articleCount,
      tableCount: tableCount ?? this.tableCount,
      orderCount: orderCount ?? this.orderCount,
      customerOrderCount: customerOrderCount ?? this.customerOrderCount,
      customerSales: customerSales ?? this.customerSales,
      feeEarned: feeEarned ?? this.feeEarned,
      packBillingPeriod: packBillingPeriod is _iohcjejn.PackBillingPeriod?
          ? packBillingPeriod
          : this.packBillingPeriod,
      packExpiresAt: packExpiresAt is DateTime?
          ? packExpiresAt
          : this.packExpiresAt,
      packHistory:
          packHistory ?? this.packHistory.map((e0) => e0.copyWith()).toList(),
    );
  }
}
