# Real-time notifications

Status: draft

## Apps

`managment` (kitchen/floor), `sip_sync_server` streams. Customer push later if needed.

## Actors and permissions

Configurable per employee access: new order alerts, status updates. No notification if the user cannot see that order.

## Flow

1. Order created → kitchen subscribers for that building.
2. Status change → relevant roles.
3. Client uses Serverpod streams (and later device push if added).

## Data

Small event payloads (ids + status), not full entities. Client refetches or applies a patch.

## Realtime

Primary delivery mechanism for this feature.
