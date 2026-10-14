# Management dashboard

Status: in progress

## Apps

`sip_sync_server`, `managment`. This is not the backoffice Stats screen (`PlatformStats`).

## Actors and permissions

- **Owner** of the building can read the counts.
- **Employee** of that building can read them only when the access profile has `consultAllOrders`. Other employees are rejected.
- A customer, a super admin, an owner of another building, and an employee of another building are rejected.
- The dashboard tab in the management shell follows the same rule. Route guards are UX only.

## Flow

1. The dashboard sends the device's local calendar day as UTC midnight, the same day key as the reservation list.
2. The server returns counts for that day plus current stock and still-waiting reservation requests.
3. The welcome band shows that the counts are for the current local day, with that day's start and end. Reservations is the first quick action and shows how many requests are still waiting. Today's reservations and ingredients under 10% sit in their own section above the order counts. Pull to refresh loads them again.

What each number means:

- **Orders** — tickets created that day, plus how many are in progress, payed, or cancelled.
- **Customer app** — those tickets whose launcher is a customer.
- **Items by status** — lines created that day, counted by progress, picked, prepared, served, payed, and cancelled.
- **Pending requests** — reservation requests still waiting, any day. Expired requests are settled first, so they are not counted.
- **Reservations today** — reservations whose start falls on that day, every status.
- **Need restock** — ingredients whose current stock is under 10% of the full level (`initialStock`). Exactly 10% is not included. A full level of zero counts when current stock is also zero.

Revenue and employee performance are not on this screen.

## Data

- `DashboardSummary` — the counts above. Not a table.
- Endpoint: `Dashboard.summary(buildingId, day)`. No writes, except settling overdue reservations before the pending count.

## Realtime

Refresh on open and on pull. Not a stream.
