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

abstract class ArticleCompositionCreate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ArticleCompositionCreate._({
    required this.articleId,
    required this.ingredientId,
    required this.quantity,
  });

  factory ArticleCompositionCreate({
    required _isc.UuidValue articleId,
    required _isc.UuidValue ingredientId,
    required double quantity,
  }) = _ArticleCompositionCreateImpl;

  factory ArticleCompositionCreate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ArticleCompositionCreate(
      articleId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['articleId'],
      ),
      ingredientId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ingredientId'],
      ),
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
    );
  }

  _isc.UuidValue articleId;

  _isc.UuidValue ingredientId;

  double quantity;

  /// Returns a shallow copy of this [ArticleCompositionCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ArticleCompositionCreate copyWith({
    _isc.UuidValue? articleId,
    _isc.UuidValue? ingredientId,
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
    return _isc.SerializationManager.encode(this);
  }
}

class _ArticleCompositionCreateImpl extends ArticleCompositionCreate {
  _ArticleCompositionCreateImpl({
    required _isc.UuidValue articleId,
    required _isc.UuidValue ingredientId,
    required double quantity,
  }) : super._(
         articleId: articleId,
         ingredientId: ingredientId,
         quantity: quantity,
       );

  /// Returns a shallow copy of this [ArticleCompositionCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ArticleCompositionCreate copyWith({
    _isc.UuidValue? articleId,
    _isc.UuidValue? ingredientId,
    double? quantity,
  }) {
    return ArticleCompositionCreate(
      articleId: articleId ?? this.articleId,
      ingredientId: ingredientId ?? this.ingredientId,
      quantity: quantity ?? this.quantity,
    );
  }
}
