# Customer discovery

Status: in progress

## Apps

`sip_sync_server`, `sip_sync_flutter`.

## Actors and permissions

- **Customer** — after sign-in, lists every venue as a public card and looks up a place (typed address or device coordinates).
- **Owner, employee, super admin** — rejected on these endpoints (`AccountException` / not authorized). Venue create and ops fields stay on `BuildingEndpoint`.
- The card omits owner id, staff, social links, and order-pipeline flags.

## Flow

1. First launch while signed out shows onboarding once (`shared_preferences`). Skip and Get started both mark it done and open sign-in. A customer who already has a session skips onboarding.
2. Sign-in or register success opens home.
3. Home asks for a place: type an address (suggestions) or use the device position. The chosen label stays in the place bar.
4. Venues sort nearest first. Default filter is 15 km, with a control to show every venue. Each row shows name, type, address, distance in km, and an approximate walk time (straight line at 4.8 km/h, not a road route).
5. The same screen switches to an OpenStreetMap view (public OSM tiles plus attribution). The user’s place and each venue are marked. Selecting a card or marker shows that venue. No menu or order in this flow.

Address search and reverse geocoding go through the server, which calls Nominatim. The browser cannot call Nominatim directly (CORS). The client waits about half a second between searches.

## Data

- No new tables. Reads `building`.
- `CustomerVenueCard`: id, name, type, address, latitude, longitude, opening and closing minutes, phone.
- `PlaceHit`: label, latitude, longitude.
- Endpoints: `CustomerVenue.list`, `CustomerPlace.search`, `CustomerPlace.reverse`.
- Exceptions: `PlaceException` (`invalidInput`, `lookupFailed`, `notFound`). Auth failures use `AccountException`.

## Realtime

None.
