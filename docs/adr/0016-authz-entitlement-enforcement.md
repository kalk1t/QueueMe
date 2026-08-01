# ADR-0016: Authorization and Entitlement Enforcement Strategy

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Operations require role-based access and location entitlements.

## Decision

Authorization and entitlement checks are mandatory for every state-changing command and event publish path.

## Alternatives considered

- UI-only authorization checks.
- Coarse permission model with few location checks.

## Rationale

Minimizes risk of unauthorized queue or billing mutations.

## Positive consequences

- Uniform policy across all clients.
- Clear audit entry for denied requests.

## Negative consequences

- Additional latency for complex role checks.

## Security implications

- Fewer privilege escalation opportunities.

## Cost implications

- Early development overhead, reduced incident burden later.

## Operational implications

- Requires permission cache invalidation and periodic review.

## Migration implications

- Permissions model can evolve with milestone-specific capabilities.

## Reversal strategy

- Move only by explicit security and governance approval.

## Related PRD requirements

- PRD-TENANT-003
- PRD-WEB-003

## Related future milestones

- M09
- M11

## Approval state

Pending product-owner review.
