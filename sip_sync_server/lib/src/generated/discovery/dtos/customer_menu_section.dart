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
import '../../discovery/dtos/customer_article_preview.dart' as _iy9yvlrm;

/// One category and its articles, in menu order.
abstract class CustomerMenuSection
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CustomerMenuSection._({
    required this.id,
    required this.name,
    this.description,
    required this.articles,
  });

  factory CustomerMenuSection({
    required _is.UuidValue id,
    required String name,
    String? description,
    required List<_iy9yvlrm.CustomerArticlePreview> articles,
  }) = _CustomerMenuSectionImpl;

  factory CustomerMenuSection.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerMenuSection(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      articles: _iaib1p48.Protocol()
          .deserialize<List<_iy9yvlrm.CustomerArticlePreview>>(
            jsonSerialization['articles'],
          ),
    );
  }

  _is.UuidValue id;

  String name;

  String? description;

  List<_iy9yvlrm.CustomerArticlePreview> articles;

  /// Returns a shallow copy of this [CustomerMenuSection]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerMenuSection copyWith({
    _is.UuidValue? id,
    String? name,
    String? description,
    List<_iy9yvlrm.CustomerArticlePreview>? articles,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerMenuSection',
      'id': id.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'articles': articles.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerMenuSection',
      'id': id.toJson(),
      'name': name,
      if (description != null) 'description': description,
      'articles': articles.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerMenuSectionImpl extends CustomerMenuSection {
  _CustomerMenuSectionImpl({
    required _is.UuidValue id,
    required String name,
    String? description,
    required List<_iy9yvlrm.CustomerArticlePreview> articles,
  }) : super._(
         id: id,
         name: name,
         description: description,
         articles: articles,
       );

  /// Returns a shallow copy of this [CustomerMenuSection]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CustomerMenuSection copyWith({
    _is.UuidValue? id,
    String? name,
    Object? description = _Undefined,
    List<_iy9yvlrm.CustomerArticlePreview>? articles,
  }) {
    return CustomerMenuSection(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      articles: articles ?? this.articles.map((e0) => e0.copyWith()).toList(),
    );
  }
}
