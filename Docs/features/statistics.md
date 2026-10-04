# Statistics & analytics

Status: in progress

## Apps

`sip_sync_server`, `backoffice`. The owner dashboard in `managment` is still later.

## Actors and permissions

- **Super admin** — `PlatformStats.summary` on the backoffice Stats screen.
- **Owner, employee, customer** — rejected. Route guards are UX only.

## Flow

1. Stats opens on sign-in. It shows owners, customers, venues, employees, orders, customer orders that were not cancelled, and the monthly plan total.
2. The monthly total is the sum of each venue’s current pack price, in TND millimes. A private pack still counts in that total.
3. **Public packs** lists every public pack, including a disabled one, with how many venues are on it and how many distinct owners those venues belong to. Private packs stay off this list.

The owner dashboard (revenue in the venue currency, employee performance) is not this screen.

## Data

- `PlatformStats` — the counts above plus `publicPacks`.
- `PublicPackUsage` — pack id, code, name, monthly price, fee, enabled, `venueCount`, `ownerCount`.
- Endpoint: `PlatformStats.summary`. No writes.

## Realtime

Refresh on demand or periodic; not a substitute for kitchen streams.
