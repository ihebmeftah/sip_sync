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
import '../../discovery/dtos/customer_article_preview.dart' as _iy9yvlrm;
import '../../discovery/dtos/customer_category_preview.dart' as _irq7e2mv;
import '../../discovery/dtos/customer_menu_section.dart' as _i5wjhh7t;

/// One window of a customer menu, plus the category index for the rail.
abstract class CustomerMenu
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CustomerMenu._({
    required this.currencyCode,
    required this.sections,
    required this.customerOrdering,
    required this.categories,
    required this.articles,
    required this.totalArticles,
    required this.limit,
    required this.offset,
  });

  factory CustomerMenu({
    required String currencyCode,
    required List<_i5wjhh7t.CustomerMenuSection> sections,
    required bool customerOrdering,
    required List<_irq7e2mv.CustomerCategoryPreview> categories,
    required List<_iy9yvlrm.CustomerArticlePreview> articles,
    required int totalArticles,
    required int limit,
    required int offset,
  }) = _CustomerMenuImpl;

  factory CustomerMenu.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerMenu(
      currencyCode: jsonSerialization['currencyCode'] as String,
      sections: _iozg9o5r.Protocol()
          .deserialize<List<_i5wjhh7t.CustomerMenuSection>>(
            jsonSerialization['sections'],
          ),
      customerOrdering: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['customerOrdering'],
      ),
      categories: _iozg9o5r.Protocol()
          .deserialize<List<_irq7e2mv.CustomerCategoryPreview>>(
            jsonSerialization['categories'],
          ),
      articles: _iozg9o5r.Protocol()
          .deserialize<List<_iy9yvlrm.CustomerArticlePreview>>(
            jsonSerialization['articles'],
          ),
      totalArticles: jsonSerialization['totalArticles'] as int,
      limit: jsonSerialization['limit'] as int,
      offset: jsonSerialization['offset'] as int,
    );
  }

  String currencyCode;

  /// Categories touched by this window, including truly empty ones.
  List<_i5wjhh7t.CustomerMenuSection> sections;

  /// False when the venue pack does not include customer-app orders.
  bool customerOrdering;

  /// Every category in catalog order. Article counts, no dishes.
  List<_irq7e2mv.CustomerCategoryPreview> categories;

  /// Dishes in this window, catalog order.
  List<_iy9yvlrm.CustomerArticlePreview> articles;

  int totalArticles;

  int limit;

  int offset;

  /// Returns a shallow copy of this [CustomerMenu]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CustomerMenu copyWith({
    String? currencyCode,
    List<_i5wjhh7t.CustomerMenuSection>? sections,
    bool? customerOrdering,
    List<_irq7e2mv.CustomerCategoryPreview>? categories,
    List<_iy9yvlrm.CustomerArticlePreview>? articles,
    int? totalArticles,
    int? limit,
    int? offset,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerMenu',
      'currencyCode': currencyCode,
      'sections': sections.toJson(valueToJson: (v) => v.toJson()),
      'customerOrdering': customerOrdering,
      'categories': categories.toJson(valueToJson: (v) => v.toJson()),
      'articles': articles.toJson(valueToJson: (v) => v.toJson()),
      'totalArticles': totalArticles,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerMenu',
      'currencyCode': currencyCode,
      'sections': sections.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'customerOrdering': customerOrdering,
      'categories': categories.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'articles': articles.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalArticles': totalArticles,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _CustomerMenuImpl extends CustomerMenu {
  _CustomerMenuImpl({
    required String currencyCode,
    required List<_i5wjhh7t.CustomerMenuSection> sections,
    required bool customerOrdering,
    required List<_irq7e2mv.CustomerCategoryPreview> categories,
    required List<_iy9yvlrm.CustomerArticlePreview> articles,
    required int totalArticles,
    required int limit,
    required int offset,
  }) : super._(
         currencyCode: currencyCode,
         sections: sections,
         customerOrdering: customerOrdering,
         categories: categories,
         articles: articles,
         totalArticles: totalArticles,
         limit: limit,
         offset: offset,
       );

  /// Returns a shallow copy of this [CustomerMenu]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CustomerMenu copyWith({
    String? currencyCode,
    List<_i5wjhh7t.CustomerMenuSection>? sections,
    bool? customerOrdering,
    List<_irq7e2mv.CustomerCategoryPreview>? categories,
    List<_iy9yvlrm.CustomerArticlePreview>? articles,
    int? totalArticles,
    int? limit,
    int? offset,
  }) {
    return CustomerMenu(
      currencyCode: currencyCode ?? this.currencyCode,
      sections: sections ?? this.sections.map((e0) => e0.copyWith()).toList(),
      customerOrdering: customerOrdering ?? this.customerOrdering,
      categories:
          categories ?? this.categories.map((e0) => e0.copyWith()).toList(),
      articles: articles ?? this.articles.map((e0) => e0.copyWith()).toList(),
      totalArticles: totalArticles ?? this.totalArticles,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }
}
