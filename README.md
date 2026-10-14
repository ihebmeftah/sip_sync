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

### Customers

There is no seeded customer. On https://sipsync.serverpod.space/ register any email and password, then search a city such as Sousse, Tunis, Stockholm, or Frankfurt. The map lists the seeded venues nearest that place.

Staff accounts are created by an owner inside a venue. They are not pre-seeded.

## What it does

- **Discover.** A customer picks a place and sees nearby venues on a list and a map, with hours, distance, menu, and free tables.
- **Order.** The customer builds a cart from the live menu and sends the order to the venue. Staff move it through the floor until it is paid. Stock drops from each dish’s recipe.
- **Run the venue.** The owner manages the building, menu and inventory, tables, employees and what each role may do, reservations, the cash register, and today’s dashboard.
- **Run the platform.** Backoffice lists venues, owners, customers, and commercial packs. A new venue starts on the free plan.

## Run locally

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

The same test accounts above are created on first boot. To load them again, stop the server, delete `sip_sync_server/.serverpod/development/pgdata`, and run `serverpod start`.

Feature detail lives in [Docs/](Docs/README.md).
