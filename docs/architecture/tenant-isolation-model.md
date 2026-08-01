# Tenant and Location Isolation Model

## Core principle

QueueMe enforces isolation at organization and location scope in every data access and operation path.

## Ownership graph

- Organization owns one or more locations.
- Location owns queues, queue entries, staff assignments, subscriptions, consent evidence, and numbers.
- Queue-entry ownership is by location.
- Provider events are correlated by location and request lineage.

## Defense in depth

- Authentication establishes user/session.
- Authorization checks require organization and location scope.
- Query scoping by location/org is mandatory in all write/read paths.
- Composite keys enforce tenant boundaries in database and cache.
- Every Redis key is namespaced by location and tenant.

## Security controls

- Role assignment matrix enforced per endpoint.
- Explicit session-scoped revocation with active token invalidation.
- Cross-tenant negative testing required for each high-risk mutation.
- Device/device-role matrix is validated on every command.

## Database constraints

- `org_id` and `location_id` are required and non-null on tenant-scoped tables.
- `location_id` scope required for queue, billing, consent, messaging, and audit references.
- Partial indexes for active/queued resources include `org_id, location_id`.

## Runtime scoping

- API resolves and freezes scope at request start.
- Jobs propagate tenant scope in payloads and validate before execution.
- Realtime subscription checks only requested and allowed location set.

## Event scoping

- Event messages include `org_id`, `location_id`, and revision.
- Subscription lists for websocket require explicit location allowlist.
- Provider callback correlation IDs map to tenant location.

## Prohibited patterns

- Client-supplied org/location IDs are never trusted alone.
- Scope is never inferred from client path parameters without auth context.
- Global queries are forbidden unless scoped by explicit system admin authorization.
*** End Patch
