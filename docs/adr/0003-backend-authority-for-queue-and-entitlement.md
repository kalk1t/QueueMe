# ADR-0003: Backend as Sole Authoritative State Owner

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER
- Related milestone: Milestone 02 - Architecture and Decision Records

## Context

Queue and entitlement operations involve compliance-sensitive decisions and cross-device concurrency.

## Decision

Queue state, authorization decisions, entitlement, consent status, messaging limits, and audit become backend-authoritative and non-overridable by clients.

## Alternatives considered

- Client-side optimistic authority with server reconciliation: not sufficient for billing and security.
- Third-party queue engines: introduces additional trust and migration risk.

## Rationale

Any deviation creates audit and tenant-isolation risks and weakens retry correctness.

## Positive consequences

- Consistent conflict resolution.
- Clear source-of-truth for compliance checks.

## Negative consequences

- Offline operations for clients are limited to read-only behavior.

## Security implications

- Reduces client manipulation risk and improves tenant isolation.

## Cost implications

- Slightly higher backend complexity; lower incident recovery cost.

## Operational implications

- All critical mutations need DB transactions and authorization checks.

## Migration implications

- Client implementations must shift to revision-based sync patterns.

## Reversal strategy

Any partial relaxation must be explicit and documented as a policy rollback with high-risk review.

## Related PRD requirements

- PRD-SEC-001
- PRD-ONBOARD-001
- PRD-PRIV-003

## Related future milestones

- M07
- M09
- M10

## Approval state

Pending product-owner review.
