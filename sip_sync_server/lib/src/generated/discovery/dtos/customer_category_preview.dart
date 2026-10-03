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

/// A menu category a customer may see on a venue page. No stock or recipes.
abstract class CustomerCategoryPreview
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CustomerCategoryPreview._({
    required this.id,
    required this.name,
    this.description,
    required this.articleCount,
  });

  factory CustomerCategoryPreview({
    required _is.UuidValue id,
    required String name,
    String? description,
    required int articleCount,
  }) = _CustomerCategoryPreviewImpl;

  factory CustomerCategoryPreview.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CustomerCategoryPreview(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      articleCount: jsonSerialization['articleCount'] as int,
    );
  }

  _is.UuidValue id;

  String name;

  String? description;

  int articleCount;

  /// Returns a shallow copy of this [CustomerCategoryPreview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerCategoryPreview copyWith({
    _is.UuidValue? id,
    String? name,
    String? description,
    int? articleCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerCategoryPreview',
      'id': id.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'articleCount': articleCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerCategoryPreview',
      'id': id.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'articleCount': articleCount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerCategoryPreviewImpl extends CustomerCategoryPreview {
  _CustomerCategoryPreviewImpl({
    required _is.UuidValue id,
    required String name,
    String? description,
    required int articleCount,
  }) : super._(
         id: id,
         name: name,
         description: description,
         articleCount: articleCount,
       );

  /// Returns a shallow copy of this [CustomerCategoryPreview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CustomerCategoryPreview copyWith({
    _is.UuidValue? id,
    String? name,
    Object? description = _Undefined,
    int? articleCount,
  }) {
    return CustomerCategoryPreview(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      articleCount: articleCount ?? this.articleCount,
    );
  }
}
