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

abstract class IngredientRestock
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IngredientRestock._({
    required this.id,
    required this.quantity,
  });

  factory IngredientRestock({
    required _isc.UuidValue id,
    required double quantity,
  }) = _IngredientRestockImpl;

  factory IngredientRestock.fromJson(Map<String, dynamic> jsonSerialization) {
    return IngredientRestock(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
    );
  }

  _isc.UuidValue id;

  /// Quantity to add to current stock (must be > 0).
  double quantity;

  /// Returns a shallow copy of this [IngredientRestock]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IngredientRestock copyWith({
    _isc.UuidValue? id,
    double? quantity,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IngredientRestock',
      'id': id.toJson(),
      'quantity': quantity,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IngredientRestock',
      'id': id.toJson(),
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _IngredientRestockImpl extends IngredientRestock {
  _IngredientRestockImpl({
    required _isc.UuidValue id,
    required double quantity,
  }) : super._(
         id: id,
         quantity: quantity,
       );

  /// Returns a shallow copy of this [IngredientRestock]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IngredientRestock copyWith({
    _isc.UuidValue? id,
    double? quantity,
  }) {
    return IngredientRestock(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
    );
  }
}
