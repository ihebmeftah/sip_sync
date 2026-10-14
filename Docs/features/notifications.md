# Real-time notifications

Status: in progress

## Apps

`sip_sync_server`, `sip_sync_flutter`, `managment`.

## Actors and permissions

- **Customer** — sees alerts for orders they launched, and for a reservation that was accepted or cancelled. Cancelling their own reservation still alerts them.
- **Owner** — sees a reservation request, and a reservation that was accepted or cancelled. The owner is not alerted for a change they made themselves. In management the list and the bell are the venue that is open, not every venue the owner has.
- **Employee** — uses the same list and stream, limited to the building they work in. Reservation alerts are stored only when their access profile includes reservations, and not for a change they made themselves.
- Kinds are `orderItem`, `order`, and `reservation`. `subjectId` is the record a tap opens. Later management events add a kind and fill `subjectId` without a new table.
- One actor cannot list or mark another actor's row. A foreign id is `notFound`.

## Flow

1. A customer requests a reservation, staff moves a line, cancels a line or the order, accepts a reservation, or cancels a reservation.
2. The server stores an `app_notification` for each recipient and posts it on that actor's channel. A reservation alert goes to the venue owner and to enabled employees whose access includes reservations. Staff are not alerted for a change they made. The customer is not alerted for their own request. They are alerted when that reservation is accepted or cancelled, including when they cancel it.
3. The customer app and the management shell load the unread count for the bell, then listen. Each new alert increments the badge and raises a toast at the top of the screen. Toasts sit one in front of another, each for 10 seconds. Each toast has mark as read beside close. Above the pile, mark all as read covers the alerts in scope, and view all opens the notification screen. Form and plan errors stay on their own snackbar. The customer count is every unread alert. The management count is unread alerts for the open venue only. Month and unread filters do not change the badge. A management toast is only for the venue that is open.
4. The notification screen opens on the current venue. A customer can switch to every venue. Management cannot: an owner stays on the venue they opened, and an employee stays on the building they work in. Either app can limit the list to this calendar month or show unread rows only. **Mark all as read** marks the unread rows in that venue and month scope.
5. A tap marks that row read. In the customer app an order alert opens that order, and a reservation alert opens that venue's reservation screen. In management an order alert opens the order, and a reservation alert opens the venue's reservation list. The management bell sits in the app bar trailing.

## Data

- Table `app_notification`: recipient type and id, building, venue name, `subjectId`, kind, optional order line / ref / article / statuses, optional reservation status, optional cancellation reason, `readAt`, `createdAt`. UUID primary key.
- `AppNotificationView` is what the client receives. `read` is true when `readAt` is set.
- Endpoints: `Notification.list` (optional venue, month window, unread only), `Notification.unreadCount`, `Notification.markRead`, `Notification.markAllRead`, `Notification.watch`.

## Realtime

`Notification.watch` yields each new `AppNotificationView` for the signed-in actor. History is `list`, not the stream.
