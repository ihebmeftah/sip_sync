import 'package:serverpod/serverpod.dart';

import '../core/page_window.dart';
import '../generated/protocol.dart';
import '../menu/article_stock.dart';
import '../packs/pack_expiry.dart';
import '../reservations/reservation_service.dart';

/// Customer-facing venue page and menu. Hides owner, staff, and stock.
class CustomerVenueService {
  static const previewLimit = 5;

  /// Same radius the customer app uses for the nearby chip.
  static const nearbyRadiusKm = 15.0;

  /// Discovery cards. Name order, or nearest first when a place is set.
  Future<CustomerVenuePage> list(
    Session session, {
    int? limit,
    int? offset,
    double? latitude,
    double? longitude,
    bool nearbyOnly = false,
  }) async {
    await PackExpiry.revertDue(session);
    final window = PageWindow.from(limit: limit, offset: offset);
    final hasOrigin = latitude != null && longitude != null;
    if (hasOrigin && session.db.dialect == DatabaseDialect.postgres) {
      return _listByDistance(
        session,
        window: window,
        latitude: latitude,
        longitude: longitude,
        nearbyOnly: nearbyOnly,
      );
    }
    Expression where(BuildingTable t) => t.pack.customerDiscovery.equals(true);
    final total = await Building.db.count(session, where: where);
    final rows = await Building.db.find(
      session,
      where: where,
      orderBy: (t) => t.name,
      limit: window.limit,
      offset: window.offset,
    );
    return CustomerVenuePage(
      items: [
        for (final row in rows)
          if (row.id != null) _card(row),
      ],
      total: total,
      limit: window.limit,
      offset: window.offset,
    );
  }

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
    final ingredients = await recipeStockByArticle(
      session,
      {for (final row in articles) row.id!},
    );
    final tables = await _tablePreviews(session, buildingId);
    final freeTables = [
      for (final table in tables.previews)
        if (!tables.occupied.contains(table.id)) table,
    ];
    return CustomerVenueDetail(
      venue: _card(building),
      currencyCode: building.currencyCode,
      availableTableCount: freeTables.length,
      availableTables: freeTables,
      bookableTables: tables.previews,
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
            ingredientNames: ingredients[row.id!]?.ingredientNames ?? const [],
            outOfStockIngredientNames:
                ingredients[row.id!]?.outOfStockIngredientNames ?? const [],
          ),
      ],
      customerOrdering: _customerOrderingOpen(building),
      orderingClosedByVenue: _orderingClosedByVenue(building),
      reservationsEnabled: _reservationsOpen(building),
      reservationsClosedByVenue: _reservationsClosedByVenue(building),
      allowOutOfStockOrders: building.allowOutOfStockOrders,
      reservationFee: building.reservationFee,
    );
  }

  /// One article window in catalog order, plus the full category index.
  Future<CustomerMenu> menu(
    Session session,
    UuidValue buildingId, {
    int? limit,
    int? offset,
  }) async {
    final building = await _building(session, buildingId);
    final window = PageWindow.from(limit: limit, offset: offset);
    final categories = await _categories(session, buildingId);
    final counts = await _articleCounts(session, buildingId);
    final totalArticles = counts.values.fold<int>(
      0,
      (sum, count) => sum + count,
    );
    final articleIds = await _articlePageIds(session, buildingId, window);
    final articles = await _articlesByIds(session, articleIds);
    final ingredients = await recipeStockByArticle(
      session,
      {for (final row in articles) row.id!},
    );
    final names = {for (final row in categories) row.id!.uuid: row.name};
    final previews = [
      for (final row in articles)
        CustomerArticlePreview(
          id: row.id!,
          categoryId: row.categoryId,
          categoryName: names[row.categoryId.uuid] ?? '',
          name: row.name,
          description: row.description,
          price: row.price,
          ingredientNames: ingredients[row.id!]?.ingredientNames ?? const [],
          outOfStockIngredientNames:
              ingredients[row.id!]?.outOfStockIngredientNames ?? const [],
        ),
    ];
    final byCategory = <String, List<CustomerArticlePreview>>{};
    for (final article in previews) {
      byCategory.putIfAbsent(article.categoryId.uuid, () => []).add(article);
    }
    final index = [
      for (final category in categories)
        if (category.id != null)
          CustomerCategoryPreview(
            id: category.id!,
            name: category.name,
            description: category.description,
            articleCount: counts[category.id!.uuid] ?? 0,
          ),
    ];
    return CustomerMenu(
      currencyCode: building.currencyCode,
      sections: [
        for (final category in index)
          if (category.articleCount == 0 ||
              byCategory.containsKey(category.id.uuid))
            CustomerMenuSection(
              id: category.id,
              name: category.name,
              description: category.description,
              articles: byCategory[category.id.uuid] ?? const [],
            ),
      ],
      customerOrdering: _customerOrderingOpen(building),
      orderingClosedByVenue: _orderingClosedByVenue(building),
      allowOutOfStockOrders: building.allowOutOfStockOrders,
      categories: index,
      articles: previews,
      totalArticles: totalArticles,
      limit: window.limit,
      offset: window.offset,
    );
  }

  Future<Building> _building(Session session, UuidValue buildingId) async {
    final building = await Building.db.findById(
      session,
      buildingId,
      include: Building.include(pack: Pack.include()),
    );
    if (building == null || building.id == null) {
      throw BuildingException(
        message: 'Venue not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    final current = await PackExpiry.apply(session, building);
    if (current.pack?.customerDiscovery != true) {
      throw BuildingException(
        message: 'Venue not found.',
        code: BuildingErrorCode.notFound,
      );
    }
    return current;
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

  Future<CustomerVenuePage> _listByDistance(
    Session session, {
    required PageWindow window,
    required double latitude,
    required double longitude,
    required bool nearbyOnly,
  }) async {
    const distance = '''
6371.0 * acos(LEAST(1.0, GREATEST(-1.0,
  cos(radians(@lat)) * cos(radians(b.latitude))
  * cos(radians(b.longitude) - radians(@lon))
  + sin(radians(@lat)) * sin(radians(b.latitude))
)))''';
    const from =
        '''
FROM building b
INNER JOIN pack p ON p.id = b."packId"
WHERE p."customerDiscovery" = true
AND (
  @nearbyOnly = false
  OR ($distance) <= @radius
)''';
    final origin = QueryParameters.named({
      'lat': latitude,
      'lon': longitude,
      'nearbyOnly': nearbyOnly,
      'radius': nearbyRadiusKm,
    });
    final counted = await session.db.unsafeQuery(
      'SELECT count(*)::int $from',
      parameters: origin,
    );
    final ranked = await session.db.unsafeQuery(
      'SELECT b.id::text $from ORDER BY ($distance) ASC, b.name ASC LIMIT @limit OFFSET @offset',
      parameters: QueryParameters.named({
        'lat': latitude,
        'lon': longitude,
        'nearbyOnly': nearbyOnly,
        'radius': nearbyRadiusKm,
        'limit': window.limit,
        'offset': window.offset,
      }),
    );
    final total = counted.isEmpty ? 0 : sqlInt(counted.first.first);
    final ids = [for (final row in ranked) sqlUuid(row.first)];
    if (ids.isEmpty) {
      return CustomerVenuePage(
        items: const [],
        total: total,
        limit: window.limit,
        offset: window.offset,
      );
    }
    final rows = await Building.db.find(
      session,
      where: (t) => t.id.inSet(ids.toSet()),
    );
    final byId = {for (final row in rows) row.id: row};
    return CustomerVenuePage(
      items: [
        for (final id in ids)
          if (byId[id] != null) _card(byId[id]!),
      ],
      total: total,
      limit: window.limit,
      offset: window.offset,
    );
  }

  Future<Map<String, int>> _articleCounts(
    Session session,
    UuidValue buildingId,
  ) async {
    final rows = await session.db.unsafeQuery(
      '''
SELECT "categoryId"::text, count(*)::int
FROM menu_article
WHERE "buildingId" = @buildingId::uuid
GROUP BY "categoryId"
''',
      parameters: QueryParameters.named({'buildingId': buildingId.uuid}),
    );
    return {
      for (final row in rows) row[0].toString(): sqlInt(row[1]),
    };
  }

  Future<List<UuidValue>> _articlePageIds(
    Session session,
    UuidValue buildingId,
    PageWindow window,
  ) async {
    final rows = await session.db.unsafeQuery(
      '''
SELECT a.id::text
FROM menu_article a
INNER JOIN menu_category c ON c.id = a."categoryId"
WHERE a."buildingId" = @buildingId::uuid
ORDER BY c."createdAt" ASC, a."createdAt" ASC, a.id ASC
LIMIT @limit OFFSET @offset
''',
      parameters: QueryParameters.named({
        'buildingId': buildingId.uuid,
        'limit': window.limit,
        'offset': window.offset,
      }),
    );
    return [for (final row in rows) sqlUuid(row.first)];
  }

  Future<List<MenuArticle>> _articlesByIds(
    Session session,
    List<UuidValue> ids,
  ) async {
    if (ids.isEmpty) {
      return const [];
    }
    final rows = await MenuArticle.db.find(
      session,
      where: (t) => t.id.inSet(ids.toSet()),
    );
    final byId = {for (final row in rows) row.id: row};
    return [
      for (final id in ids)
        if (byId[id] != null) byId[id]!,
    ];
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
    if (building.pack?.tableQr != true) {
      throw BuildingException(
        message: 'Table not found.',
        code: BuildingErrorCode.notFound,
      );
    }
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

  /// Active tables, lowest number first, plus which ones have an open order.
  Future<({List<CustomerTablePreview> previews, Set<UuidValue> occupied})>
  _tablePreviews(Session session, UuidValue buildingId) async {
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
    final signals = await ReservationService().signalsForBuilding(
      session,
      buildingId,
    );
    return (
      occupied: occupied,
      previews: [
        for (final table in tables)
          CustomerTablePreview(
            id: table.id!,
            number: table.number,
            maxSeats: table.maxSeats,
            reservationPhase: signals[table.id]?.phase ?? ReservationPhase.none,
          ),
      ],
    );
  }

  /// Pack capability and the venue switch must both be on.
  bool _customerOrderingOpen(Building building) {
    return building.pack?.customerOrdering == true &&
        building.customerOrderingEnabled;
  }

  /// Pack capability and the venue switch must both be on.
  bool _reservationsOpen(Building building) {
    return building.pack?.reservations == true && building.reservationsEnabled;
  }

  /// The pack still includes ordering; the venue turned the switch off.
  bool _orderingClosedByVenue(Building building) {
    return building.pack?.customerOrdering == true &&
        !building.customerOrderingEnabled;
  }

  /// The pack still includes reservations; the venue turned the switch off.
  bool _reservationsClosedByVenue(Building building) {
    return building.pack?.reservations == true && !building.reservationsEnabled;
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
