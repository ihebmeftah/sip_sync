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
    required this.bookableTables,
    required this.categories,
    required this.articles,
    required this.customerOrdering,
    required this.orderingClosedByVenue,
    required this.reservationsEnabled,
    required this.reservationsClosedByVenue,
    bool? allowOutOfStockOrders,
    required this.reservationFee,
  }) : allowOutOfStockOrders = allowOutOfStockOrders ?? false;

  factory CustomerVenueDetail({
    required _iw16ezvu.CustomerVenueCard venue,
    required String currencyCode,
    required int availableTableCount,
    required List<_iwd58pyr.CustomerTablePreview> availableTables,
    required List<_iwd58pyr.CustomerTablePreview> bookableTables,
    required List<_irq7e2mv.CustomerCategoryPreview> categories,
    required List<_iy9yvlrm.CustomerArticlePreview> articles,
    required bool customerOrdering,
    required bool orderingClosedByVenue,
    required bool reservationsEnabled,
    required bool reservationsClosedByVenue,
    bool? allowOutOfStockOrders,
    required double reservationFee,
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
      bookableTables: _iaib1p48.Protocol()
          .deserialize<List<_iwd58pyr.CustomerTablePreview>>(
            jsonSerialization['bookableTables'],
          ),
      categories: _iaib1p48.Protocol()
          .deserialize<List<_irq7e2mv.CustomerCategoryPreview>>(
            jsonSerialization['categories'],
          ),
      articles: _iaib1p48.Protocol()
          .deserialize<List<_iy9yvlrm.CustomerArticlePreview>>(
            jsonSerialization['articles'],
          ),
      customerOrdering: _is.BoolJsonExtension.fromJson(
        jsonSerialization['customerOrdering'],
      ),
      orderingClosedByVenue: _is.BoolJsonExtension.fromJson(
        jsonSerialization['orderingClosedByVenue'],
      ),
      reservationsEnabled: _is.BoolJsonExtension.fromJson(
        jsonSerialization['reservationsEnabled'],
      ),
      reservationsClosedByVenue: _is.BoolJsonExtension.fromJson(
        jsonSerialization['reservationsClosedByVenue'],
      ),
      allowOutOfStockOrders: jsonSerialization['allowOutOfStockOrders'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['allowOutOfStockOrders'],
            ),
      reservationFee: (jsonSerialization['reservationFee'] as num).toDouble(),
    );
  }

  _iw16ezvu.CustomerVenueCard venue;

  String currencyCode;

  /// Active tables with no open order.
  int availableTableCount;

  /// Those free tables, lowest number first.
  List<_iwd58pyr.CustomerTablePreview> availableTables;

  /// Every active table, so a later booking can include one that is busy now.
  List<_iwd58pyr.CustomerTablePreview> bookableTables;

  /// Up to five categories, busiest first. Creation order when nothing was ordered.
  List<_irq7e2mv.CustomerCategoryPreview> categories;

  /// Up to five articles, busiest first. Creation order when nothing was ordered.
  List<_iy9yvlrm.CustomerArticlePreview> articles;

  /// False when the pack or the venue has customer-app orders turned off.
  bool customerOrdering;

  /// True only when the pack includes ordering and the venue has turned it off.
  bool orderingClosedByVenue;

  /// False when the pack or the venue has reservations turned off.
  bool reservationsEnabled;

  /// True only when the pack includes reservations and the venue has turned them off.
  bool reservationsClosedByVenue;

  /// When true, a dish can still be added if a recipe ingredient cannot cover one unit.
  bool allowOutOfStockOrders;

  /// Building default, in [currencyCode].
  double reservationFee;

  /// Returns a shallow copy of this [CustomerVenueDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerVenueDetail copyWith({
    _iw16ezvu.CustomerVenueCard? venue,
    String? currencyCode,
    int? availableTableCount,
    List<_iwd58pyr.CustomerTablePreview>? availableTables,
    List<_iwd58pyr.CustomerTablePreview>? bookableTables,
    List<_irq7e2mv.CustomerCategoryPreview>? categories,
    List<_iy9yvlrm.CustomerArticlePreview>? articles,
    bool? customerOrdering,
    bool? orderingClosedByVenue,
    bool? reservationsEnabled,
    bool? reservationsClosedByVenue,
    bool? allowOutOfStockOrders,
    double? reservationFee,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerVenueDetail',
      'venue': venue.toJson(),
      'currencyCode': currencyCode,
      'availableTableCount': availableTableCount,
      'availableTables': availableTables.toJson(valueToJson: (v) => v.toJson()),
      'bookableTables': bookableTables.toJson(valueToJson: (v) => v.toJson()),
      'categories': categories.toJson(valueToJson: (v) => v.toJson()),
      'articles': articles.toJson(valueToJson: (v) => v.toJson()),
      'customerOrdering': customerOrdering,
      'orderingClosedByVenue': orderingClosedByVenue,
      'reservationsEnabled': reservationsEnabled,
      'reservationsClosedByVenue': reservationsClosedByVenue,
      'allowOutOfStockOrders': allowOutOfStockOrders,
      'reservationFee': reservationFee,
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
      'bookableTables': bookableTables.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'categories': categories.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'articles': articles.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'customerOrdering': customerOrdering,
      'orderingClosedByVenue': orderingClosedByVenue,
      'reservationsEnabled': reservationsEnabled,
      'reservationsClosedByVenue': reservationsClosedByVenue,
      'allowOutOfStockOrders': allowOutOfStockOrders,
      'reservationFee': reservationFee,
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
    required List<_iwd58pyr.CustomerTablePreview> bookableTables,
    required List<_irq7e2mv.CustomerCategoryPreview> categories,
    required List<_iy9yvlrm.CustomerArticlePreview> articles,
    required bool customerOrdering,
    required bool orderingClosedByVenue,
    required bool reservationsEnabled,
    required bool reservationsClosedByVenue,
    bool? allowOutOfStockOrders,
    required double reservationFee,
  }) : super._(
         venue: venue,
         currencyCode: currencyCode,
         availableTableCount: availableTableCount,
         availableTables: availableTables,
         bookableTables: bookableTables,
         categories: categories,
         articles: articles,
         customerOrdering: customerOrdering,
         orderingClosedByVenue: orderingClosedByVenue,
         reservationsEnabled: reservationsEnabled,
         reservationsClosedByVenue: reservationsClosedByVenue,
         allowOutOfStockOrders: allowOutOfStockOrders,
         reservationFee: reservationFee,
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
    List<_iwd58pyr.CustomerTablePreview>? bookableTables,
    List<_irq7e2mv.CustomerCategoryPreview>? categories,
    List<_iy9yvlrm.CustomerArticlePreview>? articles,
    bool? customerOrdering,
    bool? orderingClosedByVenue,
    bool? reservationsEnabled,
    bool? reservationsClosedByVenue,
    bool? allowOutOfStockOrders,
    double? reservationFee,
  }) {
    return CustomerVenueDetail(
      venue: venue ?? this.venue.copyWith(),
      currencyCode: currencyCode ?? this.currencyCode,
      availableTableCount: availableTableCount ?? this.availableTableCount,
      availableTables:
          availableTables ??
          this.availableTables.map((e0) => e0.copyWith()).toList(),
      bookableTables:
          bookableTables ??
          this.bookableTables.map((e0) => e0.copyWith()).toList(),
      categories:
          categories ?? this.categories.map((e0) => e0.copyWith()).toList(),
      articles: articles ?? this.articles.map((e0) => e0.copyWith()).toList(),
      customerOrdering: customerOrdering ?? this.customerOrdering,
      orderingClosedByVenue:
          orderingClosedByVenue ?? this.orderingClosedByVenue,
      reservationsEnabled: reservationsEnabled ?? this.reservationsEnabled,
      reservationsClosedByVenue:
          reservationsClosedByVenue ?? this.reservationsClosedByVenue,
      allowOutOfStockOrders:
          allowOutOfStockOrders ?? this.allowOutOfStockOrders,
      reservationFee: reservationFee ?? this.reservationFee,
    );
  }
}
