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
import '../../menu/dtos/units_type.dart' as _imlqt1yb;

abstract class IngredientCreate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  IngredientCreate._({
    required this.buildingId,
    required this.name,
    required this.unit,
    required this.currentStock,
    required this.thresholdStock,
  });

  factory IngredientCreate({
    required _is.UuidValue buildingId,
    required String name,
    required _imlqt1yb.UnitsType unit,
    required double currentStock,
    required double thresholdStock,
  }) = _IngredientCreateImpl;

  factory IngredientCreate.fromJson(Map<String, dynamic> jsonSerialization) {
    return IngredientCreate(
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      name: jsonSerialization['name'] as String,
      unit: _imlqt1yb.UnitsType.fromJson((jsonSerialization['unit'] as String)),
      currentStock: (jsonSerialization['currentStock'] as num).toDouble(),
      thresholdStock: (jsonSerialization['thresholdStock'] as num).toDouble(),
    );
  }

  _is.UuidValue buildingId;

  String name;

  _imlqt1yb.UnitsType unit;

  double currentStock;

  double thresholdStock;

  /// Returns a shallow copy of this [IngredientCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IngredientCreate copyWith({
    _is.UuidValue? buildingId,
    String? name,
    _imlqt1yb.UnitsType? unit,
    double? currentStock,
    double? thresholdStock,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IngredientCreate',
      'buildingId': buildingId.toJson(),
      'name': name,
      'unit': unit.toJson(),
      'currentStock': currentStock,
      'thresholdStock': thresholdStock,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IngredientCreate',
      'buildingId': buildingId.toJson(),
      'name': name,
      'unit': unit.toJson(),
      'currentStock': currentStock,
      'thresholdStock': thresholdStock,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _IngredientCreateImpl extends IngredientCreate {
  _IngredientCreateImpl({
    required _is.UuidValue buildingId,
    required String name,
    required _imlqt1yb.UnitsType unit,
    required double currentStock,
    required double thresholdStock,
  }) : super._(
         buildingId: buildingId,
         name: name,
         unit: unit,
         currentStock: currentStock,
         thresholdStock: thresholdStock,
       );

  /// Returns a shallow copy of this [IngredientCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IngredientCreate copyWith({
    _is.UuidValue? buildingId,
    String? name,
    _imlqt1yb.UnitsType? unit,
    double? currentStock,
    double? thresholdStock,
  }) {
    return IngredientCreate(
      buildingId: buildingId ?? this.buildingId,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      currentStock: currentStock ?? this.currentStock,
      thresholdStock: thresholdStock ?? this.thresholdStock,
    );
  }
}
