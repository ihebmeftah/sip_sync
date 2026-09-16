# Employee management & access control

Status: draft

## Apps

`managment`, `sip_sync_server`. `backoffice` for platform users if required.

## Actors and permissions

- Owner: invite/add staff, assign buildings (later), set permissions (order create, payment, kitchen).
- Employee: own profile; cannot escalate permissions.
- The same email can already be a customer or backoffice user; adding them as employee attaches the employee role to that identity. See [authentication](authentication.md).

## Flow

1. Owner adds employee (email, profile fields, password if the email is new).
2. Server creates or reuses the auth user, assigns the employee role, stores `employee_record` under that owner.
3. Employee signs in on `managment`; routes and endpoints filter by assignment (building scope in a later iteration).
4. Owner opens a staff row on Profile; `getEmployee` returns that `ProfileView` only if the record belongs to the owner.
5. Each person updates their own name/username/phone with `updateMyProfile`.

## Data

`EmployeeCreate` without auth secrets in responses. Passwords are write-only on create for new emails. `ProfileView` is the read model for self and for an owner’s staff.

## Realtime

Optional presence later; not in first version.
