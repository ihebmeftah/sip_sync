import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Recipe names for one article, and the lines that cannot cover one more unit.
class ArticleRecipeStock {
  const ArticleRecipeStock({
    required this.ingredientNames,
    required this.outOfStockIngredientNames,
  });

  final List<String> ingredientNames;

  /// Ingredients whose [Ingredient.currentStock] is below the recipe quantity.
  final List<String> outOfStockIngredientNames;

  static const empty = ArticleRecipeStock(
    ingredientNames: [],
    outOfStockIngredientNames: [],
  );
}

/// Loads composition lines in recipe order.
///
/// An ingredient is out of stock for that article when its current stock
/// cannot cover one more unit. Callers show the names; they do not receive
/// quantities or stock levels.
Future<Map<UuidValue, ArticleRecipeStock>> recipeStockByArticle(
  Session session,
  Set<UuidValue> articleIds,
) async {
  if (articleIds.isEmpty) {
    return {};
  }
  final lines = await ArticleComposition.db.find(
    session,
    where: (t) => t.articleId.inSet(articleIds),
    include: ArticleComposition.include(ingredient: Ingredient.include()),
    orderBy: (t) => t.createdAt,
  );
  final names = <UuidValue, List<String>>{};
  final missing = <UuidValue, List<String>>{};
  for (final line in lines) {
    final ingredient = line.ingredient;
    final name = ingredient?.name.trim();
    if (name == null || name.isEmpty) {
      continue;
    }
    names.putIfAbsent(line.articleId, () => []).add(name);
    if (ingredient!.currentStock < line.quantity) {
      missing.putIfAbsent(line.articleId, () => []).add(name);
    }
  }
  return {
    for (final id in names.keys)
      id: ArticleRecipeStock(
        ingredientNames: names[id] ?? const [],
        outOfStockIngredientNames: missing[id] ?? const [],
      ),
  };
}
