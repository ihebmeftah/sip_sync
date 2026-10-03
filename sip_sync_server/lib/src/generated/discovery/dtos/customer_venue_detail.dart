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
import '../../discovery/dtos/customer_category_preview.dart' as _irq7e2mv;
import '../../discovery/dtos/customer_table_preview.dart' as _iwd58pyr;
import '../../discovery/dtos/customer_venue_card.dart' as _iw16ezvu;

/// Venue page for a signed-in customer: card, free tables, and a short menu preview.
abstract class CustomerVenueDetail
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CustomerVenueDetail._({
    required this.venue,
    required this.currencyCode,
    required this.availableTableCount,
    required this.availableTables,
    required this.categories,
    required this.articles,
  });

  factory CustomerVenueDetail({
    required _iw16ezvu.CustomerVenueCard venue,
    required String currencyCode,
    required int availableTableCount,
    required List<_iwd58pyr.CustomerTablePreview> availableTables,
    required List<_irq7e2mv.CustomerCategoryPreview> categories,
    required List<_iy9yvlrm.CustomerArticlePreview> articles,
  }) = _CustomerVenueDetailImpl;

  factory CustomerVenueDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerVenueDetail(
      venue: _iaib1p48.Protocol().deserialize<_iw16ezvu.CustomerVenueCard>(
        jsonSerialization['venue'],
      ),
      currencyCode: jsonSerialization['currencyCode'] as String,
      availableTableCount: jsonSerialization['availableTableCount'] as int,
      availableTables: _iaib1p48.Protocol()
          .deserialize<List<_iwd58pyr.CustomerTablePreview>>(
            jsonSerialization['availableTables'],
          ),
      categories: _iaib1p48.Protocol()
          .deserialize<List<_irq7e2mv.CustomerCategoryPreview>>(
            jsonSerialization['categories'],
          ),
      articles: _iaib1p48.Protocol()
          .deserialize<List<_iy9yvlrm.CustomerArticlePreview>>(
            jsonSerialization['articles'],
          ),
    );
  }

  _iw16ezvu.CustomerVenueCard venue;

  String currencyCode;

  /// Active tables with no open order.
  int availableTableCount;

  /// Those free tables, lowest number first.
  List<_iwd58pyr.CustomerTablePreview> availableTables;

  /// Up to five categories, busiest first. Creation order when nothing was ordered.
  List<_irq7e2mv.CustomerCategoryPreview> categories;

  /// Up to five articles, busiest first. Creation order when nothing was ordered.
  List<_iy9yvlrm.CustomerArticlePreview> articles;

  /// Returns a shallow copy of this [CustomerVenueDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerVenueDetail copyWith({
    _iw16ezvu.CustomerVenueCard? venue,
    String? currencyCode,
    int? availableTableCount,
    List<_iwd58pyr.CustomerTablePreview>? availableTables,
    List<_irq7e2mv.CustomerCategoryPreview>? categories,
    List<_iy9yvlrm.CustomerArticlePreview>? articles,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerVenueDetail',
      'venue': venue.toJson(),
      'currencyCode': currencyCode,
      'availableTableCount': availableTableCount,
      'availableTables': availableTables.toJson(valueToJson: (v) => v.toJson()),
      'categories': categories.toJson(valueToJson: (v) => v.toJson()),
      'articles': articles.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerVenueDetail',
      'venue': venue.toJsonForProtocol(),
      'currencyCode': currencyCode,
      'availableTableCount': availableTableCount,
      'availableTables': availableTables.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'categories': categories.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'articles': articles.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CustomerVenueDetailImpl extends CustomerVenueDetail {
  _CustomerVenueDetailImpl({
    required _iw16ezvu.CustomerVenueCard venue,
    required String currencyCode,
    required int availableTableCount,
    required List<_iwd58pyr.CustomerTablePreview> availableTables,
    required List<_irq7e2mv.CustomerCategoryPreview> categories,
    required List<_iy9yvlrm.CustomerArticlePreview> articles,
  }) : super._(
         venue: venue,
         currencyCode: currencyCode,
         availableTableCount: availableTableCount,
         availableTables: availableTables,
         categories: categories,
         articles: articles,
       );

  /// Returns a shallow copy of this [CustomerVenueDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CustomerVenueDetail copyWith({
    _iw16ezvu.CustomerVenueCard? venue,
    String? currencyCode,
    int? availableTableCount,
    List<_iwd58pyr.CustomerTablePreview>? availableTables,
    List<_irq7e2mv.CustomerCategoryPreview>? categories,
    List<_iy9yvlrm.CustomerArticlePreview>? articles,
  }) {
    return CustomerVenueDetail(
      venue: venue ?? this.venue.copyWith(),
      currencyCode: currencyCode ?? this.currencyCode,
      availableTableCount: availableTableCount ?? this.availableTableCount,
      availableTables:
          availableTables ??
          this.availableTables.map((e0) => e0.copyWith()).toList(),
      categories:
          categories ?? this.categories.map((e0) => e0.copyWith()).toList(),
      articles: articles ?? this.articles.map((e0) => e0.copyWith()).toList(),
    );
  }
}
