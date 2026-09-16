---
name: sip-sync-l10n-theming
description: Sets up and extends en/ar/fr ARB localization, RTL, text styles, and theme tokens in Sip Sync Flutter apps. Use when adding UI copy, themes, typography, or locale support.
---

# Localization and theming

## Setup (once per app)

`l10n.yaml` in the app root:

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

`pubspec.yaml`: `flutter_localizations`, `intl`, `generate: true`.

`MaterialApp.router`:

- `supportedLocales: [Locale('en'), Locale('ar'), Locale('fr')]`
- `localizationsDelegates` including `AppLocalizations.delegate`

Arabic (`ar`) is RTL. Test row layouts, icons that imply direction, and `Alignment`.

## Copy

```json
{
  "orderReady": "Ready",
  "@orderReady": { "description": "Kitchen ticket status" }
}
```

Use `AppLocalizations.of(context)!`. Never concatenate sentences in code; use ARB placeholders.

## Theme

`lib/core/theme/app_theme.dart` exports `ThemeData light()` / `dark()`.

- `AppColors` → `ColorScheme`
- `AppTextStyles` wired into `textTheme` (display / title / body / label)
- `AppSpacing` (4/8/12/16/24/32)
- Feature widgets: `Theme.of(context).textTheme.titleMedium`, not inline `fontSize: 18`

If the app has no theme yet, pick a distinctive hospitality-appropriate language (see `serverpod-flutter-frontend`) and document tokens in `Docs/architecture.md`.
