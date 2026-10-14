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

abstract class EmployeeAccessView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EmployeeAccessView._({
    required this.id,
    required this.buildingId,
    required this.name,
    required this.orderCreation,
    required this.orderPayment,
    required this.cancelOrder,
    required this.preparation,
    required this.serving,
    required this.consultAllOrders,
    required this.reservations,
    bool? cashRegister,
    required this.createdAt,
  }) : cashRegister = cashRegister ?? false;

  factory EmployeeAccessView({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required String name,
    required bool orderCreation,
    required bool orderPayment,
    required bool cancelOrder,
    required bool preparation,
    required bool serving,
    required bool consultAllOrders,
    required bool reservations,
    bool? cashRegister,
    required DateTime createdAt,
  }) = _EmployeeAccessViewImpl;

  factory EmployeeAccessView.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmployeeAccessView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      name: jsonSerialization['name'] as String,
      orderCreation: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['orderCreation'],
      ),
      orderPayment: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['orderPayment'],
      ),
      cancelOrder: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['cancelOrder'],
      ),
      preparation: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['preparation'],
      ),
      serving: _isc.BoolJsonExtension.fromJson(jsonSerialization['serving']),
      consultAllOrders: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['consultAllOrders'],
      ),
      reservations: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['reservations'],
      ),
      cashRegister: jsonSerialization['cashRegister'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['cashRegister']),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue buildingId;

  String name;

  bool orderCreation;

  bool orderPayment;

  bool cancelOrder;

  bool preparation;

  bool serving;

  bool consultAllOrders;

  bool reservations;

  bool cashRegister;

  DateTime createdAt;

  /// Returns a shallow copy of this [EmployeeAccessView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EmployeeAccessView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    String? name,
    bool? orderCreation,
    bool? orderPayment,
    bool? cancelOrder,
    bool? preparation,
    bool? serving,
    bool? consultAllOrders,
    bool? reservations,
    bool? cashRegister,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmployeeAccessView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'name': name,
      'orderCreation': orderCreation,
      'orderPayment': orderPayment,
      'cancelOrder': cancelOrder,
      'preparation': preparation,
      'serving': serving,
      'consultAllOrders': consultAllOrders,
      'reservations': reservations,
      'cashRegister': cashRegister,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmployeeAccessView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'name': name,
      'orderCreation': orderCreation,
      'orderPayment': orderPayment,
      'cancelOrder': cancelOrder,
      'preparation': preparation,
      'serving': serving,
      'consultAllOrders': consultAllOrders,
      'reservations': reservations,
      'cashRegister': cashRegister,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _EmployeeAccessViewImpl extends EmployeeAccessView {
  _EmployeeAccessViewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required String name,
    required bool orderCreation,
    required bool orderPayment,
    required bool cancelOrder,
    required bool preparation,
    required bool serving,
    required bool consultAllOrders,
    required bool reservations,
    bool? cashRegister,
    required DateTime createdAt,
  }) : super._(
         id: id,
         buildingId: buildingId,
         name: name,
         orderCreation: orderCreation,
         orderPayment: orderPayment,
         cancelOrder: cancelOrder,
         preparation: preparation,
         serving: serving,
         consultAllOrders: consultAllOrders,
         reservations: reservations,
         cashRegister: cashRegister,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [EmployeeAccessView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EmployeeAccessView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    String? name,
    bool? orderCreation,
    bool? orderPayment,
    bool? cancelOrder,
    bool? preparation,
    bool? serving,
    bool? consultAllOrders,
    bool? reservations,
    bool? cashRegister,
    DateTime? createdAt,
  }) {
    return EmployeeAccessView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      name: name ?? this.name,
      orderCreation: orderCreation ?? this.orderCreation,
      orderPayment: orderPayment ?? this.orderPayment,
      cancelOrder: cancelOrder ?? this.cancelOrder,
      preparation: preparation ?? this.preparation,
      serving: serving ?? this.serving,
      consultAllOrders: consultAllOrders ?? this.consultAllOrders,
      reservations: reservations ?? this.reservations,
      cashRegister: cashRegister ?? this.cashRegister,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
