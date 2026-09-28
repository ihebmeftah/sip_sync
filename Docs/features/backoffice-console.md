# Backoffice console

Status: in progress

## Apps

`sip_sync_server`, `backoffice`.

## Actors and permissions

- **Super admin** — signed in on `backoffice`. Can list, create, and update other super admins, and can enable or disable them. Can list every building on the platform (read only).
- **Owner, employee, customer** — cannot call these methods. Route guards in the app are UX only.

The seeded default admin cannot be deleted or disabled. A signed-in admin cannot disable their own account. Disabling someone else revokes that admin’s sessions so the next call fails.

## Flow

1. Sign in → `/users` inside the console shell (sidebar: Users, Buildings).
2. **Users** lists backoffice accounts (name, email, phone, enabled). Create opens a dialog. Edit updates name, email, phone, optional new password, and the enabled switch.
3. Disabled login returns `accountDisabled`.
4. **Buildings** lists every venue with type, owner (name, email, phone), and contact (phone, WhatsApp, Instagram, Facebook).
5. Opening a row shows a dialog with address, coordinates, currency code, phone, and country code.

## Data

- `super_admin.isEnabled` (default true)
- `SuperAdminUpdate` — id plus profile fields, optional password, `isEnabled`
- `SuperAdminView` includes `isEnabled`
- `AdminBuildingView` — venue contact and location plus owner display fields (no employee ids, no order config)
- Endpoints: `SuperAdminAuth.update`, `SuperAdminAuth.setEnabled`, `Building.listAll`

## Realtime

None.
