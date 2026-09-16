# Operations shell (management)

Status: in progress

## Apps

`managment` only. Profile mutations use `sip_sync_server` `AccountEndpoint`. POS, tables, and products are UI shells without endpoints yet.

## Actors and permissions

- **Owner / employee** — signed-in management users see the rail (dashboard, profile, products, POS, tables).
- **Owner** — list and open profiles of staff they added; add employees. Enforced on `listEmployees`, `getEmployee`, `addEmployee`.
- **Any signed-in user** — view and update their own username, phone, and name via `updateMyProfile`. Email is identity-bound and read-only in the UI.

## Flow

1. After login, go_router sends the user to `/dashboard` inside `OpsShell`.
2. The rail stays visible while destinations change. Compact widths use a drawer.
3. Profile loads `me` from auth state, saves with `ProfileUpdate`, and (owners) lists employees.
4. Opening a staff row calls `getEmployee` for that auth user id. Other owners’ staff are `notFound`.
5. Products (articles, ingredients), POS, and tables render a placeholder (“Hello” + screen name) until those features have a server contract.

## Data

- `ProfileUpdate`: username, phoneNumber, firstName, lastName
- Responses: `AccountSessionView`, `ProfileView`
- No new tables

## Realtime

None.
