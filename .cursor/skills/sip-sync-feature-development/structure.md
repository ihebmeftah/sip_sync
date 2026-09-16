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
    auth/
    <feature>/
      <feature>.spy.yaml          # tables + protocol types
      <feature>_endpoint.dart
      <feature>_service.dart      # optional domain service
```

Group by feature, not by "all endpoints in one file". Keep generated code untouched.
