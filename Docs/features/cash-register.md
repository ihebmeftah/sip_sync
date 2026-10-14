# Cash register

Status: shipped

## Apps

`sip_sync_server`, `managment`, `backoffice` (pack switch only). The customer app has no register screen. A place or append while the venue requires a register and none is open fails with `registerRequired`.

## Actors and permissions

- **Owner** — turn the venue switch on when the pack includes it. Open, close, and read history. Correct opening and closing cash after they were saved.
- **Employee with `cashRegister`** — open, close, and read history for their building. They can count the drawer when they open or close. The open shift hides the opening count from them. History hides opening cash, closing cash, and the paid-order total. They cannot change those amounts later. The owner still sees the counts and the drawer check.
- **Any building member** — read the session that is in progress, so the order board and dashboard can follow it.
- **Super admin** — the pack capability only. No register operations.
- A customer, an owner of another building, and an employee of another building are rejected.

New buildings seed **Gerant** with the flag on. Waiter and Barista stay off. Profiles that already exist stay off until the owner turns the flag on.

## What a session is

One venue has at most one session in progress. Opening it starts the shift. Every new ticket, staff or customer, is stamped with that session. Closing it ends the shift. Reservations and stock alerts stay on the calendar day.

There is still no card-versus-cash split, and no second till. Every payed line on the shift counts as cash in the drawer. Expected closing cash is the opening count plus those lines. When both counts are present, a matching drawer is marked correct, a larger count is tips, and a smaller count is short.

## Flow

1. The pack includes `cashRegister` (`counter`, `floor`, `house`, `group`; off on `free`). The owner turns **Cash register** on under Configuration. Saving it on while the pack leaves it off is rejected. The switch is locked with the Upgrade badge when the pack leaves it off and it is not already on.
2. While the switch is off, orders and the dashboard keep the local calendar day. No session is required.
3. While the switch is on and nothing is open, staff cannot create an order, append items, or record a payment. A customer cannot place or append. The order board is empty and asks to open the register. Dashboard order and item counts are zero. Pending reservations, today's reservations, and restock stay as they are.
4. An owner or an employee with the flag opens the register from a dialog. Opening cash is optional. A negative amount is rejected. A second open is rejected. While the shift is open, the screen counts the time since it started.
5. New orders store `cashRegisterSessionId`. The item board and the order list default to that session. Day chips on the list still pick another day. The dashboard welcome band says this register, and order and item counts use the session. A session can run past midnight. The 8-day list limit does not apply to the open session.
6. Close is refused while that session still has an order in progress. Pay or cancel those tickets first. Closing cash is entered in the same dialog. It is required when the shift has an opening count (`endCashRequired`), and optional when opening cash was left blank. History is a grid of closed sessions, without the tickets. A date picker limits that grid to shifts that started on one day. Only the owner sees opening cash, closing cash, the paid total, and the drawer check, and only the owner can correct those amounts after they were saved.
7. Tickets that already existed keep a null session id. Turning the switch on does not rewrite them. The live board, while a session is open, still shows in-progress tickets that have no session, so an older open ticket is not hidden. Those tickets are not part of the shift counts.

Open requires the pack switch and the venue switch. Close of a session that is already in progress is still allowed after the venue switch is turned off, so the shift can end.

## Data

- `cash_register_session` — building, status `progress` or `closed`, opened-by actor, openedAt, optional `startCash`, closed-by actor, closedAt, optional `endCash`.
- `venue_order.cashRegisterSessionId` — set on create while a session is open. Null on older tickets.
- `building.cashRegisterEnabled` — default false.
- `pack.cashRegister` — capability boolean. `PackFeature.cashRegister`.
- `employee_access.cashRegister` — open and close.
- `CashRegisterSessionView` / `CashRegisterPage` — display shape. `orderCount` and `paidTotal` are computed, not stored. `paidTotal` is the sum of payed lines, skipping cancelled lines.
- `CashRegisterException` / `CashRegisterErrorCode` — `notAuthorized`, `notFound`, `disabled`, `registerAlreadyOpen`, `registerNotOpen`, `registerHasOpenOrders`, `invalidAmount`, `endCashRequired`.
- `CashRegister.open` takes optional `startCash`. `CashRegister.close` takes optional `endCash`, required when `startCash` is set. Blank stays null. A negative amount is `invalidAmount`.
- `CashRegister.correct` replaces the counted amounts. Owner only. Closing cash cannot be set while the shift is still open. `CashRegister.list` takes an optional `openedFrom` / `openedTo` window of at most 36 hours.
- `OrderErrorCode.registerRequired` — create, append, or payment while the venue requires a register and none is open.
- Endpoint: `CashRegister.current`, `open`, `close`, `list` (20 per page, newest first).
- `Order.list` and `Order.watchBoard` take an optional session id. When set, it replaces the day window.
- `Dashboard.summary` takes an optional session id. When the venue requires a register and the id is omitted, the server uses the open session, or zeros the order and item counts.

## Realtime

None. The order board and dashboard read the current session when they open and on pull to refresh.
