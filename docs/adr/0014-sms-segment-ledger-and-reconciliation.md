# ADR-0014: SMS Segment Ledger and Reconciliation Authority

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Trial and monthly usage requires precise segment counting and overage behavior.

## Decision

Make SMS ledger authoritative in backend with provider event reconciliation and location-scoped counters.

## Alternatives considered

- Client-side segment counting only.
- Provider event pass-through without local reconciliation.

## Rationale

Authoritative ledger supports overage caps and auditability.

## Positive consequences

- Reliable billing and anti-abuse behavior.
- Correct trial pause and cap transitions.

## Negative consequences

- Reconciliation complexity around provider event ordering.

## Security implications

- Provider event integrity and webhook dedupe required.

## Cost implications

- Requires storage and analytics for usage events.

## Operational implications

- Requires periodic reconciliation job and variance alerts.

## Migration implications

- Ledger schema can remain while provider adapters evolve.

## Reversal strategy

- Freeze billing feature until provider events can be revalidated; no silent fallback.

## Related PRD requirements

- PRD-SUB-007
- PRD-SUB-009
- PRD-SUB-016

## Related future milestones

- M12
- M14

## Approval state

Pending product-owner review.
