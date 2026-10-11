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
import 'package:sip_sync_server/src/generated/protocol.dart' as _iaib1p48;

abstract class MenuArticleView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MenuArticleView._({
    required this.id,
    required this.buildingId,
    required this.categoryId,
    required this.categoryName,
    required this.name,
    this.description,
    required this.price,
    required this.compositionLineCount,
    required this.outOfStockIngredientNames,
  });

  factory MenuArticleView({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
    required _is.UuidValue categoryId,
    required String categoryName,
    required String name,
    String? description,
    required double price,
    required int compositionLineCount,
    required List<String> outOfStockIngredientNames,
  }) = _MenuArticleViewImpl;

  factory MenuArticleView.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuArticleView(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      categoryId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['categoryId'],
      ),
      categoryName: jsonSerialization['categoryName'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      price: (jsonSerialization['price'] as num).toDouble(),
      compositionLineCount: jsonSerialization['compositionLineCount'] as int,
      outOfStockIngredientNames: _iaib1p48.Protocol().deserialize<List<String>>(
        jsonSerialization['outOfStockIngredientNames'],
      ),
    );
  }

  _is.UuidValue id;

  _is.UuidValue buildingId;

  _is.UuidValue categoryId;

  String categoryName;

  String name;

  String? description;

  double price;

  /// Number of recipe lines; 0 means no composition yet (allowed).
  int compositionLineCount;

  /// Recipe ingredients that cannot cover one more unit.
  List<String> outOfStockIngredientNames;

  /// Returns a shallow copy of this [MenuArticleView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MenuArticleView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    _is.UuidValue? categoryId,
    String? categoryName,
    String? name,
    String? description,
    double? price,
    int? compositionLineCount,
    List<String>? outOfStockIngredientNames,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuArticleView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'categoryId': categoryId.toJson(),
      'categoryName': categoryName,
      'name': name,
      if (description != null) 'description': description,
      'price': price,
      'compositionLineCount': compositionLineCount,
      'outOfStockIngredientNames': outOfStockIngredientNames.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MenuArticleView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'categoryId': categoryId.toJson(),
      'categoryName': categoryName,
      'name': name,
      if (description != null) 'description': description,
      'price': price,
      'compositionLineCount': compositionLineCount,
      'outOfStockIngredientNames': outOfStockIngredientNames.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MenuArticleViewImpl extends MenuArticleView {
  _MenuArticleViewImpl({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
    required _is.UuidValue categoryId,
    required String categoryName,
    required String name,
    String? description,
    required double price,
    required int compositionLineCount,
    required List<String> outOfStockIngredientNames,
  }) : super._(
         id: id,
         buildingId: buildingId,
         categoryId: categoryId,
         categoryName: categoryName,
         name: name,
         description: description,
         price: price,
         compositionLineCount: compositionLineCount,
         outOfStockIngredientNames: outOfStockIngredientNames,
       );

  /// Returns a shallow copy of this [MenuArticleView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MenuArticleView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    _is.UuidValue? categoryId,
    String? categoryName,
    String? name,
    Object? description = _Undefined,
    double? price,
    int? compositionLineCount,
    List<String>? outOfStockIngredientNames,
  }) {
    return MenuArticleView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      price: price ?? this.price,
      compositionLineCount: compositionLineCount ?? this.compositionLineCount,
      outOfStockIngredientNames:
          outOfStockIngredientNames ??
          this.outOfStockIngredientNames.map((e0) => e0).toList(),
    );
  }
}
