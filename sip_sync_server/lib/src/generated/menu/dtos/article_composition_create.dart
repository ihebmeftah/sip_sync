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

abstract class ArticleCompositionCreate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ArticleCompositionCreate._({
    required this.articleId,
    required this.ingredientId,
    required this.quantity,
  });

  factory ArticleCompositionCreate({
    required _is.UuidValue articleId,
    required _is.UuidValue ingredientId,
    required double quantity,
  }) = _ArticleCompositionCreateImpl;

  factory ArticleCompositionCreate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ArticleCompositionCreate(
      articleId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['articleId'],
      ),
      ingredientId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ingredientId'],
      ),
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
    );
  }

  _is.UuidValue articleId;

  _is.UuidValue ingredientId;

  double quantity;

  /// Returns a shallow copy of this [ArticleCompositionCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ArticleCompositionCreate copyWith({
    _is.UuidValue? articleId,
    _is.UuidValue? ingredientId,
    double? quantity,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArticleCompositionCreate',
      'articleId': articleId.toJson(),
      'ingredientId': ingredientId.toJson(),
      'quantity': quantity,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ArticleCompositionCreate',
      'articleId': articleId.toJson(),
      'ingredientId': ingredientId.toJson(),
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ArticleCompositionCreateImpl extends ArticleCompositionCreate {
  _ArticleCompositionCreateImpl({
    required _is.UuidValue articleId,
    required _is.UuidValue ingredientId,
    required double quantity,
  }) : super._(
         articleId: articleId,
         ingredientId: ingredientId,
         quantity: quantity,
       );

  /// Returns a shallow copy of this [ArticleCompositionCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ArticleCompositionCreate copyWith({
    _is.UuidValue? articleId,
    _is.UuidValue? ingredientId,
    double? quantity,
  }) {
    return ArticleCompositionCreate(
      articleId: articleId ?? this.articleId,
      ingredientId: ingredientId ?? this.ingredientId,
      quantity: quantity ?? this.quantity,
    );
  }
}
