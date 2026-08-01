# ADR-0009: Durable Jobs and Retry Policy

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Provider sends and billing reconciliations must be retried safely without duplicate side effects.

## Decision

Adopt durable jobs with at-least-once semantics, idempotent handlers, and explicit dead-letter handling.

## Alternatives considered

- In-process async only: simpler but crash-sensitive.
- Fully queue-less synchronous processing: brittle for provider outages.

## Rationale

Background jobs provide reliability while preserving controlled side effects.

## Positive consequences

- Stable behavior under outages.
- Controlled reconciliation points.

## Negative consequences

- Additional operational load to monitor job health.

## Security implications

- Jobs carry signed correlation metadata and limited privilege.

## Cost implications

- Additional queue service cost and worker compute.

## Operational implications

- Need DLQ review and job replay tooling.

## Migration implications

- Jobs can be split by domain with contract preserved.

## Reversal strategy

- Reduce job categories and keep provider calls synchronous where acceptable.

## Related PRD requirements

- PRD-SMS-009
- PRD-PRIV-001

## Related future milestones

- M12
- M19
- M30

## Approval state

Pending product-owner review.
