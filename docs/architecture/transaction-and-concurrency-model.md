# Transaction and Concurrency Model

## Objective

Provide atomic, deterministic, and auditable queue mutation behavior when multiple operators act concurrently.

## Primary conflict scenarios

- Multiple staff devices calling `call next` on same queue.
- Parallel state edits on same queue entry.
- Manual reorder while transitions occur.
- Repeated submission from flaky networks.
- Worker retries of partially applied operations.
- Duplicate websocket events.

## Transaction boundaries

- Queue mutation commands run in a single serializable-ish transaction at entry-level:
  - fetch entry with location-scoped lock token
  - validate transition and revision
  - apply mutation + audit + side effects
  - emit outbox event in same transaction
- Ordering updates use explicit `position_revision` and deterministic recompute if contention is detected.

## Concurrency strategy

- Optimistic concurrency by revision/version for entry and queue objects.
- Compare-and-swap on queue entry state where applicable:
  - must pass `expected_revision` on high-contention operations
  - fallback to explicit conflict response on mismatch
- Per-location advisory locks for head transitions (`CALL_NEXT`) in critical sections.

## Required constraints

- Unique active serving entry per queue per operator scope as per queue policy.
- Queue-entry transition graph enforced as state machine.
- One transition per entry per request transaction.
- Mandatory `reason` for manual reorder.
- Queue reorder operations cannot be partial; they are atomic across affected entries.

## Conflict and stale write behavior

- `VERSION_CONFLICT` for stale revision mismatch.
- `CONFLICT` when state transition is no longer valid.
- Idempotent replay returns original outcome when input fingerprint and scope match.

## Queue and entry race scenarios

1. **Concurrent Call Next**
   - Serialize by queue lock and recompute next active entry.
2. **Manual reorder racing with state transitions**
   - Enforce single transaction per queue mutation set.
3. **Serving vs removal races**
   - Validate transitions against latest revision before update.
4. **Duplicate calls from client**
   - Use idempotency keys or deterministic operation IDs.

## Audit expectations

- Every conflict rejection logs:
  - actor and source client
  - requested command
  - expected vs actual revision
  - queue and entry identifiers
- Replayed successful command uses existing result if idempotent key matches.
