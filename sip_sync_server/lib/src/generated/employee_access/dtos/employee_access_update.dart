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

abstract class EmployeeAccessUpdate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EmployeeAccessUpdate._({
    required this.id,
    required this.name,
    required this.orderCreation,
    required this.orderPayment,
    required this.cancelOrder,
    required this.preparation,
    required this.serving,
    required this.consultAllOrders,
  });

  factory EmployeeAccessUpdate({
    required _is.UuidValue id,
    required String name,
    required bool orderCreation,
    required bool orderPayment,
    required bool cancelOrder,
    required bool preparation,
    required bool serving,
    required bool consultAllOrders,
  }) = _EmployeeAccessUpdateImpl;

  factory EmployeeAccessUpdate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EmployeeAccessUpdate(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
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
    );
  }

  _is.UuidValue id;

  String name;

  bool orderCreation;

  bool orderPayment;

  bool cancelOrder;

  bool preparation;

  bool serving;

  bool consultAllOrders;

  /// Returns a shallow copy of this [EmployeeAccessUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EmployeeAccessUpdate copyWith({
    _is.UuidValue? id,
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
      '__className__': 'EmployeeAccessUpdate',
      'id': id.toJson(),
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
      '__className__': 'EmployeeAccessUpdate',
      'id': id.toJson(),
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
    return _is.SerializationManager.encode(this);
  }
}

class _EmployeeAccessUpdateImpl extends EmployeeAccessUpdate {
  _EmployeeAccessUpdateImpl({
    required _is.UuidValue id,
    required String name,
    required bool orderCreation,
    required bool orderPayment,
    required bool cancelOrder,
    required bool preparation,
    required bool serving,
    required bool consultAllOrders,
  }) : super._(
         id: id,
         name: name,
         orderCreation: orderCreation,
         orderPayment: orderPayment,
         cancelOrder: cancelOrder,
         preparation: preparation,
         serving: serving,
         consultAllOrders: consultAllOrders,
       );

  /// Returns a shallow copy of this [EmployeeAccessUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EmployeeAccessUpdate copyWith({
    _is.UuidValue? id,
    String? name,
    bool? orderCreation,
    bool? orderPayment,
    bool? cancelOrder,
    bool? preparation,
    bool? serving,
    bool? consultAllOrders,
  }) {
    return EmployeeAccessUpdate(
      id: id ?? this.id,
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
