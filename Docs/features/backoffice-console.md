# Backoffice console

Status: in progress

## Apps

`sip_sync_server`, `backoffice`.

## Actors and permissions

- **Super admin** — signed in on `backoffice`. Can list, create, and update other super admins, and can enable or disable them. Can list every building on the platform (read only). Can list every owner and customer (name, email, phone, created time; no password hash). Can create and edit packs. See [packs](packs.md).
- **Owner, employee, customer** — cannot call these methods. Route guards in the app are UX only.

The seeded default admin cannot be deleted or disabled. A signed-in admin cannot disable their own account. Disabling someone else revokes that admin’s sessions so the next call fails.

## Flow

1. Sign in → `/stats` inside the console shell. The sidebar is Stats, Users, Customers, Buildings, Packs.
2. **Stats** shows platform counts and, for each public pack, how many venues and owners are on it. **Packs** is the plan catalog.
3. **Customers** has two tabs, Owners and Customers. Each card shows name, email, phone, and created time. Details opens the same fields.
4. **Users** lists backoffice accounts (name, email, phone, enabled). Create opens a dialog. Edit updates name, email, phone, optional new password, and the enabled switch.
5. Disabled login returns `accountDisabled`.
6. **Buildings** lists every venue. The type sits on the same row as the name. The card opens `/buildings/:id`.
7. The detail screen has four tabs. **Details** is contact and location. **Pack** shows the current plan, assigns an enabled pack, or creates a private pack and assigns it. **Gain** is the monthly price plus the customer-app fee on customer orders. **Stats** is category, article, table, and order counts.

## Data

- `super_admin.isEnabled` (default true)
- `SuperAdminUpdate` — id plus profile fields, optional password, `isEnabled`
- `SuperAdminView` includes `isEnabled`
- `AdminBuildingView` — venue contact and location plus owner display fields (no employee ids, no order config)
- `PlatformPersonView` — owner or customer name, email, phone, and `createdAt` (no password hash)
- Endpoints: `SuperAdminAuth.update`, `SuperAdminAuth.setEnabled`, `Building.listAll`, `PlatformDirectory.listOwners`, `PlatformDirectory.listCustomers`, `Pack.list` / `create` / `update` / `delete`, `PlatformStats.summary`

## Realtime

None.
