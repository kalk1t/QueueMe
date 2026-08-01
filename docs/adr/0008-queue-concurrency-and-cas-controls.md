# ADR-0008: Queue Concurrency, Stale-Write Detection, and Call-Next Conflict Control

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER
- Related milestone: Milestone 02 - Architecture and Decision Records

## Context

Simultaneous operator commands can corrupt queue order without strict guards.

## Decision

Apply revision-based optimistic concurrency plus queue-level advisory lock for head operations (`call next`), with transaction-scoped state transitions and atomic ordering updates.

## Alternatives considered

- Last-write-wins with timestamps: simple but unsafe for call-next fairness.
- Full distributed lock only: operationally heavier and more failure-prone.

## Rationale

Combines correctness with manageable complexity for initial implementation.

## Positive consequences

- Fairness and deterministic conflict handling.
- Better incident traceability.

## Negative consequences

- More strict API client conflict handling for retries.

## Security implications

- Reduces abuse opportunities from race-condition manipulation.

## Cost implications

- Slightly higher DB lock contention costs.

## Operational implications

- Expect conflict metrics; client UX should surface clear retry steps.

## Migration implications

- Locking semantics can remain while moving to separate services.

## Reversal strategy

- Increase scope of lock granularity or move to queue command queueing worker.

## Related PRD requirements

- PRD-QUEUE-008
- PRD-QUEUE-002
- PRD-QUEUE-003

## Related future milestones

- M23
- M29

## Approval state

Pending product-owner review.
