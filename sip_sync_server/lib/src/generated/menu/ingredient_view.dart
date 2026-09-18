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
import '../menu/units_type.dart' as _ifqd8x7y;

abstract class IngredientView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  IngredientView._({
    required this.id,
    required this.buildingId,
    required this.name,
    required this.unit,
    required this.currentStock,
    required this.thresholdStock,
  });

  factory IngredientView({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
    required String name,
    required _ifqd8x7y.UnitsType unit,
    required double currentStock,
    required double thresholdStock,
  }) = _IngredientViewImpl;

  factory IngredientView.fromJson(Map<String, dynamic> jsonSerialization) {
    return IngredientView(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      name: jsonSerialization['name'] as String,
      unit: _ifqd8x7y.UnitsType.fromJson((jsonSerialization['unit'] as String)),
      currentStock: (jsonSerialization['currentStock'] as num).toDouble(),
      thresholdStock: (jsonSerialization['thresholdStock'] as num).toDouble(),
    );
  }

  _is.UuidValue id;

  _is.UuidValue buildingId;

  String name;

  _ifqd8x7y.UnitsType unit;

  double currentStock;

  double thresholdStock;

  /// Returns a shallow copy of this [IngredientView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IngredientView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    String? name,
    _ifqd8x7y.UnitsType? unit,
    double? currentStock,
    double? thresholdStock,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IngredientView',
      'id': id.toJson(),
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
      '__className__': 'IngredientView',
      'id': id.toJson(),
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

class _IngredientViewImpl extends IngredientView {
  _IngredientViewImpl({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
    required String name,
    required _ifqd8x7y.UnitsType unit,
    required double currentStock,
    required double thresholdStock,
  }) : super._(
         id: id,
         buildingId: buildingId,
         name: name,
         unit: unit,
         currentStock: currentStock,
         thresholdStock: thresholdStock,
       );

  /// Returns a shallow copy of this [IngredientView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IngredientView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    String? name,
    _ifqd8x7y.UnitsType? unit,
    double? currentStock,
    double? thresholdStock,
  }) {
    return IngredientView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      currentStock: currentStock ?? this.currentStock,
      thresholdStock: thresholdStock ?? this.thresholdStock,
    );
  }
}
