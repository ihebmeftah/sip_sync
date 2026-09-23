# Operations shell (management)

Status: in progress

## Apps

`managment` only.

## Flow

1. After login:
   - **Owner** → `/buildings` (gate, no sidebar)
   - **Employee** → `/b/:buildingId/dashboard` (ops shell)
2. Owner picks a venue → ops shell under `/b/:buildingId/...`
3. **Wide**: rail with dashboard, employees, products (**categories**, articles, ingredients), **Orders**, **tables**. Profile opens from the bottom account tile. **Buildings** link for owners only.
4. **Compact (mobile)**: bottom navigation for **Dashboard**, **Tables**, and **Orders**; other destinations stay in the drawer. Owners get a **New order** FAB (table pick / cancel). Employees have no FAB — they start orders by tapping a table. On the **article-picker** and **order detail** screens the FAB, shared AppBar, drawer, and bottom nav are hidden so those screens own the chrome.
5. Auth is custom bearer tokens (`AppSessionStore`), not Serverpod `client.auth`.

## Realtime

None.
