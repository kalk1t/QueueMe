# ADR-0021: Environment Isolation and Secret Management

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Each environment must isolate secrets and test/prod workflows.

## Decision

Separate local, dev, staging, production trust zones with distinct secret scopes and no shared credentials across envs.

## Alternatives considered

- Shared secrets across environments.
- Environment-specific config without strict secret rotation.

## Rationale

Prevents accidental production impacts and simplifies incident containment.

## Positive consequences

- Better isolation and compliance alignment.
- Clear promotion controls.

## Negative consequences

- More deployment operational work.

## Security implications

- Mandatory secret store and role-based secret access.

## Cost implications

- Operational cost from secret infrastructure and policies.

## Operational implications

- Requires rotation procedures and incident key-cycling.

## Migration implications

- Legacy credential migration to scoped secret manager supported.

## Reversal strategy

- Restrict scope further if compliance changes.

## Related PRD requirements

- PRD-SEC-001

## Related future milestones

- M04
- M05

## Approval state

Pending product-owner review.
