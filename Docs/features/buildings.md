# Buildings & multi-location

Status: in progress

## Apps

`sip_sync_server`, `managment`. Backoffice and customer apps do not manage venues yet.

## Actors and permissions

- **Owner** — create and update buildings they own; assign employees via `BuildingStaff`. After login they stay on `/buildings` until they pick a venue; dashboard, employees, POS, tables, and products stay locked until then.
- **Employee** — `listMine` returns only assigned buildings; they can open one for ops. They cannot create or edit venue settings.
- Enforcement is on `BuildingEndpoint` (`requireLogin` + owner vs staff). Flutter redirects are UX only.

## Flow

1. Owner signs in or registers. `listMine` is empty → buildings list with create. Other ops routes redirect to `/buildings`.
2. Create/update form: name, type (restaurant / lounge / bar / café or a custom label), address + longitude + latitude on one row, opening and closing times (same text fields as the rest of the form), currency dropdown. **Pick current position** uses `geolocator` then reverse-geocodes with `geocoding`.
3. Tapping a row selects that building (`BuildingSession`) and goes to `/dashboard`, which shows the selected venue.
4. Employees listed for a selected building come from `building.listEmployees`. New staff created from that screen pass `EmployeeCreate.buildingId`.
5. Edit is `/buildings/:buildingId/edit`. Saving a venue selects it and opens the dashboard.

## Data

- Table `building`: UUID PK, `ownerAuthUserId`, `name`, `type` (normalized string), `address`, `latitude`, `longitude`, `openingMinutes`, `closingMinutes`, `currencyCode`
- Table `building_staff`: `buildingId`, `employeeAuthUserId`
- Create: `BuildingCreate`
- Update: `BuildingUpdate`
- Response: `BuildingView` (includes `employeeAuthUserIds`)
- Errors: `BuildingException` (`invalidInput`, `notAuthorized`, `notFound`)

## Realtime

None. The client reloads `listMine` after save and keeps the selected id in `BuildingSession`.
