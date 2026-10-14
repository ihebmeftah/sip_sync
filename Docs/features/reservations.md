# Reservations

Status: shipped

## Apps

`sip_sync_server`, `managment`, `sip_sync_flutter`, `backoffice` (plan editor only).

## Actors and permissions

- **Owner** — create, list, confirm, cancel, and assign tables. Always allowed when the pack includes reservations.
- **Employee** — the same actions when their access profile has `reservations`. Gerant is seeded on. Waiter and Barista stay off. An order does not require a scan to confirm arrival.
- **Customer** — requests a time for themselves when the pack includes reservations. They do not pick a table, and they cannot confirm the request. A customer scan does not confirm arrival. They can cancel their own future request or confirmed reservation.
- **Super admin** — turns the capability and the daily cap on or off in the pack form. They do not create reservations.

Route guards are UX only. The endpoint checks the actor and the pack.

## Flow

1. The building stores a reservation fee in the venue currency. It defaults to 0 and prefills the paid amount on a staff booking.
2. A customer taps **Reserve now** and lands on the request screen, which lists this venue's upcoming reservations, newest first. Staff see the same order on the day they have open. The management drawer and the reservations item show how many requests are still waiting. **Request** opens a dialog for the date and the start, then confirm sends the request for their own account. The booking lasts two hours from that start. Opening and closing times do not limit it. The row is `requested`, the paid amount is 0, and no table is attached.
3. An owner or an employee with `reservations` confirms that request (`confirmed`) or cancels it. The list updates that row. Confirmation does not choose a table. A customer cancel updates their row the same way.
4. After it is `confirmed`, the same staff assign one or more active tables. Overlap is checked at assignment, against other `confirmed` or `arrived` rows on those tables. Assigning again replaces the previous tables.
5. Staff can also create a reservation from the management app. That row is stored as `confirmed` immediately (the guest is an existing customer, or a typed name and phone). The customer control is a dropdown: open it, type a name, phone, or email, and after typing stops for one second it shows up to 20 matches. Choosing a row fills the field. A query shorter than two characters is not searched. It still needs a table. The paid amount can differ from the building fee. The same two-hour length applies when no end is sent.
6. A customer request stores an alert for the venue owner and each enabled employee whose access includes reservations. Accepting or cancelling stores an alert for that same desk and for the customer. Staff are not alerted for their own change. A customer who cancels their own reservation still is. See [notifications](notifications.md). A pack with reservations off rejects the create. The venue switch `reservationsEnabled` does the same (`ReservationErrorCode.disabled`) even when the pack includes reservations. `maxReservationsPerDay` counts non-cancelled reservations whose start falls on that UTC date. Null means no cap. A request whose end has passed is cancelled, so it stops counting.
7. From 30 minutes before the start, a confirmed reservation that already has a table marks that table reserved and names the guest. Ordering still works.
8. At the start, the table stays marked reserved and names the guest, and orders are allowed. A scan does not have to confirm arrival first. A confirmed reservation with no table does not hold the floor.
9. If the end passes while the row is still `confirmed`, it becomes `noShow` and any tables unlock. Staff can cancel a `requested` or `confirmed` row before arrival.

Rows saved by the previous flow as `booked` are rewritten to `confirmed` the next time reservations are read, keeping their tables.

## Data

- `building.reservationFee` — default amount, venue currency.
- `pack.reservations` / `pack.maxReservationsPerDay` — switch and daily cap.
- `employee_access.reservations` — staff permission. Gerant is seeded on. Waiter and Barista stay off.
- `reservation` — times, guest name and phone, optional customer, paid amount, status, who created it, who confirmed it.
- `table_reservation` — tables on that reservation, empty until staff assign them. The model is `TableReservation` so it does not collide with Serverpod's query class for `Reservation`.
- `ReservationCreate` / `CustomerReservationCreate` / `ReservationView` / `ReservationCustomerMatch`.
- `ReservationException` / `ReservationErrorCode` — `invalidInput`, `notAuthorized`, `notFound`, `overlap`. Pack failures stay `PackException`.
- `VenueTableView` carries `reservationPhase` (`none`, `soon`, `holding`), the guest name, and the start, so the floor can warn without a second call.
- `CustomerVenueDetail.reservationsEnabled` is true only when the pack includes reservations and the venue switch is on. `reservationsClosedByVenue` is true only when the pack includes them and the venue switch is off; the customer app then disables **Reserve now** instead of showing the plan message. `reservationFee` is the building default.

Seeded caps: free off, counter 8/day, floor 30/day, house and group on with no cap. Existing databases get those values from the migration that adds the columns. Later pack edits are left alone.

## Realtime

None. The floor and the customer venue read the phase on the next table or venue load. The order endpoint enforces the hold even if that screen is stale.
