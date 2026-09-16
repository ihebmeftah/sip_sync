# Cash register

Status: draft

## Apps

`managment`, `sip_sync_server`.

## Actors and permissions

- Open/close register: employees with cash permission, scoped to building.
- If building requires a register, order payment is rejected without an open session.

## Flow

1. Launch session (timestamp, employee, building).
2. Link paid orders to that session.
3. Close session; keep history for reporting.

## Data

Session create/close DTOs. History list is paginated; no need to embed full order graphs.

## Realtime

Optional live session totals.
