# Buildings & multi-location

Status: in progress

## Apps

`sip_sync_server`, `managment`.

## Actors and permissions

- **Owner** — create/update buildings they own (`building.ownerId`). After login → `/buildings` until they open a venue.
- **Employee** — one building on their row; after login → `/b/:buildingId/dashboard`. No venue create/edit.
- Enforcement on `BuildingEndpoint` via custom `AuthGuard`.

## Flow

1. Owner signs in → `/buildings` (list + add), no ops sidebar.
2. Employee signs in → dashboard for their `buildingId`.
3. Create/update: name, type, address, lat/long, hours, currency, and **Multiple orders per table** (`tableMultiOrder`). No employee picker.
4. Owner opens a row → `/b/:buildingId/dashboard`. Staff listed via `building.listEmployees`.
5. Ops shell hydrates the current venue with `building.get(buildingId)` whenever `/b/:buildingId/...` is opened and the in-memory [BuildingSession] has no details (e.g. browser refresh) so currency and flags stay available.

## Configuration

| Field | Default | Meaning |
| --- | --- | --- |
| `tableMultiOrder` | `false` | When **true**, staff may open another order on a table that already has a `progress` order. When **false**, create is rejected (`tableOccupied`) and the floor picker blocks occupied tables. |
| `allowAppendingItemsToOrder` | `true` | When **false**, staff cannot append articles to an open order (UI disables Add articles; server rejects `addItems`). |
| `strictMode` | `false` | When **true**, order lines must advance through enabled `strictModeSteps` in rank order. When **false**, staff may jump to **payed**. |
| `strictModeSteps` | picked→ready→served→payed (all on) | Fixed ranks; UI only toggles `enabled` (no reorder). Disabled steps are skipped when computing the next status. |

## Data

- `building`: UUID PK, `ownerId` → `owner`, venue fields including `tableMultiOrder`
- `employee`: required `buildingId`
- Create/Update/View DTOs without staff assignment lists for create/update; view may include employee ids

## Realtime

None.
