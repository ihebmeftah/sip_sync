# Buildings & multi-location

Status: in progress

## Apps

`sip_sync_server`, `managment`, `backoffice` (read-only platform list), `sip_sync_flutter` (public card only — see [customer discovery](customer-discovery.md)).

## Actors and permissions

- **Owner** — create/update buildings they own (`building.ownerId`). After login → `/buildings` until they open a venue.
- **Employee** — one building on their row; after login → `/b/:buildingId/dashboard`. No venue create/edit.
- Enforcement on `BuildingEndpoint` via custom `AuthGuard`.
- **Super admin** — `building.listAll` returns every venue with owner name, email, and phone, the current pack, and contact fields. Optional `query` matches venue name, address, or owner first and last name. Optional `packId` keeps one pack. Opening a card calls `building.adminDetail`. `building.assignPack` moves a free-plan venue onto an enabled pack and keeps the previous row in history. A paid plan cannot be replaced until cancellation exists. No venue create or update from backoffice.
- **Customer** — `CustomerVenue.list` returns a `CustomerVenueCard` (name, type, address, coordinates, hours, phone). Ops flags and owner identity stay off that card.

## Flow

1. Owner signs in → `/buildings` (list + add), no ops sidebar. The owner list is 20 venues per page. An employee sees only their venue.
2. Employee signs in → dashboard for their `buildingId`.
3. Create/update: name, type, address, lat/long, hours, currency, **phone** (E.164 with country dial code), WhatsApp / Instagram / Facebook / other links. No employee picker. The server sets the venue on the **free** pack. Order, reservation, and stock switches are saved later from Configuration.
4. Server derives `countryCode` (ISO 3166-1 alpha-2, e.g. `TN` from `+216…`) and `countryName` (English common name, e.g. Tunisia) from the venue phone via [`sealed_countries`](https://pub.dev/packages/sealed_countries) and stores both. A blank name on an older row is filled from the code the next time that venue is read, and again on boot. Currency codes are validated against ISO 4217 fiat list from the same ecosystem.
5. Owner opens a row → `/b/:buildingId/dashboard`. Staff listed via `building.listEmployees`.
6. Ops shell hydrates the current venue with `building.get(buildingId)` whenever `/b/:buildingId/...` is opened and the in-memory [BuildingSession] has no details (e.g. browser refresh or employee login, which only selects the id) so currency, flags, and the pack stay available. A banner under the shell names the pack and says a change goes through the support team. Auth does **not** call `building.get` itself.

## Configuration

| Field | Default | Meaning |
| --- | --- | --- |
| `phoneNumber` | required | Venue contact in E.164 (`+216…`). |
| `countryCode` | derived | ISO country from dial code (not client-editable). |
| `countryName` | derived | English common name for that code, such as Tunisia. |
| `whatsapp` | optional | WhatsApp number in E.164. |
| `instagram` / `facebook` | optional | Handle or URL. |
| `otherLinks` | `[]` | Extra `http(s)` URLs (max 10). |
| `tableMultiOrder` | `false` | When **true**, staff may open another order on a table that already has a `progress` order. When **false**, create is rejected (`tableOccupied`) and the floor picker blocks occupied tables. |
| `allowAppendingItemsToOrder` | `true` | When **false**, staff cannot append articles to an open order (UI disables Add articles; server rejects `addItems`). |
| `strictMode` | `false` | When **true**, order lines must advance through enabled `strictModeSteps` in rank order. When **false**, staff may jump to **payed**. |
| `strictModeSteps` | picked→ready→served→payed (all on) | Fixed ranks; UI only toggles `enabled` (no reorder). Disabled steps are skipped when computing the next status. |
| `customerOrderingEnabled` | `true` | When **false**, customers cannot place or append orders even if the pack includes customer ordering. The customer app keeps **+** and **Pass order** visible and disables them. |
| `reservationsEnabled` | `true` | When **false**, nobody can create a reservation even if the pack includes reservations. Existing rows stay visible. The customer app keeps **Reserve now** visible and disables it. |
| `allowOutOfStockOrders` | `false` | When **true**, an order may be placed even if a recipe ingredient cannot cover it; stock stops at zero. When **false**, that order is rejected and the customer app disables add for that dish. |

Owners edit these switches on **Configuration**, directly under **Buildings** in the operations sidebar (`/b/:buildingId/configuration`). Creating or editing the venue profile does not change them. A switch the pack does not include stays locked off. Employees cannot open the page.

## Data

- `building`: UUID PK, `ownerId` → `owner`, venue fields including contact / socials and `tableMultiOrder`
- `employee`: required `buildingId`
- Create/Update/View DTOs without staff assignment lists for create/update; view may include employee ids

## Realtime

None.
