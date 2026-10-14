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

/// Operational counts for one venue on one local calendar day.
///
/// Orders, item lines, and customer-app orders are those created on [day].
/// Pending reservations are still-waiting requests of any day.
/// Ingredients to restock are current stock, not limited to the day.
abstract class DashboardSummary
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DashboardSummary._({
    required this.orderTotal,
    required this.ordersProgress,
    required this.ordersPayed,
    required this.ordersCancelled,
    required this.customerOrders,
    required this.itemsProgress,
    required this.itemsPicked,
    required this.itemsReady,
    required this.itemsServed,
    required this.itemsPayed,
    required this.itemsCancelled,
    required this.pendingReservations,
    required this.reservationsToday,
    required this.ingredientsToRestock,
  });

  factory DashboardSummary({
    required int orderTotal,
    required int ordersProgress,
    required int ordersPayed,
    required int ordersCancelled,
    required int customerOrders,
    required int itemsProgress,
    required int itemsPicked,
    required int itemsReady,
    required int itemsServed,
    required int itemsPayed,
    required int itemsCancelled,
    required int pendingReservations,
    required int reservationsToday,
    required int ingredientsToRestock,
  }) = _DashboardSummaryImpl;

  factory DashboardSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardSummary(
      orderTotal: jsonSerialization['orderTotal'] as int,
      ordersProgress: jsonSerialization['ordersProgress'] as int,
      ordersPayed: jsonSerialization['ordersPayed'] as int,
      ordersCancelled: jsonSerialization['ordersCancelled'] as int,
      customerOrders: jsonSerialization['customerOrders'] as int,
      itemsProgress: jsonSerialization['itemsProgress'] as int,
      itemsPicked: jsonSerialization['itemsPicked'] as int,
      itemsReady: jsonSerialization['itemsReady'] as int,
      itemsServed: jsonSerialization['itemsServed'] as int,
      itemsPayed: jsonSerialization['itemsPayed'] as int,
      itemsCancelled: jsonSerialization['itemsCancelled'] as int,
      pendingReservations: jsonSerialization['pendingReservations'] as int,
      reservationsToday: jsonSerialization['reservationsToday'] as int,
      ingredientsToRestock: jsonSerialization['ingredientsToRestock'] as int,
    );
  }

  /// Orders opened on the requested day.
  int orderTotal;

  int ordersProgress;

  int ordersPayed;

  int ordersCancelled;

  /// Orders that day launched from the customer app.
  int customerOrders;

  int itemsProgress;

  int itemsPicked;

  int itemsReady;

  int itemsServed;

  int itemsPayed;

  int itemsCancelled;

  /// Reservation requests still waiting, any day.
  int pendingReservations;

  /// Reservations whose start falls on the requested day.
  int reservationsToday;

  /// Ingredients whose current stock is under 10% of the full level.
  int ingredientsToRestock;

  /// Returns a shallow copy of this [DashboardSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DashboardSummary copyWith({
    int? orderTotal,
    int? ordersProgress,
    int? ordersPayed,
    int? ordersCancelled,
    int? customerOrders,
    int? itemsProgress,
    int? itemsPicked,
    int? itemsReady,
    int? itemsServed,
    int? itemsPayed,
    int? itemsCancelled,
    int? pendingReservations,
    int? reservationsToday,
    int? ingredientsToRestock,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardSummary',
      'orderTotal': orderTotal,
      'ordersProgress': ordersProgress,
      'ordersPayed': ordersPayed,
      'ordersCancelled': ordersCancelled,
      'customerOrders': customerOrders,
      'itemsProgress': itemsProgress,
      'itemsPicked': itemsPicked,
      'itemsReady': itemsReady,
      'itemsServed': itemsServed,
      'itemsPayed': itemsPayed,
      'itemsCancelled': itemsCancelled,
      'pendingReservations': pendingReservations,
      'reservationsToday': reservationsToday,
      'ingredientsToRestock': ingredientsToRestock,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DashboardSummary',
      'orderTotal': orderTotal,
      'ordersProgress': ordersProgress,
      'ordersPayed': ordersPayed,
      'ordersCancelled': ordersCancelled,
      'customerOrders': customerOrders,
      'itemsProgress': itemsProgress,
      'itemsPicked': itemsPicked,
      'itemsReady': itemsReady,
      'itemsServed': itemsServed,
      'itemsPayed': itemsPayed,
      'itemsCancelled': itemsCancelled,
      'pendingReservations': pendingReservations,
      'reservationsToday': reservationsToday,
      'ingredientsToRestock': ingredientsToRestock,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _DashboardSummaryImpl extends DashboardSummary {
  _DashboardSummaryImpl({
    required int orderTotal,
    required int ordersProgress,
    required int ordersPayed,
    required int ordersCancelled,
    required int customerOrders,
    required int itemsProgress,
    required int itemsPicked,
    required int itemsReady,
    required int itemsServed,
    required int itemsPayed,
    required int itemsCancelled,
    required int pendingReservations,
    required int reservationsToday,
    required int ingredientsToRestock,
  }) : super._(
         orderTotal: orderTotal,
         ordersProgress: ordersProgress,
         ordersPayed: ordersPayed,
         ordersCancelled: ordersCancelled,
         customerOrders: customerOrders,
         itemsProgress: itemsProgress,
         itemsPicked: itemsPicked,
         itemsReady: itemsReady,
         itemsServed: itemsServed,
         itemsPayed: itemsPayed,
         itemsCancelled: itemsCancelled,
         pendingReservations: pendingReservations,
         reservationsToday: reservationsToday,
         ingredientsToRestock: ingredientsToRestock,
       );

  /// Returns a shallow copy of this [DashboardSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DashboardSummary copyWith({
    int? orderTotal,
    int? ordersProgress,
    int? ordersPayed,
    int? ordersCancelled,
    int? customerOrders,
    int? itemsProgress,
    int? itemsPicked,
    int? itemsReady,
    int? itemsServed,
    int? itemsPayed,
    int? itemsCancelled,
    int? pendingReservations,
    int? reservationsToday,
    int? ingredientsToRestock,
  }) {
    return DashboardSummary(
      orderTotal: orderTotal ?? this.orderTotal,
      ordersProgress: ordersProgress ?? this.ordersProgress,
      ordersPayed: ordersPayed ?? this.ordersPayed,
      ordersCancelled: ordersCancelled ?? this.ordersCancelled,
      customerOrders: customerOrders ?? this.customerOrders,
      itemsProgress: itemsProgress ?? this.itemsProgress,
      itemsPicked: itemsPicked ?? this.itemsPicked,
      itemsReady: itemsReady ?? this.itemsReady,
      itemsServed: itemsServed ?? this.itemsServed,
      itemsPayed: itemsPayed ?? this.itemsPayed,
      itemsCancelled: itemsCancelled ?? this.itemsCancelled,
      pendingReservations: pendingReservations ?? this.pendingReservations,
      reservationsToday: reservationsToday ?? this.reservationsToday,
      ingredientsToRestock: ingredientsToRestock ?? this.ingredientsToRestock,
    );
  }
}
