# Product overview

Sip Sync is an ecosystem for cafés, restaurants, lounges, and bars.

## Clients

- **managment** — owners and employees: locations, staff, menu, inventory, tables, orders, cash register, kitchen.
- **sip_sync_flutter** — customers.
- **backoffice** — super admin / platform operator.
- **sip_sync_server** — Serverpod API, PostgreSQL, auth, realtime.

## Planned capabilities (subject to change)

1. **Buildings** — multiple locations; currency, hours, payment rules, operational modes (strict order workflow, cash register required, multi-order vs single-order per table).
2. **Employees** — building assignments, granular permissions (orders, payments, kitchen), role-based access, employee emails derived from building name.
3. **Menu & inventory** — categories, articles, ingredient stock and thresholds, composition with deduction on order, live stock updates.
4. **Orders** — tables/seating, statuses In Progress → Picked → Ready → Served → Paid, add items to existing orders, order- and item-level payment, auto-close at building closing time.
5. **Cash register** — open/close sessions with time tracking, link orders to a session, history and reporting.
6. **Statistics** — dashboard, order reporting, employee performance.
7. **Notifications** — kitchen alerts on new orders, status updates, configurable per employee access.

Source notes: repo `notes.txt`.
