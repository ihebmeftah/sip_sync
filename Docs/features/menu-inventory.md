# Menu & inventory

Status: draft

## Apps

`managment` (catalog + stock), `sip_sync_flutter` (menu read for customers), `sip_sync_server`.

## Actors and permissions

- Owner / menu managers: categories, articles, recipes (ingredient composition).
- Kitchen / ops: stock levels, threshold alerts.
- Customers: published menu only.

## Flow

1. Manage categories and articles per building (or shared catalog — decide at implementation).
2. Articles compose ingredients; placing an order deducts stock on the server.
3. Threshold alerts when stock falls below limit.

## Data

Separate create/update for category, article, ingredient. Do not send full recipe graphs on every list response.

## Realtime

Stock updates when orders are placed (invalidate or stream to `managment`).
