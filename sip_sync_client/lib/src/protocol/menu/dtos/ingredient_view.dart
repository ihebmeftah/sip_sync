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
import '../../menu/dtos/units_type.dart' as _imlqt1yb;

abstract class IngredientView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IngredientView._({
    required this.id,
    required this.buildingId,
    required this.name,
    required this.unit,
    required this.initialStock,
    required this.currentStock,
    required this.thresholdStock,
    required this.belowThreshold,
    required this.stockProgress,
  });

  factory IngredientView({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required String name,
    required _imlqt1yb.UnitsType unit,
    required double initialStock,
    required double currentStock,
    required double thresholdStock,
    required bool belowThreshold,
    required double stockProgress,
  }) = _IngredientViewImpl;

  factory IngredientView.fromJson(Map<String, dynamic> jsonSerialization) {
    return IngredientView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      name: jsonSerialization['name'] as String,
      unit: _imlqt1yb.UnitsType.fromJson((jsonSerialization['unit'] as String)),
      initialStock: (jsonSerialization['initialStock'] as num).toDouble(),
      currentStock: (jsonSerialization['currentStock'] as num).toDouble(),
      thresholdStock: (jsonSerialization['thresholdStock'] as num).toDouble(),
      belowThreshold: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['belowThreshold'],
      ),
      stockProgress: (jsonSerialization['stockProgress'] as num).toDouble(),
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue buildingId;

  String name;

  _imlqt1yb.UnitsType unit;

  double initialStock;

  double currentStock;

  double thresholdStock;

  /// True when currentStock <= thresholdStock (alert the floor).
  bool belowThreshold;

  /// currentStock / initialStock clamped to 0..1 for the fill bar.
  double stockProgress;

  /// Returns a shallow copy of this [IngredientView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IngredientView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    String? name,
    _imlqt1yb.UnitsType? unit,
    double? initialStock,
    double? currentStock,
    double? thresholdStock,
    bool? belowThreshold,
    double? stockProgress,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IngredientView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'name': name,
      'unit': unit.toJson(),
      'initialStock': initialStock,
      'currentStock': currentStock,
      'thresholdStock': thresholdStock,
      'belowThreshold': belowThreshold,
      'stockProgress': stockProgress,
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
      'initialStock': initialStock,
      'currentStock': currentStock,
      'thresholdStock': thresholdStock,
      'belowThreshold': belowThreshold,
      'stockProgress': stockProgress,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _IngredientViewImpl extends IngredientView {
  _IngredientViewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required String name,
    required _imlqt1yb.UnitsType unit,
    required double initialStock,
    required double currentStock,
    required double thresholdStock,
    required bool belowThreshold,
    required double stockProgress,
  }) : super._(
         id: id,
         buildingId: buildingId,
         name: name,
         unit: unit,
         initialStock: initialStock,
         currentStock: currentStock,
         thresholdStock: thresholdStock,
         belowThreshold: belowThreshold,
         stockProgress: stockProgress,
       );

  /// Returns a shallow copy of this [IngredientView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IngredientView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    String? name,
    _imlqt1yb.UnitsType? unit,
    double? initialStock,
    double? currentStock,
    double? thresholdStock,
    bool? belowThreshold,
    double? stockProgress,
  }) {
    return IngredientView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      initialStock: initialStock ?? this.initialStock,
      currentStock: currentStock ?? this.currentStock,
      thresholdStock: thresholdStock ?? this.thresholdStock,
      belowThreshold: belowThreshold ?? this.belowThreshold,
      stockProgress: stockProgress ?? this.stockProgress,
    );
  }
}
