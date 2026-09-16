# Statistics & analytics

Status: draft

## Apps

`managment` (owner dashboard), `backoffice` (platform metrics if needed), `sip_sync_server`.

## Actors and permissions

- Owners: own buildings only.
- Super admin: aggregated platform stats.
- Employees: only if a permission is granted (default off).

## Flow

Dashboard: orders, revenue (per building currency), employee performance. Prefer aggregated queries, not dumping raw order lists.

## Data

Read-only view models / summary DTOs. No PII beyond what the role may see.

## Realtime

Refresh on demand or periodic; not a substitute for kitchen streams.
