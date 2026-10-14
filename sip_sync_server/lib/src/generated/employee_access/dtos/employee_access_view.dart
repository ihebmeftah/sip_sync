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

abstract class EmployeeAccessView
    implements _is.SerializableModel, _is.ProtocolSerialization {
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
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
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
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      name: jsonSerialization['name'] as String,
      orderCreation: _is.BoolJsonExtension.fromJson(
        jsonSerialization['orderCreation'],
      ),
      orderPayment: _is.BoolJsonExtension.fromJson(
        jsonSerialization['orderPayment'],
      ),
      cancelOrder: _is.BoolJsonExtension.fromJson(
        jsonSerialization['cancelOrder'],
      ),
      preparation: _is.BoolJsonExtension.fromJson(
        jsonSerialization['preparation'],
      ),
      serving: _is.BoolJsonExtension.fromJson(jsonSerialization['serving']),
      consultAllOrders: _is.BoolJsonExtension.fromJson(
        jsonSerialization['consultAllOrders'],
      ),
      reservations: _is.BoolJsonExtension.fromJson(
        jsonSerialization['reservations'],
      ),
      cashRegister: jsonSerialization['cashRegister'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['cashRegister']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  _is.UuidValue id;

  _is.UuidValue buildingId;

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
  @_is.useResult
  EmployeeAccessView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
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
    return _is.SerializationManager.encode(this);
  }
}

class _EmployeeAccessViewImpl extends EmployeeAccessView {
  _EmployeeAccessViewImpl({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
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
  @_is.useResult
  @override
  EmployeeAccessView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
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
