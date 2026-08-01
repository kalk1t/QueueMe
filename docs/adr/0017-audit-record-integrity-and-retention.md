# ADR-0017: Audit Integrity and Retention Strategy

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Queue order, entitlement, and billing decisions require tamper-evident evidence.

## Decision

Adopt append-only audit stream for sensitive operations with retention rules and optional hash-chain hardening.

## Alternatives considered

- No append-only semantics in early milestones.
- Full external SIEM only, without internal audit model.

## Rationale

Internal audit stream simplifies rollback and dispute resolution.

## Positive consequences

- Better operational incident and legal traceability.
- Supports tenant breach and billing disputes.

## Negative consequences

- Storage growth and retention governance complexity.

## Security implications

- Audit IDs and actor context reduce repudiation risk.

## Cost implications

- Storage cost for long-lived audit traces.

## Operational implications

- Search and retention tooling required as operations scale.

## Migration implications

- Hash chain can be added incrementally without historical rewrite.

## Reversal strategy

- If chain implementation is deferred, retain immutable append semantics at minimum.

## Related PRD requirements

- PRD-AUDIT-001
- PRD-PRIV-006

## Related future milestones

- M30

## Approval state

Pending product-owner review.
