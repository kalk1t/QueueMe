# ADR-0025: API and Event Contract Versioning

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Contract drift between web, Android, and backend can break clients and event replay.

## Decision

Use semantic versioning for contract packages, additive changes by default, and explicit major versions for breaking schema changes.

## Alternatives considered

- Unversioned rolling changes.
- Endpoint-level versioning only.

## Rationale

Consumer safety requires stable compatibility guarantees across release and client cohorts.

## Positive consequences

- Predictable client rollout and dependency management.
- Better support for Android and web mixed deployments.

## Negative consequences

- Additional maintenance on release pipelines and changelog tracking.

## Security implications

- Prevents silent contract break that can skip authorization checks.

## Cost implications

- Minor process overhead and package publication changes.

## Operational implications

- Need contract release gating and compatibility notes.

## Migration implications

- Backward-compatible path for clients before full migration.

## Reversal strategy

- Consolidate versions if migration costs become excessive while preserving compatibility notes.

## Related PRD requirements

- PRD-WEB-002
- PRD-PLAT-001

## Related future milestones

- M30

## Approval state

Pending product-owner review.
