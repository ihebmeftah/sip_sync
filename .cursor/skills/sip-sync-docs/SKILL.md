---
name: sip-sync-docs
description: Writes dartdoc and Docs/ feature pages for Sip Sync. Use when adding a feature, changing a flow, or the user asks for documentation.
---

# Documentation

## Feature page template

Create `Docs/features/<kebab-name>.md`:

```markdown
# <Feature name>

Status: draft | in progress | stable

## Apps
Which of managment / sip_sync_flutter / backoffice / server.

## Actors and permissions
Who can do what, per building.

## Flow
Step-by-step (happy path + key errors).

## Data
Tables, create/update DTOs, what the client receives.

## Realtime
Streams / notifications if any.
```

Add a row to `Docs/README.md`.

## Code

```dart
/// Creates an order in [buildingId] for the authenticated employee.
///
/// Rejects if the cash register is required and no session is open.
Future<OrderView> create(Session session, OrderCreate request) async { ... }
```

Do not duplicate the full feature spec in comments — link conceptually to `Docs/features/...` and keep comments local to invariants.
