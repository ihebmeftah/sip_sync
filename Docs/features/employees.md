# Employee management & access control

Status: shipped

## Apps

`managment`, `sip_sync_server`.

## Actors and permissions

- Owner: CRUD staff for a selected building (`Employee` endpoint). Create requires `buildingId` and an **access** profile. See [employee-access](employee-access.md).
- Employee: own profile only; cannot manage staff. Disabled employees cannot log in. Floor actions follow assigned access flags.

## Flow

1. Owner opens `/b/:buildingId/employees` (and **Access** to manage profiles). The staff list is 20 people per page. The access picker on the form still loads every profile.
2. Create: password, phone, names, required `buildingId` + `accessId` — username generated.
3. Details show username (read-only), access name; enable/disable; edit phone/names/access.
4. Staff login: username + password via `EmployeeAuth` (session includes access summary).

## Data

- Table `employee`: `buildingId`, `ownerId`, optional `accessId`, username, passwordHash, phone, names, `isEnabled`
- Create/Update/View DTOs; passwords write-only on create

## Realtime

None.
