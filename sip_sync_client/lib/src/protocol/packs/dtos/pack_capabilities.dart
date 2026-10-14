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

/// Limits and switches a pack turns on. Null limits mean unlimited.
abstract class PackCapabilities
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PackCapabilities._({
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
    required this.cashRegister,
    this.maxReservationsPerDay,
  });

  factory PackCapabilities({
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
    required bool cashRegister,
    int? maxReservationsPerDay,
  }) = _PackCapabilitiesImpl;

  factory PackCapabilities.fromJson(Map<String, dynamic> jsonSerialization) {
    return PackCapabilities(
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
      cashRegister: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['cashRegister'],
      ),
      maxReservationsPerDay: jsonSerialization['maxReservationsPerDay'] as int?,
    );
  }

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

  bool cashRegister;

  /// Non-cancelled reservations whose start falls on one UTC date. Null means no cap.
  int? maxReservationsPerDay;

  /// Returns a shallow copy of this [PackCapabilities]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PackCapabilities copyWith({
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
    bool? cashRegister,
    int? maxReservationsPerDay,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PackCapabilities',
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
      'cashRegister': cashRegister,
      if (maxReservationsPerDay != null)
        'maxReservationsPerDay': maxReservationsPerDay,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PackCapabilities',
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
      'cashRegister': cashRegister,
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

class _PackCapabilitiesImpl extends PackCapabilities {
  _PackCapabilitiesImpl({
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
    required bool cashRegister,
    int? maxReservationsPerDay,
  }) : super._(
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
         cashRegister: cashRegister,
         maxReservationsPerDay: maxReservationsPerDay,
       );

  /// Returns a shallow copy of this [PackCapabilities]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PackCapabilities copyWith({
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
    bool? cashRegister,
    Object? maxReservationsPerDay = _Undefined,
  }) {
    return PackCapabilities(
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
      cashRegister: cashRegister ?? this.cashRegister,
      maxReservationsPerDay: maxReservationsPerDay is int?
          ? maxReservationsPerDay
          : this.maxReservationsPerDay,
    );
  }
}
