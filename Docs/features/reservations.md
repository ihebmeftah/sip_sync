# Reservations

Status: shipped

## Apps

`sip_sync_server`, `managment`, `sip_sync_flutter`, `backoffice` (plan editor only).

## Actors and permissions

- **Owner** — create, list, cancel, and confirm a reservation for their venue. Always allowed when the pack includes reservations.
- **Employee** — the same actions when their access profile has `reservations`. Scan-to-confirm uses that flag. Order creation alone does not confirm a reservation.
- **Customer** — books for themselves when the pack includes reservations. A customer scan does not confirm arrival.
- **Super admin** — turns the capability and the daily cap on or off in the pack form.

Route guards are UX only. The endpoint checks the actor and the pack.

## Flow

1. The building stores a reservation fee in the venue currency. It defaults to 0 and prefills the paid amount on a staff booking.
2. Staff pick one or more active tables, a start, an end, and either an existing customer (looked up by phone) or a guest name and phone. The paid amount can differ from the building fee.
3. A customer books the same tables and times for their own account. The paid amount is stored as 0.
4. A pack with reservations off rejects the create. `maxReservationsPerDay` counts non-cancelled reservations whose start falls on that UTC date. Null means no cap.
5. Overlapping bookings on the same table are rejected while the other row is `booked` or `arrived`.
6. From 30 minutes before the start, the floor marks the table reserved and names the guest. Ordering still works.
7. At the start, ordering on those tables is refused until an owner or an employee with `reservations` scans one of the tables. That scan sets the reservation to `arrived`, and orders are allowed again.
8. If the end passes while the row is still `booked`, it becomes `noShow` and the tables unlock. Staff can cancel a `booked` row before then. A customer can cancel their own future `booked` row.

## Data

- `building.reservationFee` — default amount, venue currency.
- `pack.reservations` / `pack.maxReservationsPerDay` — switch and daily cap.
- `employee_access.reservations` — staff permission. Gerant is seeded on. Waiter and Barista stay off.
- `reservation` — times, guest name and phone, optional customer, paid amount, status, who created it, who confirmed it.
- `table_reservation` — tables on that reservation. The model is `TableReservation` so it does not collide with Serverpod's query class for `Reservation`.
- `ReservationCreate` / `CustomerReservationCreate` / `ReservationView` / `ReservationCustomerMatch`.
- `ReservationException` / `ReservationErrorCode` — `invalidInput`, `notAuthorized`, `notFound`, `overlap`. Pack failures stay `PackException`. A held table on order create is `OrderErrorCode.reservationHeld`.
- `VenueTableView` carries `reservationPhase` (`none`, `soon`, `holding`), the guest name, and the start, so the floor can warn without a second call.
- `CustomerVenueDetail.reservationsEnabled` and `reservationFee` tell the customer app whether booking is open. `bookableTables` lists every active table, including one that is busy right now.

Seeded caps: free off, counter 8/day, floor 30/day, house and group on with no cap. Existing databases get those values from the migration that adds the columns. Later pack edits are left alone.

## Realtime

None. The floor and the customer venue read the phase on the next table or venue load. The order endpoint enforces the hold even if that screen is stale.
