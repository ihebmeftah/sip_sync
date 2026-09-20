# Floor tables

Status: shipped

## Apps

`sip_sync_server`, `managment`.

## Actors and permissions

- **Owner** — list, create, update, and activate/deactivate tables for buildings they own.
- **Employee** — list tables for their assigned building (floor view). Cannot create/edit.
- Enforced on `VenueTableEndpoint` via `AuthGuard` + building ownership / assignment.

## Flow

1. Open a venue → **Tables** in the ops rail (`/b/:buildingId/tables`).
2. Floor grid shows each table as a seat-based dining preview (round for ≤4 seats, oblong for more; chairs match `maxSeats`).
3. Filter chips: All / Available / Occupied / Reserved / Inactive.
4. Owner taps **Add table** → dialog asks **how many** tables, max seats, and active. Server assigns sequential numbers continuing after the highest existing number.
5. Owner taps a table tile to edit **seats** and **active** only (number is locked).
6. **Employee** taps a table to start a new order (no FAB). Inactive / occupied (when `tableMultiOrder` is off) tables are blocked with a snackbar.

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

New-order floor pick: if the building’s `tableMultiOrder` is **false**, tapping an occupied table is blocked with a snackbar (server also rejects create).

## Realtime

None yet (status refreshes when the tables list is loaded / after order create, pay, or cancel).
