# Employee access profiles

Status: shipped

## Apps

`sip_sync_server`, `managment`.

## Actors and permissions

- **Owner** — CRUD access profiles per building; assign a profile when creating/updating an employee. Enforced on `EmployeeAccessEndpoint` / `EmployeeEndpoint`.
- **Employee** — no access-profile management. Order actions are limited by the assigned profile (server-enforced). Owners keep full order powers.

## Access flags

| Flag | Allows |
| --- | --- |
| `orderCreation` | Create orders and append items |
| `orderPayment` | Set item status to **payed** (and order last-paid attribution) |
| `cancelOrder` | Cancel an order or an order line |
| `preparation` | Set item status to **picked** or **ready** |
| `serving` | Set item status to **served** |
| `consultAllOrders` | When **true**, list all building orders. When **false**, only orders the employee launched or lines they added |

An employee with **no** access assigned cannot perform floor order actions (except what building membership alone allowed before — now denied until assigned).

## Flow

1. Owner creates a **building** → server seeds default profiles **Waiter**, **Gerant**, **Barista**.
2. Owner opens **Access** (from Employees) → adjust toggles or add custom profiles. The list is 20 profiles per page. The employee form still loads every profile.
3. Owner creates/edits an employee and picks an access profile.
4. Employee login loads session with access summary for UX; server re-checks on every order RPC.
5. Order list for employees with `consultAllOrders: false` is filtered to their launched orders / added lines.

## Default profiles (on building create)

| Name | orderCreation | orderPayment | cancelOrder | preparation | serving | consultAllOrders |
| --- | --- | --- | --- | --- | --- | --- |
| Waiter | ✓ | ✓ | ✓ | | ✓ | |
| Gerant | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| Barista | ✓ | | | ✓ | | |

## Data

### `employee_access`

| Field | Notes |
| --- | --- |
| `id` | UUID |
| `buildingId` | → building (Cascade) |
| `name` | Unique per building |
| flags | booleans above |
| `createdAt` | |

### `employee.accessId`

Optional FK → `employee_access` (Restrict on delete while assigned).

### `venue_order_item.addedBy*`

Stamped on create/append so visibility can include “items I added”.

## Realtime

None.
