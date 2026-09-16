# Architecture

## Stack

- Backend: Serverpod (`sip_sync_server`) + generated `sip_sync_client`
- Flutter: MVVM, Riverpod + `riverpod_generator`, go_router + `go_router_builder`, `build_runner`
- DI: Riverpod in widgets; GetIt for Serverpod `Client` and repositories used outside the tree (e.g. router `redirect`)
- i18n: ARB English, Arabic (RTL), French
- Auth: Serverpod email identity plus Sip Sync profile/roles (`Docs/features/authentication.md`)

## Layers (each Flutter app)

```
View (widgets) → ViewModel (Riverpod) → Repository → sip_sync_client → Endpoint
```

Business rules and permissions live on the server. Views do not call the client.

## Shared vs per-app

Reusable widgets, theme, and routing helpers live under that app's `lib/core/`. Do not create a fourth Flutter package until a real shared UI need appears (today the three apps have different audiences and visual languages).

## Security

- Endpoints: `requireLogin`, Sip Sync scopes (`sip.owner`, `sip.employee`, `sip.backoffice`, …), building membership
- One `AuthUser` per person; apps attach roles instead of duplicating accounts
- Routes: go_router `redirect` for UX
- DTOs: narrow create/update/view models

## Agent conventions

See `AGENTS.md`, `.cursor/rules/`, and `.cursor/skills/sip-sync-*`.
