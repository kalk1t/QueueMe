# ADR-0001: Monorepo Topology and Source Ownership

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER
- Related milestone: Milestone 02 - Architecture and Decision Records

## Context

The project already has `apps`, `services`, `packages`, and `infrastructure` directories. Milestone 2 needs a clear ownership model that avoids accidental cross-layer coupling.

## Decision

Use a modular-monolith monorepo topology with distinct runtime services (`services/api`, `services/worker`, `services/realtime`) and shared contract/config packages.

## Alternatives considered

- Polyrepo: stronger isolation but high coordination overhead and lower early productivity.
- Fully service-mesh-first: overkill before core domain and contract stability.

## Rationale

Milestone 2 targets correctness and operational planning, not production complexity. The proposed model balances evolution potential and short-term velocity.

## Positive consequences

- Shared contracts and fast cross-surface iteration.
- Lower overhead for early milestones.
- Clear future extraction path via contract boundaries.

## Negative consequences

- Some coupling risk if boundaries are not enforced in code.
- Shared release artifacts may need strict ownership.

## Security implications

Sensitive paths remain in backend service modules; only contracts are shared.

## Cost implications

- Lower short-term tooling and infra costs.
- No need for multiple build systems initially.

## Operational implications

- Single runtime release unit for each service.
- Deployment boundaries planned but not yet provisioned.

## Migration implications

Service extraction is straightforward where boundaries are contracted.

## Reversal strategy

Collapse to single service or further split into microservices after contract stability.

## Related PRD requirements

- PRD-TENANT-002
- PRD-PLAT-001

## Related future milestones

- M02
- M08
- M09

## Approval state

Pending product-owner review due to scope and cost implications.
