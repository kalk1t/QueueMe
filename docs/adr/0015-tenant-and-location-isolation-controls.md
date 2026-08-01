# ADR-0015: Tenant and Location Isolation Enforcement

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Tenant isolation is a top-risk requirement spanning authorization and data partitioning.

## Decision

Implement scope enforcement in every repository method and enforce organization/location checks in queries, caches, queue payloads, and events.

## Alternatives considered

- Application-level only checks with weak DB constraints.
- DB-only constraints without runtime guards.

## Rationale

Defense-in-depth across layers lowers cross-tenant breach risk.

## Positive consequences

- Reduced blast radius for mis-scoped API bugs.
- Cleaner evidence for negative testing.

## Negative consequences

- Additional mandatory query conditions and tests on every service path.

## Security implications

- Prevents major data-leakage vectors.

## Cost implications

- Slightly more development time for query hardening and test coverage.

## Operational implications

- Requires routine tenant-isolation test harness.

## Migration implications

- Existing data backfills must include tenant IDs before service start.

## Reversal strategy

- Hardening changes should only be removed with formal security review.

## Related PRD requirements

- PRD-SEC-001
- PRD-TENANT-003

## Related future milestones

- M08
- M09

## Approval state

Pending product-owner review.
