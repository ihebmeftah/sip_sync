# Order management

Status: in progress (create wizard / list / detail / item status; customer create later)

## Apps

`sip_sync_server`, `managment` (Orders). Customer app create later.

## Actors and permissions

- **Owner / employee** — create orders for a building they own or are assigned to; list; advance / cancel item and order status.
- **Customer** — not yet (schema already uses `ActorType` so customer launch can plug in later).
- Enforced on `OrderEndpoint` via `AuthGuard` + building access.

## Statuses

### Order (`OrderStatus`)

| Value | Meaning |
| --- | --- |
| `progress` | Open / in progress |
| `payed` | Fully paid |
| `cancelled` | Cancelled |

### Order item (`OrderItemStatus`)

| Value | Meaning |
| --- | --- |
| `progress` | Ticket opened |
| `picked` | Taken by kitchen / prep |
| `ready` | Prepared |
| `served` | Delivered to guest |
| `payed` | Item paid |
| `cancelled` | Cancelled |

## Attribution

### Order

| Field | Meaning |
| --- | --- |
| `venueTableId` | Floor table (required in management create wizard) |
| `launchedByType` / `launchedById` | Who created the order |
| `lastPaidByType` / `lastPaidById` / `lastPaidAt` | Who recorded the most recent payment |
| `cancelledByType` / `cancelledById` / `cancelledAt` | Who cancelled the order |

### Order item

| Field | Meaning |
| --- | --- |
| `passedByType` / `passedById` | Who moved the item to **picked** |
| `preparedByType` / `preparedById` / `preparedAt` | Who marked **ready** |
| `servedByType` / `servedById` / `servedAt` | Who marked **served** |
| `paidToType` / `paidToId` / `paidAt` | Who recorded **payed** for this line |
| `cancelledByType` / `cancelledById` / `cancelledAt` | Who cancelled the line |
| `createdAt` / `updatedAt` | Always set |

Attribution actor ids are owner/employee (or later customer) UUIDs with matching `ActorType` — not FK-linked so one column covers all roles.

## Flow (management)

1. **Owner**: **New order** FAB → Tables floor map in pick mode. Tap the FAB again (red) to cancel selection while still picking. On the **article** and **order detail** steps the FAB and (on mobile) shared AppBar / bottom nav / drawer are hidden so those screens are immersive; use **Reset articles**, **Change table**, or **Cancel order** (returns to tables in normal view).
2. **Employee**: no FAB — open **Tables** and tap a table to start ordering (same inactive / occupied rules as pick mode).
3. Article selection (category chips, name search, **+/−** adds/removes units; each unit becomes its own order line).
4. **Confirm order** → server create → deducts composition stock per unit → **order detail** with colored status chips, currency amounts, created/updated times, and advance / cancel actions.
5. Detail: compact advance / cancel on each line (only that card shows a spinner). With **strict mode off**, a **Pay now** shortcut jumps to payed. **Add articles** appends more units (and deducts stock again) when the building’s `allowAppendingItemsToOrder` is **true**; otherwise the button is disabled and `addItems` returns `appendNotAllowed`. Info icon opens item attribution. Table chip opens the floor map.
6. When an order is open on a table, that table’s floor status is **occupied**; after pay/cancel it returns to **available**. If the building’s `tableMultiOrder` is **false**, a second order on that table is blocked (server + floor picker).
7. Cancel whole order when still in progress; stay on the detail screen (shows cancelled state). Cancelling a line or order **restores** composition stock for non-payed lines.
8. Orders list can filter by status (All / In progress / Payed / Cancelled). Server returns orders by `createdAt` desc; detail lines stay in stable `createdAt` (+ id) order with **payed** items at the bottom (`paidAt` desc among payed). Intermediate status changes do not reorder lines.
9. Create / append fails with `insufficientStock` when any ingredient would go below zero.

Draft cart lives in `OrderDraftViewModel` (keepAlive). `pickingTable` drives floor-map selection.

## Data

- `venue_order` — building, optional `venue_table`, status, launch/last-pay actors, timestamps
- `venue_order_item` — one row per article **unit** (same article repeats as separate lines), name/price snapshot, status, attribution timestamps

There is no quantity column: ordering three espressos creates three `venue_order_item` rows.

Protocol DTOs stay `OrderCreate` / `OrderView` / `OrderItemView` for the client API.

## Realtime

None yet (kitchen streams later).
