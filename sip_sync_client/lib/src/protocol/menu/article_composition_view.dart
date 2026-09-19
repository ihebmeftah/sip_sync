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
import '../menu/units_type.dart' as _ifqd8x7y;

abstract class ArticleCompositionView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ArticleCompositionView._({
    required this.id,
    required this.articleId,
    required this.ingredientId,
    required this.ingredientName,
    required this.unit,
    required this.quantity,
  });

  factory ArticleCompositionView({
    required _isc.UuidValue id,
    required _isc.UuidValue articleId,
    required _isc.UuidValue ingredientId,
    required String ingredientName,
    required _ifqd8x7y.UnitsType unit,
    required double quantity,
  }) = _ArticleCompositionViewImpl;

  factory ArticleCompositionView.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ArticleCompositionView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      articleId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['articleId'],
      ),
      ingredientId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ingredientId'],
      ),
      ingredientName: jsonSerialization['ingredientName'] as String,
      unit: _ifqd8x7y.UnitsType.fromJson((jsonSerialization['unit'] as String)),
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue articleId;

  _isc.UuidValue ingredientId;

  String ingredientName;

  _ifqd8x7y.UnitsType unit;

  double quantity;

  /// Returns a shallow copy of this [ArticleCompositionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ArticleCompositionView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? articleId,
    _isc.UuidValue? ingredientId,
    String? ingredientName,
    _ifqd8x7y.UnitsType? unit,
    double? quantity,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArticleCompositionView',
      'id': id.toJson(),
      'articleId': articleId.toJson(),
      'ingredientId': ingredientId.toJson(),
      'ingredientName': ingredientName,
      'unit': unit.toJson(),
      'quantity': quantity,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ArticleCompositionView',
      'id': id.toJson(),
      'articleId': articleId.toJson(),
      'ingredientId': ingredientId.toJson(),
      'ingredientName': ingredientName,
      'unit': unit.toJson(),
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ArticleCompositionViewImpl extends ArticleCompositionView {
  _ArticleCompositionViewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue articleId,
    required _isc.UuidValue ingredientId,
    required String ingredientName,
    required _ifqd8x7y.UnitsType unit,
    required double quantity,
  }) : super._(
         id: id,
         articleId: articleId,
         ingredientId: ingredientId,
         ingredientName: ingredientName,
         unit: unit,
         quantity: quantity,
       );

  /// Returns a shallow copy of this [ArticleCompositionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ArticleCompositionView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? articleId,
    _isc.UuidValue? ingredientId,
    String? ingredientName,
    _ifqd8x7y.UnitsType? unit,
    double? quantity,
  }) {
    return ArticleCompositionView(
      id: id ?? this.id,
      articleId: articleId ?? this.articleId,
      ingredientId: ingredientId ?? this.ingredientId,
      ingredientName: ingredientName ?? this.ingredientName,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
    );
  }
}
