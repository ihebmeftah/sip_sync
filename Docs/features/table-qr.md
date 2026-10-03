# Table QR codes

Status: in progress

## Apps

`managment` prints and scans stickers for orders. `sip_sync_flutter` scans the same sticker so a customer opens the venue already seated. `CustomerVenue.resolveTable` confirms the table is active.

## Actors and permissions

- **Owner** — export a printable PDF of QR stickers for all tables on the current floor. UI only on the Tables screen.
- **Employee** — scan a table QR to start a new order (same inactive / occupied rules as tapping a floor tile). Compact bottom nav: **Tables** | **Scan** | **Orders** (no Dashboard).

## Flow

1. Owner opens **Tables** → **Export QR PDF** → print / share sheet with one sticker per table (QR + table number + building name).
2. Each QR encodes `buildingId`, `tableId`, and `number` (`sipsync:table:v1:…` payload).
3. Employee taps **Scan** → camera → valid code for this building:
   - Inactive table → error snackbar.
   - Available table (or `tableMultiOrder` on) → success snackbar → **new** order article picker.
   - Occupied table and `tableMultiOrder` off:
     - `allowAppendingItemsToOrder` off → snackbar (`orderAppendArticlesDisabled`) and **close** the scanner (return to Tables) so the same QR cannot re-fire.
     - `allowAppendingItemsToOrder` on → success snackbar → **append** article picker for the open progress order on that table.
4. Invalid / wrong building / unknown / inactive → one snackbar and close the scanner.
5. A signed-in customer uses **Scan table** on the venue list, or **Change table** on a venue page. The same payload is sent to `CustomerVenue.resolveTable`. A match opens that venue and marks the table (occupied tables still match). Changing an existing seat shows a success snackbar. Inactive or unknown codes stay on the camera.

## Data

Payload (string, not persisted):

| Field | Notes |
| --- | --- |
| `buildingId` | UUID string |
| `tableId` | UUID string |
| `number` | Table number (1–9999) |

Must match a row from `venueTable.list` for the current building before starting an order.

## Realtime

None.
