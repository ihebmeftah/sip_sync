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

Passwords are hashed (**bcrypt**) on the actor row (`passwordHash`). Sessions are opaque bearer tokens stored hashed in `auth_session` (`tokenHash`, optional `refreshTokenHash`, `actorType`, `actorId`, expiry).

Phone numbers for owners, employees, customers, and venues are stored in **E.164** (`+216…`). Server validation requires a known country dial code.

## Domain links

- Owner **has many** buildings (`building.ownerId`).
- Building **has many** employees (`employee.buildingId`).
- Employee **belongs to one** building (and that building’s owner via `employee.ownerId`).

## Actors and permissions

- **Customer** — self-register / login on `sip_sync_flutter`.
- **Owner** — self-register / login on `managment`; manages buildings and staff.
- **Employee** — created by an owner for a building; logs in on `managment` with username; session includes `buildingId` → app opens dashboard directly.
- **Super admin** — seeded default + staff added by an admin; logs in on `backoffice`. Default admin cannot be deleted or disabled. A disabled admin cannot sign in (`accountDisabled`); disabling revokes their sessions. An admin cannot disable their own account. See [backoffice console](backoffice-console.md).

## Local demo seed

On development server boot, if `owner1@sipsync.dev` is missing, [DevSeed](../../sip_sync_server/lib/src/seed/dev_seed.dart) creates five owners (idempotent). Every password is `password1`. Venues sit around Greater Tunis so the customer map can rank them.

| Email | Building |
| --- | --- |
| `owner1@sipsync.dev` | Olive Café (Tunis) and Olive Café Carthage — coffee, pastries, breakfast |
| `owner2@sipsync.dev` | Harbor Lounge, La Marsa — cocktails and snacks |
| `owner3@sipsync.dev` | Dar El Medina — grills, salads, desserts |
| `owner4@sipsync.dev` | Lac Social, Berges du Lac — drinks and bar bites |
| `owner5@sipsync.dev` | Café des Nattes, Sidi Bou Said — tea and sweets |

Each venue has categories, articles, ingredient stock, recipes, and tables.

Wipe `.serverpod/development/pgdata` then `serverpod start` to reset and re-seed.

## Flow

### Owner or customer register

1. Email, password, phone, names. The customer app collects a country dial code (default Tunisia, `+216`) and a national number, then sends E.164. Sign-in and register validate before the request. A physical phone must be launched with `--dart-define=SERVER_URL=http://<lan-ip>:8080` so the app does not call `localhost`.
2. Server hashes password, inserts actor row, creates `auth_session`, returns token + session view.

### Employee create (owner)

1. Building must exist and be owned by the actor.
2. Password, phone, names, required `buildingId` — no email/username from client.
3. Server allocates username, hashes password, inserts `employee`.

### Login

- Owner / customer / super admin: email + password on their endpoint.
- Employee: username + password on `EmployeeAuth.login`.
- Disabled employee → `accountDisabled`.
- Disabled super admin → `accountDisabled`.

### Change password (authenticated)

- Owner: `OwnerAuth.changePassword` — verify current, set new, revoke other sessions for that actor.
- Employee: `EmployeeAuth.changePassword` — same.
- Management **Profile** screen exposes current / new / confirm fields.

### Forgot password (owner)

1. Sign-in → **Forgot password?** (owners only). Employees see “ask your manager”.
2. `OwnerAuth.requestPasswordReset(email)` — always succeeds (no enumeration). If an owner exists, stores a hashed 6-digit OTP for 15 minutes (`password_reset` table).
3. Until SMTP exists, the OTP is **logged** on the server and returned as `debugCode` in **development/test** only (shown in the UI for local demos).
4. `OwnerAuth.confirmPasswordReset(email, code, newPassword)` — verifies OTP, updates hash, revokes **all** owner sessions.

### Authenticated calls

Client sends `Authorization: Bearer <token>`. Endpoints resolve the session via `AuthGuard` (not Serverpod `session.authenticated`).

## Data

- Tables: `owner`, `customer`, `super_admin`, `employee`, `auth_session`, `password_reset`, `building`
- Endpoints: `OwnerAuth`, `EmployeeAuth`, `CustomerAuth`, `SuperAdminAuth`, `Employee`, `Building`
- Results: `AuthTokenResult` + actor-specific session views; `PasswordResetRequestResult`
- Exceptions: `AccountException` / `AccountErrorCode` (includes `invalidResetCode`, `resetCodeExpired`)

## Realtime

None for auth.
