# Order management

Status: draft

## Apps

`managment` (floor, POS, kitchen), `sip_sync_flutter` (customer orders if enabled), `sip_sync_server`.

## Actors and permissions

- Create order: employees (and customers if product allows) with permission.
- Status transitions: kitchen vs floor vs cashier as configured.
- Payments: payment permission; item-level and order-level.

Statuses: In Progress → Picked → Ready → Served → Paid. Auto-close open orders at building closing time.

## Flow

1. Tables with seating; multi-order or single-order per table from building settings.
2. Add items to an existing order when allowed.
3. Track payment at order and item level.

## Data

`OrderCreate` / `OrderAddItems` / status commands. `OrderView` for clients. Server computes totals.

## Realtime

Kitchen and floor subscribe to order streams.
