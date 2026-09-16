# Operations shell (management)

Status: in progress

## Apps

`managment` only. Buildings, profile, and employees use `sip_sync_server`. POS, tables, and products are UI shells without endpoints yet.

## Actors and permissions

- **Owner / employee** — after picking a building, the rail shows dashboard, profile, employees, products, POS, and tables. Until a venue is selected, only **Buildings** is usable.
- **Owner** — create/update venues; Employees screens for staff of the selected building.
- **Any signed-in user** — view and update their own username, phone, and name via `updateMyProfile`. Email is identity-bound and read-only in the UI.

## Flow

1. After login, go_router sends the user to `/buildings` inside `OpsShell`. Other destinations redirect here if no building is selected.
2. Choosing a venue stores it in `BuildingSession` and opens `/dashboard`.
3. The rail stays visible while destinations change. Compact widths use a drawer.
4. Profile loads `me` from auth state and saves with `ProfileUpdate`.
5. Employees lives at `/employees`, create at `/employees/new`, details at `/employees/:authUserId`, edit at `/employees/:authUserId/edit`, scoped to the selected building.
6. Products (articles, ingredients), POS, and tables render a placeholder (“Hello” + screen name) until those features have a server contract.

## Data

- `BuildingCreate`, `BuildingUpdate`, `BuildingView`
- `ProfileUpdate`, `EmployeeCreate`, `EmployeeUpdate`
- Responses: `AccountSessionView`, `EmployeeView`
- `employee_record.isEnabled` for staff login

## Realtime

None.
