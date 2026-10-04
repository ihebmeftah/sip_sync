import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../generated/protocol.dart';
import '../packs/pack_gate.dart';

/// Building-scoped menu article CRUD.
class MenuArticleService {
  /// Lists articles for a building the caller can access.
  Future<List<MenuArticleView>> listForBuilding(
    Session session,
    UuidValue buildingId,
  ) async {
    await _requireBuildingAccess(session, buildingId);
    final rows = await MenuArticle.db.find(
      session,
      where: (t) => t.buildingId.equals(buildingId),
      orderBy: (t) => t.name,
      include: MenuArticle.include(category: MenuCategory.include()),
    );
    final counts = await _compositionCounts(
      session,
      rows.map((r) => r.id!).toSet(),
    );
    return rows
        .map((row) => _view(row, compositionLineCount: counts[row.id!] ?? 0))
        .toList();
  }

  /// Owner-only create.
  Future<MenuArticleView> create(
    Session session,
    MenuArticleCreate request,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
    await _requireOwnedBuilding(session, ownerId, request.buildingId);
    final name = _validateName(request.name);
    final description = _normalizeDescription(request.description);
    final price = _validatePrice(request.price);
    final category = await _requireCategoryInBuilding(
      session,
      request.categoryId,
      request.buildingId,
    );
    await _assertNameAvailable(session, request.buildingId, name);
    final pack = await PackGate.ofBuilding(session, request.buildingId);
    final current = await MenuArticle.db.count(
      session,
      where: (t) => t.buildingId.equals(request.buildingId),
    );
    PackGate.requireRoom(
      max: pack.maxArticles,
      current: current,
      adding: 1,
    );

    final row = await MenuArticle.db.insertRow(
      session,
      MenuArticle(
        buildingId: request.buildingId,
        categoryId: category.id!,
        name: name,
        description: description,
        price: price,
      ),
    );
    return MenuArticleView(
      id: row.id!,
      buildingId: row.buildingId,
      categoryId: row.categoryId,
      categoryName: category.name,
      name: row.name,
      description: row.description,
      price: row.price,
      compositionLineCount: 0,
    );
  }

  /// Owner-only update.
  Future<MenuArticleView> update(
    Session session,
    MenuArticleUpdate request,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
    final existing = await MenuArticle.db.findById(session, request.id);
    if (existing == null) {
      throw MenuArticleException(
        message: 'Article not found.',
        code: MenuArticleErrorCode.notFound,
      );
    }
    await _requireOwnedBuilding(session, ownerId, existing.buildingId);
    final name = _validateName(request.name);
    final description = _normalizeDescription(request.description);
    final price = _validatePrice(request.price);
    final category = await _requireCategoryInBuilding(
      session,
      request.categoryId,
      existing.buildingId,
    );
    await _assertNameAvailable(
      session,
      existing.buildingId,
      name,
      excludingId: existing.id,
    );

    final updated = await MenuArticle.db.updateRow(
      session,
      existing.copyWith(
        categoryId: category.id!,
        name: name,
        description: description,
        price: price,
      ),
    );
    final lineCount = await ArticleComposition.db.count(
      session,
      where: (t) => t.articleId.equals(updated.id!),
    );
    return MenuArticleView(
      id: updated.id!,
      buildingId: updated.buildingId,
      categoryId: updated.categoryId,
      categoryName: category.name,
      name: updated.name,
      description: updated.description,
      price: updated.price,
      compositionLineCount: lineCount,
    );
  }

  Future<Map<UuidValue, int>> _compositionCounts(
    Session session,
    Set<UuidValue> articleIds,
  ) async {
    if (articleIds.isEmpty) {
      return {};
    }
    final lines = await ArticleComposition.db.find(
      session,
      where: (t) => t.articleId.inSet(articleIds),
    );
    final counts = <UuidValue, int>{};
    for (final line in lines) {
      counts[line.articleId] = (counts[line.articleId] ?? 0) + 1;
    }
    return counts;
  }

  MenuArticleView _view(
    MenuArticle row, {
    required int compositionLineCount,
  }) => MenuArticleView(
    id: row.id!,
    buildingId: row.buildingId,
    categoryId: row.categoryId,
    categoryName: row.category?.name ?? '',
    name: row.name,
    description: row.description,
    price: row.price,
    compositionLineCount: compositionLineCount,
  );

  String _validateName(String raw) {
    final name = raw.trim();
    if (name.isEmpty || name.length > 80) {
      throw MenuArticleException(
        message: 'Article name must be 1–80 characters.',
        code: MenuArticleErrorCode.invalidInput,
      );
    }
    return name;
  }

  String? _normalizeDescription(String? raw) {
    if (raw == null) {
      return null;
    }
    final text = raw.trim();
    if (text.isEmpty) {
      return null;
    }
    if (text.length > 500) {
      throw MenuArticleException(
        message: 'Description must be at most 500 characters.',
        code: MenuArticleErrorCode.invalidInput,
      );
    }
    return text;
  }

  double _validatePrice(double price) {
    if (price <= 0 || price > 1000000) {
      throw MenuArticleException(
        message: 'Price must be greater than 0.',
        code: MenuArticleErrorCode.invalidInput,
      );
    }
    return price;
  }

  Future<MenuCategory> _requireCategoryInBuilding(
    Session session,
    UuidValue categoryId,
    UuidValue buildingId,
  ) async {
    final category = await MenuCategory.db.findById(session, categoryId);
    if (category == null || category.buildingId != buildingId) {
      throw MenuArticleException(
        message: 'Category not found in this building.',
        code: MenuArticleErrorCode.notFound,
      );
    }
    return category;
  }

  Future<void> _assertNameAvailable(
    Session session,
    UuidValue buildingId,
    String name, {
    UuidValue? excludingId,
  }) async {
    final clash = await MenuArticle.db.findFirstRow(
      session,
      where: (t) {
        var filter = t.buildingId.equals(buildingId) & t.name.ilike(name);
        if (excludingId != null) {
          filter = filter & t.id.notEquals(excludingId);
        }
        return filter;
      },
    );
    if (clash != null) {
      throw MenuArticleException(
        message: 'An article with that name already exists here.',
        code: MenuArticleErrorCode.nameTaken,
      );
    }
  }

  Future<void> _requireBuildingAccess(
    Session session,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null) {
      throw MenuArticleException(
        message: 'Building not found.',
        code: MenuArticleErrorCode.notFound,
      );
    }
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType == ActorType.owner && building.ownerId == ctx.actorId) {
      return;
    }
    if (ctx.actorType == ActorType.employee) {
      final employee = await Employee.db.findById(session, ctx.actorId);
      if (employee != null && employee.buildingId == buildingId) {
        return;
      }
    }
    throw MenuArticleException(
      message: 'Not allowed for this building.',
      code: MenuArticleErrorCode.notAuthorized,
    );
  }

  Future<void> _requireOwnedBuilding(
    Session session,
    UuidValue ownerId,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null || building.ownerId != ownerId) {
      throw MenuArticleException(
        message: 'Building not found.',
        code: MenuArticleErrorCode.notFound,
      );
    }
  }
}
