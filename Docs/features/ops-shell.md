# Operations shell (management)

Status: in progress

## Apps

`managment` only. Buildings, profile, and employees use `sip_sync_server`. POS, tables, and products are UI shells without endpoints yet.

## Actors and permissions

- **Owner / employee** — after opening a building, the rail shows dashboard, profile, employees, products, POS, and tables under `/b/:buildingId/...`.
- **Owner** — create/update venues on `/buildings` (no sidebar). Employees screens only after a building is open.
- **Any signed-in user** — view and update their own username, phone, and name via `updateMyProfile`. Email is identity-bound and read-only in the UI.

## Flow

1. After login/register:
   - **Owner** → `/buildings` **without** the ops sidebar (buildings gate chrome only).
   - **Employee** → `/b/:buildingId/dashboard` inside `OpsShell` (their only venue; no buildings list).
2. Owner choosing a venue opens `/b/:buildingId/dashboard` inside `OpsShell`.
3. The rail stays visible while destinations change under that `buildingId`. Compact widths use a drawer. **Buildings** in the rail (owners only) returns to `/buildings` (leaves the shell).
4. Profile loads `me` from auth state and saves with `ProfileUpdate`.
5. Employees live at `/b/:buildingId/employees`, create at `.../employees/new`, details at `.../employees/:authUserId`, edit at `.../employees/:authUserId/edit`.
6. Products (articles, ingredients), POS, and tables render a placeholder until those features have a server contract.

## Data

- `BuildingCreate`, `BuildingUpdate`, `BuildingView`
- `ProfileUpdate`, `EmployeeCreate`, `EmployeeUpdate`
- Responses: `AccountSessionView`, `EmployeeView`
- `employee_record.isEnabled` for staff login

## Realtime

None.
