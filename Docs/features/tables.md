# Floor tables

Status: shipped

## Apps

`sip_sync_server`, `managment`.

## Actors and permissions

- **Owner** — list, create, update, and activate/deactivate tables for buildings they own.
- **Employee** — list tables for their assigned building (floor view). Cannot create/edit tables. Order actions follow their access profile (`canCreateOrders`, etc.).
- Enforced on `VenueTableEndpoint` via `AuthGuard` + building ownership / assignment.

## Flow

1. Open a venue → **Tables** in the ops rail (`/b/:buildingId/tables`).
2. Floor grid shows each table as a seat-based dining preview (round for ≤4 seats, oblong for more; chairs match `maxSeats`).
3. Filter chips call `venueTable.list(buildingId, filter)` (`TableListFilter`: All / Available / Occupied / Reserved / Inactive).
4. Owner taps **Add table** → on **mobile** a full-screen form; on **wide** a dialog. Asks **how many** tables, max seats, and active. Server assigns sequential numbers continuing after the highest existing number.
5. Tap a table tile (when not in order pick mode) → **mobile** bottom sheet / **wide** dialog with:
   - **Edit table** (owner only) — seats and active; number locked.
   - **Current order** if `tableMultiOrder` is off, or **Current orders** list if on — open `progress` orders for that table (client filters `order.list(..., status: progress)` by `venueTableId`). Tap opens order detail; **+** appends articles when allowed.
   - **Create order** when the actor may create and the table is eligible (active; not occupied when multi-order is off).
6. **Owner FAB pick mode** still selects a table immediately and continues to article selection (no sheet).
7. Employees can also **scan** a table QR sticker (see [table-qr](table-qr.md)).
8. **Owner** can **Export QR PDF** from Tables to print stickers for the floor.

## Data

Persisted (`venue_table`):

| Field | Notes |
| --- | --- |
| `id` | UUID |
| `buildingId` | → `building` |
| `number` | Unique per building (1–9999) |
| `maxSeats` | 1–50 |
| `isActive` | default `true` |
| `createdAt` | |

**Not persisted:** `status` (`available` \| `occupied` \| `reserved`). Returned on `VenueTableView` only. **Occupied** when the table has at least one order with status `progress`; otherwise **available** (reservations later).

New-order create: if the building’s `tableMultiOrder` is **false**, creating on an occupied table is blocked (UI + server).

## Realtime

None yet (status refreshes when the tables list is loaded / after order create, pay, or cancel).
