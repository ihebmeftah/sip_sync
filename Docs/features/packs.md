# Packs

Status: in progress

## Apps

`sip_sync_server`, `backoffice`, `managment` (a new venue is placed on the free pack; the ops shell shows that pack). There is no self-serve purchase. In the management app, an action the pack turns off — or a create that would pass a cap — is disabled and carries an Upgrade badge. Tapping the badge, or the Upgrade chip on the owner banner, lists public packs with price, limits, and capabilities. Changing the plan still goes through the support team. `Pack.listPublic` feeds that catalog.

## Actors and permissions

- **Super admin** — full catalog CRUD on `backoffice`.
- **Owner** — creating a building assigns the free pack. The owner does not pick a plan.
- **Owner, employee, customer** — `Pack.listPublic` only (enabled public packs). Writes are rejected.
- Route guards in the console are UX only. The endpoint checks the super-admin scope.

## Flow

1. On an empty `pack` table, server boot inserts five plans. Later boots leave the catalog alone, so an edit or a delete survives a restart.
2. **Packs** lists every plan, 20 per page: name, code, monthly price, public or private, and enabled.
3. Create and update edit the price, the customer-app fee, the public flag, enabled, sort order, and every capability value. Each limit and each switch has a short explanation in the form.
4. **Public** packs are the ones apps may list so an owner can upgrade later. **Private** packs stay off that list.
5. Creating a venue sets `building.packId` to the free pack. The owner does not choose.
6. `free` is a system pack (0 TND, private). It cannot be deleted. Any other pack can be deleted only when no venue is still on it.
7. A disabled pack is hidden from `listPublic`. Venues already on it stay there.
8. Assigning any pack other than `free` requires a term: **daily**, **monthly**, or **yearly**. The console previews the end (one day, one month, or one year) and the admin can move it later. A monthly date cannot be earlier than one month from today. A yearly date cannot be earlier than one year. A daily date can be any day through 20 days; a later daily date is stored as a monthly term, and if that date is still before one month the end becomes the one-month mark. The free pack has no end date. A venue that is already on a paid plan cannot be moved to another pack. Cancellation will be a later action. The term ending still returns the venue to free.
9. When `building.packExpiresAt` is reached, the venue returns to the free pack and the term is cleared. The previous assignment stays in history with reason `expired`. The server checks on boot, every 15 minutes, and the next time that venue is read.
10. The pack tab lists every assignment, newest first, so a change of plan stays visible.

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
- `building.packId` — the venue’s current plan. Restrict delete while a venue still points at the pack.
- `building_pack_assignment` — one row per plan the venue has been on. The open row (`endedAt` null) matches `building.packId`. Closed rows keep `replaced` or `expired`.
- `building.packBillingPeriod` — `daily`, `monthly`, or `yearly` while a paid pack is assigned. Null on the free pack.
- `building.packExpiresAt` — when that term ends. Null on the free pack.
- `PackCreate` / `PackUpdate` / `PackView` — admin shape. No owner grant list.
- `PackPublicView` — id, code, name, prices, fee, sort, capabilities.
- `PackException` / `PackErrorCode` — `invalidInput`, `notFound`, `codeTaken`, `cannotDeleteSystemPack`, `packInUse`, `limitReached`, `featureOff`, `paidPlanActive`. `limitReached` and `featureOff` also name the `PackFeature`. A caller who is signed in as the wrong role gets `AccountException` / `notAuthorized`.
- Endpoint: `Pack.list`, `Pack.listPublic`, `Pack.create`, `Pack.update`, `Pack.delete`.
- `Building.adminDetail` and `Building.assignPack` — super admin. Detail includes the pack, the billing period, `packExpiresAt`, the assignment history, category / article / table / order counts, and platform gain (monthly price plus the customer-app fee on non-cancelled customer orders). `assignPack` takes an optional period and end date. The free pack ignores them. A paid pack rejects a missing or past date, a monthly date before one month, and a yearly date before one year. A daily date past 20 days is saved as monthly. A venue already on a paid plan rejects any new assignment (`paidPlanActive`). Expiry still returns the venue to free and keeps both rows.
- `BuildingView.pack` — the plan the owner app shows in the top banner.

## Enforcement

Before a write is stored, the server loads the venue pack:

- Counts: employees, tables, categories, articles, ingredients. A null cap is unlimited.
- Flags: customer ordering, appending items, inventory (ingredients, restock, recipes), custom access profiles, and turning on multi-order, strict mode, or append on the venue.
- Customer discovery hides a venue from the customer map and venue page. Table QR hides sticker resolution. The owner app blocks QR export before the call when the pack leaves it off.

The owner banner names the current pack, says a change goes through the support team, and offers an Upgrade chip that opens the public catalog. A locked action is drawn disabled with the same Upgrade badge; tapping it opens that catalog instead of running the action. A switch the pack leaves off stays off and locked unless it is already on, so the owner can still turn it off. Strict item workflow is one of those switches. While it is off, order lines go from in progress to payed or cancelled, and the item board shows a payed column. The customer app shows a snackbar when ordering is off, and hides the cart action. Discovery and table QR still answer as not found when those switches are off.

## Demo data

A fresh development database seeds 30 owners, one real venue each, all on the free pack: Sousse, Tunis, Hammamet, Stockholm, Marburg, Frankfurt, and Gießen. Each venue has ten categories and five to ten articles per category, inserted directly so the customer map can show a full menu. The free plan still rejects further category and article creates (caps 4 and 20). Sign in with `owner.tn.01@sipsync.dev` through `owner.tn.14@sipsync.dev`, `owner.se.01@sipsync.dev` through `owner.se.06@sipsync.dev`, and `owner.de.01@sipsync.dev` through `owner.de.10@sipsync.dev`, password `password1`.

## Realtime

None. The expiry sweep is a server timer, not a client stream.
