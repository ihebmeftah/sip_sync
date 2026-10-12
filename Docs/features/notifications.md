# Real-time notifications

Status: in progress

## Apps

`sip_sync_server`, `sip_sync_flutter`, `managment`.

## Actors and permissions

- **Customer** — sees alerts for orders they launched, and for a reservation that was accepted or cancelled by the venue. Cancelling their own reservation does not alert them.
- **Owner** — sees a reservation that was accepted or cancelled by someone else (a customer cancel, or staff creating a confirmed booking). The person who made the change is not alerted. Employees use the same list and stream; no reservation row is written for them yet.
- Kinds are `orderItem`, `order`, and `reservation`. `subjectId` is the record a tap opens. Later management events add a kind and fill `subjectId` without a new table.
- One actor cannot list or mark another actor's row. A foreign id is `notFound`.

## Flow

1. Staff moves a line, cancels a line or the order, accepts a reservation, or cancels a reservation.
2. The server stores an `app_notification` for each recipient who did not make the change, and posts it on that actor's channel.
3. The customer app and the management shell load the unread count for the bell, then listen. Each new alert increments the badge. The count is every unread alert, not the filtered list.
4. The notification screen opens on the current venue. The customer or staff can switch to every venue, limit the list to this calendar month, or show unread rows only. **Mark all as read** marks the unread rows in that venue and month scope.
5. A tap marks that row read. In the customer app an order alert opens that order, and a reservation alert opens that venue's reservation screen. In management an order alert opens the order, and a reservation alert opens the venue's reservation list. The management bell sits in the sidebar footer.

## Data

- Table `app_notification`: recipient type and id, building, venue name, `subjectId`, kind, optional order line / ref / article / statuses, optional reservation status, optional cancellation reason, `readAt`, `createdAt`. UUID primary key.
- `AppNotificationView` is what the client receives. `read` is true when `readAt` is set.
- Endpoints: `Notification.list` (optional venue, month window, unread only), `Notification.unreadCount`, `Notification.markRead`, `Notification.markAllRead`, `Notification.watch`.

## Realtime

`Notification.watch` yields each new `AppNotificationView` for the signed-in actor. History is `list`, not the stream.
