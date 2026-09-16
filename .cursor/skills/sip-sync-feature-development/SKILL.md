---
name: sip-sync-feature-development
description: End-to-end Sip Sync feature workflow across Serverpod and the three Flutter apps (managment, sip_sync_flutter, backoffice). Use when adding or changing a product feature, endpoint, screen, or domain module.
---

# Sip Sync feature development

Implement **server → docs → client app(s)** in that order. Do not start UI before the contract (`.spy.yaml` + endpoint) is defined.

Copy and track:

```
- [ ] Docs/features/<feature>.md (actors, flow, permissions)
- [ ] Protocol DTOs (Create/Update/Response) — no over-fetch
- [ ] Table models + migration if needed
- [ ] Endpoint: requireLogin, scopes, building membership
- [ ] Server tests (`dart test` in sip_sync_server)
- [ ] Flutter: GetIt singleton if needed → `@riverpod` repository/ViewModel → view
- [ ] Typed `@TypedGoRoute` + `$appRoutes`, then `dart run build_runner build --delete-conflicting-outputs`
- [ ] go_router guards + ARB strings (en/ar/fr)
- [ ] dartdoc on public APIs
- [ ] analyze, format, MCP migrate/hot_restart as in AGENTS.md
```

## Which app?

| Actor | Package |
| --- | --- |
| Owner / employee | `managment` |
| Customer | `sip_sync_flutter` |
| Super admin | `backoffice` |
| Shared API | `sip_sync_server` |

Never duplicate business rules in the UI that the server must enforce.

## Patterns

- SOLID: one class, one reason to change; depend on repositories/providers not concrete widgets
- Repository between Serverpod client and ViewModels
- Result-style errors mapped to user-facing l10n keys
- Streams for kitchen / order status (Serverpod streams), not polling loops

## Skills to follow

- [sip-sync-mvvm-riverpod](../sip-sync-mvvm-riverpod/SKILL.md)
- [sip-sync-security-and-errors](../sip-sync-security-and-errors/SKILL.md)
- [sip-sync-l10n-theming](../sip-sync-l10n-theming/SKILL.md)
- [sip-sync-docs](../sip-sync-docs/SKILL.md)

Folder trees: [structure.md](structure.md)
