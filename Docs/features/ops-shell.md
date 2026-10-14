# Operations shell (management)

Status: in progress

## Apps

`managment` only.

## Flow

1. After login:
   - **Owner** → `/buildings` (gate, no sidebar)
   - **Employee** → `/b/:buildingId/dashboard` (ops shell)
2. Owner picks a venue → ops shell under `/b/:buildingId/...`
3. **Wide**: rail with **Buildings**, and **Configuration** directly under it (owners only), then dashboard, employees, products (**categories**, articles, ingredients), **Orders**, **tables**, and **reservations** (when the access profile allows it). The reservations item shows how many customer requests are still waiting. Profile opens from the bottom account tile. **Buildings** link for owners only. A destination the venue pack turns off (ingredients when inventory is off, table scan when table QR is off) stays in the rail, dimmed, with an Upgrade badge. Tapping it opens the public plan catalog. Configuration only updates the venue switches. A bell in the app bar trailing opens this venue's alerts. Its badge is the unread count for that venue: the one the owner has open, or the building the employee works in. The drawer and the wide rail end with a dark-mode switch and the language control.
4. **Compact (mobile)**:
   - **Owner**: bottom nav **Dashboard** | **Tables** | **Orders**; other destinations in the drawer. **New order** FAB (table pick / cancel). The menu button and the reservations item show how many customer requests are still waiting.
   - **Employee**: bottom nav **Tables** | **Scan** | **Orders** (no Dashboard). No FAB — start orders by tapping a table or scanning its QR. Home is Tables.
   - On the **article-picker**, **order detail**, and **QR scan** screens the FAB, shared AppBar, drawer, and bottom nav are hidden so those screens own the chrome.
5. Auth is custom bearer tokens (`AppSessionStore`), not Serverpod `client.auth`.

## Realtime

The app bar bell listens for new alerts. See [notifications](notifications.md).
