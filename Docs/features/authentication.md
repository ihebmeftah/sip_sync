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

One Serverpod `AuthUser` per person. Email, username, and phone number are unique across the platform. The same person can hold several **roles at once** (customer + owner, employee + customer, backoffice + customer, and so on). Apps never create a second login for an existing email: they attach another role after the password is verified.

Profile fields (table `sip_sync_profile`):

- `username` (unique, stored lowercase)
- `email` (unique, stored lowercase)
- `phoneNumber` (unique)
- `firstName`, `lastName`

Roles live in `user_role_membership` (`customer`, `owner`, `employee`, `backoffice`). Serverpod scopes (`sip.customer`, `sip.owner`, `sip.employee`, `sip.backoffice`, `sip.backoffice.admin`) are kept in sync with those memberships so endpoints can use `requiredScopes`.

Backoffice extras (`backoffice_staff`):

- `isAdmin` — platform operator who can add/remove other backoffice users
- `isSystemDefault` — the seeded account; it cannot be deleted

Employee extras (`employee_record`): links an employee identity to the owner who added them. Building assignments come later.

## Actors and permissions

- **Customer** — self-register or log in on `sip_sync_flutter`. Logging in on that app grants the customer role if it is missing.
- **Owner** — self-register or log in on `managment` (register grants owner). May add employees.
- **Employee** — created by an owner (new account or existing email). Logs in on `managment`.
- **Backoffice user** — added by a backoffice admin (`isAdmin`). Logs in on `backoffice`. Cannot self-register.
- **Default super admin** — created on server start if missing. `isAdmin` and `isSystemDefault` are true. Optional `config/passwords.yaml` keys: `sipSyncDefaultAdminEmail` (default `admin@sipsync.local`) and `sipSyncDefaultAdminPassword` (default `SipSyncAdmin8!`).

## Flow

### New person

1. Fill profile + password in the app they care about (customer or owner).
2. Server creates `AuthUser`, email password, `sip_sync_profile`, and the matching role.
3. Client stores the issued JWT and loads `AccountSessionView`.

### Existing person, another app

1. They register or log in with the **same email** and password.
2. Server authenticates, does not create a second user, and adds the role that app needs (owner on management register; customer on customer login).
3. Username / phone from a later register are ignored if a profile already exists.

### Owner adds an employee

1. If the email is new: create identity + employee role + `employee_record`.
2. If the email already exists: authenticate is not required; attach employee role and record. Profile uniqueness is left as-is.

### Backoffice staff

1. Default admin (or later `isAdmin` users) create a backoffice user with `isAdmin: false`.
2. Delete is allowed only when `isSystemDefault` is false.

### Access denied

Login to `managment` without owner/employee, or to `backoffice` without backoffice membership, returns `appAccessDenied`. Register is the path to become an owner; backoffice is invite-only.

## Data

- Tables: `sip_sync_profile`, `user_role_membership`, `backoffice_staff`, `employee_record` (server-only)
- Create: `SelfRegisterCreate`, `LoginRequest`, `EmployeeCreate`, `BackofficeUserCreate`
- Update: `ProfileUpdate` (username, phone, names; email stays on the identity)
- Responses: `AuthSessionResult` (`AuthSuccess` + `AccountSessionView`), `ProfileView`, `BackofficeUserView`
- Exceptions: `AccountException` with `AccountErrorCode`

Passwords are never stored on Sip Sync tables; they live in the email identity provider.

Signed-in users call `updateMyProfile`. Owners call `getEmployee` for staff they added (see [ops-shell](ops-shell.md) and [employees](employees.md)).

## Realtime

None for auth.
