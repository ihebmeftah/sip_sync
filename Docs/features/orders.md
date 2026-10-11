# Order management

Status: in progress (management wizard; customer pass-order on the menu)

## Apps

`sip_sync_server`, `managment` (Orders), `sip_sync_flutter` (menu pass-order).

## Actors and permissions

- **Owner / employee** — create orders for a building they own or are assigned to; list; advance / cancel item and order status.
- **Customer** — places an order from the menu for a table they scanned (`CustomerOrder.place`). They can read only orders they launched (`CustomerOrder.get`). They cannot change kitchen status.
- Enforced on `OrderEndpoint` via `AuthGuard` + building access. Customer place uses the same stock, ticket number, and one-open-order table rules.

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
| `launchedBy` | Who created the order (`OrderActorView`: type + id + first/last name) |
| `lastPaidBy` / `lastPaidAt` | Who recorded the most recent payment |
| `cancelledBy` / `cancelledAt` | Who cancelled the order |

### Order item

| Field | Meaning |
| --- | --- |
| `passedBy` | Who moved the item to **picked** |
| `preparedBy` / `preparedAt` | Who marked **ready** |
| `servedBy` / `servedAt` | Who marked **served** |
| `paidTo` / `paidAt` | Who recorded **payed** for this line |
| `cancelledBy` / `cancelledAt` | Who cancelled the line |
| `createdAt` / `updatedAt` | Always set |

Attribution actor ids are owner/employee (or later customer) UUIDs with matching `ActorType` — not FK-linked so one column covers all roles. Views resolve first/last name for display as `{role} - {firstName} {lastName}`.

## Flow (management)

1. **Owner**: **New order** FAB → Tables floor map in pick mode. Tap the FAB again (red) to cancel selection while still picking. On the **article** and **order detail** steps the FAB and (on mobile) shared AppBar / bottom nav / drawer are hidden so those screens are immersive; use **Reset articles**, **Change table**, or **Cancel order** (returns to tables in normal view).
2. **Employee**: no FAB — open **Tables** and tap a table to start ordering (same inactive / occupied rules as pick mode).
3. Article selection (category chips, name search, **+/−** adds/removes units; each unit becomes its own order line).
4. **Confirm order** → server create → deducts composition stock per unit → **order detail** with colored status chips, currency amounts, created/updated times, and advance / cancel actions.
5. Detail: compact advance / cancel on each line (only that card shows a spinner). With **strict mode off**, a **Pay now** shortcut jumps to payed. **Add articles** appends more units (and deducts stock again) when the building’s `allowAppendingItemsToOrder` is **true**; otherwise the button is disabled and `addItems` returns `appendNotAllowed`. Info icon opens item attribution. Table chip opens the floor map.
6. When an order is open on a table, that table’s floor status is **occupied**; after pay/cancel it returns to **available**. If the building’s `tableMultiOrder` is **false**, a second order on that table is blocked (server + floor picker).
7. Cancel whole order when still in progress; stay on the detail screen (shows cancelled state). The dialog asks for one reason: ingredient out of stock, closing time is coming, or a breakdown at work. The same list is used when cancelling one line. The reason is stored on the order and on each line cancelled with it, and shown on the staff ticket and on the customer receipt and order history. Cancelling a line or order **restores** composition stock for non-payed lines.
8. Orders list filter chips call `order.list(buildingId, status)` on the server (`null` = all). The floor loads 20 tickets at a time and appends the next page as the list scrolls. An employee who cannot consult every order is filtered in SQL, so the page length matches what they may see. Open orders for one table are loaded in full, not from that scrolling page. Results are sorted by `createdAt` desc; detail lines stay in stable `createdAt` (+ id) order with **payed** items at the bottom (`paidAt` desc among payed). Intermediate status changes do not reorder lines.
9. Create / append fails with `insufficientStock` when any ingredient would go below zero, unless the venue’s `allowOutOfStockOrders` is **true**. In that case stock is reduced only down to zero. The article picker shows the names of ingredients that cannot cover one more unit. The customer menu does not name them; **+** stays disabled while that flag is off. A venue with `customerOrderingEnabled` off rejects `CustomerOrder.place` and `append` with `customerOrderingDisabled` even when the pack includes ordering.

Draft cart lives in `OrderDraftViewModel` (keepAlive). `pickingTable` drives floor-map selection.

## Flow (customer)

1. On the menu, **+** / **−** keep a session cart for that venue. A bottom bar shows the unit count and preview total.
2. **Pass order** opens the review (dishes, line prices, total, table).
3. If this venue has no scanned table, the review sends the customer to scan the sticker, then returns.
4. **Pass order** calls `CustomerOrder.place`. Prices are copied from the menu. Stock is deducted. A second open order on that table fails when `tableMultiOrder` is off.
5. The receipt shows ticket `ref`, table number, one line per unit, and the server total.
6. While an order is **in progress** and not paid, the buildings list and map are closed. The visit hides back, and the system back control stays on that venue with a short note. Opening that venue shows a short note with the total. **Details** on that note opens the receipt. The receipt lists each unit with its status. **Scan table** is disabled until the order is paid or cancelled. The menu still adds dishes; **Add to order** calls `CustomerOrder.append` on that open ticket (stock is deducted again; the venue flag `allowAppendingItemsToOrder` still applies). After the order is paid or cancelled, the list and map are available again.
7. **Order history** (home receipt icon, or the Orders pane of a venue visit) lists every venue for this customer, newest first, defaulting to the past month. On a venue visit, **This venue** keeps only orders for that building. **Today**, **Last week**, and **Last month** are the only windows (`CustomerOrder.list`, from inclusive, to exclusive, at most 62 days). The history loads 20 orders at a time and appends the next page as the list scrolls. `CustomerOrder.current` is the newest in-progress order, or empty.

## Data

- `venue_order` — building, optional `venue_table`, **`ref`** (sequential ticket number unique per building, assigned on create), status, launch/last-pay actors, timestamps
- `venue_order_item` — one row per article **unit** (same article repeats as separate lines), name/price snapshot, status, attribution timestamps

Management list shows `ref` as the leading badge; order detail AppBar title is `Order · #{ref}`.

Protocol DTOs stay `OrderCreate` / `OrderView` / `OrderItemView` for the staff API. Customers use `CustomerOrderPlace` / `CustomerOrderAppend` / `CustomerOrderView`. Each `CustomerOrderItem` is one unit (`articleId` only), and each `CustomerOrderLine` is one stored unit (name, unit price, and item status, no quantity). On the venue page an open order is only a short note with the total; the receipt lists each unit’s status.

## Realtime

None yet (kitchen streams later).
