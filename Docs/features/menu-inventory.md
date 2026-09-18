# Menu & inventory

Status: in progress (categories + articles)

## Apps

`sip_sync_server`, `managment`. Customer menu read and ingredients/stock come later.

## Actors and permissions

- **Owner** — list, create, and update categories and articles for buildings they own.
- **Employee** — list categories and articles for their assigned building (POS / kitchen later). Cannot create or edit.
- Enforced on `MenuCategoryEndpoint` / `MenuArticleEndpoint` via `AuthGuard` + building ownership / assignment.

## Flow

1. Open a venue → **Products** in the ops rail.
2. **Categories** (`/b/:buildingId/products/categories`) — per-building catalog groups (name + optional description).
3. **Articles** (`/b/:buildingId/products/articles`) — sellable items with name, optional description, price, and a category in the same building.
4. Owner adds or edits via dialogs (same activity chrome as employees / tables).
5. Category and article **names are unique per building** (case-insensitive after trim).

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

## Realtime

None yet. Stock / ingredient deduction arrives with orders.
