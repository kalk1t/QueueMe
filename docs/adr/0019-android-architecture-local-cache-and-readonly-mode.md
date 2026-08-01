# ADR-0019: Android Architecture, Local Cache, and Degraded Mode

## Context

Android is operator-centric and must remain usable during transient network issues.

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Decision

Operator actions require network for mutations; local cache provides read-only queue status and offline-safe stale warning. Mutations in cached mode are blocked.

## Alternatives considered

- Full offline mutation sync queue.
- No caching and no degraded support.

## Rationale

Balance usability with queue correctness and security.

## Positive consequences

- Better user experience during transient network loss.
- Safer correctness than offline mutation.

## Negative consequences

- No queue updates while disconnected.

## Security implications

- Cached data must be minimal and access-protected.

## Cost implications

- Low implementation complexity relative to offline-first sync.

## Operational implications

- Client status messaging for read-only mode required.

## Migration implications
- Can evolve to partial offline command queue in later milestones.

## Reversal strategy

- Remove cache if security constraints change significantly.

## Related PRD requirements

- PRD-QUEUE-009
- PRD-QUEUE-010
- PRD-WEB-001

## Related future milestones

- M27
- M29

## Approval state

Pending product-owner review.
