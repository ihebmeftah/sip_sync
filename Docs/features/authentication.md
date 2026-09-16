# Authentication and identities

Status: in progress

## Apps

All three clients plus `sip_sync_server`.

| App | Package | Who may enter |
| --- | --- | --- |
| Customer | `sip_sync_flutter` | Anyone with a Sip Sync account (customer role is granted on first customer login or self-register) |
| Operations | `managment` | Owner or employee membership |
| Platform admin | `backoffice` | Backoffice membership (seeded default admin plus staff added by that admin) |

## Identity model

One Serverpod `AuthUser` per person. Login method depends on role:

| Actor | Signs in with | Email | Username |
| --- | --- | --- | --- |
| Customer | email + password | required (real) | none (null) |
| Owner | email + password | required (real) | none (null) |
| Backoffice / super admin | email + password | required (real) | none (null) |
| Employee | **username** + password | synthetic only (server IDP); never collected or shown | auto-generated from first + last + digits; **read-only** |

Employees use a synthetic email (`{username}@employees.sipsync.local`) under the hood so Serverpod’s email identity provider still stores the password. Owners never see or edit that address.

Profile fields (table `sip_sync_profile`):

- `email` (unique, lowercase) — real for customer/owner/backoffice; synthetic for employees
- `username` (unique when set, lowercase) — set only for employees
- `phoneNumber` (unique)
- `firstName`, `lastName`

Roles live in `user_role_membership` (`customer`, `owner`, `employee`, `backoffice`). Serverpod scopes stay in sync with those memberships.

Backoffice extras (`backoffice_staff`): `isAdmin`, `isSystemDefault` (seeded default cannot be deleted).

Employee extras (`employee_record`): links staff to the owner who added them. Building assignment uses `building_staff`.

## Actors and permissions

- **Customer** — self-register or log in on `sip_sync_flutter` with email.
- **Owner** — self-register or log in on `managment` with email (register grants owner).
- **Employee** — created by an owner (no email). Logs in on `managment` with username + password. Disabled `employee_record` blocks management login.
- **Backoffice user** — added by a backoffice admin. Logs in on `backoffice` with email. Cannot self-register.
- **Default super admin** — seeded on server start. Optional passwords: `sipSyncDefaultAdminEmail` / `sipSyncDefaultAdminPassword`.

## Flow

### New customer or owner

1. Submit email, password, phone, names (no username field).
2. Server creates `AuthUser`, email password, `sip_sync_profile` with `username: null`, and the app role.
3. Client stores the JWT and loads `AccountSessionView`.

### Existing person, another email-based app

1. Same **email** + password.
2. Server authenticates and adds the role that app needs.

### Owner adds an employee

1. Password, phone, names, optional `buildingId` — **no email, no username**.
2. Server generates a unique username (`firstname.lastname` + random digits), a synthetic email, identity + employee role + `employee_record`, and optional `building_staff`.
3. Owner sees the username on the employee details screen (read-only). Staff sign in with that username.

### Login (`LoginRequest.identifier`)

- Contains `@` → treat as email (customer / owner / backoffice).
- Otherwise → look up profile by username, authenticate with that row’s synthetic email (employees on management).

### Access denied

Management without owner/employee, or backoffice without membership → `appAccessDenied`.

## Data

- Tables: `sip_sync_profile`, `user_role_membership`, `backoffice_staff`, `employee_record`
- Create: `SelfRegisterCreate` (no username), `LoginRequest` (`identifier` + password + app), `EmployeeCreate` (no email/username), `BackofficeUserCreate` (no username)
- Update: `ProfileUpdate` / `EmployeeUpdate` (phone + names only; username and email not writable)
- Responses: `AuthSessionResult`, `ProfileView` (`username` nullable), `EmployeeView` (username, no email), `BackofficeUserView`
- Exceptions: `AccountException` / `AccountErrorCode`

Passwords live in the email identity provider, never on Sip Sync tables.

## Realtime

None for auth.
