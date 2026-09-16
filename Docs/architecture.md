# Architecture

## Stack

- Backend: Serverpod (`sip_sync_server`) + generated `sip_sync_client`
- Flutter: MVVM, Riverpod, go_router
- i18n: ARB English, Arabic (RTL), French
- Auth: Serverpod built-in identity (`lib/server.dart`)

## Layers (each Flutter app)

```
View (widgets) → ViewModel (Riverpod) → Repository → sip_sync_client → Endpoint
```

Business rules and permissions live on the server. Views do not call the client.

## Shared vs per-app

Reusable widgets, theme, and routing helpers live under that app's `lib/core/`. Do not create a fourth Flutter package until a real shared UI need appears (today the three apps have different audiences and visual languages).

## Security

- Endpoints: `requireLogin`, scopes, building membership
- Routes: go_router `redirect` for UX
- DTOs: narrow create/update/view models

## Agent conventions

See `AGENTS.md`, `.cursor/rules/`, and `.cursor/skills/sip-sync-*`.
