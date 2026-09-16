---
name: sip-sync-security-and-errors
description: Protects Serverpod endpoints and Flutter routes, DTO hygiene, and consistent error handling. Use when adding endpoints, auth scopes, create/update models, or mapping failures to the UI.
---

# Security, DTOs, errors

## Endpoint

```dart
class OrderEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<OrderView> create(Session session, OrderCreate request) async {
    final userId = session.authenticated?.authUserId;
    if (userId == null) {
      throw NotAuthorizedException();
    }
    await ensureCanCreateOrder(session, userId, request.buildingId);
    // persist using table models, return OrderView
  }
}
```

- Resolve the actor from the session, never from a client-supplied `userId` unless it is an admin acting on someone else **and** that is authorized
- Building-scoped: employee must be assigned to that building
- Customer: only own orders
- Super admin (`backoffice`): platform-wide, still audit-log sensitive actions

## DTO rules

| Type | Contains |
| --- | --- |
| `*Create` | Required fields to create; no id, no timestamps, no derived totals the server must compute |
| `*Update` | Optional fields + id; never send "set this to the same as GET" blobs of secrets |
| `*View` / response | Display + ids needed by the client; no password hashes, tokens, unused relations |

Prefer Serverpod `Exception` types for expected failures (`NotFound`, `NotAuthorized`, `Validation`).

## Flutter errors

Map exceptions → `Failure` → ARB key. Show `core/widgets` error views. Log details; do not `toString()` exceptions into the UI.

## go_router

Redirect unauthenticated users. Hide routes the role cannot use. If the user pastes a URL, the **endpoint** still rejects.
