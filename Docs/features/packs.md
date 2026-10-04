# Packs

Status: in progress

## Apps

`sip_sync_server`, `backoffice`, `managment` (a new venue is placed on the free pack; the ops shell shows that pack). There is no self-serve upgrade. `Pack.listPublic` stays available for a later upgrade screen.

## Actors and permissions

- **Super admin** — full catalog CRUD on `backoffice`.
- **Owner** — creating a building assigns the free pack. The owner does not pick a plan.
- **Owner, employee, customer** — `Pack.listPublic` only (enabled public packs). Writes are rejected.
- Route guards in the console are UX only. The endpoint checks the super-admin scope.

## Flow

1. On an empty `pack` table, server boot inserts five plans. Later boots leave the catalog alone, so an edit or a delete survives a restart.
2. **Packs** lists every plan: name, code, monthly price, public or private, and enabled.
3. Create and update edit the price, the customer-app fee, the public flag, enabled, sort order, and every capability value. Each limit and each switch has a short explanation in the form.
4. **Public** packs are the ones apps may list so an owner can upgrade later. **Private** packs stay off that list.
5. Creating a venue sets `building.packId` to the free pack. The owner does not choose.
6. `free` is a system pack (0 TND, private). It cannot be deleted. Any other pack can be deleted only when no venue is still on it.
7. A disabled pack is hidden from `listPublic`. Venues already on it stay there.

Prices are millimes (89 TND = 89,000). The catalog currency is TND, separate from a venue’s `currencyCode`. The customer-app fee is basis points on orders placed in the customer app (`150` = 1.5%). Staff-entered tickets are not charged.

Capability keys match features that exist today. An empty limit means no cap. Cash register, statistics, and kitchen alerts are not keys yet.

## Seeded catalog

| Code | Public | Month | Year | Fee | Employees | Tables | Categories | Articles | Ingredients | Ordering, multi-order, strict, custom profiles | Discovery, QR, inventory, append |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `free` | no | 0 | 0 | 0 | 2 | 8 | 4 | 20 | 15 | off | on |
| `counter` | yes | 39 TND | 390 | 0 | 3 | 12 | 6 | 40 | 40 | off | on |
| `floor` | yes | 89 TND | 890 | 1.5% | 12 | 40 | 20 | 200 | 200 | on | on |
| `house` | yes | 149 TND | 1,490 | 1.0% | 30 | 100 | none | none | none | on | on |
| `group` | no | 249 TND | 2,490 | 0.5% | 80 | 250 | none | none | none | on | on |

`counter`, `floor`, and `house` are the public ladder. `free` and `group` stay private. Every new venue starts on `free`.

## Data

- `pack` — code (unique), prices in millimes, fee in basis points, `isPublic`, `isEnabled`, `isSystem`, sort order, limit columns (null = unlimited), capability booleans.
- `building.packId` — the venue’s plan. Restrict delete while a venue still points at the pack.
- `PackCreate` / `PackUpdate` / `PackView` — admin shape. No owner grant list.
- `PackPublicView` — id, code, name, prices, fee, sort, capabilities.
- `PackException` / `PackErrorCode` — `invalidInput`, `notFound`, `codeTaken`, `cannotDeleteSystemPack`, `packInUse`, `limitReached`, `featureOff`. A caller who is signed in as the wrong role gets `AccountException` / `notAuthorized`.
- Endpoint: `Pack.list`, `Pack.listPublic`, `Pack.create`, `Pack.update`, `Pack.delete`.
- `Building.adminDetail` and `Building.assignPack` — super admin. Detail includes the pack, category / article / table / order counts, and platform gain (monthly price plus the customer-app fee on non-cancelled customer orders).
- `BuildingView.pack` — the plan the owner app shows in the top banner.

## Enforcement

Before a write is stored, the server loads the venue pack:

- Counts: employees, tables, categories, articles, ingredients. A null cap is unlimited.
- Flags: customer ordering, appending items, inventory (ingredients, restock, recipes), custom access profiles, and turning on multi-order, strict mode, or append on the venue.
- Customer discovery hides a venue from the customer map and venue page. Table QR hides sticker resolution. The owner app blocks QR export before the call when the pack leaves it off.

The owner banner names the current pack and says a change goes through the support team. There is no self-serve upgrade. The management and customer apps map `limitReached` and `featureOff` to a message.

## Realtime

None.
