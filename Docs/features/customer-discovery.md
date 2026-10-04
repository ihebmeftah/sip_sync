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
3. Home asks for a place: type an address (suggestions) or tap the location icon at the end of that field. The chosen label stays in the place bar.
4. Venues sort nearest first on the server (straight-line distance). Default filter is 15 km, with a control to show every venue. The first page is 20 cards; scrolling loads the next page. Each card shows a type icon, name, localized type, address, hours, distance in km, and an approximate walk time (straight line at 4.8 km/h, not a road route). The list fills the space under the place bar. On a short window the page scrolls and the list keeps a fixed height so the header never overflows. The map shows the venues loaded so far.
5. On a narrow window the same screen switches to an OpenStreetMap view (public OSM tiles plus attribution). From 840 dp wide, the list and the map sit side by side. The user’s place and each venue are marked. A marker shows that venue in a card along the bottom edge, so the map stays visible. Tapping a list card, or that map card, opens the venue page.
6. The venue page shows the public card fields, how many tables are free, and those tables by number and seats. The free-table band is green. Up to five categories and five articles follow, in a short row. Ranking uses non-cancelled lines on non-cancelled orders. A house with no orders yet shows the first five in catalog order. Each row ends with See all, and a Menu button does the same: the menu, with a category rail whose labels are centered. The rail lists every category. Dishes load 20 at a time in catalog order; scrolling loads the next window, and tapping a category loads forward until that category is on screen. Empty categories stay so the catalog shape stays visible. Articles list ingredient names as `Mint . Lemon` when the recipe has lines, and a photo slot is reserved until images exist.
7. On the menu, **+** and **−** build a selection. A bar at the bottom shows the count and preview total. **Pass order** opens the review: dishes, prices, and the scanned table. With no table for this venue, the review asks for a QR scan and returns here. **Pass order** then sends the cart. The receipt shows the ticket number, table, and server prices. See [orders](orders.md).
8. **Scan table** sits at the bottom of the buildings screen. A valid sticker (`sipsync:table:v1:…`) is checked on the server, then the venue page opens with that table marked as the seat, including when the table is already occupied. An inactive, unknown, or mismatched code stays on the camera with an error. The venue page can scan again to change the seat; a successful change shows a snackbar. The seat lasts for the app session and is the table used when the customer passes an order. While that customer has an order in progress, scan is disabled. The buildings list and map stay on screen. Past orders stay on **Order history**. See [orders](orders.md).

Address search and reverse geocoding go through the server, which calls Nominatim. The browser cannot call Nominatim directly (CORS). The client waits about half a second between searches.

## Data

- No new tables. Reads `building`, active `venue_table` rows, `menu_category`, `menu_article`, `article_composition`, `ingredient` names, and non-cancelled `venue_order` / `venue_order_item` rows.
- A table is free when it is active and no order in progress is seated there. Inactive tables are not free. The list is number and seats only.
- Ingredient names are recipe order. Quantities, units, and stock stay off this API.
- `CustomerVenueCard`: id, name, type, address, latitude, longitude, opening and closing minutes, phone.
- `CustomerVenueDetail`: that card, currency, free-table count and list, up to five categories (with article count), up to five articles (with price and ingredient names).
- `CustomerMenu`: currency, every category (with article count), and one page of articles in catalog order (`limit`, `offset`, `totalArticles`). Empty categories stay on the rail.
- `CustomerVenuePage`: one page of `CustomerVenueCard` plus `total`, `limit`, and `offset`. With a place, the server orders by distance and can keep only venues within 15 km.
- `PlaceHit`: label, latitude, longitude.
- `CustomerSeatedTable`: building id, table id, number, seats, venue name. Returned only after the sticker matches an active table.
- Endpoints: `CustomerVenue.list`, `CustomerVenue.detail`, `CustomerVenue.menu`, `CustomerVenue.resolveTable`, `CustomerPlace.search`, `CustomerPlace.reverse`.
- A missing building is `BuildingException` / `notFound`. Auth failures use `AccountException`. Place failures use `PlaceException` (`invalidInput`, `lookupFailed`, `notFound`).

## Realtime

None.
