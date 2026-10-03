# Architecture

## Stack

- Backend: Serverpod (`sip_sync_server`) + generated `sip_sync_client`
- Flutter: MVVM, Riverpod + `riverpod_generator`, go_router + `go_router_builder`, `build_runner`
- DI: Riverpod in widgets; GetIt for Serverpod `Client` and repositories used outside the tree (e.g. router `redirect`)
- i18n: ARB English, Arabic (RTL), French
- Auth: Serverpod email identity plus Sip Sync profile/roles (`Docs/features/authentication.md`)
- IDs: `UuidValue` everywhere (tables: `defaultPersist=random_v7`). Auth users already use UUID. Flutter route params are UUID strings → `UuidValue.fromString`.

## Layers (each Flutter app)

```
View (widgets) → ViewModel (Riverpod) → Repository → sip_sync_client → Endpoint
```

Business rules and permissions live on the server. Views do not call the client.

## Shared vs per-app

Reusable widgets, theme, and routing helpers live under that app's `lib/core/`. Do not create a fourth Flutter package until a real shared UI need appears (today the three apps have different audiences and visual languages).

## Visual language

Each Flutter app extends its own tokens in `lib/core/theme/` (`AppColors`, `AppSpacing`, `AppRadii`, `AppBreakpoints`) and a full `ThemeData` (type, fields, buttons, chips, cards). Layouts switch at `840` dp: split hero + form (auth) or two-column dashboards (home). The backoffice console switches to its sidebar at `960` dp. Forms cap at `440` dp so they do not stretch on web.

| App | Audience | Palette | Type |
| --- | --- | --- | --- |
| `sip_sync_flutter` | customers | daylight paper, apricot, clay, moss; light until a theme switch | Fraunces + Figtree, Google Material Symbols (rounded) |
| `managment` | owners / staff | olive, sage, sand, parchment (same family in light/dark) | Syne + IBM Plex Sans |
| `backoffice` | super admin | light zinc canvas, white cards, ink primary (shadcn/ui). Dark scheme is defined and not switched on yet | Geist (bundled with shadcn_ui) |

Auth uses `AuthShell` (wide split / compact stack). Signed-in `managment` uses `OpsShell` (olive rail / compact drawer). Signed-in `backoffice` uses `ConsoleShell`: a light shadcn sidebar (Stats, Users, Customers, Buildings, Packs) and a zinc canvas. Stats, Customers, and Packs are placeholders until those features exist. After login the user must pick a **building**; dashboard, employees, products, POS, and tables stay locked until then. Forms use `TextFormField` validators (`FormValidators`) plus server errors. On the customer app, a failure that belongs to one field (email taken, phone taken, weak password) is drawn on that field and scrolled into view; other failures use `AppFormMessage`. Primary actions are `AppFilledButton` (full width, spinner while busy) and secondary actions are `AppTonalButton`. Arabic is RTL via `MaterialApp` locales. Management selects light or dark with `ThemeController`. Backoffice stays on the light shadcn scheme until a theme switch is added; `AppTheme.shadDark` is already defined. The customer app stays on the light scheme until a theme switch is added; `AppTheme.dark` is already defined.

## Local development on a physical phone

Bundled `assets/config.json` uses `http://localhost:8080`. That works for Flutter **web** and **iOS Simulator**. On a **physical** iOS/Android device, `localhost` is the phone itself — login fails with a network error.

1. Mac and phone on the same Wi‑Fi.
2. Find the Mac LAN IP (e.g. `ipconfig getifaddr en0` → `192.168.0.67`).
3. Run the management app with an override (full rebuild, not just hot reload):

```bash
cd managment
flutter run --dart-define=SERVER_URL=http://192.168.0.67:8080
```

Replace the IP with yours. Keep `serverpod start` (or the API on `:8080`) running on the Mac.

iOS also needs local-network HTTP (`NSAllowsLocalNetworking` in `Info.plist`); Android debug allows cleartext HTTP.

## Security

- Endpoints: `requireLogin`, Sip Sync scopes (`sip.owner`, `sip.employee`, `sip.backoffice`, …), building membership
- One `AuthUser` per person; apps attach roles instead of duplicating accounts
- Routes: go_router `redirect` for UX
- DTOs: narrow create/update/view models under each feature’s `dtos/`; table models under `entity/`; ids are UUID

## Agent conventions

See `AGENTS.md`, `.cursor/rules/`, and `.cursor/skills/sip-sync-*`.
