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
import 'package:sip_sync_client/src/protocol/protocol.dart' as _iozg9o5r;

/// A sellable article a customer may see. Price is the current menu price.
abstract class CustomerArticlePreview
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CustomerArticlePreview._({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.name,
    this.description,
    required this.price,
    required this.ingredientNames,
    required this.outOfStockIngredientNames,
  });

  factory CustomerArticlePreview({
    required _isc.UuidValue id,
    required _isc.UuidValue categoryId,
    required String categoryName,
    required String name,
    String? description,
    required double price,
    required List<String> ingredientNames,
    required List<String> outOfStockIngredientNames,
  }) = _CustomerArticlePreviewImpl;

  factory CustomerArticlePreview.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CustomerArticlePreview(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      categoryId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['categoryId'],
      ),
      categoryName: jsonSerialization['categoryName'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      price: (jsonSerialization['price'] as num).toDouble(),
      ingredientNames: _iozg9o5r.Protocol().deserialize<List<String>>(
        jsonSerialization['ingredientNames'],
      ),
      outOfStockIngredientNames: _iozg9o5r.Protocol().deserialize<List<String>>(
        jsonSerialization['outOfStockIngredientNames'],
      ),
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue categoryId;

  String categoryName;

  String name;

  String? description;

  double price;

  /// Ingredient names in recipe order. No quantities or stock levels.
  List<String> ingredientNames;

  /// Recipe ingredients that cannot cover one more unit. Names only.
  List<String> outOfStockIngredientNames;

  /// Returns a shallow copy of this [CustomerArticlePreview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CustomerArticlePreview copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? categoryId,
    String? categoryName,
    String? name,
    String? description,
    double? price,
    List<String>? ingredientNames,
    List<String>? outOfStockIngredientNames,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerArticlePreview',
      'id': id.toJson(),
      'categoryId': categoryId.toJson(),
      'categoryName': categoryName,
      'name': name,
      if (description != null) 'description': description,
      'price': price,
      'ingredientNames': ingredientNames.toJson(),
      'outOfStockIngredientNames': outOfStockIngredientNames.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerArticlePreview',
      'id': id.toJson(),
      'categoryId': categoryId.toJson(),
      'categoryName': categoryName,
      'name': name,
      if (description != null) 'description': description,
      'price': price,
      'ingredientNames': ingredientNames.toJson(),
      'outOfStockIngredientNames': outOfStockIngredientNames.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerArticlePreviewImpl extends CustomerArticlePreview {
  _CustomerArticlePreviewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue categoryId,
    required String categoryName,
    required String name,
    String? description,
    required double price,
    required List<String> ingredientNames,
    required List<String> outOfStockIngredientNames,
  }) : super._(
         id: id,
         categoryId: categoryId,
         categoryName: categoryName,
         name: name,
         description: description,
         price: price,
         ingredientNames: ingredientNames,
         outOfStockIngredientNames: outOfStockIngredientNames,
       );

  /// Returns a shallow copy of this [CustomerArticlePreview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CustomerArticlePreview copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? categoryId,
    String? categoryName,
    String? name,
    Object? description = _Undefined,
    double? price,
    List<String>? ingredientNames,
    List<String>? outOfStockIngredientNames,
  }) {
    return CustomerArticlePreview(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      price: price ?? this.price,
      ingredientNames:
          ingredientNames ?? this.ingredientNames.map((e0) => e0).toList(),
      outOfStockIngredientNames:
          outOfStockIngredientNames ??
          this.outOfStockIngredientNames.map((e0) => e0).toList(),
    );
  }
}
