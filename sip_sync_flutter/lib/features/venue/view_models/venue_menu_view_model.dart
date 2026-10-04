import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/paging/list_paging.dart';

part 'venue_menu_view_model.g.dart';

/// Menu articles loaded so far, plus the full category rail.
class VenueMenuState {
  const VenueMenuState({
    required this.currencyCode,
    required this.customerOrdering,
    required this.categories,
    required this.articles,
    required this.totalArticles,
    this.loadingMore = false,
    this.moreErrorKey,
  });

  final String currencyCode;
  final bool customerOrdering;
  final List<CustomerCategoryPreview> categories;
  final List<CustomerArticlePreview> articles;
  final int totalArticles;
  final bool loadingMore;
  final String? moreErrorKey;

  bool get hasMore => articles.length < totalArticles;

  /// Categories whose dishes are in [articles], plus categories that are empty.
  List<CustomerMenuSection> get visibleSections {
    final byCategory = <String, List<CustomerArticlePreview>>{};
    for (final article in articles) {
      byCategory.putIfAbsent(article.categoryId.uuid, () => []).add(article);
    }
    final loaded = articles.length;
    var cursor = 0;
    final visible = <CustomerMenuSection>[];
    for (final category in categories) {
      final start = cursor;
      cursor += category.articleCount;
      final revealed = category.articleCount == 0 || loaded > start;
      if (!revealed) {
        continue;
      }
      visible.add(
        CustomerMenuSection(
          id: category.id,
          name: category.name,
          description: category.description,
          articles: byCategory[category.id.uuid] ?? const [],
        ),
      );
    }
    return visible;
  }

  VenueMenuState copyWith({
    List<CustomerArticlePreview>? articles,
    int? totalArticles,
    bool? loadingMore,
    String? moreErrorKey,
    bool clearMoreError = false,
  }) {
    return VenueMenuState(
      currencyCode: currencyCode,
      customerOrdering: customerOrdering,
      categories: categories,
      articles: articles ?? this.articles,
      totalArticles: totalArticles ?? this.totalArticles,
      loadingMore: loadingMore ?? this.loadingMore,
      moreErrorKey: clearMoreError ? null : (moreErrorKey ?? this.moreErrorKey),
    );
  }

  static VenueMenuState fromPage(CustomerMenu page) {
    final articles = page.articles.isNotEmpty
        ? page.articles
        : [
            for (final section in page.sections) ...section.articles,
          ];
    final categories = page.categories.isNotEmpty
        ? page.categories
        : [
            for (final section in page.sections)
              CustomerCategoryPreview(
                id: section.id,
                name: section.name,
                description: section.description,
                articleCount: section.articles.length,
              ),
          ];
    final total = page.totalArticles > 0 ? page.totalArticles : articles.length;
    return VenueMenuState(
      currencyCode: page.currencyCode,
      customerOrdering: page.customerOrdering,
      categories: categories,
      articles: articles,
      totalArticles: total,
    );
  }
}

/// Customer menu for one building, loaded in catalog order.
@riverpod
class VenueMenuViewModel extends _$VenueMenuViewModel {
  @override
  Future<VenueMenuState> build(String buildingId) async {
    final page = await ref
        .read(customerDiscoveryRepositoryProvider)
        .venueMenu(UuidValue.fromString(buildingId), limit: listPageSize);
    return VenueMenuState.fromPage(page);
  }

  /// Appends the next dishes. [categoryIndex] loads forward until that
  /// category's first dish is present.
  Future<void> loadMore() => _loadUntil(null);

  Future<void> loadUntil(int categoryIndex) async {
    final current = state.asData?.value;
    if (current == null || categoryIndex < 0) {
      return;
    }
    var target = 0;
    for (var i = 0; i < categoryIndex && i < current.categories.length; i++) {
      target += current.categories[i].articleCount;
    }
    if (current.categories.length > categoryIndex &&
        current.categories[categoryIndex].articleCount > 0) {
      target += 1;
    }
    await _loadUntil(target);
  }

  Future<void> _loadUntil(int? target) async {
    var current = state.asData?.value;
    if (current == null || current.loadingMore || !current.hasMore) {
      return;
    }
    while (current != null &&
        current.hasMore &&
        (target == null || current.articles.length < target)) {
      final loading = current;
      state = AsyncData(
        loading.copyWith(loadingMore: true, clearMoreError: true),
      );
      try {
        final page = await ref
            .read(customerDiscoveryRepositoryProvider)
            .venueMenu(
              UuidValue.fromString(buildingId),
              limit: listPageSize,
              offset: loading.articles.length,
            );
        final seen = {for (final article in loading.articles) article.id};
        current = loading.copyWith(
          articles: [
            ...loading.articles,
            for (final article in page.articles)
              if (!seen.contains(article.id)) article,
          ],
          totalArticles: page.totalArticles,
          loadingMore: false,
        );
        state = AsyncData(current);
        if (target == null) {
          return;
        }
      } catch (error) {
        state = AsyncData(
          loading.copyWith(
            loadingMore: false,
            moreErrorKey: mapError(error).l10nKey,
          ),
        );
        return;
      }
    }
  }
}
