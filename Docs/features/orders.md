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

1. **New order** FAB on any ops screen → Tables floor map in pick mode.
2. Tap a table → article selection (category chips, name search, **+/−** adds/removes units; each unit becomes its own order line).
3. **Confirm order** → server create → deducts composition stock per unit → **order detail** with colored status chips, currency amounts, created/updated times, and advance / cancel actions.
4. Detail: compact advance / cancel on each line (only that card shows a spinner). **Add articles** appends more units (and deducts stock again). Info icon opens item attribution. Table chip opens the floor map.
5. When an order is open on a table, that table’s floor status is **occupied**; after pay/cancel it returns to **available**.
6. Cancel whole order when still in progress; stay on the detail screen (shows cancelled state). Cancelling a line or order **restores** composition stock for non-payed lines.
7. Orders list can filter by status (All / In progress / Payed / Cancelled). Server returns orders by `createdAt` desc; detail lines stay in stable `createdAt` (+ id) order with **payed** items at the bottom (`paidAt` desc among payed). Intermediate status changes do not reorder lines.
8. Create / append fails with `insufficientStock` when any ingredient would go below zero.

Draft cart lives in `OrderDraftViewModel` (keepAlive). `pickingTable` drives floor-map selection.

## Data

- `venue_order` — building, optional `venue_table`, status, launch/last-pay actors, timestamps
- `venue_order_item` — one row per article **unit** (same article repeats as separate lines), name/price snapshot, status, attribution timestamps

There is no quantity column: ordering three espressos creates three `venue_order_item` rows.

Protocol DTOs stay `OrderCreate` / `OrderView` / `OrderItemView` for the client API.

## Realtime

None yet (kitchen streams later).
