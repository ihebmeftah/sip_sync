/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import 'package:sip_sync_server/src/generated/protocol.dart' as _iaib1p48;
import '../../auth/entity/employee.dart' as _ie30fksv;
import '../../auth/entity/owner.dart' as _i2wy11ca;
import '../../buildings/dtos/strict_mode_step.dart' as _ik04yv2w;
import '../../employee_access/entity/employee_access.dart' as _i5dpfzds;
import '../../menu/entity/ingredient.dart' as _ixki5cxr;
import '../../menu/entity/menu_article.dart' as _is7gdyz6;
import '../../menu/entity/menu_category.dart' as _illkjvef;
import '../../orders/entity/venue_order.dart' as _iwamn8sj;
import '../../packs/dtos/pack_billing_period.dart' as _iohcjejn;
import '../../packs/entity/building_pack_assignment.dart' as _iq3bhcsv;
import '../../packs/entity/pack.dart' as _iqwmqtub;
import '../../reservations/entity/reservation.dart' as _iq51mm5o;
import '../../tables/entity/venue_table.dart' as _ilcfc7kr;

/// A café, restaurant, lounge, bar, or custom venue owned by one owner.
abstract class Building
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  Building._({
    this.id,
    required this.ownerId,
    this.owner,
    required this.name,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.openingMinutes,
    required this.closingMinutes,
    required this.currencyCode,
    required this.phoneNumber,
    required this.countryCode,
    String? countryName,
    this.whatsapp,
    this.instagram,
    this.facebook,
    required this.otherLinks,
    bool? tableMultiOrder,
    bool? allowAppendingItemsToOrder,
    bool? strictMode,
    required this.strictModeSteps,
    double? reservationFee,
    bool? customerOrderingEnabled,
    bool? reservationsEnabled,
    bool? allowOutOfStockOrders,
    DateTime? createdAt,
    this.employees,
    this.accessProfiles,
    this.tables,
    this.menuCategories,
    this.menuArticles,
    this.ingredients,
    this.orders,
    this.reservations,
    this.packAssignments,
    required this.packId,
    this.pack,
    this.packBillingPeriod,
    this.packExpiresAt,
  }) : countryName = countryName ?? '',
       tableMultiOrder = tableMultiOrder ?? false,
       allowAppendingItemsToOrder = allowAppendingItemsToOrder ?? true,
       strictMode = strictMode ?? false,
       reservationFee = reservationFee ?? 0.0,
       customerOrderingEnabled = customerOrderingEnabled ?? true,
       reservationsEnabled = reservationsEnabled ?? true,
       allowOutOfStockOrders = allowOutOfStockOrders ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Building({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    _i2wy11ca.Owner? owner,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    required String phoneNumber,
    required String countryCode,
    String? countryName,
    String? whatsapp,
    String? instagram,
    String? facebook,
    required List<String> otherLinks,
    bool? tableMultiOrder,
    bool? allowAppendingItemsToOrder,
    bool? strictMode,
    required List<_ik04yv2w.StrictModeStep> strictModeSteps,
    double? reservationFee,
    bool? customerOrderingEnabled,
    bool? reservationsEnabled,
    bool? allowOutOfStockOrders,
    DateTime? createdAt,
    List<_ie30fksv.Employee>? employees,
    List<_i5dpfzds.EmployeeAccess>? accessProfiles,
    List<_ilcfc7kr.VenueTable>? tables,
    List<_illkjvef.MenuCategory>? menuCategories,
    List<_is7gdyz6.MenuArticle>? menuArticles,
    List<_ixki5cxr.Ingredient>? ingredients,
    List<_iwamn8sj.VenueOrder>? orders,
    List<_iq51mm5o.Reservation>? reservations,
    List<_iq3bhcsv.BuildingPackAssignment>? packAssignments,
    required _is.UuidValue packId,
    _iqwmqtub.Pack? pack,
    _iohcjejn.PackBillingPeriod? packBillingPeriod,
    DateTime? packExpiresAt,
  }) = _BuildingImpl;

  factory Building.fromJson(Map<String, dynamic> jsonSerialization) {
    return Building(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      owner: jsonSerialization['owner'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_i2wy11ca.Owner>(
              jsonSerialization['owner'],
            ),
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      address: jsonSerialization['address'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      openingMinutes: jsonSerialization['openingMinutes'] as int,
      closingMinutes: jsonSerialization['closingMinutes'] as int,
      currencyCode: jsonSerialization['currencyCode'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      countryCode: jsonSerialization['countryCode'] as String,
      countryName: jsonSerialization['countryName'] as String?,
      whatsapp: jsonSerialization['whatsapp'] as String?,
      instagram: jsonSerialization['instagram'] as String?,
      facebook: jsonSerialization['facebook'] as String?,
      otherLinks: _iaib1p48.Protocol().deserialize<List<String>>(
        jsonSerialization['otherLinks'],
      ),
      tableMultiOrder: jsonSerialization['tableMultiOrder'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['tableMultiOrder'],
            ),
      allowAppendingItemsToOrder:
          jsonSerialization['allowAppendingItemsToOrder'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['allowAppendingItemsToOrder'],
            ),
      strictMode: jsonSerialization['strictMode'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['strictMode']),
      strictModeSteps: _iaib1p48.Protocol()
          .deserialize<List<_ik04yv2w.StrictModeStep>>(
            jsonSerialization['strictModeSteps'],
          ),
      reservationFee: (jsonSerialization['reservationFee'] as num?)?.toDouble(),
      customerOrderingEnabled:
          jsonSerialization['customerOrderingEnabled'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['customerOrderingEnabled'],
            ),
      reservationsEnabled: jsonSerialization['reservationsEnabled'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['reservationsEnabled'],
            ),
      allowOutOfStockOrders: jsonSerialization['allowOutOfStockOrders'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['allowOutOfStockOrders'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      employees: jsonSerialization['employees'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_ie30fksv.Employee>>(
              jsonSerialization['employees'],
            ),
      accessProfiles: jsonSerialization['accessProfiles'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_i5dpfzds.EmployeeAccess>>(
              jsonSerialization['accessProfiles'],
            ),
      tables: jsonSerialization['tables'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_ilcfc7kr.VenueTable>>(
              jsonSerialization['tables'],
            ),
      menuCategories: jsonSerialization['menuCategories'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_illkjvef.MenuCategory>>(
              jsonSerialization['menuCategories'],
            ),
      menuArticles: jsonSerialization['menuArticles'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_is7gdyz6.MenuArticle>>(
              jsonSerialization['menuArticles'],
            ),
      ingredients: jsonSerialization['ingredients'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_ixki5cxr.Ingredient>>(
              jsonSerialization['ingredients'],
            ),
      orders: jsonSerialization['orders'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_iwamn8sj.VenueOrder>>(
              jsonSerialization['orders'],
            ),
      reservations: jsonSerialization['reservations'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_iq51mm5o.Reservation>>(
              jsonSerialization['reservations'],
            ),
      packAssignments: jsonSerialization['packAssignments'] == null
          ? null
          : _iaib1p48.Protocol()
                .deserialize<List<_iq3bhcsv.BuildingPackAssignment>>(
                  jsonSerialization['packAssignments'],
                ),
      packId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['packId']),
      pack: jsonSerialization['pack'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<_iqwmqtub.Pack>(
              jsonSerialization['pack'],
            ),
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
    );
  }

  static final t = BuildingTable();

  static const db = BuildingRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue ownerId;

  _i2wy11ca.Owner? owner;

  String name;

  String type;

  String address;

  double latitude;

  double longitude;

  int openingMinutes;

  int closingMinutes;

  String currencyCode;

  /// Venue contact phone in E.164 (`+216…`).
  String phoneNumber;

  /// ISO 3166-1 alpha-2 derived from [phoneNumber] dial code.
  String countryCode;

  /// English common name for [countryCode], such as Tunisia. Blank until filled from the code.
  String countryName;

  /// Optional WhatsApp number (E.164) or empty.
  String? whatsapp;

  /// Instagram handle or profile URL.
  String? instagram;

  /// Facebook page URL or handle.
  String? facebook;

  /// Extra website / social URLs.
  List<String> otherLinks;

  /// When false, a table with an open (progress) order cannot receive another order.
  bool tableMultiOrder;

  /// When false, staff cannot append articles to an existing open order.
  bool allowAppendingItemsToOrder;

  /// When true, item status must follow enabled [strictModeSteps] in rank order.
  bool strictMode;

  /// Fixed pipeline steps (picked → … → payed); enable/disable only, no reorder.
  List<_ik04yv2w.StrictModeStep> strictModeSteps;

  /// Default amount collected for a reservation, in [currencyCode].
  double reservationFee;

  /// When false, customers cannot place or append orders even if the pack includes ordering.
  bool customerOrderingEnabled;

  /// When false, reservations cannot be created even if the pack includes them.
  bool reservationsEnabled;

  /// When true, an order may be placed even if a recipe ingredient would go below zero.
  bool allowOutOfStockOrders;

  DateTime createdAt;

  List<_ie30fksv.Employee>? employees;

  List<_i5dpfzds.EmployeeAccess>? accessProfiles;

  List<_ilcfc7kr.VenueTable>? tables;

  List<_illkjvef.MenuCategory>? menuCategories;

  List<_is7gdyz6.MenuArticle>? menuArticles;

  List<_ixki5cxr.Ingredient>? ingredients;

  List<_iwamn8sj.VenueOrder>? orders;

  List<_iq51mm5o.Reservation>? reservations;

  /// Every plan this venue has been on, including the open row.
  List<_iq3bhcsv.BuildingPackAssignment>? packAssignments;

  _is.UuidValue packId;

  /// Plan this venue is on. Create assigns the free pack.
  _iqwmqtub.Pack? pack;

  /// Paid term. Null while the venue is on the free pack.
  _iohcjejn.PackBillingPeriod? packBillingPeriod;

  /// When the paid term ends. A sweep returns the venue to the free pack after this instant.
  DateTime? packExpiresAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Building]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Building copyWith({
    _is.UuidValue? id,
    _is.UuidValue? ownerId,
    _i2wy11ca.Owner? owner,
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    int? openingMinutes,
    int? closingMinutes,
    String? currencyCode,
    String? phoneNumber,
    String? countryCode,
    String? countryName,
    String? whatsapp,
    String? instagram,
    String? facebook,
    List<String>? otherLinks,
    bool? tableMultiOrder,
    bool? allowAppendingItemsToOrder,
    bool? strictMode,
    List<_ik04yv2w.StrictModeStep>? strictModeSteps,
    double? reservationFee,
    bool? customerOrderingEnabled,
    bool? reservationsEnabled,
    bool? allowOutOfStockOrders,
    DateTime? createdAt,
    List<_ie30fksv.Employee>? employees,
    List<_i5dpfzds.EmployeeAccess>? accessProfiles,
    List<_ilcfc7kr.VenueTable>? tables,
    List<_illkjvef.MenuCategory>? menuCategories,
    List<_is7gdyz6.MenuArticle>? menuArticles,
    List<_ixki5cxr.Ingredient>? ingredients,
    List<_iwamn8sj.VenueOrder>? orders,
    List<_iq51mm5o.Reservation>? reservations,
    List<_iq3bhcsv.BuildingPackAssignment>? packAssignments,
    _is.UuidValue? packId,
    _iqwmqtub.Pack? pack,
    _iohcjejn.PackBillingPeriod? packBillingPeriod,
    DateTime? packExpiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Building',
      if (id != null) 'id': id?.toJson(),
      'ownerId': ownerId.toJson(),
      if (owner != null) 'owner': owner?.toJson(),
      'name': name,
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'openingMinutes': openingMinutes,
      'closingMinutes': closingMinutes,
      'currencyCode': currencyCode,
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
      'countryName': countryName,
      if (whatsapp != null) 'whatsapp': whatsapp,
      if (instagram != null) 'instagram': instagram,
      if (facebook != null) 'facebook': facebook,
      'otherLinks': otherLinks.toJson(),
      'tableMultiOrder': tableMultiOrder,
      'allowAppendingItemsToOrder': allowAppendingItemsToOrder,
      'strictMode': strictMode,
      'strictModeSteps': strictModeSteps.toJson(valueToJson: (v) => v.toJson()),
      'reservationFee': reservationFee,
      'customerOrderingEnabled': customerOrderingEnabled,
      'reservationsEnabled': reservationsEnabled,
      'allowOutOfStockOrders': allowOutOfStockOrders,
      'createdAt': createdAt.toJson(),
      if (employees != null)
        'employees': employees?.toJson(valueToJson: (v) => v.toJson()),
      if (accessProfiles != null)
        'accessProfiles': accessProfiles?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (tables != null)
        'tables': tables?.toJson(valueToJson: (v) => v.toJson()),
      if (menuCategories != null)
        'menuCategories': menuCategories?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (menuArticles != null)
        'menuArticles': menuArticles?.toJson(valueToJson: (v) => v.toJson()),
      if (ingredients != null)
        'ingredients': ingredients?.toJson(valueToJson: (v) => v.toJson()),
      if (orders != null)
        'orders': orders?.toJson(valueToJson: (v) => v.toJson()),
      if (reservations != null)
        'reservations': reservations?.toJson(valueToJson: (v) => v.toJson()),
      if (packAssignments != null)
        'packAssignments': packAssignments?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      'packId': packId.toJson(),
      if (pack != null) 'pack': pack?.toJson(),
      if (packBillingPeriod != null)
        'packBillingPeriod': packBillingPeriod?.toJson(),
      if (packExpiresAt != null) 'packExpiresAt': packExpiresAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static BuildingInclude include({
    _i2wy11ca.OwnerInclude? owner,
    _ie30fksv.EmployeeIncludeList? employees,
    _i5dpfzds.EmployeeAccessIncludeList? accessProfiles,
    _ilcfc7kr.VenueTableIncludeList? tables,
    _illkjvef.MenuCategoryIncludeList? menuCategories,
    _is7gdyz6.MenuArticleIncludeList? menuArticles,
    _ixki5cxr.IngredientIncludeList? ingredients,
    _iwamn8sj.VenueOrderIncludeList? orders,
    _iq51mm5o.ReservationIncludeList? reservations,
    _iq3bhcsv.BuildingPackAssignmentIncludeList? packAssignments,
    _iqwmqtub.PackInclude? pack,
  }) {
    return BuildingInclude._(
      owner: owner,
      employees: employees,
      accessProfiles: accessProfiles,
      tables: tables,
      menuCategories: menuCategories,
      menuArticles: menuArticles,
      ingredients: ingredients,
      orders: orders,
      reservations: reservations,
      packAssignments: packAssignments,
      pack: pack,
    );
  }

  static BuildingIncludeList includeList({
    _is.WhereExpressionBuilder<BuildingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BuildingTable>? orderBy,
    _is.OrderByListBuilder<BuildingTable>? orderByList,
    BuildingInclude? include,
  }) {
    return BuildingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Building.t),
      orderByList: orderByList?.call(Building.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BuildingImpl extends Building {
  _BuildingImpl({
    _is.UuidValue? id,
    required _is.UuidValue ownerId,
    _i2wy11ca.Owner? owner,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    required String phoneNumber,
    required String countryCode,
    String? countryName,
    String? whatsapp,
    String? instagram,
    String? facebook,
    required List<String> otherLinks,
    bool? tableMultiOrder,
    bool? allowAppendingItemsToOrder,
    bool? strictMode,
    required List<_ik04yv2w.StrictModeStep> strictModeSteps,
    double? reservationFee,
    bool? customerOrderingEnabled,
    bool? reservationsEnabled,
    bool? allowOutOfStockOrders,
    DateTime? createdAt,
    List<_ie30fksv.Employee>? employees,
    List<_i5dpfzds.EmployeeAccess>? accessProfiles,
    List<_ilcfc7kr.VenueTable>? tables,
    List<_illkjvef.MenuCategory>? menuCategories,
    List<_is7gdyz6.MenuArticle>? menuArticles,
    List<_ixki5cxr.Ingredient>? ingredients,
    List<_iwamn8sj.VenueOrder>? orders,
    List<_iq51mm5o.Reservation>? reservations,
    List<_iq3bhcsv.BuildingPackAssignment>? packAssignments,
    required _is.UuidValue packId,
    _iqwmqtub.Pack? pack,
    _iohcjejn.PackBillingPeriod? packBillingPeriod,
    DateTime? packExpiresAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         owner: owner,
         name: name,
         type: type,
         address: address,
         latitude: latitude,
         longitude: longitude,
         openingMinutes: openingMinutes,
         closingMinutes: closingMinutes,
         currencyCode: currencyCode,
         phoneNumber: phoneNumber,
         countryCode: countryCode,
         countryName: countryName,
         whatsapp: whatsapp,
         instagram: instagram,
         facebook: facebook,
         otherLinks: otherLinks,
         tableMultiOrder: tableMultiOrder,
         allowAppendingItemsToOrder: allowAppendingItemsToOrder,
         strictMode: strictMode,
         strictModeSteps: strictModeSteps,
         reservationFee: reservationFee,
         customerOrderingEnabled: customerOrderingEnabled,
         reservationsEnabled: reservationsEnabled,
         allowOutOfStockOrders: allowOutOfStockOrders,
         createdAt: createdAt,
         employees: employees,
         accessProfiles: accessProfiles,
         tables: tables,
         menuCategories: menuCategories,
         menuArticles: menuArticles,
         ingredients: ingredients,
         orders: orders,
         reservations: reservations,
         packAssignments: packAssignments,
         packId: packId,
         pack: pack,
         packBillingPeriod: packBillingPeriod,
         packExpiresAt: packExpiresAt,
       );

  /// Returns a shallow copy of this [Building]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Building copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
    Object? owner = _Undefined,
    String? name,
    String? type,
    String? address,
    double? latitude,
    double? longitude,
    int? openingMinutes,
    int? closingMinutes,
    String? currencyCode,
    String? phoneNumber,
    String? countryCode,
    String? countryName,
    Object? whatsapp = _Undefined,
    Object? instagram = _Undefined,
    Object? facebook = _Undefined,
    List<String>? otherLinks,
    bool? tableMultiOrder,
    bool? allowAppendingItemsToOrder,
    bool? strictMode,
    List<_ik04yv2w.StrictModeStep>? strictModeSteps,
    double? reservationFee,
    bool? customerOrderingEnabled,
    bool? reservationsEnabled,
    bool? allowOutOfStockOrders,
    DateTime? createdAt,
    Object? employees = _Undefined,
    Object? accessProfiles = _Undefined,
    Object? tables = _Undefined,
    Object? menuCategories = _Undefined,
    Object? menuArticles = _Undefined,
    Object? ingredients = _Undefined,
    Object? orders = _Undefined,
    Object? reservations = _Undefined,
    Object? packAssignments = _Undefined,
    _is.UuidValue? packId,
    Object? pack = _Undefined,
    Object? packBillingPeriod = _Undefined,
    Object? packExpiresAt = _Undefined,
  }) {
    return Building(
      id: id is _is.UuidValue? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      owner: owner is _i2wy11ca.Owner? ? owner : this.owner?.copyWith(),
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      openingMinutes: openingMinutes ?? this.openingMinutes,
      closingMinutes: closingMinutes ?? this.closingMinutes,
      currencyCode: currencyCode ?? this.currencyCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      whatsapp: whatsapp is String? ? whatsapp : this.whatsapp,
      instagram: instagram is String? ? instagram : this.instagram,
      facebook: facebook is String? ? facebook : this.facebook,
      otherLinks: otherLinks ?? this.otherLinks.map((e0) => e0).toList(),
      tableMultiOrder: tableMultiOrder ?? this.tableMultiOrder,
      allowAppendingItemsToOrder:
          allowAppendingItemsToOrder ?? this.allowAppendingItemsToOrder,
      strictMode: strictMode ?? this.strictMode,
      strictModeSteps:
          strictModeSteps ??
          this.strictModeSteps.map((e0) => e0.copyWith()).toList(),
      reservationFee: reservationFee ?? this.reservationFee,
      customerOrderingEnabled:
          customerOrderingEnabled ?? this.customerOrderingEnabled,
      reservationsEnabled: reservationsEnabled ?? this.reservationsEnabled,
      allowOutOfStockOrders:
          allowOutOfStockOrders ?? this.allowOutOfStockOrders,
      createdAt: createdAt ?? this.createdAt,
      employees: employees is List<_ie30fksv.Employee>?
          ? employees
          : this.employees?.map((e0) => e0.copyWith()).toList(),
      accessProfiles: accessProfiles is List<_i5dpfzds.EmployeeAccess>?
          ? accessProfiles
          : this.accessProfiles?.map((e0) => e0.copyWith()).toList(),
      tables: tables is List<_ilcfc7kr.VenueTable>?
          ? tables
          : this.tables?.map((e0) => e0.copyWith()).toList(),
      menuCategories: menuCategories is List<_illkjvef.MenuCategory>?
          ? menuCategories
          : this.menuCategories?.map((e0) => e0.copyWith()).toList(),
      menuArticles: menuArticles is List<_is7gdyz6.MenuArticle>?
          ? menuArticles
          : this.menuArticles?.map((e0) => e0.copyWith()).toList(),
      ingredients: ingredients is List<_ixki5cxr.Ingredient>?
          ? ingredients
          : this.ingredients?.map((e0) => e0.copyWith()).toList(),
      orders: orders is List<_iwamn8sj.VenueOrder>?
          ? orders
          : this.orders?.map((e0) => e0.copyWith()).toList(),
      reservations: reservations is List<_iq51mm5o.Reservation>?
          ? reservations
          : this.reservations?.map((e0) => e0.copyWith()).toList(),
      packAssignments:
          packAssignments is List<_iq3bhcsv.BuildingPackAssignment>?
          ? packAssignments
          : this.packAssignments?.map((e0) => e0.copyWith()).toList(),
      packId: packId ?? this.packId,
      pack: pack is _iqwmqtub.Pack? ? pack : this.pack?.copyWith(),
      packBillingPeriod: packBillingPeriod is _iohcjejn.PackBillingPeriod?
          ? packBillingPeriod
          : this.packBillingPeriod,
      packExpiresAt: packExpiresAt is DateTime?
          ? packExpiresAt
          : this.packExpiresAt,
    );
  }
}

class BuildingUpdateTable extends _is.UpdateTable<BuildingTable> {
  BuildingUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> type(String value) => _is.ColumnValue(
    table.type,
    value,
  );

  _is.ColumnValue<String, String> address(String value) => _is.ColumnValue(
    table.address,
    value,
  );

  _is.ColumnValue<double, double> latitude(double value) => _is.ColumnValue(
    table.latitude,
    value,
  );

  _is.ColumnValue<double, double> longitude(double value) => _is.ColumnValue(
    table.longitude,
    value,
  );

  _is.ColumnValue<int, int> openingMinutes(int value) => _is.ColumnValue(
    table.openingMinutes,
    value,
  );

  _is.ColumnValue<int, int> closingMinutes(int value) => _is.ColumnValue(
    table.closingMinutes,
    value,
  );

  _is.ColumnValue<String, String> currencyCode(String value) => _is.ColumnValue(
    table.currencyCode,
    value,
  );

  _is.ColumnValue<String, String> phoneNumber(String value) => _is.ColumnValue(
    table.phoneNumber,
    value,
  );

  _is.ColumnValue<String, String> countryCode(String value) => _is.ColumnValue(
    table.countryCode,
    value,
  );

  _is.ColumnValue<String, String> countryName(String value) => _is.ColumnValue(
    table.countryName,
    value,
  );

  _is.ColumnValue<String, String> whatsapp(String? value) => _is.ColumnValue(
    table.whatsapp,
    value,
  );

  _is.ColumnValue<String, String> instagram(String? value) => _is.ColumnValue(
    table.instagram,
    value,
  );

  _is.ColumnValue<String, String> facebook(String? value) => _is.ColumnValue(
    table.facebook,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> otherLinks(List<String> value) =>
      _is.ColumnValue(
        table.otherLinks,
        value,
      );

  _is.ColumnValue<bool, bool> tableMultiOrder(bool value) => _is.ColumnValue(
    table.tableMultiOrder,
    value,
  );

  _is.ColumnValue<bool, bool> allowAppendingItemsToOrder(bool value) =>
      _is.ColumnValue(
        table.allowAppendingItemsToOrder,
        value,
      );

  _is.ColumnValue<bool, bool> strictMode(bool value) => _is.ColumnValue(
    table.strictMode,
    value,
  );

  _is.ColumnValue<
    List<_ik04yv2w.StrictModeStep>,
    List<_ik04yv2w.StrictModeStep>
  >
  strictModeSteps(List<_ik04yv2w.StrictModeStep> value) => _is.ColumnValue(
    table.strictModeSteps,
    value,
  );

  _is.ColumnValue<double, double> reservationFee(double value) =>
      _is.ColumnValue(
        table.reservationFee,
        value,
      );

  _is.ColumnValue<bool, bool> customerOrderingEnabled(bool value) =>
      _is.ColumnValue(
        table.customerOrderingEnabled,
        value,
      );

  _is.ColumnValue<bool, bool> reservationsEnabled(bool value) =>
      _is.ColumnValue(
        table.reservationsEnabled,
        value,
      );

  _is.ColumnValue<bool, bool> allowOutOfStockOrders(bool value) =>
      _is.ColumnValue(
        table.allowOutOfStockOrders,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> packId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.packId,
        value,
      );

  _is.ColumnValue<_iohcjejn.PackBillingPeriod, _iohcjejn.PackBillingPeriod>
  packBillingPeriod(_iohcjejn.PackBillingPeriod? value) => _is.ColumnValue(
    table.packBillingPeriod,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> packExpiresAt(DateTime? value) =>
      _is.ColumnValue(
        table.packExpiresAt,
        value,
      );
}

class BuildingTable extends _is.Table<_is.UuidValue?> {
  BuildingTable({super.tableRelation}) : super(tableName: 'building') {
    updateTable = BuildingUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    type = _is.ColumnString(
      'type',
      this,
    );
    address = _is.ColumnString(
      'address',
      this,
    );
    latitude = _is.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _is.ColumnDouble(
      'longitude',
      this,
    );
    openingMinutes = _is.ColumnInt(
      'openingMinutes',
      this,
    );
    closingMinutes = _is.ColumnInt(
      'closingMinutes',
      this,
    );
    currencyCode = _is.ColumnString(
      'currencyCode',
      this,
    );
    phoneNumber = _is.ColumnString(
      'phoneNumber',
      this,
    );
    countryCode = _is.ColumnString(
      'countryCode',
      this,
    );
    countryName = _is.ColumnString(
      'countryName',
      this,
      hasDefault: true,
    );
    whatsapp = _is.ColumnString(
      'whatsapp',
      this,
    );
    instagram = _is.ColumnString(
      'instagram',
      this,
    );
    facebook = _is.ColumnString(
      'facebook',
      this,
    );
    otherLinks = _is.ColumnSerializable<List<String>>(
      'otherLinks',
      this,
    );
    tableMultiOrder = _is.ColumnBool(
      'tableMultiOrder',
      this,
    );
    allowAppendingItemsToOrder = _is.ColumnBool(
      'allowAppendingItemsToOrder',
      this,
    );
    strictMode = _is.ColumnBool(
      'strictMode',
      this,
    );
    strictModeSteps = _is.ColumnSerializable<List<_ik04yv2w.StrictModeStep>>(
      'strictModeSteps',
      this,
    );
    reservationFee = _is.ColumnDouble(
      'reservationFee',
      this,
      hasDefault: true,
    );
    customerOrderingEnabled = _is.ColumnBool(
      'customerOrderingEnabled',
      this,
      hasDefault: true,
    );
    reservationsEnabled = _is.ColumnBool(
      'reservationsEnabled',
      this,
      hasDefault: true,
    );
    allowOutOfStockOrders = _is.ColumnBool(
      'allowOutOfStockOrders',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    packId = _is.ColumnUuid(
      'packId',
      this,
    );
    packBillingPeriod = _is.ColumnEnum(
      'packBillingPeriod',
      this,
      _is.EnumSerialization.byName,
    );
    packExpiresAt = _is.ColumnDateTime(
      'packExpiresAt',
      this,
    );
  }

  late final BuildingUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  _i2wy11ca.OwnerTable? _owner;

  late final _is.ColumnString name;

  late final _is.ColumnString type;

  late final _is.ColumnString address;

  late final _is.ColumnDouble latitude;

  late final _is.ColumnDouble longitude;

  late final _is.ColumnInt openingMinutes;

  late final _is.ColumnInt closingMinutes;

  late final _is.ColumnString currencyCode;

  /// Venue contact phone in E.164 (`+216…`).
  late final _is.ColumnString phoneNumber;

  /// ISO 3166-1 alpha-2 derived from [phoneNumber] dial code.
  late final _is.ColumnString countryCode;

  /// English common name for [countryCode], such as Tunisia. Blank until filled from the code.
  late final _is.ColumnString countryName;

  /// Optional WhatsApp number (E.164) or empty.
  late final _is.ColumnString whatsapp;

  /// Instagram handle or profile URL.
  late final _is.ColumnString instagram;

  /// Facebook page URL or handle.
  late final _is.ColumnString facebook;

  /// Extra website / social URLs.
  late final _is.ColumnSerializable<List<String>> otherLinks;

  /// When false, a table with an open (progress) order cannot receive another order.
  late final _is.ColumnBool tableMultiOrder;

  /// When false, staff cannot append articles to an existing open order.
  late final _is.ColumnBool allowAppendingItemsToOrder;

  /// When true, item status must follow enabled [strictModeSteps] in rank order.
  late final _is.ColumnBool strictMode;

  /// Fixed pipeline steps (picked → … → payed); enable/disable only, no reorder.
  late final _is.ColumnSerializable<List<_ik04yv2w.StrictModeStep>>
  strictModeSteps;

  /// Default amount collected for a reservation, in [currencyCode].
  late final _is.ColumnDouble reservationFee;

  /// When false, customers cannot place or append orders even if the pack includes ordering.
  late final _is.ColumnBool customerOrderingEnabled;

  /// When false, reservations cannot be created even if the pack includes them.
  late final _is.ColumnBool reservationsEnabled;

  /// When true, an order may be placed even if a recipe ingredient would go below zero.
  late final _is.ColumnBool allowOutOfStockOrders;

  late final _is.ColumnDateTime createdAt;

  _ie30fksv.EmployeeTable? ___employees;

  _is.ManyRelation<_ie30fksv.EmployeeTable>? _employees;

  _i5dpfzds.EmployeeAccessTable? ___accessProfiles;

  _is.ManyRelation<_i5dpfzds.EmployeeAccessTable>? _accessProfiles;

  _ilcfc7kr.VenueTableTable? ___tables;

  _is.ManyRelation<_ilcfc7kr.VenueTableTable>? _tables;

  _illkjvef.MenuCategoryTable? ___menuCategories;

  _is.ManyRelation<_illkjvef.MenuCategoryTable>? _menuCategories;

  _is7gdyz6.MenuArticleTable? ___menuArticles;

  _is.ManyRelation<_is7gdyz6.MenuArticleTable>? _menuArticles;

  _ixki5cxr.IngredientTable? ___ingredients;

  _is.ManyRelation<_ixki5cxr.IngredientTable>? _ingredients;

  _iwamn8sj.VenueOrderTable? ___orders;

  _is.ManyRelation<_iwamn8sj.VenueOrderTable>? _orders;

  _iq51mm5o.ReservationTable? ___reservations;

  _is.ManyRelation<_iq51mm5o.ReservationTable>? _reservations;

  /// Every plan this venue has been on, including the open row.
  _iq3bhcsv.BuildingPackAssignmentTable? ___packAssignments;

  /// Every plan this venue has been on, including the open row.
  _is.ManyRelation<_iq3bhcsv.BuildingPackAssignmentTable>? _packAssignments;

  late final _is.ColumnUuid packId;

  /// Plan this venue is on. Create assigns the free pack.
  _iqwmqtub.PackTable? _pack;

  /// Paid term. Null while the venue is on the free pack.
  late final _is.ColumnEnum<_iohcjejn.PackBillingPeriod> packBillingPeriod;

  /// When the paid term ends. A sweep returns the venue to the free pack after this instant.
  late final _is.ColumnDateTime packExpiresAt;

  _i2wy11ca.OwnerTable get owner {
    if (_owner != null) return _owner!;
    _owner = _is.createRelationTable(
      relationFieldName: 'owner',
      field: Building.t.ownerId,
      foreignField: _i2wy11ca.Owner.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2wy11ca.OwnerTable(tableRelation: foreignTableRelation),
    );
    return _owner!;
  }

  _ie30fksv.EmployeeTable get __employees {
    if (___employees != null) return ___employees!;
    ___employees = _is.createRelationTable(
      relationFieldName: '__employees',
      field: Building.t.id,
      foreignField: _ie30fksv.Employee.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ie30fksv.EmployeeTable(tableRelation: foreignTableRelation),
    );
    return ___employees!;
  }

  _i5dpfzds.EmployeeAccessTable get __accessProfiles {
    if (___accessProfiles != null) return ___accessProfiles!;
    ___accessProfiles = _is.createRelationTable(
      relationFieldName: '__accessProfiles',
      field: Building.t.id,
      foreignField: _i5dpfzds.EmployeeAccess.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5dpfzds.EmployeeAccessTable(tableRelation: foreignTableRelation),
    );
    return ___accessProfiles!;
  }

  _ilcfc7kr.VenueTableTable get __tables {
    if (___tables != null) return ___tables!;
    ___tables = _is.createRelationTable(
      relationFieldName: '__tables',
      field: Building.t.id,
      foreignField: _ilcfc7kr.VenueTable.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ilcfc7kr.VenueTableTable(tableRelation: foreignTableRelation),
    );
    return ___tables!;
  }

  _illkjvef.MenuCategoryTable get __menuCategories {
    if (___menuCategories != null) return ___menuCategories!;
    ___menuCategories = _is.createRelationTable(
      relationFieldName: '__menuCategories',
      field: Building.t.id,
      foreignField: _illkjvef.MenuCategory.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _illkjvef.MenuCategoryTable(tableRelation: foreignTableRelation),
    );
    return ___menuCategories!;
  }

  _is7gdyz6.MenuArticleTable get __menuArticles {
    if (___menuArticles != null) return ___menuArticles!;
    ___menuArticles = _is.createRelationTable(
      relationFieldName: '__menuArticles',
      field: Building.t.id,
      foreignField: _is7gdyz6.MenuArticle.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _is7gdyz6.MenuArticleTable(tableRelation: foreignTableRelation),
    );
    return ___menuArticles!;
  }

  _ixki5cxr.IngredientTable get __ingredients {
    if (___ingredients != null) return ___ingredients!;
    ___ingredients = _is.createRelationTable(
      relationFieldName: '__ingredients',
      field: Building.t.id,
      foreignField: _ixki5cxr.Ingredient.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ixki5cxr.IngredientTable(tableRelation: foreignTableRelation),
    );
    return ___ingredients!;
  }

  _iwamn8sj.VenueOrderTable get __orders {
    if (___orders != null) return ___orders!;
    ___orders = _is.createRelationTable(
      relationFieldName: '__orders',
      field: Building.t.id,
      foreignField: _iwamn8sj.VenueOrder.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iwamn8sj.VenueOrderTable(tableRelation: foreignTableRelation),
    );
    return ___orders!;
  }

  _iq51mm5o.ReservationTable get __reservations {
    if (___reservations != null) return ___reservations!;
    ___reservations = _is.createRelationTable(
      relationFieldName: '__reservations',
      field: Building.t.id,
      foreignField: _iq51mm5o.Reservation.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iq51mm5o.ReservationTable(tableRelation: foreignTableRelation),
    );
    return ___reservations!;
  }

  _iq3bhcsv.BuildingPackAssignmentTable get __packAssignments {
    if (___packAssignments != null) return ___packAssignments!;
    ___packAssignments = _is.createRelationTable(
      relationFieldName: '__packAssignments',
      field: Building.t.id,
      foreignField: _iq3bhcsv.BuildingPackAssignment.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iq3bhcsv.BuildingPackAssignmentTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return ___packAssignments!;
  }

  _iqwmqtub.PackTable get pack {
    if (_pack != null) return _pack!;
    _pack = _is.createRelationTable(
      relationFieldName: 'pack',
      field: Building.t.packId,
      foreignField: _iqwmqtub.Pack.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iqwmqtub.PackTable(tableRelation: foreignTableRelation),
    );
    return _pack!;
  }

  _is.ManyRelation<_ie30fksv.EmployeeTable> get employees {
    if (_employees != null) return _employees!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'employees',
      field: Building.t.id,
      foreignField: _ie30fksv.Employee.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ie30fksv.EmployeeTable(tableRelation: foreignTableRelation),
    );
    _employees = _is.ManyRelation<_ie30fksv.EmployeeTable>(
      tableWithRelations: relationTable,
      table: _ie30fksv.EmployeeTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _employees!;
  }

  _is.ManyRelation<_i5dpfzds.EmployeeAccessTable> get accessProfiles {
    if (_accessProfiles != null) return _accessProfiles!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'accessProfiles',
      field: Building.t.id,
      foreignField: _i5dpfzds.EmployeeAccess.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5dpfzds.EmployeeAccessTable(tableRelation: foreignTableRelation),
    );
    _accessProfiles = _is.ManyRelation<_i5dpfzds.EmployeeAccessTable>(
      tableWithRelations: relationTable,
      table: _i5dpfzds.EmployeeAccessTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _accessProfiles!;
  }

  _is.ManyRelation<_ilcfc7kr.VenueTableTable> get tables {
    if (_tables != null) return _tables!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'tables',
      field: Building.t.id,
      foreignField: _ilcfc7kr.VenueTable.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ilcfc7kr.VenueTableTable(tableRelation: foreignTableRelation),
    );
    _tables = _is.ManyRelation<_ilcfc7kr.VenueTableTable>(
      tableWithRelations: relationTable,
      table: _ilcfc7kr.VenueTableTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _tables!;
  }

  _is.ManyRelation<_illkjvef.MenuCategoryTable> get menuCategories {
    if (_menuCategories != null) return _menuCategories!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'menuCategories',
      field: Building.t.id,
      foreignField: _illkjvef.MenuCategory.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _illkjvef.MenuCategoryTable(tableRelation: foreignTableRelation),
    );
    _menuCategories = _is.ManyRelation<_illkjvef.MenuCategoryTable>(
      tableWithRelations: relationTable,
      table: _illkjvef.MenuCategoryTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _menuCategories!;
  }

  _is.ManyRelation<_is7gdyz6.MenuArticleTable> get menuArticles {
    if (_menuArticles != null) return _menuArticles!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'menuArticles',
      field: Building.t.id,
      foreignField: _is7gdyz6.MenuArticle.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _is7gdyz6.MenuArticleTable(tableRelation: foreignTableRelation),
    );
    _menuArticles = _is.ManyRelation<_is7gdyz6.MenuArticleTable>(
      tableWithRelations: relationTable,
      table: _is7gdyz6.MenuArticleTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _menuArticles!;
  }

  _is.ManyRelation<_ixki5cxr.IngredientTable> get ingredients {
    if (_ingredients != null) return _ingredients!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'ingredients',
      field: Building.t.id,
      foreignField: _ixki5cxr.Ingredient.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ixki5cxr.IngredientTable(tableRelation: foreignTableRelation),
    );
    _ingredients = _is.ManyRelation<_ixki5cxr.IngredientTable>(
      tableWithRelations: relationTable,
      table: _ixki5cxr.IngredientTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _ingredients!;
  }

  _is.ManyRelation<_iwamn8sj.VenueOrderTable> get orders {
    if (_orders != null) return _orders!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'orders',
      field: Building.t.id,
      foreignField: _iwamn8sj.VenueOrder.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iwamn8sj.VenueOrderTable(tableRelation: foreignTableRelation),
    );
    _orders = _is.ManyRelation<_iwamn8sj.VenueOrderTable>(
      tableWithRelations: relationTable,
      table: _iwamn8sj.VenueOrderTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _orders!;
  }

  _is.ManyRelation<_iq51mm5o.ReservationTable> get reservations {
    if (_reservations != null) return _reservations!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'reservations',
      field: Building.t.id,
      foreignField: _iq51mm5o.Reservation.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iq51mm5o.ReservationTable(tableRelation: foreignTableRelation),
    );
    _reservations = _is.ManyRelation<_iq51mm5o.ReservationTable>(
      tableWithRelations: relationTable,
      table: _iq51mm5o.ReservationTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _reservations!;
  }

  _is.ManyRelation<_iq3bhcsv.BuildingPackAssignmentTable> get packAssignments {
    if (_packAssignments != null) return _packAssignments!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'packAssignments',
      field: Building.t.id,
      foreignField: _iq3bhcsv.BuildingPackAssignment.t.buildingId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iq3bhcsv.BuildingPackAssignmentTable(
            tableRelation: foreignTableRelation,
          ),
    );
    _packAssignments = _is.ManyRelation<_iq3bhcsv.BuildingPackAssignmentTable>(
      tableWithRelations: relationTable,
      table: _iq3bhcsv.BuildingPackAssignmentTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _packAssignments!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    name,
    type,
    address,
    latitude,
    longitude,
    openingMinutes,
    closingMinutes,
    currencyCode,
    phoneNumber,
    countryCode,
    countryName,
    whatsapp,
    instagram,
    facebook,
    otherLinks,
    tableMultiOrder,
    allowAppendingItemsToOrder,
    strictMode,
    strictModeSteps,
    reservationFee,
    customerOrderingEnabled,
    reservationsEnabled,
    allowOutOfStockOrders,
    createdAt,
    packId,
    packBillingPeriod,
    packExpiresAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'owner') {
      return owner;
    }
    if (relationField == 'employees') {
      return __employees;
    }
    if (relationField == 'accessProfiles') {
      return __accessProfiles;
    }
    if (relationField == 'tables') {
      return __tables;
    }
    if (relationField == 'menuCategories') {
      return __menuCategories;
    }
    if (relationField == 'menuArticles') {
      return __menuArticles;
    }
    if (relationField == 'ingredients') {
      return __ingredients;
    }
    if (relationField == 'orders') {
      return __orders;
    }
    if (relationField == 'reservations') {
      return __reservations;
    }
    if (relationField == 'packAssignments') {
      return __packAssignments;
    }
    if (relationField == 'pack') {
      return pack;
    }
    return null;
  }
}

class BuildingInclude extends _is.IncludeObject {
  BuildingInclude._({
    _i2wy11ca.OwnerInclude? owner,
    _ie30fksv.EmployeeIncludeList? employees,
    _i5dpfzds.EmployeeAccessIncludeList? accessProfiles,
    _ilcfc7kr.VenueTableIncludeList? tables,
    _illkjvef.MenuCategoryIncludeList? menuCategories,
    _is7gdyz6.MenuArticleIncludeList? menuArticles,
    _ixki5cxr.IngredientIncludeList? ingredients,
    _iwamn8sj.VenueOrderIncludeList? orders,
    _iq51mm5o.ReservationIncludeList? reservations,
    _iq3bhcsv.BuildingPackAssignmentIncludeList? packAssignments,
    _iqwmqtub.PackInclude? pack,
  }) {
    _owner = owner;
    _employees = employees;
    _accessProfiles = accessProfiles;
    _tables = tables;
    _menuCategories = menuCategories;
    _menuArticles = menuArticles;
    _ingredients = ingredients;
    _orders = orders;
    _reservations = reservations;
    _packAssignments = packAssignments;
    _pack = pack;
  }

  _i2wy11ca.OwnerInclude? _owner;

  _ie30fksv.EmployeeIncludeList? _employees;

  _i5dpfzds.EmployeeAccessIncludeList? _accessProfiles;

  _ilcfc7kr.VenueTableIncludeList? _tables;

  _illkjvef.MenuCategoryIncludeList? _menuCategories;

  _is7gdyz6.MenuArticleIncludeList? _menuArticles;

  _ixki5cxr.IngredientIncludeList? _ingredients;

  _iwamn8sj.VenueOrderIncludeList? _orders;

  _iq51mm5o.ReservationIncludeList? _reservations;

  _iq3bhcsv.BuildingPackAssignmentIncludeList? _packAssignments;

  _iqwmqtub.PackInclude? _pack;

  @override
  Map<String, _is.Include?> get includes => {
    'owner': _owner,
    'employees': _employees,
    'accessProfiles': _accessProfiles,
    'tables': _tables,
    'menuCategories': _menuCategories,
    'menuArticles': _menuArticles,
    'ingredients': _ingredients,
    'orders': _orders,
    'reservations': _reservations,
    'packAssignments': _packAssignments,
    'pack': _pack,
  };

  @override
  _is.Table<_is.UuidValue?> get table => Building.t;
}

class BuildingIncludeList extends _is.IncludeList {
  BuildingIncludeList._({
    _is.WhereExpressionBuilder<BuildingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Building.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => Building.t;
}

class BuildingRepository {
  const BuildingRepository._();

  final attach = const BuildingAttachRepository._();

  final attachRow = const BuildingAttachRowRepository._();

  /// Returns a list of [Building]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Building>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BuildingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BuildingTable>? orderBy,
    _is.OrderByListBuilder<BuildingTable>? orderByList,
    _is.Transaction? transaction,
    BuildingInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Building>(
      where: where?.call(Building.t),
      orderBy: orderBy?.call(Building.t),
      orderByList: orderByList?.call(Building.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Building] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Building?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BuildingTable>? where,
    int? offset,
    _is.OrderByBuilder<BuildingTable>? orderBy,
    _is.OrderByListBuilder<BuildingTable>? orderByList,
    _is.Transaction? transaction,
    BuildingInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Building>(
      where: where?.call(Building.t),
      orderBy: orderBy?.call(Building.t),
      orderByList: orderByList?.call(Building.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Building] by its [id] or null if no such row exists.
  Future<Building?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    BuildingInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Building>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Building]s in the list and returns the inserted rows.
  ///
  /// The returned [Building]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Building>> insert(
    _is.DatabaseSession session,
    List<Building> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Building>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Building] and returns the inserted row.
  ///
  /// The returned [Building] will have its `id` field set.
  Future<Building> insertRow(
    _is.DatabaseSession session,
    Building row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Building>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Building]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Building]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Building>> upsert(
    _is.DatabaseSession session,
    List<Building> rows, {
    required _is.ColumnSelections<BuildingTable> conflictColumns,
    _is.ColumnSelections<BuildingTable>? updateColumns,
    _is.WhereExpressionBuilder<BuildingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Building>(
      rows,
      conflictColumns: conflictColumns(Building.t),
      updateColumns: updateColumns?.call(Building.t),
      updateWhere: updateWhere?.call(Building.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Building] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Building] will have its `id` field set.
  Future<Building?> upsertRow(
    _is.DatabaseSession session,
    Building row, {
    required _is.ColumnSelections<BuildingTable> conflictColumns,
    _is.ColumnSelections<BuildingTable>? updateColumns,
    _is.WhereExpressionBuilder<BuildingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Building>(
      row,
      conflictColumns: conflictColumns(Building.t),
      updateColumns: updateColumns?.call(Building.t),
      updateWhere: updateWhere?.call(Building.t),
      transaction: transaction,
    );
  }

  /// Updates all [Building]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Building>> update(
    _is.DatabaseSession session,
    List<Building> rows, {
    _is.ColumnSelections<BuildingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Building>(
      rows,
      columns: columns?.call(Building.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Building]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Building> updateRow(
    _is.DatabaseSession session,
    Building row, {
    _is.ColumnSelections<BuildingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Building>(
      row,
      columns: columns?.call(Building.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Building] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Building?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<BuildingUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Building>(
      id,
      columnValues: columnValues(Building.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Building]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Building>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BuildingUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BuildingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BuildingTable>? orderBy,
    _is.OrderByListBuilder<BuildingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Building>(
      columnValues: columnValues(Building.t.updateTable),
      where: where(Building.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Building.t),
      orderByList: orderByList?.call(Building.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Building]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Building>> delete(
    _is.DatabaseSession session,
    List<Building> rows, {
    _is.OrderByBuilder<BuildingTable>? orderBy,
    _is.OrderByListBuilder<BuildingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Building>(
      rows,
      orderBy: orderBy?.call(Building.t),
      orderByList: orderByList?.call(Building.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Building].
  Future<Building> deleteRow(
    _is.DatabaseSession session,
    Building row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Building>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Building>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BuildingTable> where,
    _is.OrderByBuilder<BuildingTable>? orderBy,
    _is.OrderByListBuilder<BuildingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Building>(
      where: where(Building.t),
      orderBy: orderBy?.call(Building.t),
      orderByList: orderByList?.call(Building.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BuildingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Building>(
      where: where?.call(Building.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Building] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BuildingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Building>(
      where: where(Building.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class BuildingAttachRepository {
  const BuildingAttachRepository._();

  /// Creates a relation between this [Building] and the given [Employee]s
  /// by setting each [Employee]'s foreign key `buildingId` to refer to this [Building].
  Future<void> employees(
    _is.DatabaseSession session,
    Building building,
    List<_ie30fksv.Employee> employee, {
    _is.Transaction? transaction,
  }) async {
    if (employee.any((e) => e.id == null)) {
      throw ArgumentError.notNull('employee.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $employee = employee
        .map((e) => e.copyWith(buildingId: building.id))
        .toList();
    await session.db.update<_ie30fksv.Employee>(
      $employee,
      columns: [_ie30fksv.Employee.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [EmployeeAccess]s
  /// by setting each [EmployeeAccess]'s foreign key `buildingId` to refer to this [Building].
  Future<void> accessProfiles(
    _is.DatabaseSession session,
    Building building,
    List<_i5dpfzds.EmployeeAccess> employeeAccess, {
    _is.Transaction? transaction,
  }) async {
    if (employeeAccess.any((e) => e.id == null)) {
      throw ArgumentError.notNull('employeeAccess.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $employeeAccess = employeeAccess
        .map((e) => e.copyWith(buildingId: building.id))
        .toList();
    await session.db.update<_i5dpfzds.EmployeeAccess>(
      $employeeAccess,
      columns: [_i5dpfzds.EmployeeAccess.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [VenueTable]s
  /// by setting each [VenueTable]'s foreign key `buildingId` to refer to this [Building].
  Future<void> tables(
    _is.DatabaseSession session,
    Building building,
    List<_ilcfc7kr.VenueTable> venueTable, {
    _is.Transaction? transaction,
  }) async {
    if (venueTable.any((e) => e.id == null)) {
      throw ArgumentError.notNull('venueTable.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $venueTable = venueTable
        .map((e) => e.copyWith(buildingId: building.id))
        .toList();
    await session.db.update<_ilcfc7kr.VenueTable>(
      $venueTable,
      columns: [_ilcfc7kr.VenueTable.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [MenuCategory]s
  /// by setting each [MenuCategory]'s foreign key `buildingId` to refer to this [Building].
  Future<void> menuCategories(
    _is.DatabaseSession session,
    Building building,
    List<_illkjvef.MenuCategory> menuCategory, {
    _is.Transaction? transaction,
  }) async {
    if (menuCategory.any((e) => e.id == null)) {
      throw ArgumentError.notNull('menuCategory.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $menuCategory = menuCategory
        .map((e) => e.copyWith(buildingId: building.id))
        .toList();
    await session.db.update<_illkjvef.MenuCategory>(
      $menuCategory,
      columns: [_illkjvef.MenuCategory.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [MenuArticle]s
  /// by setting each [MenuArticle]'s foreign key `buildingId` to refer to this [Building].
  Future<void> menuArticles(
    _is.DatabaseSession session,
    Building building,
    List<_is7gdyz6.MenuArticle> menuArticle, {
    _is.Transaction? transaction,
  }) async {
    if (menuArticle.any((e) => e.id == null)) {
      throw ArgumentError.notNull('menuArticle.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $menuArticle = menuArticle
        .map((e) => e.copyWith(buildingId: building.id))
        .toList();
    await session.db.update<_is7gdyz6.MenuArticle>(
      $menuArticle,
      columns: [_is7gdyz6.MenuArticle.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [Ingredient]s
  /// by setting each [Ingredient]'s foreign key `buildingId` to refer to this [Building].
  Future<void> ingredients(
    _is.DatabaseSession session,
    Building building,
    List<_ixki5cxr.Ingredient> ingredient, {
    _is.Transaction? transaction,
  }) async {
    if (ingredient.any((e) => e.id == null)) {
      throw ArgumentError.notNull('ingredient.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $ingredient = ingredient
        .map((e) => e.copyWith(buildingId: building.id))
        .toList();
    await session.db.update<_ixki5cxr.Ingredient>(
      $ingredient,
      columns: [_ixki5cxr.Ingredient.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [VenueOrder]s
  /// by setting each [VenueOrder]'s foreign key `buildingId` to refer to this [Building].
  Future<void> orders(
    _is.DatabaseSession session,
    Building building,
    List<_iwamn8sj.VenueOrder> venueOrder, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrder.any((e) => e.id == null)) {
      throw ArgumentError.notNull('venueOrder.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $venueOrder = venueOrder
        .map((e) => e.copyWith(buildingId: building.id))
        .toList();
    await session.db.update<_iwamn8sj.VenueOrder>(
      $venueOrder,
      columns: [_iwamn8sj.VenueOrder.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [Reservation]s
  /// by setting each [Reservation]'s foreign key `buildingId` to refer to this [Building].
  Future<void> reservations(
    _is.DatabaseSession session,
    Building building,
    List<_iq51mm5o.Reservation> reservation, {
    _is.Transaction? transaction,
  }) async {
    if (reservation.any((e) => e.id == null)) {
      throw ArgumentError.notNull('reservation.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $reservation = reservation
        .map((e) => e.copyWith(buildingId: building.id))
        .toList();
    await session.db.update<_iq51mm5o.Reservation>(
      $reservation,
      columns: [_iq51mm5o.Reservation.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [BuildingPackAssignment]s
  /// by setting each [BuildingPackAssignment]'s foreign key `buildingId` to refer to this [Building].
  Future<void> packAssignments(
    _is.DatabaseSession session,
    Building building,
    List<_iq3bhcsv.BuildingPackAssignment> buildingPackAssignment, {
    _is.Transaction? transaction,
  }) async {
    if (buildingPackAssignment.any((e) => e.id == null)) {
      throw ArgumentError.notNull('buildingPackAssignment.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $buildingPackAssignment = buildingPackAssignment
        .map((e) => e.copyWith(buildingId: building.id))
        .toList();
    await session.db.update<_iq3bhcsv.BuildingPackAssignment>(
      $buildingPackAssignment,
      columns: [_iq3bhcsv.BuildingPackAssignment.t.buildingId],
      transaction: transaction,
    );
  }
}

class BuildingAttachRowRepository {
  const BuildingAttachRowRepository._();

  /// Creates a relation between the given [Building] and [Owner]
  /// by setting the [Building]'s foreign key `ownerId` to refer to the [Owner].
  Future<void> owner(
    _is.DatabaseSession session,
    Building building,
    _i2wy11ca.Owner owner, {
    _is.Transaction? transaction,
  }) async {
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }
    if (owner.id == null) {
      throw ArgumentError.notNull('owner.id');
    }

    var $building = building.copyWith(ownerId: owner.id);
    await session.db.updateRow<Building>(
      $building,
      columns: [Building.t.ownerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Building] and [Pack]
  /// by setting the [Building]'s foreign key `packId` to refer to the [Pack].
  Future<void> pack(
    _is.DatabaseSession session,
    Building building,
    _iqwmqtub.Pack pack, {
    _is.Transaction? transaction,
  }) async {
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }
    if (pack.id == null) {
      throw ArgumentError.notNull('pack.id');
    }

    var $building = building.copyWith(packId: pack.id);
    await session.db.updateRow<Building>(
      $building,
      columns: [Building.t.packId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [Employee]
  /// by setting the [Employee]'s foreign key `buildingId` to refer to this [Building].
  Future<void> employees(
    _is.DatabaseSession session,
    Building building,
    _ie30fksv.Employee employee, {
    _is.Transaction? transaction,
  }) async {
    if (employee.id == null) {
      throw ArgumentError.notNull('employee.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $employee = employee.copyWith(buildingId: building.id);
    await session.db.updateRow<_ie30fksv.Employee>(
      $employee,
      columns: [_ie30fksv.Employee.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [EmployeeAccess]
  /// by setting the [EmployeeAccess]'s foreign key `buildingId` to refer to this [Building].
  Future<void> accessProfiles(
    _is.DatabaseSession session,
    Building building,
    _i5dpfzds.EmployeeAccess employeeAccess, {
    _is.Transaction? transaction,
  }) async {
    if (employeeAccess.id == null) {
      throw ArgumentError.notNull('employeeAccess.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $employeeAccess = employeeAccess.copyWith(buildingId: building.id);
    await session.db.updateRow<_i5dpfzds.EmployeeAccess>(
      $employeeAccess,
      columns: [_i5dpfzds.EmployeeAccess.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [VenueTable]
  /// by setting the [VenueTable]'s foreign key `buildingId` to refer to this [Building].
  Future<void> tables(
    _is.DatabaseSession session,
    Building building,
    _ilcfc7kr.VenueTable venueTable, {
    _is.Transaction? transaction,
  }) async {
    if (venueTable.id == null) {
      throw ArgumentError.notNull('venueTable.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $venueTable = venueTable.copyWith(buildingId: building.id);
    await session.db.updateRow<_ilcfc7kr.VenueTable>(
      $venueTable,
      columns: [_ilcfc7kr.VenueTable.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [MenuCategory]
  /// by setting the [MenuCategory]'s foreign key `buildingId` to refer to this [Building].
  Future<void> menuCategories(
    _is.DatabaseSession session,
    Building building,
    _illkjvef.MenuCategory menuCategory, {
    _is.Transaction? transaction,
  }) async {
    if (menuCategory.id == null) {
      throw ArgumentError.notNull('menuCategory.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $menuCategory = menuCategory.copyWith(buildingId: building.id);
    await session.db.updateRow<_illkjvef.MenuCategory>(
      $menuCategory,
      columns: [_illkjvef.MenuCategory.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [MenuArticle]
  /// by setting the [MenuArticle]'s foreign key `buildingId` to refer to this [Building].
  Future<void> menuArticles(
    _is.DatabaseSession session,
    Building building,
    _is7gdyz6.MenuArticle menuArticle, {
    _is.Transaction? transaction,
  }) async {
    if (menuArticle.id == null) {
      throw ArgumentError.notNull('menuArticle.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $menuArticle = menuArticle.copyWith(buildingId: building.id);
    await session.db.updateRow<_is7gdyz6.MenuArticle>(
      $menuArticle,
      columns: [_is7gdyz6.MenuArticle.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [Ingredient]
  /// by setting the [Ingredient]'s foreign key `buildingId` to refer to this [Building].
  Future<void> ingredients(
    _is.DatabaseSession session,
    Building building,
    _ixki5cxr.Ingredient ingredient, {
    _is.Transaction? transaction,
  }) async {
    if (ingredient.id == null) {
      throw ArgumentError.notNull('ingredient.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $ingredient = ingredient.copyWith(buildingId: building.id);
    await session.db.updateRow<_ixki5cxr.Ingredient>(
      $ingredient,
      columns: [_ixki5cxr.Ingredient.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [VenueOrder]
  /// by setting the [VenueOrder]'s foreign key `buildingId` to refer to this [Building].
  Future<void> orders(
    _is.DatabaseSession session,
    Building building,
    _iwamn8sj.VenueOrder venueOrder, {
    _is.Transaction? transaction,
  }) async {
    if (venueOrder.id == null) {
      throw ArgumentError.notNull('venueOrder.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $venueOrder = venueOrder.copyWith(buildingId: building.id);
    await session.db.updateRow<_iwamn8sj.VenueOrder>(
      $venueOrder,
      columns: [_iwamn8sj.VenueOrder.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [Reservation]
  /// by setting the [Reservation]'s foreign key `buildingId` to refer to this [Building].
  Future<void> reservations(
    _is.DatabaseSession session,
    Building building,
    _iq51mm5o.Reservation reservation, {
    _is.Transaction? transaction,
  }) async {
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $reservation = reservation.copyWith(buildingId: building.id);
    await session.db.updateRow<_iq51mm5o.Reservation>(
      $reservation,
      columns: [_iq51mm5o.Reservation.t.buildingId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Building] and the given [BuildingPackAssignment]
  /// by setting the [BuildingPackAssignment]'s foreign key `buildingId` to refer to this [Building].
  Future<void> packAssignments(
    _is.DatabaseSession session,
    Building building,
    _iq3bhcsv.BuildingPackAssignment buildingPackAssignment, {
    _is.Transaction? transaction,
  }) async {
    if (buildingPackAssignment.id == null) {
      throw ArgumentError.notNull('buildingPackAssignment.id');
    }
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }

    var $buildingPackAssignment = buildingPackAssignment.copyWith(
      buildingId: building.id,
    );
    await session.db.updateRow<_iq3bhcsv.BuildingPackAssignment>(
      $buildingPackAssignment,
      columns: [_iq3bhcsv.BuildingPackAssignment.t.buildingId],
      transaction: transaction,
    );
  }
}
