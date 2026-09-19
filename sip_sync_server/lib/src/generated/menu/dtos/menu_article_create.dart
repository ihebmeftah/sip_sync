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

abstract class MenuArticleCreate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MenuArticleCreate._({
    required this.buildingId,
    required this.categoryId,
    required this.name,
    this.description,
    required this.price,
  });

  factory MenuArticleCreate({
    required _is.UuidValue buildingId,
    required _is.UuidValue categoryId,
    required String name,
    String? description,
    required double price,
  }) = _MenuArticleCreateImpl;

  factory MenuArticleCreate.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuArticleCreate(
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      categoryId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['categoryId'],
      ),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      price: (jsonSerialization['price'] as num).toDouble(),
    );
  }

  _is.UuidValue buildingId;

  _is.UuidValue categoryId;

  String name;

  String? description;

  double price;

  /// Returns a shallow copy of this [MenuArticleCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MenuArticleCreate copyWith({
    _is.UuidValue? buildingId,
    _is.UuidValue? categoryId,
    String? name,
    String? description,
    double? price,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuArticleCreate',
      'buildingId': buildingId.toJson(),
      'categoryId': categoryId.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'price': price,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MenuArticleCreate',
      'buildingId': buildingId.toJson(),
      'categoryId': categoryId.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'price': price,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MenuArticleCreateImpl extends MenuArticleCreate {
  _MenuArticleCreateImpl({
    required _is.UuidValue buildingId,
    required _is.UuidValue categoryId,
    required String name,
    String? description,
    required double price,
  }) : super._(
         buildingId: buildingId,
         categoryId: categoryId,
         name: name,
         description: description,
         price: price,
       );

  /// Returns a shallow copy of this [MenuArticleCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MenuArticleCreate copyWith({
    _is.UuidValue? buildingId,
    _is.UuidValue? categoryId,
    String? name,
    Object? description = _Undefined,
    double? price,
  }) {
    return MenuArticleCreate(
      buildingId: buildingId ?? this.buildingId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      price: price ?? this.price,
    );
  }
}
