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

abstract class EmployeeAccessCreate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EmployeeAccessCreate._({
    required this.buildingId,
    required this.name,
    required this.orderCreation,
    required this.orderPayment,
    required this.cancelOrder,
    required this.preparation,
    required this.serving,
    required this.consultAllOrders,
  });

  factory EmployeeAccessCreate({
    required _isc.UuidValue buildingId,
    required String name,
    required bool orderCreation,
    required bool orderPayment,
    required bool cancelOrder,
    required bool preparation,
    required bool serving,
    required bool consultAllOrders,
  }) = _EmployeeAccessCreateImpl;

  factory EmployeeAccessCreate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EmployeeAccessCreate(
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
    );
  }

  _isc.UuidValue buildingId;

  String name;

  bool orderCreation;

  bool orderPayment;

  bool cancelOrder;

  bool preparation;

  bool serving;

  bool consultAllOrders;

  /// Returns a shallow copy of this [EmployeeAccessCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EmployeeAccessCreate copyWith({
    _isc.UuidValue? buildingId,
    String? name,
    bool? orderCreation,
    bool? orderPayment,
    bool? cancelOrder,
    bool? preparation,
    bool? serving,
    bool? consultAllOrders,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmployeeAccessCreate',
      'buildingId': buildingId.toJson(),
      'name': name,
      'orderCreation': orderCreation,
      'orderPayment': orderPayment,
      'cancelOrder': cancelOrder,
      'preparation': preparation,
      'serving': serving,
      'consultAllOrders': consultAllOrders,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmployeeAccessCreate',
      'buildingId': buildingId.toJson(),
      'name': name,
      'orderCreation': orderCreation,
      'orderPayment': orderPayment,
      'cancelOrder': cancelOrder,
      'preparation': preparation,
      'serving': serving,
      'consultAllOrders': consultAllOrders,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _EmployeeAccessCreateImpl extends EmployeeAccessCreate {
  _EmployeeAccessCreateImpl({
    required _isc.UuidValue buildingId,
    required String name,
    required bool orderCreation,
    required bool orderPayment,
    required bool cancelOrder,
    required bool preparation,
    required bool serving,
    required bool consultAllOrders,
  }) : super._(
         buildingId: buildingId,
         name: name,
         orderCreation: orderCreation,
         orderPayment: orderPayment,
         cancelOrder: cancelOrder,
         preparation: preparation,
         serving: serving,
         consultAllOrders: consultAllOrders,
       );

  /// Returns a shallow copy of this [EmployeeAccessCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EmployeeAccessCreate copyWith({
    _isc.UuidValue? buildingId,
    String? name,
    bool? orderCreation,
    bool? orderPayment,
    bool? cancelOrder,
    bool? preparation,
    bool? serving,
    bool? consultAllOrders,
  }) {
    return EmployeeAccessCreate(
      buildingId: buildingId ?? this.buildingId,
      name: name ?? this.name,
      orderCreation: orderCreation ?? this.orderCreation,
      orderPayment: orderPayment ?? this.orderPayment,
      cancelOrder: cancelOrder ?? this.cancelOrder,
      preparation: preparation ?? this.preparation,
      serving: serving ?? this.serving,
      consultAllOrders: consultAllOrders ?? this.consultAllOrders,
    );
  }
}
