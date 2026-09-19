import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../generated/protocol.dart';

/// Optional recipe lines linking articles to ingredients.
class ArticleCompositionService {
  /// Lists composition lines for an article the caller can access.
  Future<List<ArticleCompositionView>> listForArticle(
    Session session,
    UuidValue articleId,
  ) async {
    final article = await MenuArticle.db.findById(session, articleId);
    if (article == null) {
      throw ArticleCompositionException(
        message: 'Article not found.',
        code: ArticleCompositionErrorCode.notFound,
      );
    }
    await _requireBuildingAccess(session, article.buildingId);
    final rows = await ArticleComposition.db.find(
      session,
      where: (t) => t.articleId.equals(articleId),
      orderBy: (t) => t.createdAt,
      include: ArticleComposition.include(
        ingredient: Ingredient.include(),
      ),
    );
    return rows.map(_view).toList();
  }

  /// Owner adds one ingredient line (articles may stay with zero lines).
  Future<ArticleCompositionView> create(
    Session session,
    ArticleCompositionCreate request,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
    final article = await MenuArticle.db.findById(session, request.articleId);
    if (article == null) {
      throw ArticleCompositionException(
        message: 'Article not found.',
        code: ArticleCompositionErrorCode.notFound,
      );
    }
    await _requireOwnedBuilding(session, ownerId, article.buildingId);
    final quantity = _validateQuantity(request.quantity);
    final ingredient = await Ingredient.db.findById(
      session,
      request.ingredientId,
    );
    if (ingredient == null || ingredient.buildingId != article.buildingId) {
      throw ArticleCompositionException(
        message: 'Ingredient not found in this building.',
        code: ArticleCompositionErrorCode.notFound,
      );
    }
    final clash = await ArticleComposition.db.findFirstRow(
      session,
      where: (t) =>
          t.articleId.equals(article.id!) &
          t.ingredientId.equals(ingredient.id!),
    );
    if (clash != null) {
      throw ArticleCompositionException(
        message: 'That ingredient is already on this article.',
        code: ArticleCompositionErrorCode.ingredientTaken,
      );
    }

    final row = await ArticleComposition.db.insertRow(
      session,
      ArticleComposition(
        articleId: article.id!,
        ingredientId: ingredient.id!,
        quantity: quantity,
      ),
    );
    return ArticleCompositionView(
      id: row.id!,
      articleId: row.articleId,
      ingredientId: row.ingredientId,
      ingredientName: ingredient.name,
      unit: ingredient.unit,
      quantity: row.quantity,
    );
  }

  /// Owner updates quantity only.
  Future<ArticleCompositionView> update(
    Session session,
    ArticleCompositionUpdate request,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
    final existing = await ArticleComposition.db.findById(
      session,
      request.id,
      include: ArticleComposition.include(
        article: MenuArticle.include(),
        ingredient: Ingredient.include(),
      ),
    );
    if (existing == null) {
      throw ArticleCompositionException(
        message: 'Composition line not found.',
        code: ArticleCompositionErrorCode.notFound,
      );
    }
    final buildingId = existing.article?.buildingId;
    if (buildingId == null) {
      throw ArticleCompositionException(
        message: 'Article not found.',
        code: ArticleCompositionErrorCode.notFound,
      );
    }
    await _requireOwnedBuilding(session, ownerId, buildingId);
    final quantity = _validateQuantity(request.quantity);
    final updated = await ArticleComposition.db.updateRow(
      session,
      existing.copyWith(quantity: quantity),
    );
    final ingredient = existing.ingredient;
    return ArticleCompositionView(
      id: updated.id!,
      articleId: updated.articleId,
      ingredientId: updated.ingredientId,
      ingredientName: ingredient?.name ?? '',
      unit: ingredient?.unit ?? UnitsType.piece,
      quantity: updated.quantity,
    );
  }

  /// Owner removes one line.
  Future<void> delete(Session session, UuidValue id) async {
    final ownerId = AuthGuard.requireOwner(session);
    final existing = await ArticleComposition.db.findById(
      session,
      id,
      include: ArticleComposition.include(article: MenuArticle.include()),
    );
    if (existing == null) {
      throw ArticleCompositionException(
        message: 'Composition line not found.',
        code: ArticleCompositionErrorCode.notFound,
      );
    }
    final buildingId = existing.article?.buildingId;
    if (buildingId == null) {
      throw ArticleCompositionException(
        message: 'Article not found.',
        code: ArticleCompositionErrorCode.notFound,
      );
    }
    await _requireOwnedBuilding(session, ownerId, buildingId);
    await ArticleComposition.db.deleteRow(session, existing);
  }

  ArticleCompositionView _view(ArticleComposition row) =>
      ArticleCompositionView(
        id: row.id!,
        articleId: row.articleId,
        ingredientId: row.ingredientId,
        ingredientName: row.ingredient?.name ?? '',
        unit: row.ingredient?.unit ?? UnitsType.piece,
        quantity: row.quantity,
      );

  double _validateQuantity(double quantity) {
    if (quantity <= 0 || quantity > 1000000) {
      throw ArticleCompositionException(
        message: 'Quantity must be greater than 0.',
        code: ArticleCompositionErrorCode.invalidInput,
      );
    }
    return quantity;
  }

  Future<void> _requireBuildingAccess(
    Session session,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null) {
      throw ArticleCompositionException(
        message: 'Building not found.',
        code: ArticleCompositionErrorCode.notFound,
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
    throw ArticleCompositionException(
      message: 'Not allowed for this building.',
      code: ArticleCompositionErrorCode.notAuthorized,
    );
  }

  Future<void> _requireOwnedBuilding(
    Session session,
    UuidValue ownerId,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null || building.ownerId != ownerId) {
      throw ArticleCompositionException(
        message: 'Building not found.',
        code: ArticleCompositionErrorCode.notFound,
      );
    }
  }
}
