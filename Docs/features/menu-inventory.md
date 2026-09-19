# Menu & inventory

Status: in progress (categories + articles + ingredients + composition)

## Apps

`sip_sync_server`, `managment`. Customer menu read and order-time stock deduction come later.

## Actors and permissions

- **Owner** — list/create/update categories and articles; list/create/delete ingredients; list/create/update/delete article composition lines for buildings they own.
- **Employee** — list categories, articles, ingredients, and compositions for their assigned building. Cannot mutate.
- Enforced on `MenuCategoryEndpoint` / `MenuArticleEndpoint` / `IngredientEndpoint` / `ArticleCompositionEndpoint` via `AuthGuard` + building ownership / assignment.

## Flow

1. Open a venue → **Products** in the ops rail.
2. **Categories** — per-building catalog groups.
3. **Articles** — sellable items (category, price). Composition is **optional**: an article can have zero recipe lines.
4. **Ingredients** — stock rows (unit, current, threshold).
5. From an article, owner opens **Composition** to add ingredient + quantity lines (quantity uses that ingredient’s unit). Same ingredient cannot appear twice on one article.
6. Names remain unique per building for categories, articles, and ingredients.

## Data

### `menu_category` / `menu_article` / `ingredient`

Unchanged from prior slices. `MenuArticleView` also returns `compositionLineCount` (0 when none).

### `article_composition`

| Field | Notes |
| --- | --- |
| `id` | UUID |
| `articleId` | → `menu_article` (Cascade) |
| `ingredientId` | → `ingredient` (Restrict — cannot delete ingredient while used) |
| `quantity` | `> 0`, max 1_000_000 — amount **per one article** in the ingredient’s unit |
| `createdAt` | |

Unique `(articleId, ingredientId)`.

`ArticleCompositionView` includes `ingredientName` and `unit` for UI.

## Realtime

None yet. Stock deduction when an order is placed uses composition later.
