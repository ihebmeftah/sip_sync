# Backoffice console

Status: in progress

## Apps

`sip_sync_server`, `backoffice`.

## Actors and permissions

- **Super admin** — signed in on `backoffice`. Can list, create, and update other super admins, and can enable or disable them. Can list every building on the platform (read only). Can list every owner and customer (name, email, phone, created time; no password hash).
- **Owner, employee, customer** — cannot call these methods. Route guards in the app are UX only.

The seeded default admin cannot be deleted or disabled. A signed-in admin cannot disable their own account. Disabling someone else revokes that admin’s sessions so the next call fails.

## Flow

1. Sign in → `/stats` inside the console shell. The sidebar is Stats, Users, Customers, Buildings, Packs.
2. **Stats** and **Packs** are placeholders. Each shows “This screen is working.” until that feature is built.
3. **Customers** has two tabs, Owners and Customers. Each card shows name, email, phone, and created time. Details opens the same fields.
4. **Users** lists backoffice accounts (name, email, phone, enabled). Create opens a dialog. Edit updates name, email, phone, optional new password, and the enabled switch.
5. Disabled login returns `accountDisabled`.
6. **Buildings** lists every venue with type, owner (name, email, phone), and contact (phone, WhatsApp, Instagram, Facebook). The details button sits on the trailing edge of the card.
7. Opening a building shows a dialog with address, coordinates, currency code, phone, and country code.

## Data

- `super_admin.isEnabled` (default true)
- `SuperAdminUpdate` — id plus profile fields, optional password, `isEnabled`
- `SuperAdminView` includes `isEnabled`
- `AdminBuildingView` — venue contact and location plus owner display fields (no employee ids, no order config)
- `PlatformPersonView` — owner or customer name, email, phone, and `createdAt` (no password hash)
- Endpoints: `SuperAdminAuth.update`, `SuperAdminAuth.setEnabled`, `Building.listAll`, `PlatformDirectory.listOwners`, `PlatformDirectory.listCustomers`

## Realtime

None.
