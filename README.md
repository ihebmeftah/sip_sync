# Sip Sync

Sip Sync is a full-stack platform for cafés, restaurants, lounges, and bars. One [Serverpod](https://serverpod.dev) backend serves three Flutter apps: customers discover a venue and order, owners and staff run the floor, and a platform admin runs the network.

The backend is Serverpod with PostgreSQL, custom auth, and permission checks on every endpoint. The Flutter apps talk to the generated Serverpod client. Domain ids are UUIDs. The live demo is deployed on [Serverpod Cloud](https://docs.serverpod.dev/cloud).

## Live demo

| App | Who | URL |
| --- | --- | --- |
| Customer | Guests | https://sipsync.serverpod.space/ |
| Management | Owners and staff | https://sipsync.serverpod.space/managment/ |
| Backoffice | Platform admin | https://sipsync.serverpod.space/backoffice/ |
| API | Serverpod | https://sipsync.api.serverpod.space/ |

Open the customer and management apps side by side. Place an order as a customer, then complete it as the venue owner.

## Test accounts

The server seeds these accounts on boot when they are missing. Every owner password is `password1`.

### Venue owners (management app)

Sign in at https://sipsync.serverpod.space/managment/

| Email | Password | Venue |
| --- | --- | --- |
| `owner.tn.01@sipsync.dev` | `password1` | Restaurant Café Seles, Sousse |
| `owner.tn.02@sipsync.dev` … `owner.tn.14@sipsync.dev` | `password1` | Venues in Sousse, Tunis, and Hammamet |
| `owner.se.01@sipsync.dev` … `owner.se.06@sipsync.dev` | `password1` | Venues in Stockholm |
| `owner.de.01@sipsync.dev` … `owner.de.10@sipsync.dev` | `password1` | Venues in Marburg, Frankfurt, and Gießen |

Each owner has one venue on the free plan, a full menu (ten categories, five to ten dishes each), ingredient stock, and tables. Start with `owner.tn.01@sipsync.dev`.

### Platform admin (backoffice)

Sign in at https://sipsync.serverpod.space/backoffice/

| Email | Password |
| --- | --- |
| `admin@sipsync.local` | `SipSyncAdmin8!` |

A local `passwords.yaml` or `SERVERPOD_PASSWORD_sipSyncDefaultAdminEmail` replaces this pair. See [Secrets](#secrets).

### Customers

There is no seeded customer. On https://sipsync.serverpod.space/ register any email and password, then search a city such as Sousse, Tunis, Stockholm, or Frankfurt. The map lists the seeded venues nearest that place.

Staff accounts are created by an owner inside a venue. They are not pre-seeded.

## What it does

- **Discover.** A customer picks a place and sees nearby venues on a list and a map, with hours, distance, menu, and free tables.
- **Order.** The customer builds a cart from the live menu and sends the order to the venue. Staff move it through the floor until it is paid. Stock drops from each dish’s recipe.
- **Run the venue.** The owner manages the building, menu and inventory, tables, employees and what each role may do, reservations, the cash register, and today’s dashboard.
- **Run the platform.** Backoffice lists venues, owners, customers, and commercial packs. A new venue starts on the free plan.

The full write-up of every feature is the [docs index](Docs/README.md). Product shape is in the [overview](Docs/product-overview.md). How the apps and server fit together is in [architecture](Docs/architecture.md).

| Feature | Doc |
| --- | --- |
| Authentication and identities | [authentication](Docs/features/authentication.md) |
| Backoffice console | [backoffice-console](Docs/features/backoffice-console.md) |
| Operations shell | [ops-shell](Docs/features/ops-shell.md) |
| Buildings | [buildings](Docs/features/buildings.md) |
| Customer discovery | [customer-discovery](Docs/features/customer-discovery.md) |
| Employees | [employees](Docs/features/employees.md) |
| Employee access profiles | [employee-access](Docs/features/employee-access.md) |
| Floor tables | [tables](Docs/features/tables.md) |
| Table QR | [table-qr](Docs/features/table-qr.md) |
| Menu and inventory | [menu-inventory](Docs/features/menu-inventory.md) |
| Orders | [orders](Docs/features/orders.md) |
| Cash register | [cash-register](Docs/features/cash-register.md) |
| Reservations | [reservations](Docs/features/reservations.md) |
| Dashboard | [dashboard](Docs/features/dashboard.md) |
| Statistics | [statistics](Docs/features/statistics.md) |
| Notifications | [notifications](Docs/features/notifications.md) |
| Packs | [packs](Docs/features/packs.md) |

## Run locally

### Requirements

- [Flutter](https://docs.flutter.dev/get-started/install) 3.44 or newer, with Dart 3.12.2 or newer (`flutter --version`).
- The Serverpod CLI on your `PATH`:

```bash
dart pub global activate serverpod_cli
```

Docker is not required. `config/development.yaml` sets `database.dataPath`, so `serverpod start` launches an embedded PostgreSQL under `sip_sync_server/.serverpod/development/pgdata`. Redis is off. Place search calls Nominatim over HTTPS; no API key.

### Secrets

`sip_sync_server/config/passwords.yaml` is gitignored. Create it once. The database password below is the development password already in `sip_sync_server/docker-compose.yaml`.

```yaml
development:
  database: 'DrbAj3wCWvAKB3vRw0rqHcXg4NKBTDqo'
  serviceSecret: 'replace-with-any-long-random-string'
```

The same two values can be environment variables instead of the file:

```bash
export SERVERPOD_DATABASE_PASSWORD='DrbAj3wCWvAKB3vRw0rqHcXg4NKBTDqo'
export SERVERPOD_SERVICE_SECRET='replace-with-any-long-random-string'
```

Optional. When unset, the seeded platform admin is `admin@sipsync.local` / `SipSyncAdmin8!`.

```bash
export SERVERPOD_PASSWORD_sipSyncDefaultAdminEmail='admin@sipsync.local'
export SERVERPOD_PASSWORD_sipSyncDefaultAdminPassword='SipSyncAdmin8!'
```

Any `passwords.yaml` key can also be set as `SERVERPOD_PASSWORD_<key>`.

### Start

From `sip_sync_server`:

```bash
cd sip_sync_server
dart pub get
serverpod start
```

`serverpod start` boots the API and the three Flutter apps:

| App | Local URL |
| --- | --- |
| Customer | http://localhost:8090 |
| Management | http://localhost:8091 |
| Backoffice | http://localhost:8092 |
| API | http://localhost:8080 |

Web and the iOS Simulator use `http://localhost:8080` from each app’s bundled config. A physical phone does not: `localhost` is the phone. Run the customer or management app with your computer’s LAN address (same Wi-Fi):

```bash
flutter run --dart-define=SERVER_URL=http://192.168.0.10:8080
```

Replace the address with yours (`ipconfig getifaddr en0` on macOS). Android debug and iOS local-network HTTP are already allowed in the project.

The same test accounts above are created on first boot. To load them again, stop the server, delete `sip_sync_server/.serverpod/development/pgdata`, and run `serverpod start`.
