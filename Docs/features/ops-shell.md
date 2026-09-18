# Operations shell (management)

Status: in progress

## Apps

`managment` only.

## Flow

1. After login:
   - **Owner** → `/buildings` (gate, no sidebar)
   - **Employee** → `/b/:buildingId/dashboard` (ops shell)
2. Owner picks a venue → ops shell under `/b/:buildingId/...`
3. Rail: dashboard, profile, employees, products (**categories**, articles, ingredients), POS, **tables** (floor map). **Buildings** link for owners only.
4. Auth is custom bearer tokens (`AppSessionStore`), not Serverpod `client.auth`.

## Realtime

None.
