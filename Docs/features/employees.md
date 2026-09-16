# Employee management & access control

Status: draft

## Apps

`managment`, `sip_sync_server`. `backoffice` for platform users if required.

## Actors and permissions

- Owner: invite/add staff, assign buildings, set permissions (order create, payment, kitchen).
- Employee: own profile; cannot escalate permissions.
- Automated employee email from building name (server-generated, unique).

## Flow

1. Owner adds employee with role + building assignments.
2. Server creates auth user, generates email, assigns scopes.
3. Employee signs in; routes and endpoints filter by assignment.

## Data

`EmployeeCreate` / `EmployeeUpdate` without auth secrets. Responses omit password hashes and reset tokens.

## Realtime

Optional presence later; not in first version.
