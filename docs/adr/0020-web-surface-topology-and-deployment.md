# ADR-0020: Web Surface Topology and Deployment Separation

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Release has owner, operator, admin, and customer surfaces with different privileges.

## Decision

Use separate web route groups within a shared web application, with shared contracts and separate authorization guards.

## Alternatives considered

- Single surface with role-driven dynamic pages only.
- Separate binaries from day one.

## Rationale

Shared platform with role-segmented routes is faster to build and easier to govern early.

## Positive consequences

- Shared components and consistent branding.
- Clearer role boundaries than purely role-gated UI.

## Negative consequences

- Larger route matrix and guard complexity.

## Security implications

- Route-specific CSRF/session controls and strict role checks.

## Cost implications

- Lower hosting complexity than multiple frontends.

## Operational implications

- Access and session policies must be uniform across routes.

## Migration implications

- Future host split possible if operational scaling requires.

## Reversal strategy

- Promote to separate deployments only after route-level complexity grows.

## Related PRD requirements

- PRD-WEB-002
- PRD-WEB-003
- PRD-WEB-001

## Related future milestones

- M30

## Approval state

Pending product-owner review.
