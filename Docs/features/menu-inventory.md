# Menu & inventory

Status: in progress (categories + articles + ingredients)

## Apps

`sip_sync_server`, `managment`. Customer menu read and recipe composition come later.

## Actors and permissions

- **Owner** — list/create/update categories and articles; list/create/delete ingredients for buildings they own.
- **Employee** — list categories, articles, and ingredients for their assigned building. Cannot mutate.
- Enforced on `MenuCategoryEndpoint` / `MenuArticleEndpoint` / `IngredientEndpoint` via `AuthGuard` + building ownership / assignment.

## Flow

1. Open a venue → **Products** in the ops rail.
2. **Categories** (`/b/:buildingId/products/categories`) — per-building catalog groups (name + optional description).
3. **Articles** (`/b/:buildingId/products/articles`) — sellable items with name, optional description, price, and a category in the same building.
4. **Ingredients** (`/b/:buildingId/products/ingredients`) — stock rows with name, unit, current stock, and threshold. Owner can add or delete (no edit yet).
5. Category, article, and ingredient **names are unique per building** (case-insensitive after trim).

## Data

### `menu_category`

| Field | Notes |
| --- | --- |
| `id` | UUID |
| `buildingId` | → `building` |
| `name` | Unique per building (1–80) |
| `description` | Optional (max 500) |
| `createdAt` | |

### `menu_article`

| Field | Notes |
| --- | --- |
| `id` | UUID |
| `buildingId` | → `building` (denormalized for unique name + list scope) |
| `categoryId` | → `menu_category` (same building) |
| `name` | Unique per building (1–80) |
| `description` | Optional (max 500) |
| `price` | `> 0`, max 1_000_000 |
| `createdAt` | |

`MenuArticleView` also returns `categoryName` for list UI.

### `ingredient`

| Field | Notes |
| --- | --- |
| `id` | UUID |
| `buildingId` | → `building` |
| `name` | Unique per building (1–80) |
| `unit` | `UnitsType` (see below) |
| `currentStock` | `>= 0` |
| `thresholdStock` | `>= 0` — UI flags when current ≤ threshold |
| `createdAt` | |

### `UnitsType`

| Value | Meaning |
| --- | --- |
| `gram` | Mass in grams (g) — coffee, spices, small dry portions |
| `kilogram` | Mass in kilograms (kg) — bulk dry goods |
| `milliliter` | Volume in milliliters (ml) — syrups, oils, precise liquids |
| `centiliter` | Volume in centiliters (cl) — bar pours / metric spirit tracking |
| `liter` | Volume in liters (L) — milk crates, bulk liquids |
| `piece` | Countable each — eggs, lemons, buns |
| `bottle` | Whole bottles on the shelf |
| `can` | Canned goods counted as cans |
| `pack` | Sealed packs / bags |
| `box` | Boxes of goods |
| `bunch` | Fresh produce sold by the bunch |
| `teaspoon` | Culinary tsp (~5 ml) stocked by spoon |
| `tablespoon` | Culinary tbsp (~15 ml) stocked by spoon |
| `cup` | Culinary cup (~240 ml) when prep is tracked by cups |

## Realtime

None yet. Stock deduction from orders / recipe composition arrives later.
