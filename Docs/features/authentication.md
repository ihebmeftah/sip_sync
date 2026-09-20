# Authentication and identities

Status: in progress

## Apps

All three clients plus `sip_sync_server`.

| App | Package | Who may enter |
| --- | --- | --- |
| Customer | `sip_sync_flutter` | Customer account |
| Operations | `managment` | Owner or employee account |
| Platform admin | `backoffice` | Super admin account |

## Identity model

**Fully custom auth.** Product login does **not** use Serverpod email IDP or `AuthUser`. Each actor type has its own table, password hash, and auth endpoint. The same email may exist as both owner and customer as **unrelated** rows.

| Actor | Table | Signs in with | Self-register |
| --- | --- | --- | --- |
| Customer | `customer` | email + password | yes (`CustomerAuth`) |
| Owner | `owner` | email + password | yes (`OwnerAuth`) |
| Employee | `employee` | username + password | no — owner creates |
| Super admin | `super_admin` | email + password | no — admin invites / seed |

Passwords are hashed (Argon2id) on the actor row (`passwordHash`). Sessions are opaque bearer tokens stored hashed in `auth_session` (`tokenHash`, optional `refreshTokenHash`, `actorType`, `actorId`, expiry).

## Domain links

- Owner **has many** buildings (`building.ownerId`).
- Building **has many** employees (`employee.buildingId`).
- Employee **belongs to one** building (and that building’s owner via `employee.ownerId`).

## Actors and permissions

- **Customer** — self-register / login on `sip_sync_flutter`.
- **Owner** — self-register / login on `managment`; manages buildings and staff.
- **Employee** — created by an owner for a building; logs in on `managment` with username; session includes `buildingId` → app opens dashboard directly.
- **Super admin** — seeded default + staff added by an admin; logs in on `backoffice`. Default admin cannot be deleted.

## Local demo seed

On development server boot, if `owner1@sipsync.dev` is missing, [DevSeed](../../sip_sync_server/lib/src/seed/dev_seed.dart) creates two owners (idempotent):

| Email | Password | Building |
| --- | --- | --- |
| `owner1@sipsync.dev` | `password1` | Olive Café — Coffee + Pastries, ingredients, compositions, 6 tables |
| `owner2@sipsync.dev` | `password1` | Harbor Lounge — Cocktails + Snacks, ingredients, compositions, 8 tables |

Wipe `.serverpod/development/pgdata` then `serverpod start` to reset and re-seed.

## Flow

### Owner or customer register

1. Email, password, phone, names.
2. Server hashes password, inserts actor row, creates `auth_session`, returns token + session view.

### Employee create (owner)

1. Building must exist and be owned by the actor.
2. Password, phone, names, required `buildingId` — no email/username from client.
3. Server allocates username, hashes password, inserts `employee`.

### Login

- Owner / customer / super admin: email + password on their endpoint.
- Employee: username + password on `EmployeeAuth.login`.
- Disabled employee → `accountDisabled`.

### Authenticated calls

Client sends `Authorization: Bearer <token>`. Endpoints resolve the session via `AuthGuard` (not Serverpod `session.authenticated`).

## Data

- Tables: `owner`, `customer`, `super_admin`, `employee`, `auth_session`, `building`
- Endpoints: `OwnerAuth`, `EmployeeAuth`, `CustomerAuth`, `SuperAdminAuth`, `Employee`, `Building`
- Results: `AuthTokenResult` + actor-specific session views
- Exceptions: `AccountException` / `AccountErrorCode`

## Realtime

None for auth.
