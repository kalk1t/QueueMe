# ADR-0002: Modular-Monolith-First Backend

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER
- Related milestone: Milestone 02 - Architecture and Decision Records

## Context

Backend domain areas are extensive but still small enough for a modular monolith.

## Decision

Queue and billing domains remain within one deployable backend API service with clear internal components and module boundaries.

## Alternatives considered

- Multiple independent services early: improved isolation but higher cross-service consistency complexity.
- Single codebase with no module boundaries: fast initially but likely unmaintainable for concurrency-heavy queue and billing domains.

## Rationale

Queue, billing, and consent behaviors require shared transactions and strict ordering; module isolation inside one service reduces distributed transactions risk.

## Positive consequences

- Stronger transactional behavior.
- Faster initial implementation and simpler deployments.

## Negative consequences

- Shared runtime failure impacts all backend functions.
- Refactoring cost for extraction later.

## Security implications

Authorization and tenant checks are centralized and cannot be bypassed through service hops.

## Cost implications

- Lower short-term infrastructure complexity and operational cost.

## Operational implications

- Single health profile.
- Shared release and migrations with explicit component modules.

## Migration implications

Modules can be split with bounded context boundaries after milestone 10+.

## Reversal strategy

Extract service modules sequentially once cross-service event contracts are stabilized.

## Related PRD requirements

- PRD-SEC-001
- PRD-ONBOARD-001

## Related future milestones

- M02
- M06
- M10

## Approval state

Pending product-owner review.
