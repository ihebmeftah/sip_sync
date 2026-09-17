# Buildings & multi-location

Status: in progress

## Apps

`sip_sync_server`, `managment`. Backoffice and customer apps do not manage venues yet.

## Actors and permissions

- **Owner** — create and update buildings they own. Venues are created **without** staff; employees are added later for a specific `buildingId`. After login they stay on `/buildings` (no ops sidebar) until they open a venue.
- **Employee** — account is tied to one building (`AccountSessionView.buildingId`). After login they go straight to `/b/:buildingId/dashboard` (no buildings list). They cannot create or edit venue settings.
- Enforcement is on `BuildingEndpoint` (`requireLogin` + owner vs staff). Flutter redirects are UX only.

## Flow

1. Owner signs in or registers → `/buildings` (list + add), **without** the ops sidebar. Other ops URLs require `/b/:buildingId/...`.
2. Employee signs in → `/b/:buildingId/dashboard` using the building on their `employee_record`. Visiting `/buildings` redirects them back to that dashboard.
3. Create/update form (owners): name, type (restaurant / lounge / bar / café or a custom label), address + longitude + latitude on one row, opening and closing times, currency dropdown. **No employee picker.** **Pick current position** uses `geolocator` then reverse-geocodes with `geocoding`.
4. Owner tapping a row opens `/b/:buildingId/dashboard` (ops shell + sidebar). Edit stays at `/buildings/:buildingId/edit` outside the shell.
5. Staff for a venue come from `building.listEmployees` (employees whose `employee_record.buildingId` matches). New staff are created from Employees under that building with required `EmployeeCreate.buildingId`.

## Data

- Table `building`: UUID PK, `ownerAuthUserId`, `name`, `type` (normalized string), `address`, `latitude`, `longitude`, `openingMinutes`, `closingMinutes`, `currencyCode`
- Table `employee_record`: each employee row has required `buildingId` (building has many employees)
- Create: `BuildingCreate` (venue fields only)
- Update: `BuildingUpdate` (venue fields only)
- Response: `BuildingView` (includes `employeeAuthUserIds` derived from `employee_record`)
- Errors: `BuildingException` (`invalidInput`, `notAuthorized`, `notFound`)

## Realtime

None. The client reloads `listMine` after save; the selected venue is the `buildingId` path parameter.
