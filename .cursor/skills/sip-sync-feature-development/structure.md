# Folder structure

## Flutter app (`managment`, `sip_sync_flutter`, `backoffice`)

```
lib/
  main.dart
  app.dart
  core/
    di/             # GetIt service_locator (Client, repositories)
    theme/          # ColorScheme, TextTheme, spacing tokens
    l10n/           # app_en.arb, app_ar.arb, app_fr.arb
    routing/        # TypedGoRoute, GoRouter, redirects
    widgets/        # buttons, app bars, empty/error/loading
    errors/         # Failure types, mapping to l10n
  data/
    services/       # thin wrappers around sip_sync_client
    repositories/
  domain/
    models/         # app-facing immutable models
    use_cases/      # optional
  features/
    <feature>/
      views/
      view_models/
      providers/
```

## Server (`sip_sync_server/lib`)

```
lib/
  server.dart
  src/
    <feature>/
      entity/                 # table models (*.spy.yaml with table:)
      dtos/                   # Create / Update / View / Exception / enums
      <feature>_endpoint.dart
      <feature>_service.dart  # optional domain service
```

Group by feature. Put persisted models in `entity/`, protocol-only types in `dtos/`. Keep endpoints and services at the feature root. Never edit `lib/src/generated/` or `sip_sync_client`.
