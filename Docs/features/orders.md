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
| `addedBy` | Who created the line (customer, owner, or employee) |
| `preparedBy` / `preparedAt` | Kitchen staff with preparation access. Set when the line is **picked**, then again when it is marked **ready** (`preparedAt` is the ready time) |
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
5. Detail: compact advance / cancel on each line (only that card shows a spinner). The next status is the venue’s next **enabled** workflow step. With **strict item workflow off**, picked, ready, and served are off and only **payed** stays on, so a line goes from in progress to payed, or is cancelled. With it **on**, each line must follow the enabled steps in order. Each move stores the person who made it. Picked and ready both store the kitchen employee on `preparedBy` (only preparation access can do those steps). `addedBy` stays the creator. Served and payed store `servedBy` and `paidTo`. Later stamps are cleared, so the chain is only the steps that happened. The info icon on the line opens that chain. The line itself does not repeat it under the article name. **Add articles** appends more units (and deducts stock again) when the building’s `allowAppendingItemsToOrder` is **true**; otherwise the button is disabled and `addItems` returns `appendNotAllowed`. Info icon opens item attribution. Table chip opens the floor map.
6. When an order is open on a table, that table’s floor status is **occupied**; after pay/cancel it returns to **available**. If the building’s `tableMultiOrder` is **false**, a second order on that table is blocked (server + floor picker).
7. Cancel whole order when still in progress; stay on the detail screen (shows cancelled state). The dialog asks for one reason: ingredient out of stock, closing time is coming, a breakdown at work, or cancelled at the customer's request. The same list is used when cancelling one line. On the item board, **Canceled** lets someone with cancel access select lines or a whole order, then confirm with that reason. Selecting every open line cancels the order only when the ticket itself can still be cancelled. A served or payed line cannot be cancelled, and a ticket that already has one cannot be cancelled as a whole (`cancelLocked`). Employees still need `cancelOrder`. Locked lines are not selectable. The reason is stored on the order and on each line cancelled with it, and shown on the staff ticket and on the customer receipt and order history. A line or order status change also stores a notification for the customer who launched the order. See [notifications](notifications.md). Cancelling a line or order **restores** composition stock for non-payed lines.
8. The orders screen opens on a board of tickets created on the **current local day** (from inclusive, to exclusive). Older open tickets stay off this board; the ticket list is where another day is chosen. A segmented control in the title switches to that list and back. With **strict item workflow on**, columns are **progress** plus each enabled venue step except **payed**, and **payed** lines leave the board. With it **off**, the columns are **progress** and **payed**. Picked, ready, and served stay only while a line is already in that status, so it can still move to payed. A payed line stays in the payed column, and payed tickets from that same day stay on the board. Columns stay on screen when a column has nothing to move. Inside a column, lines are grouped by table and order number. The line shows the dish name only. The price is shown only to someone who can take payment. Swipe a line toward the next status; the swipe uses that status color. Press and drag the table card onto the next column to move every line in that group. **Cancelled** lines leave the board, and a payed or cancelled ticket returns the table to available on the floor map. A ticket that was just opened shows **New order**. A line appended to a ticket that was already open shows **Added**. `Order.watchBoard` sends that day's tickets, then each new ticket, appended line, and status change created in the same window. Preparation sees lines whose next step is picked or ready, including lines opened by a customer, owner, or another employee, and is the only role that can set those two statuses. Serving sees every line whose next step is served and can mark it served. The status call returns that updated line to the person who changed it, so the board moves without a refresh. Payment on a staff ticket stays with the employee who placed it, unless they can consult every order. A customer-opened line can be paid by any employee with payment access.
9. `order.list(buildingId, status)` (`null` = all) still pages 20 tickets at a time for lookups. An employee who cannot consult every order sees tickets they launched, plus lines they added, prepared, served, recorded payment for, or cancelled. Open orders for one table are loaded in full (no day window). Results are sorted by `createdAt` desc; detail lines stay in stable `createdAt` (+ id) order with **payed** items at the bottom (`paidAt` desc among payed). Intermediate status changes do not reorder lines.
10. The order **list** can be narrowed by day for every owner and employee. It opens on **today** (local calendar day, from inclusive, to exclusive). **Last 3 days** and **Last week** are the two previous presets (3 and 7 local days ending today). **Pick a day** chooses one other local day. The item board does not use those chips; it always uses today. The server applies `createdFrom` / `createdTo` for every caller, and rejects a partial, reversed, or window longer than 8 days. An employee who cannot consult every order still only sees tickets they took part in, inside that window. Leaving the list and coming back resets the chips to today and All.
11. Create / append fails with `insufficientStock` when any ingredient would go below zero, unless the venue’s `allowOutOfStockOrders` is **true**. In that case stock is reduced only down to zero. The article picker shows the names of ingredients that cannot cover one more unit. The customer menu does not name them; **+** stays disabled while that flag is off. A venue with `customerOrderingEnabled` off rejects `CustomerOrder.place` and `append` with `customerOrderingDisabled` even when the pack includes ordering.

Draft cart lives in `OrderDraftViewModel` (keepAlive). `pickingTable` drives floor-map selection.

## Flow (customer)

1. On the menu, **+** / **−** keep a session cart for that venue. A bottom bar shows the unit count and preview total.
2. **Pass order** opens the review (dishes, line prices, total, table).
3. If this venue has no scanned table, the review sends the customer to scan the sticker, then returns.
4. **Pass order** calls `CustomerOrder.place`. Prices are copied from the menu. Stock is deducted. A second open order on that table fails when `tableMultiOrder` is off.
5. The receipt shows ticket `ref`, table number, one line per unit, and the server total. While the order is still in progress, it also explains that a served or paid dish cannot be cancelled, and that a served or paid dish locks the whole order.
6. While an order is **in progress** and not paid, the buildings list and map are closed. The visit hides back, and the system back control stays on that venue with a short note. Opening that venue shows a short note with the total. **Details** on that note opens the receipt. The receipt lists each unit with its status. **Scan table** is disabled until the order is paid or cancelled. The menu still adds dishes; **Add to order** calls `CustomerOrder.append` on that open ticket (stock is deducted again; the venue flag `allowAppendingItemsToOrder` still applies). `CustomerOrder.watchCurrent` pushes each staff status change, so the receipt and the open-visit note update without a refresh. After the order is paid or cancelled, the scanned table is cleared, so the next order starts with a new scan, and the list and map are available again.
7. **Order history** (home receipt icon, or the Orders pane of a venue visit) lists every venue for this customer, newest first, defaulting to the past month. On a venue visit, **This venue** keeps only orders for that building. **Today**, **Last week**, and **Last month** are the only windows (`CustomerOrder.list`, from inclusive, to exclusive, at most 62 days). The history loads 20 orders at a time and appends the next page as the list scrolls. `CustomerOrder.current` is the newest in-progress order, or empty.

## Data

- `venue_order` — building, optional `venue_table`, **`ref`** (sequential ticket number unique per building, assigned on create), status, launch/last-pay actors, timestamps
- `venue_order_item` — one row per article **unit** (same article repeats as separate lines), name/price snapshot, status, attribution timestamps

Management list shows `ref` as the leading badge; order detail AppBar title is `Order · #{ref}`.

Protocol DTOs stay `OrderCreate` / `OrderView` / `OrderItemView` for the staff API. Customers use `CustomerOrderPlace` / `CustomerOrderAppend` / `CustomerOrderView`. Each `CustomerOrderItem` is one unit (`articleId` only), and each `CustomerOrderLine` is one stored unit (name, unit price, and item status, no quantity). On the venue page an open order is only a short note with the total; the receipt lists each unit’s status.

## Realtime

`Order.watchBoard(buildingId, createdFrom, createdTo)` is the floor board for that local day. The first events are one snapshot per ticket created in the window, then `synced`. After that the server sends `orderOpened`, `itemsAdded`, or `changed` with the full ticket when that ticket was created in the same window. Customer place and append publish the same channel, so a dish passed from the menu shows up without a refresh.

`CustomerOrder.watchCurrent` is the signed-in customer's visit. The first event is their open order, or empty. Later events carry the receipt that just changed. When that order is paid or cancelled, `open` is empty and `changed` is the final receipt.
