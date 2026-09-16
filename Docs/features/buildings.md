# Buildings & multi-location

Status: draft

## Apps

`managment` (CRUD), `backoffice` (oversight), `sip_sync_server`. Customers may see a single location context in `sip_sync_flutter`.

## Actors and permissions

- Owner: create/update buildings they own; set currency, hours, payment rules, operational modes.
- Employee: read assigned building settings only.
- Super admin: platform-level building operations if needed.

## Flow

1. Owner creates a building (name, address, currency, hours).
2. Configure modes: strict order workflow, cash register required, multi-order vs single-order per table.
3. Employees and orders always carry `buildingId`.

## Data

Create/update DTOs: writable settings only. Responses: public + ops fields appropriate to the caller (no internal flags customers should not see).

## Realtime

Not required for settings; invalidate client caches after update.
