# Employee management & access control

Status: in progress

## Apps

`managment`, `sip_sync_server`.

## Actors and permissions

- Owner: list, create, update, and enable/disable staff they added. New staff are assigned to the selected building (`EmployeeCreate.buildingId`). The Employees rail lists staff of the selected venue (`building.listEmployees`).
- Employee: own profile on Profile (phone/names); username is read-only. Cannot manage other staff. A disabled `employee_record` cannot log into `managment` (owners still can).
- Employees are always new identities (no shared email with customers/owners). See [authentication](authentication.md).

## Flow

1. Owner opens **Employees** after selecting a building and loads `listEmployees` for that venue.
2. Create uses `EmployeeCreate` (password, phone, names, optional `buildingId` — **no email/username**). Server generates username + synthetic email, assigns the employee role, stores `employee_record` (`isEnabled` defaults true), and may write `building_staff`.
3. Details shows the generated username (read-only). Enable switch calls `setEmployeeEnabled`. Edit uses `EmployeeUpdate` (phone, names only).
4. Staff sign in on management with **username + password**. Disabled staff fail with `accountDisabled`.
5. Each person updates their own phone/name with `updateMyProfile`.

## Data

- Table `employee_record`: `authUserId`, `ownerAuthUserId`, `isEnabled`
- Table `building_staff`: assignment of employees to buildings
- Create: `EmployeeCreate`
- Update: `EmployeeUpdate`
- Response: `EmployeeView` (username, phone, names, `isEnabled` — no email)
- Passwords are write-only on create.

## Realtime

Optional presence later; not in this version.
