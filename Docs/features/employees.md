# Employee management & access control

Status: in progress

## Apps

`managment`, `sip_sync_server`.

## Actors and permissions

- Owner: list, create, update, and enable/disable staff for a **selected building**. Create requires `EmployeeCreate.buildingId` (the venue must already exist and be owned by the actor). The Employees rail lists staff of that venue (`building.listEmployees`).
- Employee: own profile on Profile (phone/names); username is read-only. Cannot manage other staff. A disabled `employee_record` cannot log into `managment` (owners still can).
- Employees are always new identities (no shared email with customers/owners). See [authentication](authentication.md).

## Flow

1. Owner opens a building (`/b/:buildingId/...`), then **Employees**, which loads `listEmployees` for that venue.
2. Create uses `EmployeeCreate` (password, phone, names, **required** `buildingId` — **no email/username**). Server generates username + synthetic email, assigns the employee role, and stores `employee_record` with that `buildingId` (`isEnabled` defaults true).
3. Details shows the generated username (read-only). Enable switch calls `setEmployeeEnabled`. Edit uses `EmployeeUpdate` (phone, names only).
4. Staff sign in on management with **username + password**. Disabled staff fail with `accountDisabled`.
5. Each person updates their own phone/name with `updateMyProfile`.

## Data

- Table `employee_record`: `authUserId`, `ownerAuthUserId`, `buildingId` (required), `isEnabled`
- Create: `EmployeeCreate` (`buildingId` required)
- Update: `EmployeeUpdate`
- Response: `EmployeeView` (username, phone, names, `isEnabled`, `buildingId` — no email)
- Passwords are write-only on create.

## Realtime

Optional presence later; not in this version.
