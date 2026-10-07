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

/// Pack the owner sees for the open venue. Enough to explain the plan and block an action in the app.
abstract class BuildingPackView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BuildingPackView._({
    required this.code,
    required this.name,
    required this.monthlyMillimes,
    required this.customerOrderFeeBps,
    this.maxEmployees,
    this.maxTables,
    this.maxCategories,
    this.maxArticles,
    this.maxIngredients,
    required this.customerDiscovery,
    required this.tableQr,
    required this.customerOrdering,
    required this.inventory,
    required this.allowAppendingItems,
    required this.tableMultiOrder,
    required this.strictMode,
    required this.customAccessProfiles,
    required this.reservations,
    this.maxReservationsPerDay,
  });

  factory BuildingPackView({
    required String code,
    required String name,
    required int monthlyMillimes,
    required int customerOrderFeeBps,
    int? maxEmployees,
    int? maxTables,
    int? maxCategories,
    int? maxArticles,
    int? maxIngredients,
    required bool customerDiscovery,
    required bool tableQr,
    required bool customerOrdering,
    required bool inventory,
    required bool allowAppendingItems,
    required bool tableMultiOrder,
    required bool strictMode,
    required bool customAccessProfiles,
    required bool reservations,
    int? maxReservationsPerDay,
  }) = _BuildingPackViewImpl;

  factory BuildingPackView.fromJson(Map<String, dynamic> jsonSerialization) {
    return BuildingPackView(
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      monthlyMillimes: jsonSerialization['monthlyMillimes'] as int,
      customerOrderFeeBps: jsonSerialization['customerOrderFeeBps'] as int,
      maxEmployees: jsonSerialization['maxEmployees'] as int?,
      maxTables: jsonSerialization['maxTables'] as int?,
      maxCategories: jsonSerialization['maxCategories'] as int?,
      maxArticles: jsonSerialization['maxArticles'] as int?,
      maxIngredients: jsonSerialization['maxIngredients'] as int?,
      customerDiscovery: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['customerDiscovery'],
      ),
      tableQr: _isc.BoolJsonExtension.fromJson(jsonSerialization['tableQr']),
      customerOrdering: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['customerOrdering'],
      ),
      inventory: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['inventory'],
      ),
      allowAppendingItems: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['allowAppendingItems'],
      ),
      tableMultiOrder: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['tableMultiOrder'],
      ),
      strictMode: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['strictMode'],
      ),
      customAccessProfiles: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['customAccessProfiles'],
      ),
      reservations: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['reservations'],
      ),
      maxReservationsPerDay: jsonSerialization['maxReservationsPerDay'] as int?,
    );
  }

  String code;

  String name;

  int monthlyMillimes;

  int customerOrderFeeBps;

  int? maxEmployees;

  int? maxTables;

  int? maxCategories;

  int? maxArticles;

  int? maxIngredients;

  bool customerDiscovery;

  bool tableQr;

  bool customerOrdering;

  bool inventory;

  bool allowAppendingItems;

  bool tableMultiOrder;

  bool strictMode;

  bool customAccessProfiles;

  bool reservations;

  int? maxReservationsPerDay;

  /// Returns a shallow copy of this [BuildingPackView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BuildingPackView copyWith({
    String? code,
    String? name,
    int? monthlyMillimes,
    int? customerOrderFeeBps,
    int? maxEmployees,
    int? maxTables,
    int? maxCategories,
    int? maxArticles,
    int? maxIngredients,
    bool? customerDiscovery,
    bool? tableQr,
    bool? customerOrdering,
    bool? inventory,
    bool? allowAppendingItems,
    bool? tableMultiOrder,
    bool? strictMode,
    bool? customAccessProfiles,
    bool? reservations,
    int? maxReservationsPerDay,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BuildingPackView',
      'code': code,
      'name': name,
      'monthlyMillimes': monthlyMillimes,
      'customerOrderFeeBps': customerOrderFeeBps,
      if (maxEmployees != null) 'maxEmployees': maxEmployees,
      if (maxTables != null) 'maxTables': maxTables,
      if (maxCategories != null) 'maxCategories': maxCategories,
      if (maxArticles != null) 'maxArticles': maxArticles,
      if (maxIngredients != null) 'maxIngredients': maxIngredients,
      'customerDiscovery': customerDiscovery,
      'tableQr': tableQr,
      'customerOrdering': customerOrdering,
      'inventory': inventory,
      'allowAppendingItems': allowAppendingItems,
      'tableMultiOrder': tableMultiOrder,
      'strictMode': strictMode,
      'customAccessProfiles': customAccessProfiles,
      'reservations': reservations,
      if (maxReservationsPerDay != null)
        'maxReservationsPerDay': maxReservationsPerDay,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BuildingPackView',
      'code': code,
      'name': name,
      'monthlyMillimes': monthlyMillimes,
      'customerOrderFeeBps': customerOrderFeeBps,
      if (maxEmployees != null) 'maxEmployees': maxEmployees,
      if (maxTables != null) 'maxTables': maxTables,
      if (maxCategories != null) 'maxCategories': maxCategories,
      if (maxArticles != null) 'maxArticles': maxArticles,
      if (maxIngredients != null) 'maxIngredients': maxIngredients,
      'customerDiscovery': customerDiscovery,
      'tableQr': tableQr,
      'customerOrdering': customerOrdering,
      'inventory': inventory,
      'allowAppendingItems': allowAppendingItems,
      'tableMultiOrder': tableMultiOrder,
      'strictMode': strictMode,
      'customAccessProfiles': customAccessProfiles,
      'reservations': reservations,
      if (maxReservationsPerDay != null)
        'maxReservationsPerDay': maxReservationsPerDay,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BuildingPackViewImpl extends BuildingPackView {
  _BuildingPackViewImpl({
    required String code,
    required String name,
    required int monthlyMillimes,
    required int customerOrderFeeBps,
    int? maxEmployees,
    int? maxTables,
    int? maxCategories,
    int? maxArticles,
    int? maxIngredients,
    required bool customerDiscovery,
    required bool tableQr,
    required bool customerOrdering,
    required bool inventory,
    required bool allowAppendingItems,
    required bool tableMultiOrder,
    required bool strictMode,
    required bool customAccessProfiles,
    required bool reservations,
    int? maxReservationsPerDay,
  }) : super._(
         code: code,
         name: name,
         monthlyMillimes: monthlyMillimes,
         customerOrderFeeBps: customerOrderFeeBps,
         maxEmployees: maxEmployees,
         maxTables: maxTables,
         maxCategories: maxCategories,
         maxArticles: maxArticles,
         maxIngredients: maxIngredients,
         customerDiscovery: customerDiscovery,
         tableQr: tableQr,
         customerOrdering: customerOrdering,
         inventory: inventory,
         allowAppendingItems: allowAppendingItems,
         tableMultiOrder: tableMultiOrder,
         strictMode: strictMode,
         customAccessProfiles: customAccessProfiles,
         reservations: reservations,
         maxReservationsPerDay: maxReservationsPerDay,
       );

  /// Returns a shallow copy of this [BuildingPackView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BuildingPackView copyWith({
    String? code,
    String? name,
    int? monthlyMillimes,
    int? customerOrderFeeBps,
    Object? maxEmployees = _Undefined,
    Object? maxTables = _Undefined,
    Object? maxCategories = _Undefined,
    Object? maxArticles = _Undefined,
    Object? maxIngredients = _Undefined,
    bool? customerDiscovery,
    bool? tableQr,
    bool? customerOrdering,
    bool? inventory,
    bool? allowAppendingItems,
    bool? tableMultiOrder,
    bool? strictMode,
    bool? customAccessProfiles,
    bool? reservations,
    Object? maxReservationsPerDay = _Undefined,
  }) {
    return BuildingPackView(
      code: code ?? this.code,
      name: name ?? this.name,
      monthlyMillimes: monthlyMillimes ?? this.monthlyMillimes,
      customerOrderFeeBps: customerOrderFeeBps ?? this.customerOrderFeeBps,
      maxEmployees: maxEmployees is int? ? maxEmployees : this.maxEmployees,
      maxTables: maxTables is int? ? maxTables : this.maxTables,
      maxCategories: maxCategories is int? ? maxCategories : this.maxCategories,
      maxArticles: maxArticles is int? ? maxArticles : this.maxArticles,
      maxIngredients: maxIngredients is int?
          ? maxIngredients
          : this.maxIngredients,
      customerDiscovery: customerDiscovery ?? this.customerDiscovery,
      tableQr: tableQr ?? this.tableQr,
      customerOrdering: customerOrdering ?? this.customerOrdering,
      inventory: inventory ?? this.inventory,
      allowAppendingItems: allowAppendingItems ?? this.allowAppendingItems,
      tableMultiOrder: tableMultiOrder ?? this.tableMultiOrder,
      strictMode: strictMode ?? this.strictMode,
      customAccessProfiles: customAccessProfiles ?? this.customAccessProfiles,
      reservations: reservations ?? this.reservations,
      maxReservationsPerDay: maxReservationsPerDay is int?
          ? maxReservationsPerDay
          : this.maxReservationsPerDay,
    );
  }
}
