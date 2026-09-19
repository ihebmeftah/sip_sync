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

abstract class ArticleCompositionUpdate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ArticleCompositionUpdate._({
    required this.id,
    required this.quantity,
  });

  factory ArticleCompositionUpdate({
    required _is.UuidValue id,
    required double quantity,
  }) = _ArticleCompositionUpdateImpl;

  factory ArticleCompositionUpdate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ArticleCompositionUpdate(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
    );
  }

  _is.UuidValue id;

  double quantity;

  /// Returns a shallow copy of this [ArticleCompositionUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ArticleCompositionUpdate copyWith({
    _is.UuidValue? id,
    double? quantity,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArticleCompositionUpdate',
      'id': id.toJson(),
      'quantity': quantity,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ArticleCompositionUpdate',
      'id': id.toJson(),
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ArticleCompositionUpdateImpl extends ArticleCompositionUpdate {
  _ArticleCompositionUpdateImpl({
    required _is.UuidValue id,
    required double quantity,
  }) : super._(
         id: id,
         quantity: quantity,
       );

  /// Returns a shallow copy of this [ArticleCompositionUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ArticleCompositionUpdate copyWith({
    _is.UuidValue? id,
    double? quantity,
  }) {
    return ArticleCompositionUpdate(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
    );
  }
}
