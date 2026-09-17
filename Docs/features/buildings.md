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
3. Create/update: name, type, address, lat/long, hours, currency. No employee picker.
4. Owner opens a row → `/b/:buildingId/dashboard`. Staff listed via `building.listEmployees`.

## Data

- `building`: UUID PK, `ownerId` → `owner`, venue fields
- `employee`: required `buildingId`
- Create/Update/View DTOs without staff assignment lists for create/update; view may include employee ids

## Realtime

None.
