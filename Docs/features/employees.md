# Employee management & access control

Status: in progress

## Apps

`managment`, `sip_sync_server`.

## Actors and permissions

- Owner: CRUD staff for a selected building (`Employee` endpoint). Create requires `buildingId`.
- Employee: own profile only; cannot manage staff. Disabled employees cannot log in.

## Flow

1. Owner opens `/b/:buildingId/employees`.
2. Create: password, phone, names, required `buildingId` — username generated.
3. Details show username (read-only); enable/disable; edit phone/names.
4. Staff login: username + password via `EmployeeAuth`.

## Data

- Table `employee`: `buildingId`, `ownerId`, username, passwordHash, phone, names, `isEnabled`
- Create/Update/View DTOs; passwords write-only on create

## Realtime

None.
