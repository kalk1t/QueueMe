# API and Event Contracts

## API split

- REST for durable queries/mutations and authorization decisions.
- WebSocket for near-real-time propagation of non-authoritative deltas.
- Provider callbacks are treated as trusted-but-not-authoritative events until validation succeeds.

## REST responsibilities

- All queue mutations:
  - create/modify/cancel entry
  - call next / serve / complete
  - consent capture
  - staff/order operations
- Entitlement and billing transitions:
  - trial requests
  - subscription changes
  - spending limit requests
- Read queries:
  - queue snapshots
  - job status
  - entitlement status
  - audit history

## WebSocket responsibilities

- Broadcast state deltas for queue and status changes.
- Distribute reconciliation hints (`version` changes, snapshot-required flags).
- Not used as source of truth for authorization or mutation validation.

## Version and revision model

- Every queue, queue-entry, location entitlement, and webhook replay-sensitive state has a monotonic revision.
- Mutations can include `if_match_revision` for conflict detection.
- Duplicate command detection uses idempotency key and request fingerprint.

## Error contract

- API returns machine-readable error codes:
  - `AUTH_REQUIRED`, `AUTH_FORBIDDEN`, `NOT_FOUND`
  - `TENANT_SCOPE_MISMATCH`, `LOCATION_SCOPE_MISMATCH`
  - `RETRY_REQUIRED`, `VERSION_CONFLICT`, `CONFLICT`
  - `RATE_LIMITED`, `IDENTITY_EXPIRED`
  - `PROVIDER_TEMPORARY_FAILURE`, `PROVIDER_REJECTED`

## Realtime protocol

- Connect with bearer token + tenant/location subscription list.
- Receive:
  - `snapshot.version`
  - `event.stream_id`
  - `event.sequence`
  - `event_type`
  - `revision`
- Reconnect:
  - provide last received revision
  - request missing events or full snapshot when gap is detected.
- Duplicate tolerance:
  - clients dedupe by event id.

## Event bus and ordering

- Ordering guarantee: per-queue and per-location event ordering is preferred.
- Cross-queue ordering is best-effort.
- Gap recovery: fallback snapshot + missed event list.

## Backpressure and heartbeat

- Idle heartbeat every 20 seconds.
- Event batching under high churn (per-connection queue limits).
- Backpressure by pausing low-priority events and requesting client resync if queue overflow occurs.
