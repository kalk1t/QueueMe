# ADR-0005: Redis Responsibilities and Non-authoritative Limits

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER
- Related milestone: Milestone 02 - Architecture and Decision Records

## Context

Redis is required for performance-sensitive operations but must not hold durable truth.

## Decision

Use Redis for revisions, session caches, websocket presence, and lock coordination; no durable business semantics in Redis.

## Alternatives considered

- No Redis: simpler but reduced concurrency performance.
- Redis as primary state: high risk of state divergence and split-brain behavior.

## Rationale

Redis accelerates high-contention paths while PostgreSQL retains source of truth.

## Positive consequences

- Faster queue mutation pre-checks.
- Lower API latency under concurrent operation.

## Negative consequences

- Additional cache invalidation and stale read risks.

## Security implications

Cache keys scoped by tenant/location; never store raw secrets or unrestricted PII.

## Cost implications

- Moderate additional managed cache cost.

## Operational implications

- TTL governance and cache flush procedures required.

## Migration implications

- Redis can be introduced progressively for targeted commands.

## Reversal strategy

If cache risk outweighs benefit, collapse to DB-only reads/writes until stable.

## Related PRD requirements

- PRD-QUEUE-009
- PRD-SEC-001

## Related future milestones

- M06
- M29

## Approval state

Pending product-owner review.
