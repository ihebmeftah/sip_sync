import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Customer-facing venue page and menu. Hides owner, staff, and stock.
class CustomerVenueService {
  static const previewLimit = 5;

  /// Venue card, free tables, and the top categories and articles.
  ///
  /// Ranking uses non-cancelled lines on non-cancelled orders. A venue with
  /// no such lines falls back to the first [previewLimit] rows by creation.
  Future<CustomerVenueDetail> detail(
    Session session,
    UuidValue buildingId,
  ) async {
    final building = await _building(session, buildingId);
    final categories = await _categories(session, buildingId);
    final articles = await _articles(session, buildingId);
    final demand = await _demand(session, buildingId, articles);
    final rankedCategories = _top(
      categories,
      demand: (row) => demand.categoryCounts[row.id!.uuid] ?? 0,
      createdAt: (row) => row.createdAt,
      name: (row) => row.name,
    );
    final rankedArticles = _top(
      articles,
      demand: (row) => demand.articleCounts[row.id!.uuid] ?? 0,
      createdAt: (row) => row.createdAt,
      name: (row) => row.name,
    );
    final names = {for (final row in categories) row.id!.uuid: row.name};
    final ingredients = await _ingredientNames(session, articles);
    final freeTables = await _freeTables(session, buildingId);
    return CustomerVenueDetail(
      venue: _card(building),
      currencyCode: building.currencyCode,
      availableTableCount: freeTables.length,
      availableTables: freeTables,
      categories: [
        for (final row in rankedCategories)
          CustomerCategoryPreview(
            id: row.id!,
            name: row.name,
            description: row.description,
            articleCount: articles
                .where((article) => article.categoryId == row.id)
                .length,
          ),
      ],
      articles: [
        for (final row in rankedArticles)
          CustomerArticlePreview(
            id: row.id!,
            categoryId: row.categoryId,
            categoryName: names[row.categoryId.uuid] ?? '',
            name: row.name,
            description: row.description,
            price: row.price,
            ingredientNames: ingredients[row.id!.uuid] ?? const [],
          ),
      ],
    );
  }

  /// Every category in creation order, with its articles in creation order.
  Future<CustomerMenu> menu(Session session, UuidValue buildingId) async {
    final building = await _building(session, buildingId);
    final categories = await _categories(session, buildingId);
    final articles = await _articles(session, buildingId);
    final ingredients = await _ingredientNames(session, articles);
    return CustomerMenu(
      currencyCode: building.currencyCode,
      sections: [
        for (final category in categories)
          CustomerMenuSection(
            id: category.id!,
            name: category.name,
            description: category.description,
            articles: [
              for (final article in articles)
                if (article.categoryId == category.id)
                  CustomerArticlePreview(
                    id: article.id!,
                    categoryId: article.categoryId,
                    categoryName: category.name,
                    name: article.name,
                    description: article.description,
                    price: article.price,
                    ingredientNames: ingredients[article.id!.uuid] ?? const [],
                  ),
            ],
          ),
      ],
    );
  }

  Future<Building> _building(Session session, UuidValue buildingId) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null || building.id == null) {
      throw BuildingException(
        message: 'Venue not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    return building;
  }

  Future<List<MenuCategory>> _categories(
    Session session,
    UuidValue buildingId,
  ) {
    return MenuCategory.db.find(
      session,
      where: (t) => t.buildingId.equals(buildingId),
      orderBy: (t) => t.createdAt,
    );
  }

  Future<List<MenuArticle>> _articles(
    Session session,
    UuidValue buildingId,
  ) {
    return MenuArticle.db.find(
      session,
      where: (t) => t.buildingId.equals(buildingId),
      orderBy: (t) => t.createdAt,
    );
  }

  /// Confirms [tableId] is an active table in [buildingId] with [number].
  ///
  /// The sticker is the customer's claim. The row must still exist, stay
  /// active, and carry the same number. Occupied tables are allowed.
  Future<CustomerSeatedTable> resolveTable(
    Session session,
    UuidValue buildingId,
    UuidValue tableId,
    int number,
  ) async {
    if (number < 1) {
      throw BuildingException(
        message: 'Table number is not valid.',
        code: BuildingErrorCode.invalidInput,
      );
    }
    final building = await _building(session, buildingId);
    final table = await VenueTable.db.findById(session, tableId);
    final matches =
        table != null &&
        table.buildingId == buildingId &&
        table.number == number &&
        table.isActive &&
        table.id != null;
    if (!matches) {
      throw BuildingException(
        message: 'Table not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    return CustomerSeatedTable(
      buildingId: building.id!,
      tableId: table.id!,
      number: table.number,
      maxSeats: table.maxSeats,
      venueName: building.name,
    );
  }

  /// Active tables with no order in progress, lowest number first.
  Future<List<CustomerTablePreview>> _freeTables(
    Session session,
    UuidValue buildingId,
  ) async {
    final tables = await VenueTable.db.find(
      session,
      where: (t) => t.buildingId.equals(buildingId) & t.isActive.equals(true),
      orderBy: (t) => t.number,
    );
    final open = await VenueOrder.db.find(
      session,
      where: (t) =>
          t.buildingId.equals(buildingId) &
          t.status.equals(OrderStatus.progress) &
          t.venueTableId.notEquals(null),
    );
    final occupied = {
      for (final order in open)
        if (order.venueTableId != null) order.venueTableId!,
    };
    return [
      for (final table in tables)
        if (!occupied.contains(table.id))
          CustomerTablePreview(
            id: table.id!,
            number: table.number,
            maxSeats: table.maxSeats,
          ),
    ];
  }

  /// Recipe names only. Stock and quantities stay on the ops menu.
  Future<Map<String, List<String>>> _ingredientNames(
    Session session,
    List<MenuArticle> articles,
  ) async {
    final articleIds = {
      for (final article in articles)
        if (article.id != null) article.id!,
    };
    if (articleIds.isEmpty) {
      return {};
    }
    final lines = await ArticleComposition.db.find(
      session,
      where: (t) => t.articleId.inSet(articleIds),
      include: ArticleComposition.include(ingredient: Ingredient.include()),
      orderBy: (t) => t.createdAt,
    );
    final names = <String, List<String>>{};
    for (final line in lines) {
      final name = line.ingredient?.name.trim();
      if (name == null || name.isEmpty) {
        continue;
      }
      names.putIfAbsent(line.articleId.uuid, () => []).add(name);
    }
    return names;
  }

  Future<({Map<String, int> articleCounts, Map<String, int> categoryCounts})>
  _demand(
    Session session,
    UuidValue buildingId,
    List<MenuArticle> articles,
  ) async {
    final categoryByArticle = {
      for (final article in articles) article.id!.uuid: article.categoryId.uuid,
    };
    final orders = await VenueOrder.db.find(
      session,
      where: (t) =>
          t.buildingId.equals(buildingId) &
          t.status.notEquals(OrderStatus.cancelled),
      include: VenueOrder.include(
        items: VenueOrderItem.includeList(),
      ),
    );
    final articleCounts = <String, int>{};
    final categoryCounts = <String, int>{};
    for (final order in orders) {
      for (final item in order.items ?? const <VenueOrderItem>[]) {
        if (item.status == OrderItemStatus.cancelled) {
          continue;
        }
        final articleId = item.articleId.uuid;
        articleCounts[articleId] = (articleCounts[articleId] ?? 0) + 1;
        final categoryId = categoryByArticle[articleId];
        if (categoryId != null) {
          categoryCounts[categoryId] = (categoryCounts[categoryId] ?? 0) + 1;
        }
      }
    }
    return (articleCounts: articleCounts, categoryCounts: categoryCounts);
  }

  /// Highest demand first. Equal demand keeps creation order, then name.
  List<T> _top<T>(
    List<T> rows, {
    required int Function(T row) demand,
    required DateTime Function(T row) createdAt,
    required String Function(T row) name,
  }) {
    final sorted = [...rows]
      ..sort((a, b) {
        final byDemand = demand(b).compareTo(demand(a));
        if (byDemand != 0) {
          return byDemand;
        }
        final byTime = createdAt(a).compareTo(createdAt(b));
        if (byTime != 0) {
          return byTime;
        }
        return name(a).compareTo(name(b));
      });
    return sorted.take(previewLimit).toList();
  }

  CustomerVenueCard _card(Building building) {
    return CustomerVenueCard(
      id: building.id!,
      name: building.name,
      type: building.type,
      address: building.address,
      latitude: building.latitude,
      longitude: building.longitude,
      openingMinutes: building.openingMinutes,
      closingMinutes: building.closingMinutes,
      phoneNumber: building.phoneNumber,
    );
  }
}
