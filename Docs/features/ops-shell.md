# Operations shell (management)

Status: in progress

## Apps

`managment` only.

## Flow

1. After login:
   - **Owner** → `/buildings` (gate, no sidebar)
   - **Employee** → `/b/:buildingId/dashboard` (ops shell)
2. Owner picks a venue → ops shell under `/b/:buildingId/...`
3. Rail: dashboard, employees, products (**categories**, articles, ingredients), **Orders**, **tables**. Profile opens from the bottom account tile. **Buildings** link for owners only. A **New order** FAB is available on every building ops screen (except the article-picker create step).
4. Auth is custom bearer tokens (`AppSessionStore`), not Serverpod `client.auth`.

## Realtime

None.
